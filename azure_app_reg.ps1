#Skript muss als ADMIN ausgeführt werden!
#Skript muss als ADMIN ausgeführt werden!
#Skript muss als ADMIN ausgeführt werden!


#Installieren des Moduls
Install-Module AzureAD
Import-Module AzureAD

Connect-AzureAD


# Skript zum Erstellen einer Azure AD-Anwendungsregistrierung, Zuweisen der Microsoft Graph-Berechtigungen und Erstellen eines Client Secrets

# Variablen
$appName = "TerraformTest (via PowerShell)"
$requiredPermissions = @("Application.Read.All" ,"Directory.Read.All", "Domain.Read.All" , "Group.ReadWrite.All" , "Policy.Read.All" , "Policy.ReadWrite.AuthenticationMethod" , "Policy.ReadWrite.Authorization" , "Policy.ReadWrite.ConditionalAccess", "User.ReadWrite.All")
$clientSecretDescription = "Terraform Client Secret"
$clientSecretStartDate = [System.DateTime]::Now
$clientSecretEndDate = $clientSecretStartDate.AddYears(1)



# Schritt 1: Erstellen der Anwendungsregistrierung
$app = New-AzureADApplication -DisplayName $appName

# Schritt 2: Service Principal für die Anwendung erstellen
$servicePrincipal = New-AzureADServicePrincipal -AppId $app.AppId

# Schritt 3: Microsoft Graph API Berechtigungen zuweisen
# Zuerst die ID der Microsoft Graph API holen
$graphAPI = Get-AzureADServicePrincipal -Filter "DisplayName eq 'Microsoft Graph'"

# Die IDs der benötigten Berechtigungen holen
$permissions = @()
foreach ($permission in $requiredPermissions) {
    $graphPermission = $graphAPI.Oauth2Permissions | Where-Object { $_.Value -eq $permission }
    $resourceAccess = New-Object -TypeName Microsoft.Open.AzureAD.Model.ResourceAccess -ArgumentList $graphPermission.Id, "Scope"
    $permissions += $resourceAccess
}

# Berechtigungen der Anwendung zuweisen
$appPermission = New-Object -TypeName Microsoft.Open.AzureAD.Model.RequiredResourceAccess
$appPermission.ResourceAppId = $graphAPI.AppId
$appPermission.ResourceAccess = $permissions
$app.RequiredResourceAccess = $appPermission
Set-AzureADApplication -ObjectId $app.ObjectId -RequiredResourceAccess $app.RequiredResourceAccess

# Schritt 4: Client Secret erstellen
$clientSecret = New-AzureADApplicationPasswordCredential -ObjectId $app.ObjectId -CustomKeyIdentifier $clientSecretDescription -StartDate $clientSecretStartDate -EndDate $clientSecretEndDate -Value (New-Guid).Guid

#Schritt 5: Tenant ID abfragen
$tenantid = (Get-AzureADTenantDetail).objectid

#Schritt 6: Ausgabe aller Werte.
Write-Output "Anwendungsregistrierung '$appName' erstellt und Berechtigungen '$($requiredPermissions -join ", ")' zugewiesen."
Write-Host ""
Write-Host ""
Write-Host "Tenant ID: $tenantid" -BackgroundColor Black -ForegroundColor white
Write-Host ""
Write-Host "Client ID: $($app.AppId)" -BackgroundColor Black -ForegroundColor white
Write-Host ""
Write-Host "Client Secret: $($clientSecret.Value)" -BackgroundColor Black -ForegroundColor white



#Zuletzt muss man den Berechtigungen noch einmal zustimmen als admin!
#https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/RegisteredApps