[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

$DeleteSource = "a"

$Yes = @("Yes", "YES", "yes", "Y", "y")
$No = @("No", "NO", "no", "N", "n")

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
$GetDest.Description = "Select Game Directories Destination"
$GetDest.rootfolder = "MyComputer"
if($GetDest.ShowDialog() -eq "OK"){
    $DestDir = $GetDest.SelectedPath
}

$Games = Get-ChildItem -Path $SourceDir -Filter *.iso

foreach($Game in $Games) {
	
	echo("Extracting $Game...")
	$GameName = $Game.BaseName
	./extract-xiso.exe -q -d $DestDir\$GameName $SourceDir\$Game
	
	#Delete source
	if($Yes.contains($DeleteSource)) {
		Remove-Item $SourceDir\$Game
	}
}