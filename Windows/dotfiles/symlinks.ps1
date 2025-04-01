$documents = [Environment]::GetFolderPath("MyDocuments")
New-Item -Path $documents\PowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Value (Get-Item ".\PowerShell\Microsoft.PowerShell_profile.ps1").FullName
New-Item -Path $documents\PowerShell\seanonetdev.omp.json -ItemType SymbolicLink -Value (Get-Item ".\PowerShell\seanonetdev.omp.json").FullName