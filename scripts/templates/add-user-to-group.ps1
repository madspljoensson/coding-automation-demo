# Template: Add User to Azure AD Group
# Usage: ./add-user-to-group.ps1 -UserEmail "user@solita.dk" -GroupName "GroupName"

param(
    [Parameter(Mandatory = $true)]
    [string]$UserEmail,
    
    [Parameter(Mandatory = $true)]
    [string]$GroupName
)

$ErrorActionPreference = "Stop"

Write-Host "Adding $UserEmail to group $GroupName..."

# Get user object ID
$user = az ad user show --id $UserEmail --query id -o tsv
if (-not $user) {
    Write-Error "User not found: $UserEmail"
    exit 1
}
Write-Host "Found user: $user"

# Get group object ID
$group = az ad group show --group $GroupName --query id -o tsv
if (-not $group) {
    Write-Error "Group not found: $GroupName"
    exit 1
}
Write-Host "Found group: $group"

# Check if already a member
$isMember = az ad group member check --group $GroupName --member-id $user --query value -o tsv
if ($isMember -eq "true") {
    Write-Host "User is already a member of the group. No action needed."
    exit 0
}

# Add user to group
az ad group member add --group $GroupName --member-id $user

Write-Host "Successfully added $UserEmail to $GroupName"

