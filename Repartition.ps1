# Calculate the new size as 50% of the current size
$currentSize = (Get-Partition -DriveLetter C).Size
$newSize = [math]::Round($currentSize / 2)

# Resize the C drive to the new size
Resize-Partition -DriveLetter C -Size $newSize
New-Partition -DiskNumber 0 -UseMaximumSize -NewDriveLetter D | Format-Volume
Set-Volume -DriveLetter D -NewFileSystemLabel "Data"
