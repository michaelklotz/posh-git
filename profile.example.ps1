Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$env:path += ";${env:ProgramFiles(x86)}\Git\bin"

# Load posh-git module from current directory
Import-Module .\posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git

# source work functions
. .\work-functions.ps1

# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
$global:LINE=$global:LINE + 1
    Write-Host "    Time: "$(get-date) `($($global:LINE)`) `n -foregroundcolor "Yellow"

    $p = Split-Path -leaf -path (Get-Location)


    Write-Host($p) -nonewline -foregroundcolor "Gray"

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE

    return " > "
}

Enable-GitColors

Pop-Location

Start-SshAgent -Quiet
