<#
.SYNOPSIS
    One-time setup script to configure the GitHub Packages NPM token.

.DESCRIPTION
    Sets the NODE_AUTH_TOKEN environment variable (user-level) so that .npmrc
    can reference it via ${NODE_AUTH_TOKEN} without ever hardcoding secrets in git.

.EXAMPLE
    .\setup.ps1
    # Prompts you for the token interactively

    .\setup.ps1 -Token "ghp_xxxxx"
    # Sets the token directly
#>
param(
    [string]$Token
)

if (-not $Token) {
    $Token = Read-Host -Prompt "Enter your GitHub Personal Access Token (for npm.pkg.github.com)"
}

if (-not $Token) {
    Write-Host "Error: No token provided. Aborting." -ForegroundColor Red
    exit 1
}

# Set as a persistent user-level environment variable
[System.Environment]::SetEnvironmentVariable("NODE_AUTH_TOKEN", $Token, "User")

# Also set it in the current session so it works immediately
$env:NODE_AUTH_TOKEN = $Token

Write-Host ""
Write-Host "NODE_AUTH_TOKEN has been set successfully!" -ForegroundColor Green
Write-Host "  - Persisted to your user environment variables." -ForegroundColor DarkGray
Write-Host "  - Available in this terminal session immediately." -ForegroundColor DarkGray
Write-Host ""
Write-Host "You may need to restart other terminal windows for the change to take effect." -ForegroundColor Yellow
