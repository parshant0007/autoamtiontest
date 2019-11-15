
##-------------------------------------------------------------------
## Name           ARM Create Recovery Services vault
## Usage          ARM_Create_Recovery_Services_vault_v1.0.ps1
## Note           Change variables were needed to fit your needs
## Creator        Wim Matthyssen
## Date           05/07/17
## Version        1
##-------------------------------------------------------------------

## Requires -RunAsAdministrator

## Log on with your Azure account

#Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionName Enterprise
##-------------------------------------------------------------------

# Variables

$RGBackup = "Ax-Ent-BCK"
$Location = "East Asia"
$RSVName = "Ax-EA-Ent-ProdBCK"
$StorageRedundancyLRS = "LocallyRedundant"
$StorageRedundancyGRS = "GeoRedundant"

##-------------------------------------------------------------------

## Create a Recovery Services vault

# Register the Azure Recovery Service provider with your Azure subscription
Register-AzureRmResourceProvider -ProviderNamespace "Microsoft.RecoveryServices"

# Create the resource group
#New-AzureRmResourceGroup –Name $RGBackup –Location $Location
#Write-Host "Resource group $RGBackup selected" -foregroundcolor "Yellow"

# Select the resource group
Get-AzureRmResourceGroup –Name $RGBackup –Location $Location
Write-Host "Resource group $RGBackup selected" -foregroundcolor "Yellow"

# Create the Recovery Services vault  
New-AzureRmRecoveryServicesVault -Name $RSVName -ResourceGroupName $RGBackup -Location $Location

# Specify the type of storage redundancy for the Recovery Services vault
$VarRSV = Get-AzureRmRecoveryServicesVault –Name $RSVName
Set-AzureRmRecoveryServicesBackupProperties  -Vault $VarRSV -BackupStorageRedundancy $StorageRedundancyLRS
Write-Host "Recovery Serives vault $RSVName created" -foregroundcolor "Yellow"

