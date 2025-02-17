$CurrDir = Get-Location

Write-Host "Reading Terraform Outputs"
Set-Location "./terraform"
Import-Module .\..\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform
Set-Location $CurrDir

Write-Host "Starting Adf Patterns" -ForegroundColor Yellow
Set-Location ../DataFactory/Patterns/
Invoke-Expression  ./Jsonnet_GenerateADFArtefacts.ps1

if ($tout.adf_git_toggle_integration) {
    Invoke-Expression  ./UploadGeneratedPatternsToGit.ps1
}
else {
    Invoke-Expression  ./UploadGeneratedPatternsToADF.ps1
}
Invoke-Expression  ./UploadTaskTypeMappings.ps1
#Below is temporary - we want to make a parent folder for the both of these directories in the future.
#Currently there are duplicate powershell scripts. Plan is to iterate through each subfolder (datafactory / synapse) with one script
Write-Host "Starting Synapse Parts" -ForegroundColor Yellow
Set-Location ../../Synapse/Patterns/ 
Invoke-Expression  ./Jsonnet_GenerateADFArtefacts.ps1
if ($tout.synapse_git_toggle_integration) {
    Invoke-Expression  ./UploadGeneratedPatternsToGit.ps1
}
else {
    Invoke-Expression  ./UploadGeneratedPatternsToADF.ps1
    Invoke-Expression  ./uploadNotebooks.ps1
}
Invoke-Expression  ./UploadTaskTypeMappings.ps1


Set-Location $CurrDir