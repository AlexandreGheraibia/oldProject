[System.Reflection.Assembly]::LoadFrom( "X:\Windows\System32\erasedisk\ressources\itextsharp.dll")
#[System.Reflection.Assembly]::LoadFrom( ".\ressources\itextsharp.dll")

# Set basic PDF settings for the document
Function Create-PDF([iTextSharp.text.Document]$Document, [string]$File, [int32]$TopMargin, [int32]$BottomMargin, [int32]$LeftMargin, [int32]$RightMargin, [string]$Author)
{
    $Document.SetPageSize([iTextSharp.text.PageSize]::A4)
    $Document.SetMargins($LeftMargin, $RightMargin, $TopMargin, $BottomMargin)
    [void][iTextSharp.text.pdf.PdfWriter]::GetInstance($Document, [System.IO.File]::Create($File))
    $Document.AddAuthor($Author)
}

# Add a text paragraph to the document, optionally with a font name, size and color
function Add-Text([iTextSharp.text.Document]$Document, [string]$Text,[string]$Centered, [string]$FontName = "Arial", [int32]$FontSize = 12, [string]$Color = "BLACK",[int32] $SpacingBefore=2,[int32]$SpacingAfter=2)
{
    $p = New-Object iTextSharp.text.Paragraph
    $p.Font = [iTextSharp.text.FontFactory]::GetFont($FontName, $FontSize, [iTextSharp.text.Font]::NORMAL, [iTextSharp.text.BaseColor]::$Color)
    if($Centered -eq "centered") { $p.Alignment = [iTextSharp.text.Element]::ALIGN_CENTER }
    if($Centered -eq "right") { $p.Alignment = [iTextSharp.text.Element]::ALIGN_RIGHT }
    if($Centered -eq "left") { $p.Alignment = [iTextSharp.text.Element]::ALIGN_LEFT }
    
    $p.SpacingBefore = $SpacingBefore
    $p.SpacingAfter = $SpacingAfter
    $p.Add($Text)
    $Document.Add($p)
}

# Add a title to the document, optionally with a font name, size, color and centered
function Add-Title([iTextSharp.text.Document]$Document, [string]$Text, [string]$Centered, [string]$FontName = "Arial", [int32]$FontSize = 16, [string]$Color = "BLACK",[int32] $SpacingBefore=2,[int32]$SpacingAfter=2)
{
    $p = New-Object iTextSharp.text.Paragraph
    $p.Font = [iTextSharp.text.FontFactory]::GetFont($FontName, $FontSize, [iTextSharp.text.Font]::BOLD, [iTextSharp.text.BaseColor]::$Color)
    if($Centered -eq "centered") { $p.Alignment = [iTextSharp.text.Element]::ALIGN_CENTER }
    if($Centered -eq "right") { $p.Alignment = [iTextSharp.text.Element]::ALIGN_RIGHT }
    if($Centered -eq "left") { $p.Alignment = [iTextSharp.text.Element]::ALIGN_LEFT }
    
    $p.SpacingBefore = $SpacingBefore
    $p.SpacingAfter = $SpacingAfter
    $p.Add($Text)
    $Document.Add($p)
}

# Add an image to the document, optionally scaled
function Add-Image([iTextSharp.text.Document]$Document, [string]$File, [int32]$Scale = 100)
{
    [iTextSharp.text.Image]$img = [iTextSharp.text.Image]::GetInstance($File)
    $img.ScalePercent(50)
    $Document.Add($img)
}

# Add a table to the document with an array as the data, a number of columns, and optionally centered
function Add-Table([iTextSharp.text.Document]$Document, [string[]]$Dataset, [int32]$Cols = 3, [Switch]$Centered)
{
    $t = New-Object iTextSharp.text.pdf.PDFPTable($Cols)
    $t.SpacingBefore = 5
    $t.SpacingAfter = 5
    if(!$Centered) { $t.HorizontalAlignment = 0 }
    foreach($data in $Dataset)
    {
        $t.AddCell($data);
    }
    $Document.Add($t)
}



