<#
.SYNOPSIS
Fallen Install All Script
.DESCRIPTION
Performs automatic installation based on given parameters.

Current available app categories:
    General - everyone needs these.
    Communication - mostly social media.
    Google - adds Chrome browser and Drive local install.
    Gaming - launchers and differnent gaming utils. Has Genhin Impact optional install.
    Dev - installs environment for web dev with dotnet, node, python etc.
    Adobe - optional download of some of main adobe products.

Installer uses torrent downloads for some programs.
Magnet links are updated as of July 2023.
.PARAMETER help
Displays help information.
.PARAMETER version
Shows version of whis script.
.PARAMETER list
Displays all installation packages by categorioes.
.PARAMETER NoGoogle
Skipps installation of Google products.
.PARAMETER Conference
Includes apps for conference meetings.
.PARAMETER NoGaming
Skips all gaming related apps.
.PARAMETER NoDev
Skips all utilities for software development.
.PARAMETER Adobe
Skips all utilities for software development.
.INPUTS
This script doesn't accept any input other then switches.
.EXAMPLE
.\install_all.ps1
.EXAMPLE
.\install_all.ps1 -NoGoogle -Conference
.NOTES
Author : RingaVirda
Version : 1.0.6
Purpose : Autoinstall most of the usual apps.
#>

# This script uses only switch parameters
param(
    [Switch] $help,
    [Switch] $version,
    [Switch] $list,
    [Switch] $NoGoogle,
    [Switch] $Conference,  
    [Switch] $NoGaming,
    [Switch] $NoDev,
    [Switch] $Adobe  
)

