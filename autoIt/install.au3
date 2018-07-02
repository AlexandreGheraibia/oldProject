#cs ----------------------------------------------------------------------------

 AutoIt Version : 3.3.14.2
 Auteur:         Attila311

 Fonction du Script :
	Modèle de Script AutoIt.

#ce ----------------------------------------------------------------------------

; Début du script - Ajouter votre code ci-dessous.

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <File.au3>
#include <GDIPlus.au3>
#include <ColorConstants.au3>
#include <IE.au3>
#include <InetConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <Inet.au3>

$chemin=@WorkingDir&"\logiciels";dossier courant
Global $Len=13; nombre de dossier
;mse tjour en dernier
Global $arr[9][$Len]=[["Malwarebytes","Ccleaner","LibreOffice","Vlc","Firefox","Cdxpburner","7zip","FlashPlayer","Acrobate","ThunderBird","Java","Office2010","Mse"],[true,true,true,true,true,true,true,true,true,true,true,false,false]]

Global $nb=12
global $incre=0
;malwareBytes	0
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Securite/anti-spam/fiches/120837.html"
$arr[3][$incre]=false


$incre+=1
;ccleaner	1
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Utilitaire/nettoyeurs_et_installeurs/fiches/32599.html"
$arr[3][$incre]=false

$incre+=1

;libreoffice	2
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Bureautique/editeur_de_texte/fiches/108066.html"
$arr[3][$incre]=false
$arr[6][$incre]="http://www.01net.com/telecharger/windows/Bureautique/editeur_de_texte/fiches/134267.html"
$incre+=1

;vlc	3
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Multimedia/lecteurs_video_dvd/fiches/23823.html"
$arr[3][$incre]=false
$incre+=1



;ff	4
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Internet/navigateur/fiches/25711.html"
$arr[3][$incre]=false
$arr[6][$incre]="http://www.01net.com/telecharger/windows/Internet/navigateur/fiches/133119.html"


$incre+=1

;cdxpburner 5
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Utilitaire/gravure/fiches/27460.html"
$arr[3][$incre]=false
$incre+=1

;7zip	6
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Utilitaire/compression_et_decompression/fiches/4035.html"
$arr[3][$incre]=false
$arr[6][$incre]="http://www.01net.com/telecharger/windows/Utilitaire/compression_et_decompression/fiches/101457.html"

$incre+=1

;flashplayer 7
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Internet/navigateur/fiches/4481.html"
$arr[3][$incre]=false
$arr[6][$incre]="http://www.01net.com/telecharger/windows/Internet/navigateur/fiches/115250.html"
$incre+=1

;acrobat	8
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Internet/internet_utlitaire/fiches/14537.html"
$arr[3][$incre]=false

$incre+=1

;thunder 9
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Internet/courrier_email/fiches/26957.html"
$arr[3][$incre]=false
$incre+=1


;faire une installation special pour actualisation java
;java 10
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Programmation/java/fiches/8138.html"
$arr[3][$incre]=false
$arr[6][$incre]="http://www.01net.com/telecharger/windows/Programmation/java/fiches/116967.html"
$incre+=1

;Moffice 11
;$arr[2][$incre]="http://www.01net.com/telecharger/windows/Securite/antivirus-antitrojan/fiches/100401.html"
$arr[3][$incre]=false
;$arr[6][$incre]="http://www.01net.com/telecharger/windows/Securite/antivirus-antitrojan/fiches/100403.html"
$incre+=1

;mse 12
$arr[2][$incre]="http://www.01net.com/telecharger/windows/Securite/antivirus-antitrojan/fiches/100401.html"
$arr[3][$incre]=false
$arr[6][$incre]="http://www.01net.com/telecharger/windows/Securite/antivirus-antitrojan/fiches/100403.html"
$incre+=1

; ########## Début de la création de la GUI 1 ##########
Global $GUI1, $Lb1,$chBoxes[$Len],$Btn1,$Btn2,$Btn3,$hImage,$hGraphic

func NotinstallMse()
	return @OSVersion<>"WIN_7" and @OSVersion<>"WIN_VISTA" and @OSVersion<>"WIN_XP"
EndFunc

func imageFond($x,$y,$w,$h)
	#cs
	; Load PNG image
	_GDIPlus_StartUp()
	$hImage   = _GDIPlus_ImageLoadFromFile("ressources/sample.png")

	; Draw PNG image
	$hGraphic = _GDIPlus_GraphicsCreateFromHWND($GUI1)
	_GDIPlus_GraphicsDrawImage($hGraphic, $hImage, 0, 0)
	#ce
 Local $idPic = GUICtrlCreatePic("ressources/sample.jpg",$x,$y,$w,$h)

