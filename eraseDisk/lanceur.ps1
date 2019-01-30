#mode pour s'assurer que l'on ne peut pas r�f�rencer des choses tels que des variables non initialis�es
#ou des propri�t� non exitante.
Set-StrictMode -Version Latest

function generatePdfs(){
    #cr�ation d'un filtre pour s�ectionner que les resultats contenant des disques durs
    $wmiParameters=@{
     Class='Win32_DiskDrive'
     filter="MediaType='Fixed hard disk media'"
   
    }

   foreach ($disk in get-wmiobject @wmiParameters){
       <# D�finition des objets afin de cr�er un objet contenant les 
       propri�t�s d�sir�es
       #>
       $HDD=New-Object PSObject
       add-Member -InputObject $HDD -MemberType NoteProperty -Name SerialNumber -Value $disk.SerialNumber.trim()
       add-Member -InputObject $HDD -MemberType NoteProperty -Name Model -Value $disk.Model
       add-Member -InputObject $HDD -MemberType NoteProperty -Name Manufacturer -Value $disk.Manufacturer
       add-Member -InputObject $HDD -MemberType NoteProperty -Name PNPDeviceID -Value $disk.PNPDeviceID
       add-Member -InputObject $HDD -MemberType NoteProperty -Name Signature -Value $disk.Signature
       add-Member -InputObject $HDD -MemberType NoteProperty -Name Size -Value $disk.Size
       add-Member -InputObject $HDD -MemberType NoteProperty -Name Index -Value $disk.Index
       add-Member -inputObject $HDD -MemberType NoteProperty -Name Status -Value $disk.Status
       if($disk.Status -eq "OK"){
            Start-Job  $PSScriptRoot\jobs.ps1 -ArgumentList $HDD
        }
    }
}

$ConfirmPreference='None'
$TSEnv=New-Object -ComObject Microsoft.SMS.TSEnvironment

function checkVarEnv(){
	
	write-Warning $TSEnv.Value("OSDComputerName")
	 
}


function main(){
Get-Job| Remove-Job -Force
generatePdfs
Get-Job | Wait-Job|Receive-Job

}
main
#checkVarEnv