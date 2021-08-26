param(
    [string] $ResourceGroupName,
    [string] $AKSName
)


$templateFilePath = [System.IO.Path]::Combine($PSScriptRoot, 'template.json')

$rgDeploymentOutput = New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $templateFilePath `
    -clusterName $AKSName
   
foreach ($key in $rgDeploymentOutput.Outputs.Keys)
{
    $value = $rgDeploymentOutput.Outputs[$key].Value
    Write-Host "##vso[task.setvariable variable=$key]$value"
}