endfunc

func releaseRessources()
	;_GDIPlus_GraphicsDispose($hGraphic)
	;_GDIPlus_ImageDispose($hImage)
	 GUIDelete()
EndFunc

func initGUI()
	Local $i=0
	Local $Len1=0
	if NotinstallMse() then
 		$Len1=$Len-1
	Else
		$Len1=$Len
		$arr[1][$Len-1]=true
	endif
	local $Windowwidth=(Int(($Len1-1)/5))*120
	$GUI1 = GUICreate("Installation", 120+$Windowwidth, 172, -1, -1) ; Création de la GUI1
	GUICtrlSetBkColor(-1 ,0xa3f0f1)
	$Lb1 = GUICtrlCreateLabel("Suite logicielle",$Windowwidth/2, 10, 120, 24) ; Création du label1

	GUISetState(@SW_SHOW, $GUI1) ; On affiche la GUI1
	GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif") ; Mise en gras du texte du contrôle précédent (Label1)
	GUICtrlSetBkColor(-1 ,$GUI_BKCOLOR_TRANSPARENT)

	;GUICtrlSetColor(-1 ,0xffffff)

	while $i<$Len1
		$chBoxes[$i]= GUICtrlCreateCheckbox($arr[0][$i], 20+Int($i/5)*110, 40+Mod ( $i,5)*17, 100, 20,-1,-1) ; Création d'une CheckBox

		if $arr[1][$i] then

			$chb=GUICtrlSetState ($chBoxes[$i],$GUI_CHECKED )

		endif
		GUICtrlSetBkColor($chBoxes[$i] ,0xa3f0f1)
	$i+=1
	WEnd

	$Btn1 = GUICtrlCreateButton("Install", 120+$Windowwidth-55, 142, 50, 25) ; Création d'un bouton simple
	$Btn2 = GUICtrlCreateButton("Décocher", 5, 142, 55, 25) ; Création d'un bouton simple
	$Btn3 = GUICtrlCreateButton("MàJ", 65, 142, 55, 25) ; Création d'un bouton simple
	imageFond(0,0,120+$Windowwidth,172)

EndFunc


; ########## Fin de la création de la GUI 1 ##########
;******************************************************** installation ************************************************************************
func isActif($app)
	local $j=0
	while $arr[0][$j]<>$app
		$j+=1
	WEnd
	return $arr[1][$j]
EndFunc

Func DetectInfrastructure()

    If @OSTYPE = "WIN32_WINDOWS" Then
        ;If @OSType = "WIN32_NT" Then
        msgBox(0,"Unsupported Windows version. Use only on 2000/XP/2003 x32/64.","error")
			return 0
    EndIf
	return 1
EndFunc   ;==>DetectInfrastructure

Func nameFile($pPath)

	 Local $hSearch = FileFindFirstFile($pPath&"\*.*")
	if $hSearch <> -1 then
	 Local $sFileName = FileFindNextFile($hSearch)
	 if  $sFileName ="configuration.ini" Then
		 $sFileName = FileFindNextFile($hSearch)
	 ElseIf $sFileName ="default.cfg" Then
		 $sFileName = FileFindNextFile($hSearch)
	 ElseIf $sFileName ="AcroRead.mst" Then
		 $sFileName = FileFindNextFile($hSearch)
	 ElseIf $sFileName ="X86" or $sFileName="X64" Then
		 $sFileName = FileFindNextFile($hSearch)

	 EndIf
	 else
		$sFileName=""
	 endif
	FileClose($hSearch)
	 return $sFileName
EndFunc


func exeName($pfolder)
	Local $tempPath=""
	Local $tmpFile=""
	$tempPath=$chemin&"\"&$pfolder
	$tmpFile=nameFile($tempPath)
	return  $tmpFile
EndFunc


