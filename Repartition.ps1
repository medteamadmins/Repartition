# Retrieve C drive size information
$drive = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$driveSizeGB = [math]::Round($drive.Size / 1GB, 2) # Size in GB
#$freeSpaceGB = [math]::Round($drive.FreeSpace / 1GB, 2) # Free space in GB

# Output the results
#Write-Output "C Drive Size: $($driveSizeGB) GB"
#Write-Output "Free Space on C Drive: $($freeSpaceGB) GB"


If ($driveSizeGB -lt 200){ # If C drive size less than 200, do 100GB for C and the rest for D.
    Resize-Partition -DriveLetter C -Size 100GB
	New-Partition -DiskNumber 0 -UseMaximumSize -NewDriveLetter D | Format-Volume
	Set-Volume -DriveLetter D -NewFileSystemLabel "Data"
}
Else{
	# If the size is larger than 200 do half.
	$currentSize = (Get-Partition -DriveLetter C).Size
	$newSize = [math]::Round($currentSize / 2)
	# Resize the C drive to the new size
	Resize-Partition -DriveLetter C -Size $newSize
	New-Partition -DiskNumber 0 -UseMaximumSize -NewDriveLetter D | Format-Volume
	Set-Volume -DriveLetter D -NewFileSystemLabel "Data"
}
