[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

$DeleteSource = "a"
$SplitXISO = "a"
$TruncateNames = "a"

$Yes = @("Yes", "YES", "yes", "Y", "y")
$No = @("No", "NO", "no", "N", "n")

while(-not($Yes.contains($SplitXISO) -or $No.contains($SplitXISO))) {
	$SplitXISO = Read-Host -Prompt "Split XISO? [Y]es or [N]o"
}
while(-not($Yes.contains($TruncateNames) -or $No.contains($TruncateNames))) {
	$TruncateNames = Read-Host -Prompt "Truncate Names? [Y]es or [N]o"
}
while(-not($Yes.contains($DeleteSource) -or $No.contains($DeleteSource))) {
	$DeleteSource = Read-Host -Prompt "Delete Source? [Y]es or [N]o"
}

$GetSource = New-Object System.Windows.Forms.FolderBrowserDialog
$GetSource.Description = "Select Redump Source Directory"
$GetSource.rootfolder = "MyComputer"
if($GetSource.ShowDialog() -eq "OK"){
    $SourceDir = $GetSource.SelectedPath
}

$GetDest = New-Object System.Windows.Forms.FolderBrowserDialog
$GetDest.Description = "Select XISO Destination"
$GetDest.rootfolder = "MyComputer"
if($GetDest.ShowDialog() -eq "OK"){
    $DestDir = $GetDest.SelectedPath
}

$Games = Get-ChildItem -Path $SourceDir -Directory

foreach($Game in $Games) {
	
	echo("Converting $Game...")
	
	#Truncate name if selected
	$GameName = $Game.Name
	if($Yes.contains($TruncateNames) -and $GameName.length -gt 38){
		$GameName = $GameName.Substring(0,38)
	}
	
	#Create packed XISO and delete source
	if($Yes.contains($DeleteSource)) {
		./extract-xiso.exe -q -c $SourceDir\$Game $DestDir\$GameName.iso
		Remove-Item -R $SourceDir\$Game
	}
	
	#Create packed XISO and keep source
	else{
		./extract-xiso.exe -q -c $SourceDir\$Game $DestDir\$GameName.iso
	}
	
	$GameXISO = Get-Item $DestDir\$GameName.iso

	#Split XISO if larger than 4GB and truncate name if selected
	if($GameXISO.length/1MB -gt 4094 -and $Yes.contains($SplitXISO)){
		if($Yes.contains($TruncateNames) -and $GameXISO.BaseName.length -gt 36){
			$ShortName = $GameXISO.BaseName.Substring(0,36)
			Rename-Item $GameXISO "$ShortName.iso"
			$GameXISO = Get-Item("$DestDir\$ShortName.iso")
		}
		$GameName = $GameXISO.BaseName
		./fSplit.exe -split 4094 mb $GameXiso -f "$DestDir\$GameName.{0}.iso"
		Remove-Item $GameXiso
	}
}