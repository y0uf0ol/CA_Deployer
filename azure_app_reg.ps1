#Script must be run as ADMIN!
#Script must be run as ADMIN!
#Script must be run as ADMIN!

#Install the module
Install-Module AzureAD
Import-Module AzureAD
Connect-AzureAD

# Script to create an Azure AD application registration, assign Microsoft Graph permissions, and create a client secret

# Variables
$appName = "CA Deployer"
$requiredPermissions = @("Application.Read.All", "Directory.Read.All", "Domain.Read.All", "Group.ReadWrite.All", "Policy.Read.All", "Policy.ReadWrite.AuthenticationMethod", "Policy.ReadWrite.Authorization", "Policy.ReadWrite.ConditionalAccess", "User.ReadWrite.All")
$clientSecretDescription = "Terraform Client Secret"
$clientSecretStartDate = [System.DateTime]::Now
$clientSecretEndDate = $clientSecretStartDate.AddYears(1)

# Step 1: Create the application registration
$app = New-AzureADApplication -DisplayName $appName

# Step 2: Create service principal for the application
$servicePrincipal = New-AzureADServicePrincipal -AppId $app.AppId

# Step 3: Assign Microsoft Graph API permissions
# First, get the ID of the Microsoft Graph API
$graphAPI = Get-AzureADServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'"

# Get the IDs of the required permissions
$permissions = @()
foreach ($permission in $requiredPermissions) {
    $appRole = $graphAPI.AppRoles | Where-Object { $_.Value -eq $permission -and $_.AllowedMemberTypes -contains "Application" }
    if ($appRole) {
        $resourceAccess = New-Object -TypeName Microsoft.Open.AzureAD.Model.ResourceAccess
        $resourceAccess.Id = $appRole.Id
        $resourceAccess.Type = "Role"
        $permissions += $resourceAccess
    }
}

# Assign permissions to the application
$requiredResourceAccess = New-Object -TypeName Microsoft.Open.AzureAD.Model.RequiredResourceAccess
$requiredResourceAccess.ResourceAppId = $graphAPI.AppId
$requiredResourceAccess.ResourceAccess = $permissions
Set-AzureADApplication -ObjectId $app.ObjectId -RequiredResourceAccess @($requiredResourceAccess)

# Step 4: Create client secret
$clientSecret = New-AzureADApplicationPasswordCredential -ObjectId $app.ObjectId -CustomKeyIdentifier $clientSecretDescription -StartDate $clientSecretStartDate -EndDate $clientSecretEndDate

# Step 5: Query Tenant ID
$tenantId = (Get-AzureADTenantDetail).ObjectId

# Step 6: Output all values
Write-Output "Application registration '$appName' created and permissions '$($requiredPermissions -join ", ")' assigned."
Write-Host ""
Write-Host ""
Write-Host "Tenant ID: $tenantId" -BackgroundColor Black -ForegroundColor White
Write-Host ""
Write-Host "Client ID: $($app.AppId)" -BackgroundColor Black -ForegroundColor White
Write-Host ""
Write-Host "Client Secret: $($clientSecret.Value)" -BackgroundColor Black -ForegroundColor White

Write-Host ""
Write-Host "IMPORTANT: You must now grant permissions for the application as an administrator."
Write-Host "Go to: https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/RegisteredApps"
Write-Host "Select the application '$appName', go to 'API permissions' and click on 'Grant admin consent for [Your Directory]'."
