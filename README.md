# OGXbox_extract-xiso_Batch_Scripts
Collection of PowerShell scripts to use extract-iso on batches of games

All magic and credit to extract-iso (https://github.com/XboxDev/extract-xiso)

-----------------------------------------------------------------

RedumpToXISO:

Convert OG Xbox Redump ISOs to repacked (shrank) XISO format 

This script batch converts Xbox Redumps (complete disc rips from archive.org) to playable xisos using extract-iso (https://github.com/XboxDev/extract-xiso). It also uses fsplit.exe (taken from the 'Create and Split' tool floating around OG Xbox scenes) in order to split the resulting XISO so that it can be stored on an Xbox.
The script asks the users if they want to delete the source redumps, split large XISOs, truncate the XISOs to 42 characters so they can be used on an Xbox.
The script asks the user to input a source directory of redump ISOs and a destination directory for the resultant XISOs.
The final XISOs will need to be further processed by the script built into XBMC4Gamers in order to create an attach.xbe and make them playable.

You can run the powershell script by double clicking RedumpToXISO.bat or running the following command:
powershell -ExecutionPolicy ByPass -File .\RedumpToXISO.ps1

-----------------------------------------------------------------

RedumpToDirectory

Extract OG Xbox Redump ISOs to directory format. This will also extract XISOs to directory format.

The script asks if you want to delete source redumps
The script asks the user to input a source directory of redump ISOs and a destination directory for the game directories

You can run the powershell script by double clicking RedumpToDirectory.bat or running the following command:
powershell -ExecutionPolicy ByPass -File .\RedumpToDirectory.ps1

-----------------------------------------------------------------

DirectoryToXISO

Convert OG Xbox games from directory format to repacked (shrank) XISO format

This script can use fsplit.exe (taken from the 'Create and Split' tool floating around OG Xbox scenes) in order to split the resulting XISO so that it can be stored on an Xbox.
The script asks the users if they want to delete the source redumps, split large XISOs, or truncate the XISOs to 42 characters so they can be used on an Xbox.
The script asks the user to input a source directory of games in directory format and a destination directory for the resultant XISOs.
The final XISOs will need to be further processed in order to create an attach.xbe and make them playable. I highly recommend Repackinator for this (https://github.com/Team-Resurgent/Repackinator) but you can also use the script built into XBMC4Gamers.

You can run the powershell script by double clicking DirectoryToXISO.bat or running the following command:
powershell -ExecutionPolicy ByPass -File .\DirectoryToXISO.ps1

-----------------------------------------------------------------

These scripts have minimal to no error handling and have only been tested on Windows 10. I can not vouch in any way for the provenance of fSplit.exe, fSplit.exe.config, or extract-iso.exe. This script comes with no guarantees or warranties. You can find me at:

twitter: braxtron instagram: son_of_mr_snails