function generatePdf($disk,$remotePath){
    formatDisk $disk.Index
    if((get-wmiobject -Class 'Win32_DiskDrive'|where Index -eq $disk.Index).Status -eq "OK" ) 
    {
        $chemin="X:\Windows\System32\erasedisk\"
        New-Item $($remotePath) -type directory
        $path="$remotePath\$(get-wmiobject -class Win32_bios|Select -property SerialNumber|Select Object -ExpandProperty serialNumber)"
        $date="{0:ddMMyy}"-f(get-date)
        $name="$($date).$($disk.SerialNumber)"
        $path="$path\$($date)"
        New-Item $path -type directory
    
        $pdf = New-Object iTextSharp.text.Document
        Create-PDF -Document $pdf -File "$($path)\Cert_$name.pdf" -TopMargin 0 -BottomMargin 20 -LeftMargin 20 -RightMargin 20 -Author "Ulisse Solidura"
        $pdf.Open()
        Add-Image -Document $pdf -File "$chemin\ressources\logo.png"
        $date=Get-Date -Uformat "Anatole France Grenoble, le %d/%m/%Y" 
        Add-Text -Document $pdf -Text $date -Color "BLACK" "right" -SpacingBefore 40 -SpacingAfter 40 -FontSize 12
        Add-Title -Document $pdf -Text "Certificat d'effacement $($disk.SerialNumber)" -Color "BLACK" "centered" -SpacingBefore 20 -SpacingAfter 40 
        $size=[math]::round(($disk.Size/[math]::pow(1000,3)),0)
         if ($size/1000 -ge  1) {
                $size=$size/1000
                 $size="$size TB"
         }
         else{
                 $size="$size GB"
         }
         
    
         Add-Text -Document $pdf -Text "Identité disque" -Color "BLACK" -Centered "centered"  -FontSize 14
         Add-Table -Document $pdf -Dataset @("Molèle",$disk.Model ,"Constructeur", $disk.Manufacturer,"Device ID: ", $disk.PNPDeviceID,"Signature",$disk.Signature, "Numéro de série", $disk.SerialNumber,"Taille",$size) -Cols 2 -Centered
         Add-Text -Document $pdf -Text "Opérations effectuées" -Color "BLACK" -Centered "centered"  -FontSize 14
         $date=Get-Date -Uformat "%d/%m/%Y"
         Add-Table -Document $pdf -Dataset @("Date d'effacement",$date,"Norme", "standard","Formatage",1,"Norme","DoD 5220.22M","Nombre de formatages bas niveaux","7") -Cols 2 -Centered
         $pdf.Close()
        }   
        


}

Function AvailableVolumes($letter) { 
    $currentDrives = get-volume 
    ForEach ($v in $currentDrives) { 
        if ($letter -eq $v.DriveLetter.ToString()) { 
           return 0
        } 
    } 
    return 1
 } 


function formatDisk($index){
    $i=[convert]::ToInt32($index, 10)+67
    $j=[convert]::ToInt32($index, 10)
    $letter=[char]$i
    $exist=AvailableVolumes($letter)
    while ($i-lt 90 -And $exist -eq 0)
    {
        $i=$i+1
        $letter=[char]$i
        $exist=AvailableVolumes($letter)
    }
    <#write-warning $index
    $result=get-disk -number $index
    write-warning $resul 
    
    $result=get-disk -number $j |select partitionStyle|Select Object -ExpandProperty partitionStyle
    write-warning $result 
    
    write-warning $index
    #>
    if((get-disk -number $index |select partitionStyle|Select Object -ExpandProperty partitionStyle) -ne "RAW")
    {
  	    Clear-Disk -number $index -RemoveData -RemoveOEM -confirm:$false
    }
    Initialize-Disk -number $index -confirm:$false
    New-Partition -DiskNumber $index -UseMaximumSize -DriveLetter $($letter) | Format-Volume -NewFileSystemLabel "Disk$($index)" -FileSystem NTFS
    format "$($letter):" /V:"clean$($index)"/P:0/Y
}



if ($args.count -ne 0) {
    $folderToStore="Certificats"
    $remotePath="\\SRV-WDS\log$\$($folderToStore)"
    generatePdf $args $remotePath
}