begin {
    # Lists of all apps' ids
    $categories = [ordered] @{
        "General"       = [ordered] @{
            "VSCode"      = "Microsoft.VisualStudioCode";
            "Terminal"    = "Microsoft.WindowsTerminal";
            "PowerToys"   = "Microsoft.PowerToys";
            "OhMyPosh"    = "JanDeDobbeleer.OhMyPosh";
            "WinRar"      = "RARLab.WinRAR";
            "CCleaner"    = "Piriform.CCleaner";
            "DrawIO"      = "JGraph.Draw";
            "VLC"         = "VideoLAN.VLC";
            "OBS"         = "OBSProject.OBSStudio";
            "QBitTorrent" = "qBittorrent.qBittorrent";
            "DaemonTools" = "magnet:?xt=urn:btih:173220D1FC8481C27CD3784B1CEA1F0C54D7939A&tr=http%3A%2F%2Fbt4.t-ru.org%2Fann%3Fmagnet&dn=DAEMON%20Tools%20Ultra%20v5.5.1.1072%20x86%20x64%20RePack%20by%20KpoJIuK%20%5B2019%2C%20Multi%20%2B%20RUS%5D"
            "Office"      = "magnet:?xt=urn:btih:C2A0A9640BD7FDE833C67879FB043D1D4510CDBA&tr=http%3A%2F%2Fbt.t-ru.org%2Fann%3Fmagnet&dn=Microsoft%20Office%20LTSC%202021%20Professional%20Plus%20%2F%20Standard%20%2B%20Visio%20%2B%20Project%2016.0.14332.20517%20(x64)%20(Win10%2F11)%20RePack%20by%20KpoJIuK%20%5BENG%20%2B%20Rus%5CUkr%5D%2006.2023";
        };
        "Communication" = [ordered] @{
            "Telegram" = "Telegram.TelegramDesktop";
            "Discord"  = "Discord.Discord";
        };
        "Google"        = [ordered] @{
            "Chrome" = "Google.Chrome";
            "Drive"  = "Google.Drive";
        };
        "Gaming"        = [ordered] @{
            "Steam"             = "Valve.Steam";
            "SteamCMD"          = "Valve.SteamCMD";
            "BattleNet"         = "https://www.blizzard.com/download/confirmation?platform=windows&locale=en_US&product=bnetdesk";
            "GeforceExperience" = "Nvidia.GeForceExperience";
            "GeforceNow"        = "Nvidia.GeForceNow";
            "GenshinImpact"     = "https://genshin.hoyoverse.com";
            "Vortex"            = "NexusMods.Vortex";
        };
        "Dev"           = [ordered] @{
            "Gsudo"         = "gerardog.gsudo";
            "NMap"          = "Insecure.Nmap";
            "Git"           = "Git.Git";
            "DockerDesktop" = "Docker.DockerDesktop";
            "DockerCli"     = "Docker.DockerCLI";
            "NodeJS"        = "OpenJS.NodeJS";
            "DotnetSTS"     = "Microsoft.DotNet.SDK.7";
            "DotnetLTS"     = "Microsoft.DotNet.SDK.6";
            "Python"        = "Python.Python.3.12";
            "MSSQL"         = "Microsoft.SQLServer.2022.Express";
        };
    }
    # Failed installations
    $failed = @()
    # Parse options
    if ($NoGoogle.IsPresent) {
        Write-Host "[Installer] -NoGoogle: Removing the google category..."
        $categories.RemoveKey("Google")
    }
    if ($Conference.IsPresent) {
        Write-Host "[Installer] -Conference: Adding group meeting apps..."
        Add-Conference
    }
    if ($NoGaming.IsPresent) {
        Write-Host "[Installer] -NoGaming: Removing the gaming category..."
        $categories.RemoveKey("Gaming")
    }
    if ($NoDev.IsPresent) {
        Write-Host "[Installer] -NoDev: Removing the development category..."
        $categories.RemoveKey("Dev")
    }
    if ($Adobe.IsPresent) {
        Write-Host "[Installer] -Adobe: Installing optional abode products."
        Add-Adobe
    }
}
process {
    function Add-Conference {
        $categories["Communication"].Add("Teams", "Microsoft.Teams")
        $categories["Communication"].Add("Zoom", "Zoom.Zoom")
    }
    function Add-Adobe {
        $categories.Add("Adobe", [ordered] @{
                "Photoshop"   = "magnet:?xt=urn:btih:282FEE6BA001517D89B24F921C9DE9B11239E366&tr=http%3A%2F%2Fbt3.t-ru.org%2Fann%3Fmagnet&dn=Adobe%20Photoshop%202023%2024.6.0.573%20RePack%20by%20KpoJIuK%20%5BMulti%2FRu%5D";
                "PremierePro" = "magnet:?xt=urn:btih:3A994351470ADD8405ABEB23E5C81E3582C5D853&tr=http%3A%2F%2Fbt2.t-ru.org%2Fann%3Fmagnet&dn=Adobe%20Premiere%20Pro%202023%2023.4.0.56%20x64%20by%20m0nkrus%20%5B2023%2C%20MULTILANG%20%2B%20RUS%5D";
                "Audition"    = "magnet:?xt=urn:btih:4609CD6DF0EBCAD994237D54289608817C3036AE&tr=http%3A%2F%2Fbt.t-ru.org%2Fann%3Fmagnet&dn=Adobe%20Audition%202023%2023.3.0.55%20%5Bx64%5D%20PC%20%7C%20RePack%20by%20KpoJIuK%20%5B2023%2C%20Multi%20%2B%20RUS%5D";
            })
    }

    # Handle help
    if ($help.IsPresent) {
        Get-Help $MyInvocation.InvocationName -Detailed
        Exit 0
    }
    # Handle version
    if ($version.IsPresent) {
        (Get-Help $MyInvocation.InvocationName -Full).PSExtended.AlertSet
        Exit 0
    }
    # Handle list
    if ($list.IsPresent) {
        Add-Conference
        Add-Adobe
        foreach ($category in $categories.Keys) {
            Write-Host "Package Category: [${category}]"
            foreach ($appName in $categories[$category].Keys) {
                Write-Host "`t${appName}"
            }
        }
        Exit 0
    }
    
    Write-Host "
    ________________  .__  .__                 
    \_   _____/  _  \ |  | |  |   ____   ____  
     |    __)/  /_\  \|  | |  | _/ __ \ /    \ 
     |     \/    |    \  |_|  |_\  ___/|   |  \
     \___  /\____|__  /____/____/\___  >___|  /
         \/         \/               \/     \/ " -ForegroundColor Red
    Write-Host "`tInstall All Script v1.0"
    Write-Host ""
    Write-Host "Starting..."

    # Check if winget is present
    if (Get-Command -Name winget.exe -ErrorAction SilentlyContinue) { }
    else {
        Write-Host "Winget utility isn't installed on your machine." -ForegroundColor Red
        Write-Host "Please download it from Microsoft Store: https://www.microsoft.com/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab"
        Exit 0
    }

    function Install-Winget {
        param (
            [string] $appId
        )
        process {
            winget.exe install --id $appId -s winget   
        }
    }

    function Find-Winget {
        param (
            [string] $appId
        )
        process {
            $resp = winget.exe list --id $appId
            return $resp -match "No installed package" 
        }
    }

    function Open-Download {
        param (
            [string] $name,
            [string] $url,
            [string] $type
        )
        process {
            Write-Host $name
            
            if ($type -eq "normal") { 
                Write-Host "[Installer] ${name} requires to be manually installed from the official web-site." -ForegroundColor Yellow
                $resp = Read-Host "Open the link in the web-browser [Y/N]: "
            }
            if ($type -eq "torrent") {
                Write-Host "[Installer] ${name} requires to be manually installed through the torrent download." -ForegroundColor Yellow
                $resp = Read-Host "Open the link in the default torrent tracker [Y/N]: "
            }

            if ($resp.ToLower() -eq "y") {
                Write-Host "Manual installation confirmed."
                Start-Process $url
                Write-Host "Continuing..."
            }
            else {
                Write-Host "Manual installation declined."
                Write-Host "Skipping..."
            }
        }
    }
    
    # Main installation process
    foreach ($categoryName in $categories.Keys) {
        Write-Host "[Installer] Installing category: ${categoryName}" -ForegroundColor Yellow
        
        $category = $categories[$categoryName]
        # Actual installation
        foreach ($appName in $category.Keys) {
            Write-Host "[Installer] Installing app: ${appName}" -ForegroundColor Green
            $app = $category[$appName];
            if (-not (Find-Winget($app))) {
                Write-Host "[Installer] This app is already installed." -ForegroundColor Yellow
                Write-Host "Skipping..."
                continue
            }
            elseif ($app -like "https://*") {
                Open-Download $appName $app "normal"
                continue
            }
            elseif ($app -like "magnet:?xt*") {
                Open-Download $appName $app "torrent"
                continue
            }
            else {
                try {
                    Install-Winget $app
                    Write-Host "[Installer] App (${appName}) was successfully installed!" -ForegroundColor Green
                }
                catch {
                    Write-Host "[Installer] App (${appName}) failed to install!" -ForegroundColor Red
                    $failed.Add($app)
                    Write-Host "Continuing..."
                }
            }
        }
    }
} 
end {
    if ($failed.Count -eq 0) {
        Write-Host "Install All Script Finised!" -ForegroundColor Green
    }
    else {
        Write-Host "Install All Script finished with fails:" -ForegroundColor Yellow
        foreach ($fail in $failed) {
            Write-Host "`t${fail}`n"
        }
    }
}
