Resize-Partition -DriveLetter C -Size 250GB
New-Partition -DiskNumber 0 -UseMaximumSize -NewDriveLetter D | Format-Volume
Set-Volume -DriveLetter D -NewFileSystemLabel "Data"