Func dossiers()
  ; List all the files and folders in the desktop directory using the default parameters and return the full path.

	Local $aFileList = _FileListToArray($chemin, Default,2, false)
    Local $appPath=""
	Local $paramApp=""
	Local $cmdToLaunch=""
	Local $appName=""
	Local $nb


	If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
		releaseRessources()
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
		releaseRessources()
        Exit
    EndIf
	$nb=$aFileList[0]
	$i=1
	while $i<=$nb

		switch $aFileList[$i]
			Case "mwb"
				 $appName="Malwarebytes"

				$appPath=exeName($aFileList[$i])
				 if $appPath<>"" then
					 $paramApp="/silent /norestart /lang=fr"
					 $cmdToLaunch=$appPath;&" "&$paramApp
					 $appPath=$chemin&"\"&$aFileList[$i]
;~ 					;RunWait("mb3-setup-35891.35891-3.2.2.2029.exe ",".")
				endif
			Case "ccl"
				 $appName="Ccleaner"
				 $appPath=exeName($aFileList[$i])
				  if $appPath<>"" then
					 $paramApp="/S /L=1036"
					 $cmdToLaunch=$appPath;&" "&$paramApp
					 $appPath=$chemin&"\"&$aFileList[$i]
					;RunWait("ccsetup535.exe /S /L=1036",".")
				endif
			Case "lbo"
				 $appName="LibreOffice"
				 $appPath=exeName($aFileList[$i]&"\"&@OSArch)
				  if $appPath<>"" then
					 Local $paramMsi=" /i "&$appPath&"  /qn /norestart ";" /msi /qn /norestart" ;
					 ;Local $paramLbo="TRANSFORMS=:1036 UI_LANGS=fr ADDLOCAL=ALL CREATEDESKTOPLINKE=1 REGISTER_ALL_SMO_TYPES=1 REMOVE=gm_o_Onlineupdate RebootYesNo=No IS1033=0";1033=0
					 $paramApp=$paramMsi; & $paramLbo
					 $cmdToLaunch="msiexec"
					 $appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
				 ;RunWait($cmdToLaunch,$appPath,@SW_MAXIMIZE,0x10000)
				 endif
			Case "vlc"
				 $appName="Vlc"
				 $appPath=exeName($aFileList[$i])
				  if $appPath<>"" then
					 $paramApp="/S  /L=1036"
					 $cmdToLaunch=$appPath;&" "&$paramApp
					 $appPath=$chemin&"\"&$aFileList[$i]
					; RunWait($cmdToLaunch,$appPath)
				endif
			Case "ff"
				 $appName="Firefox"
				 $appPath=exeName($aFileList[$i]&"\"&@OSArch)
 				  if $appPath<>"" then
					 $paramApp="-ms"
					 $cmdToLaunch=$appPath;&" "&$paramApp
					 $appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
					; RunWait($cmdToLaunch,$appPath)
				endif
			case "xpb"
				 $appName="Cdxpburner"
				 $appPath=exeName($aFileList[$i])
					  if $appPath<>"" then
					 $paramApp="/SILENT /LOADINF=default.cfg"
					 $cmdToLaunch=$appPath&" ";&$paramApp
					 $appPath=$chemin&"\"&$aFileList[$i]
					 endif
			case "7zip"
				$appName="7zip"
				$appPath=exeName($aFileList[$i]&"\"&@OSArch)
				 if $appPath<>"" then
					$paramApp="/S /L=1036"
					$cmdToLaunch=$appPath;&" "&$paramApp
					$appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
				endif
			case "fpl"
				$appName="FlashPlayer"
				$appPath=exeName($aFileList[$i]);&"\"&@OSArch)
				 if $appPath<>"" then
					$paramApp="-install"
					$cmdToLaunch=$appPath;&" "&$paramApp
					$appPath=$chemin&"\"&$aFileList[$i];&"\"&@OSArch
				endif
			case "acr"
				;AcroRdrDC1500720033_en_US.exe /sPB /rs /msi TRANSFORMS=\Server.fqdn\share\ReaderDC.mst
				$appName="Acrobate"
				$appPath=exeName($aFileList[$i]);&"\"&@OSArch)
				 if $appPath<>"" then
					$paramApp="/sPB /rs /msi TRANSFORMS=AcroRead.mst"
					$cmdToLaunch=$appPath;&" "&$paramApp
					$appPath=$chemin&"\"&$aFileList[$i];&"\"&@OSArch
					$paramApp="/sPB /rs /msi TRANSFORMS="&$appPath&"\AcroRead.mst"
				endif
			case "thb"
				 $appName="ThunderBird"
				 $appPath=exeName($aFileList[$i]);&"\"&@OSArch)
					  if $appPath<>"" then
					 $paramApp="-ms -ma"
					 $cmdToLaunch=$appPath;&" "&$paramApp
					 $appPath=$chemin&"\"&$aFileList[$i];&"\"&@OSArch
					 endif
			case "mse"
				$appName="Mse"
				if not NotinstallMse() then

				$appPath=exeName($aFileList[$i]&"\"&@OSArch)
					 if $appPath<>"" then
						$paramApp="/s /runwgacheck"
						$cmdToLaunch=$appPath;&" "&$paramApp
						$appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
					 endif
				EndIf
			case "java"
				;$appPath=""
				 $appName="Java"
				 $appPath=exeName($aFileList[$i]&"\"&@OSArch)
					  if $appPath<>"" then
					 $paramApp="/lang=1036 /s"
					 $cmdToLaunch=$appPath;&" "&$paramApp
					 $appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
					  endif
			case "msoff"
				$appName="Office2010"
				 $appPath=exeName($aFileList[$i]);&"\"&@OSArch)
					  if $appPath<>"" then
					 $paramApp="/config config.xml"
					 $cmdToLaunch=$appPath;&" "&$paramApp
					 $appPath=$chemin&"\"&$aFileList[$i];&"\"&@OSArch
					endif

			Case Else

		EndSwitch
		#RequireAdmin
		if isActif($appName)=true then
				if $appPath<>"" then
					if $appName="Office2010" then
					MsgBox($MB_SYSTEMMODAL,"erreur",$appName&$cmdToLaunch&" "&$paramApp,$appPath)
					ShellExecuteWait($cmdToLaunch,"",$appPath)
					else
					ToolTip("installation de "& $appName,@DeskTopWidth, @DeskTopHeight-70,"info",1,4)
					ShellExecuteWait($cmdToLaunch,$paramApp,$appPath)
					#cs  Then
						ShellExecuteWait("soffice.exe","--language=fr","C:\Program Files\LibreOffice 5\program")
					endif
					#ce
					;MsgBox($MB_SYSTEMMODAL, "", $appPath&" "&$cmdToLaunch&" ")
					endif
				else
					MsgBox($MB_SYSTEMMODAL,"erreur",$appName&" n'as pas de fichier d'installation")
			EndIf

		endif
		$i+=1
	WEnd
	ToolTip("installation terminée",@DeskTopWidth, @DeskTopHeight-70,"info",1,4)
	sleep(2000)
EndFunc


#cs
Ce comportement est nouveau dans Windows XP SP2 du fait de l'ajout de AES (Attachment Execution Services).
Tous les programmes exécutés à l'aide de l'API ShellExecute() passent par AES.
AES considère que le fichier de mise à jour téléchargé vient de la zone Internet.
En conséquence, AES affiche la boîte de dialogue Fichier ouvert-Avertissement de sécurité.
AES examine le fichier pour voir s'il a un flux de fichier du type Zone.Identificateur.
Ensuite, AES détermine la zone de provenance du fichier et le niveau de protection à appliquer lors de son exécution.
#ce
Func desactiveAes()
    ; Crée une variable d'environnement appelée %MYVAR% et lui attribue une valeur. Lorsque vous affectez ou récupérez une variable d'environnement vous devez la nommer sans les signes de pourcentage (%).
    EnvSet("SEE_MASK_NOZONECHECKS", "1")
    ; Obtient la variable d'environnement dont on vient d'attribuer une valeur.
    Local $sEnvVar = EnvGet("SEE_MASK_NOZONECHECKS")
    ; Affiche la valeur de la variable d'environnement %MYVAR%.
   ; MsgBox($MB_SYSTEMMODAL, "", "La variable d'environnement %SEE_MASK_NOZONECHECKS% a la valeur: " & @CRLF & @CRLF & $sEnvVar)
EndFunc   ;==> Example
;********************************************************************************************************************************************

;************************************************************mise à jour*********************************************************************
func activateForDownload($app,$pversion)
	local $j=0
	while $arr[0][$j]<>$app
		$j+=1
	WEnd
	$arr[3][$j]=true
	$arr[8][$j]=$pversion
EndFunc


Func Mdossiers()
  ; List all the files and folders in the desktop directory using the default parameters and return the full path.
;
;	sleep(2000)
	Local $aFileList = _FileListToArray($chemin, Default,2, false)
    Local $appPath=""
	Local $fileName=""
	Local $paramApp=""
	Local $cmdToLaunch=""
	Local $appName=""
	Local $nb
	local $version=""
	local $nvVersion=""

	If @error = 1 Then
        MsgBox($MB_SYSTEMMODAL, "", "Path was invalid.")
		releaseRessources()
        Exit
    EndIf
    If @error = 4 Then
        MsgBox($MB_SYSTEMMODAL, "", "No file(s) were found.")
		releaseRessources()
        Exit
    EndIf
	$nb=$aFileList[0]
	$i=1
	while $i<=$nb

		switch $aFileList[$i]
			Case "mwb"
				 $appName="Malwarebytes"
				 $fileName=exeName($aFileList[$i])
				 $appPath=$chemin&"\"&$aFileList[$i]
				 $version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				 $arr[7][0]=$fileName
				 $arr[4][0]=$chemin&"\"&$aFileList[$i]
				 $arr[5][0]=1
			Case "ccl"
				 $appName="Ccleaner"
				 $fileName=exeName($aFileList[$i])

				 $appPath=$chemin&"\"&$aFileList[$i]
				 $version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				  $arr[7][1]=$fileName
				 $arr[4][1]=$chemin&"\"&$aFileList[$i]
				 $arr[5][1]=1
			Case "lbo"
				 $appName="LibreOffice"
				; $fileName=""
				$fileName=exeName($aFileList[$i]&"\"&@OSArch)
				$appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
				local $res=StringSplit($fileName,"_")
				$version=$res[2]
				;$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				 $arr[7][2]=$fileName
				$arr[4][2]=$chemin&"\"&$aFileList[$i]
				$arr[5][2]=2
			Case "vlc"
				 $appName="Vlc"
				 $fileName=exeName($aFileList[$i])
				 $appPath=$chemin&"\"&$aFileList[$i]
				;$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				local $res=StringSplit($fileName,"_")
				$version=$res[2]
				;local $res=StringSplit($fileName,"-")
				;$version=$res[2]
				 $arr[7][3]=$fileName
				$arr[4][3]=$chemin&"\"&$aFileList[$i]
				$arr[5][3]=1
			Case "ff"
				 $appName="Firefox"
				 $fileName=exeName($aFileList[$i]&"\"&@OSArch)

				 $appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
				  ;$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				  ;
				local $res=StringSplit($fileName,"_")
				$version=$res[2]
				 ;$version=StringRight($fileName,StringLen($fileName)-StringLen("Firefox Setup "))
				 ;$version=StringLeft($version,(StringLen($version)-4))
				$arr[7][4]=$fileName
				$arr[4][4]=$chemin&"\"&$aFileList[$i]
				$arr[5][4]=2
			case "xpb"
				 $appName="Cdxpburner"
				 $fileName=exeName($aFileList[$i])

				 $appPath=$chemin&"\"&$aFileList[$i]
				$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				 $arr[7][5]=$fileName
				$arr[4][5]=$chemin&"\"&$aFileList[$i]
				$arr[5][5]=1
			case "7zip"
				$appName="7zip"
				$fileName=exeName($aFileList[$i]&"\"&@OSArch)

				$appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
				$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				 $arr[7][6]=$fileName
				$arr[4][6]=$chemin&"\"&$aFileList[$i]
				$arr[5][6]=2
			case "fpl"
				$appName="FlashPlayer"
				$fileName=exeName($aFileList[$i]&"\"&@OSArch)
				$appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
				$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				$version=StringReplace($version,',','.')
				 $arr[7][7]=$fileName
				$arr[4][7]=$chemin&"\"&$aFileList[$i]
				$arr[5][7]=2
			case "acr"
				;AcroRdrDC1500720033_en_US.exe /sPB /rs /msi TRANSFORMS=\Server.fqdn\share\ReaderDC.mst
				$appName="Acrobate"
				$fileName=exeName($aFileList[$i]);&"\"&@OSArch)

				$appPath=$chemin&"\"&$aFileList[$i];&"\"&@OSArch
				$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				$version="20"&$version
				;$version=StringReplace($version,',','.')
				$arr[7][8]=$fileName
				$arr[4][8]=$chemin&"\"&$aFileList[$i]
				$arr[5][8]=1
			case "thb"
				 $appName="ThunderBird"
				 $fileName=exeName($aFileList[$i]);&"\"&@OSArch)

				 $appPath=$chemin&"\"&$aFileList[$i];&"\"&@OSArch
				 ;$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				 local $res=StringSplit($fileName,"_")
				 $version=$res[2]
				 $arr[7][9]=$fileName
				 $arr[4][9]=$chemin&"\"&$aFileList[$i]
				 $arr[5][9]=1
				 $version=StringReplace($version,'-','.')
			case "mse"
				$appName="Mse"


				$fileName=exeName($aFileList[$i]&"\"&@OSArch)

				$appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
				$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				 $arr[7][10]=$fileName
				 $arr[4][10]=$chemin&"\"&$aFileList[$i]
				 $arr[5][10]=2
			case "java"
				$fileName=""
				$appName="Java"
				$fileName=exeName($aFileList[$i]&"\"&@OSArch)
				$appPath=$chemin&"\"&$aFileList[$i]&"\"&@OSArch
				$version=FileGetVersion($appPath&"\"&$fileName,$FV_FILEVERSION)
				$arr[7][10]=$fileName
				$arr[4][10]=$chemin&"\"&$aFileList[$i]
				$arr[5][10]=2
			case "msoff"
				$fileName=""
				$appName="Office2010"
			Case Else

		EndSwitch
		if $fileName<>"" then
			$nvVersion=appVersion($appName)
			$nvVersion=StringStripWS($nvVersion,8)
			$version=StringStripWS ($version,8)
			;MsgBox($MB_SYSTEMMODAL,"info "&$appName,"versAct="&$version&" nversion="&$nvVersion)
			if $version<>$nvVersion then
					local $verF=StringSplit($version,".")
					local $verR=StringSplit(StringStripWS ($nvVersion,8),".")
					local $ind=Number($VerF[0])

					if $ind>Number($verR[0]) then
						$ind=Number($verR[0])
					endif
					local $k=1
					while $ind>=$k and Number($verR[$k])=Number($verF[$k])
						$k+=1
					wend
					if($k<>$ind+1) then
						if (Number($verR[$k])>Number($verF[$k])) then
								;MsgBox($MB_SYSTEMMODAL,"info "&$appName,"vr:"&$nvVersion&"vf:"&$version&"update")
								activateForDownload($appName,$nvVersion)
							endif
					endif

							;ToolTip("version de " & $appName&" est "&"versAct="&$version&" nversion="&$nvVersion,@DeskTopWidth, @DeskTopHeight-70,"info",1,4)

			;ToolTip("vf:"&$nvVersion&"vr:"&$version&" "&$ind,@DeskTopWidth, @DeskTopHeight-70,$appName,1,4)

			endif
		;ToolTip("version de " & $appName&" est "&$version,@DeskTopWidth, @DeskTopHeight-70,"info",1,4)
		;sleep(1000)
		endif
		$i+=1
	WEnd
MsgBox($MB_SYSTEMMODAL,"Info ","recherche des mises à jour est terminée")
downLoadapps()
EndFunc

 Func realDownload($source,$sFilePath,$pfileVersion)
    ; Save the downloaded file to the temporary folder.


    ; Download the file in the background with the selected option of 'force a reload from the remote site.'
    Local $hDownload = InetGet($source, $sFilePath&$pfileVersion, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)

    ; Wait for the download to complete by monitoring when the 2nd index value of InetGetInfo returns True.
    Do
        Sleep(250)
    Until InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)

    ; Retrieve the number of total bytes received and the filesize.
    Local $iBytesSize = InetGetInfo($hDownload, $INET_DOWNLOADREAD)
	Local $completed = InetGetInfo($hDownload, $INET_DOWNLOADCOMPLETE)
    Local $iFileSize = FileGetSize($sFilePath)

    ; Close the handle returned by InetGet.
    InetClose($hDownload)


   if not $completed then
		MsgBox($MB_SYSTEMMODAL,"Info ","telechargement de ","le fichier est imcomplet",3000)
		FileDelete($sFilePath)
		return false
	else
		MsgBox($MB_SYSTEMMODAL,"Info ",$source&" télécharger avec succçès",3000)
		return true
	endif

    ;
    ;
 EndFunc   ;==>Example

Func downloadlink($lien)
;new-dl-btn
		local $oIE = Null
		Local $oElem=Null
		local $result=""
		;$oIE=connectPage($lien)
		$oIE = _IECreate($lien,0,0,0)
		sleep(4000)
		$oElem=$oIE.document.getElementById("btn_telecharger")
		sleep(2000)
		$result=$oElem.getAttribute("data-software")
		_IEQuit($oIE)
		return $result

Endfunc

Func downloadlinkJava($lien)

	local $link=downloadlink($lien);
	local $oIE = Null
	Local $oElems[2]
	local $result=""
	local $click=null
	$oIE=connectPage($link)
	sleep(4000)
	ConsoleWrite("console"&@CRLF)
	$forms=$oIE.document.forms
	sleep(2000)

	for $form in $forms
		if $form.name="agreementFormjre-8u144-oth-JPR" then
			consolewrite($form.innertext&@CRLF)
			$inputs=$form.getElementsByTagName("input")
			for $input in $inputs
				if($input.name="agreementjre-8u144-oth-JPR") Then
					$input.click()
					endif
			next
		endif
	next

	$as=$oIE.document.body.getElementsByTagName("a")
	for $a in $as
		if $a.name="jre-8u144-oth-JPRXXXjre-8u144-windows-i586.exe" then
			$oElems[0]=$a.href
		else
			if $a.name="jre-8u144-oth-JPRXXXjre-8u144-windows-x64.exe" then
				$oElems[1]=$a.href
			endif
		endif
	next
	_IEQuit($oIE)


Endfunc

func downLoadapps()

			local $i=0
			local $link1=""
			local $link2=""
			while $i<$Len
				if $arr[3][$i]=true Then

					if $arr[5][$i]=1 then ;application sous forme 32 bis
							MsgBox($MB_SYSTEMMODAL,"Info ","telechargement de "&$arr[0][$i],3000)
							$link1=downloadlink($arr[2][$i])
							if realDownload($link1,$arr[4][$i]&"\",$arr[0][$i]&"_"&$arr[8][$i]&".exe") then
								FileDelete ($arr[4][$i]&"\"&$arr[7][$i])
							endif

					else	;applocation sous forme 32 bis et 64 bits
							MsgBox($MB_SYSTEMMODAL,"Info ","telechargement de "&$arr[0][$i],3000)

							if $i=10 then ;java
										local $links[2]
										$links=downloadlinkJava($arr[2][$i])
									if  realDownload($links[0],$arr[4][$i]&"\X86\",$arr[0][$i]&"_"&$arr[8][$i]&".exe") then
										FileDelete ($arr[4][$i]&"\X86\"&$arr[7][$i])
										endif
										if  realDownload($links[1],$arr[4][$i]&"\X64\",$arr[0][$i]&"_"&$arr[8][$i]&".exe") then
										FileDelete ($arr[4][$i]&"\X64\"&$arr[7][$i])
										endif

							else
									if $i=2 then ;libreOffice
										$link1=downloadlink($arr[2][$i])
										$link2=downloadlink($arr[6][$i])
										if  realDownload($link1,$arr[4][$i]&"\X86\",$arr[0][$i]&"_"&$arr[8][$i]&".msi") then
										FileDelete ($arr[4][$i]&"\X86\"&$arr[7][$i])
										endif
										if  realDownload($link2,$arr[4][$i]&"\X64\",$arr[0][$i]&"_"&$arr[8][$i]&".msi") then
										FileDelete ($arr[4][$i]&"\X64\"&$arr[7][$i])
										endif
										else

									;MsgBox($MB_SYSTEMMODAL,"Info ","telechargement de "&$arr[0][$i]&"vers"&$arr[4][$i]&"\X86"&$arr[8][$i]&".exe")
										$link1=downloadlink($arr[2][$i])
										$link2=downloadlink($arr[6][$i])
										if  realDownload($link1,$arr[4][$i]&"\X86\",$arr[0][$i]&"_"&$arr[8][$i]&".exe") then
											MsgBox($MB_SYSTEMMODAL,"Info ",$arr[4][$i]&"filename "&$arr[7][$i])
										FileDelete ($arr[4][$i]&"\X86\"&$arr[7][$i])
										endif
										if  realDownload($link2,$arr[4][$i]&"\X64\",$arr[0][$i]&"_"&$arr[8][$i]&".exe") then
											MsgBox($MB_SYSTEMMODAL,"Info ",$arr[4][$i]&"filename "&$arr[7][$i])
										FileDelete ($arr[4][$i]&"\X64\"&$arr[7][$i])
										endif
								  endif
							endif
					Endif
				endif
				$i+=1
			wend

endfunc

func appVersion($app)
	local $j=0
	while $arr[0][$j]<>$app
		$j+=1
	WEnd
	return rechercheVersion($j)
EndFunc

func connectPage($pUrl)
	local $FILESOURCE =Null
		$FILESOURCE = _IECreate($pUrl,0,0,0)
		sleep(2000)
		while @error<>0
			_IEQuit($FILESOURCE)
			$FILESOURCE=_IECreate($pUrl,0,0,0)
			sleep(2000)
		wend
	return $FILESOURCE
EndFunc
func rechercheVersion($i)

	local $dom=Null
	;#RequireAdmin
		;$headers='Referer: eh ?' & @CRLF & 'User-Agent: mickeymouse' & @CRLF
		;$oIE.Navigate($adresse[$i][1])

		local $oIE =Null
		$oIE =connectPage($arr[2][$i])
			Local $oElems=Null


			$oElems=$oIE.document.getElementsByClassName("tc_encadre_texte")


					;MsgBox($MB_SYSTEMMODAL,"version","ici")
					for $oElem in $oElems

						$attrib=$oElem.getAttribute("itemprop")
						if $attrib="softwareVersion" Then

								$result=StringSplit($oElem.innerHTML, " -")
								if $result<>null then
									if $result[0]>0 then
										;MsgBox($MB_SYSTEMMODAL,"info", $result[0])
										_IEQuit($oIE)
										return $result[1];

									Else
										MsgBox($MB_SYSTEMMODAL,"erreur","lien vers "&$arr[0][$i]&" est mort")
									endif
								else
									MsgBox($MB_SYSTEMMODAL,"erreur","lien vers "&$arr[0][$i]&" est mort")
								endif
							ExitLoop
						endif

					Next

			_IEQuit($oIE)
			;MsgBox($MB_SYSTEMMODAL,"version",$i)

			return ""

endfunc

;desactiveAes()
;mise à jour dosier
;Mdossiers()
;downloadlinkJava("http://www.01net.com/telecharger/windows/Programmation/java/fiches/8138.html")


;********************************************************************************************************************************************

if(DetectInfrastructure()=1) Then;
	initGUI()
	desactiveAes()

		While 1 ; Début de la boucle infinie

			$nMsg = GUIGetMsg() ; Récupération des messages GUI
			Switch $nMsg ; Début du sélecteur de cas

				Case $GUI_EVENT_CLOSE ; Si clic fermeture fenêtre GUI1 ou GUI2 on sort
					MsgBox(64, 'Info', 'Vous avez choisi de fermer la fenêtre en cours') ; Message
					releaseRessources()
					Exit ; Fin du script

				Case $Btn1 ; Si clic sur le bouton $Btn1
					GUISetState(@SW_HIDE)
					dossiers()
					releaseRessources()
					Exit

				Case $Btn2
					local $i=0
					while $i <> $Len and $arr[0][$i]=false
						$i=$i+1
					WEnd
					if $i=$Len then
						for $i=0 to ($Len-1)
							$arr[1][$i]=true
							GUICtrlSetState ($chBoxes[$i],$GUI_CHECKED )

						next
						GUICtrlSetData ($Btn2,"Décocher" )
					else
						for $i=0 to ($Len-1)
							$arr[1][$i]=false
							GUICtrlSetState ($chBoxes[$i],$GUI_UNCHECKED )

						next
						GUICtrlSetData ($Btn2,"Cocher" )
					endif
				Case $Btn3
					Mdossiers()
				Case $chBoxes[0] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][0]=Not $arr[1][0]
				Case $chBoxes[1] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][1]=Not $arr[1][1]
				Case $chBoxes[2] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][2]=Not $arr[1][2]
				Case $chBoxes[3] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][3]=Not $arr[1][3]
				Case $chBoxes[4] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][4]=Not $arr[1][4]
				Case $chBoxes[5] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][5]=Not $arr[1][5]
				Case $chBoxes[6] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][6]=Not $arr[1][6]
				Case $chBoxes[7] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][7]=Not $arr[1][7]
				Case $chBoxes[8] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][8]=Not $arr[1][8]
				Case $chBoxes[9] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][9]=Not $arr[1][9]
				Case $chBoxes[10] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][10]=Not $arr[1][10]
				Case $chBoxes[11] ; Si clic sur le contrôle $Chb1 (CheckBox)
					$arr[1][11]=Not $arr[1][11]
				Case Else
					if Not NotinstallMse() then
						if $nMsg=$chBoxes[$Len-1] then
							$arr[1][$Len-1]=Not $arr[1][$Len-1]
						EndIf
					EndIf

			EndSwitch ; Fin du sélecteur de cas
		WEnd ; Fin d

EndIf

