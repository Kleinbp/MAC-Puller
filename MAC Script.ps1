#By Philip Kleinberg


#Message read out to the user
echo "Please enter the location of the list of computer names (ex: C:/Users/Admin/List.txt)"

#Lets the user enter the path to their list of computer names
$ListLocation = Read-host


#Reads the list of computer names
$computers = Get-Content -Path $ListLocation


#This script block gets the MACs and the computer names from the list of target computers 
Invoke-command -ComputerName $computers -ScriptBlock {

#Gets the macs
$Mac = Get-NetAdapter | Select-Object -Property Name, MacAddress

#Gets computer name
$ComputerName = Get-WmiObject -Class win32_computersystem | Select-Object -Property Name

#Combines the MACs and computer names
$Mac + $ComputerName | Out-File -FilePath C:\Users\Public\Documents\Output.txt

}

#Final list location
$FinalListLocation = "C:\Users\Public\Documents\MACs.txt"

#Gathers the various Output files and brings them to the host machine
Echo "Gathering MAC addresses"
ForEach ($CName in $computers) {Move-Item -Verbose -Path \\$CName\C$\Users\Public\Documents\Output.txt -Destination C:\Users\Public\Documents\$CName' Output'.txt}
Echo "Done"


#Combines all the Outputfiles into multiple
echo "Combining final list"
Get-Content -Verbose C:\Users\Public\Documents\*Outout*.txt | Set-Content $FinalListLocation
echo "Final list created"


#Removes the unneeded files
echo "Removing the extra files"
Remove-Item -Verbose C:\Users\Public\Documents\*Output*.txt
echo "Removal done"


#Opens the final file?
$FinalListLocation

Clear-Host





