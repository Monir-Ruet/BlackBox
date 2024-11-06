# $env can be "local", "dev", "staging", or "prod"
param (
    [string]$env = 'local'
)

$Subscriptions = @{
    'local' = @{
        name = 'Azure for Students'
        label = 'Development'
    }
    'dev' = @{
        name = 'Azure for Students'
        label = 'Integration'
    }
    'staging' = @{
        name = 'Azure for Students'
        label = 'Staging'
    }
    'prod' = @{
        name = 'Azure for Students'
        label = 'Production'
    }
}

$Subscription = $Subscriptions[$env]
$SubscriptionName = $Subscription.name

$label = $Subscription.label


az account set --subscription $SubscriptionName


function New-ConfigFile {
    param (
        [string]$FileName,
        [string]$ConfigType
    )

    return @{
        FileName = $FileName
        ConfigType = $ConfigType
    }
}

$sharedConfigs = @(
    New-ConfigFile -FileName "blackbox-auth.yaml" -ConfigType "config"
)

function Set-ConfigValues {
    param (
        [string]$fileName,
        [string]$configType
    )

    if ($configType -eq "config") {
        az appconfig kv import -n "projectx-apps-conf-dev" -s file --label $label --path "./$fileName" --format yaml --auth-mode login --yes
    }
    else {
        az appconfig kv import -n "projectx-apps-conf-dev" -s file --label $label --path "./$fileName" --format json --content-type "application/vnd.microsoft.appconfig.keyvaultref+json;charset=utf-8" --auth-mode login --yes
    }
}

function Publish-Configs {
    param (
        [array]$configList
    )

    foreach ($config in $configList)
    {
        $fileName = $config.FileName
        $configType = $config.ConfigType
        Write-Host $fileName
    
        Set-ConfigValues -fileName $fileName -configType $configType
    }
}

if ($env -eq 'local') {
    Publish-Configs -configList $sharedConfigs
}
