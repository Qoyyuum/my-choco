function Install-ChocoPackages
{
    [CmdletBinding()]
    param(
        [string[]]$Packages
    )

    foreach ($Package in $Packages)
    {
        Write-Host "Installing $Package"
        choco install -y $Package 
    }
}

function Install-Options
{
    [CmdletBinding()]
    param(
        [string]$Sets
    )

    $toinstall = 'Do you want to install $Sets ?'
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
        "Will install what is specified in $Sets ."

    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
        "Skips this install option."
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($Sets, $toinstall, $options, 0)

    switch ($result)
    {
        0 { $Sets }
    }
}

function main
{
    # ChocoInstallBase.ps1 by Q (forked from atwork.at)
    # Get Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
    
    Install-Essentials
    Install-Comms
    Install-Fonts
    
    # Personal preference of what's optional
    $optional = @(
        "Install-Media",
        "Install-Design",
        "Install-Additional-Tools",
        "Install-WSL",
        "Install-Dev",
        "Install-CTF-Tools",
        "Install-Games",
        "Install-Game-Tools",
        "Install-Misc"
    )

    $title = "Selective or All Install"
    $message = 'Do you want to install All?'
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
        "Will install all optional packages such as $optional ."

    $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
        "You will be asked to selectively install in the next prompt."
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    $result = $host.ui.PromptForChoice($title, $message, $options, 0)

    switch ($result)
    {
        0 {
            Install-Media
            Install-Design
            Install-Additional-Tools
            Install-WSL
            Install-Dev
            Install-CTF-Tools
            Install-Games
            Install-Game-Tools
            Install-Misc
        }
        1 {
            foreach($option in $optional)
            {
                Install-Options -Sets $option
            }
        }
    }
    Windows-Custom-Settings
    Write-Host "Installation Completed!" 
}

function Install-Essentials
{

    # See packages at https://chocolatey.org/packages/
    # Comment (add #) or uncomment (remove #) to include or exclude from your base install
    # Use according to your own needs...

    # Essentials
    Write-Host "Installing Essentials"

    $essentials = @(
        'veracrypt',
        'keepassxc',
        'chromium',
        'firefox',
        'foxitreader --ia \'/MERGETASKS="!desktopicon,!setdefaultreader,!displayinbrowser /COMPONENTS=*pdfviewer,*ffse,*installprint,*ffaddin,*ffspellcheck,!connectedpdf /LANG=en"\'',
        'malwarebytes',
        'ccleaner',
        'f.lux',
        'sudo',
        'scrcpy',
        'money-manager-ex',
        'speccy',
	    'synctrayzor',
        "powertoys",
        "modernflyouts",
        "teracopy"
    )
    
    Install-ChocoPackages -Packages $essentials
    Write-Host "Finished installing Essentials"

}

function Install-Comms
{
    # Comms
    Write-Host "Installing Comms"
    $comms = @(
        'skype',
        'ripcord', #Discord
        'telegram.install',
        'whatsapp'
    )

    Install-ChocoPackages -Packages $comms
    Write-Host "Finished installing Comms"
}

function Install-Media
{
    # Media
    Write-Host "Installing Media"
    $media = @(
        'vlc',
        'audacity',
        'deezer',
        'openshot',
        'obs-studio',
        'zoomit'
    )
    Install-ChocoPackages -Packages $media
    Write-Host "Finished installing Media"
}

function Install-Design
{
    # Design
    Write-Host "Installing Design Apps"
    $des = @(
        'gimp',
        'inkscape'
    )
    Install-ChocoPackages -Packages $des
    Write-Host "Finished installing Design Apps"
}

function Install-Additional-Tools
{
    # Additional Tools
    Write-Host "Installing Additional Tools"
    $addtools = @(
        '7zip',
        'curl',
        'youtube-dl',
        'protonvpn',
        'forticlientvpn',
        'powershell-core',
        'sysinternals'
    )
    Install-ChocoPackages -Packages $addtools
    Write-Host "Finished installing Additional Tools"
}

function Install-WSL
{
    # Windows Subsystem for Linux
    Write-Host "Installing WSL and OS"
    $wsl = @(
        'wsl2',
        'wsl-debiangnulinux',
        'wsl-kalilinux'
    )
    Install-ChocoPackages -Packages $wsl
    Write-Host "Finished installing WSL and OS"
}

function Install-Dev
{
    # Dev
    Write-Host "Installing Developers Toolbox"
    $dev = @(
        'putty',
        'winscp',
        'git',
        'vscodium',
        'postman',
        'heroku-cli',
        'nodejs',
        'python',
        'yarn',
        'velocity',
        'mkcert',
        'android-sdk',
        'gradle',
        'docker-cli',
        'docker-compose',
        'terraform',
        'kubernetes-cli',
        'kubernetes-helm',
        'kubernetes-kompose',
        'lens',
        'netfx-4.7.1-devpack',
        'dotnetfx',
        'netfx-4.7.2-devpack',
        'dotnetcore',
        'dotnetcore-runtime'
    )

    Install-ChocoPackages -Packages $dev
    Write-Host "Finished installing Developers Toolbox"
}

function Install-CTF-Tools
{

    # CTF Tools
    # Alternatively, pentestbox.org/#download has everything but no choco :(
    Write-Host "Installing CTF Tools"
    $ctf = @(
        'tor-browser',
        'burp-suite-free-edition',
        'wireshark',
        'exiftool',
        'apktool',
        'ghidra',
        'nmap'
    )
    Install-ChocoPackages -Packages $ctf
    Write-Host "Finished installing CTF Tools"
}

function Install-Games
{

    # Games
    Write-Host "Installing Games"
    $games = @(
        'goggalaxy',
        'steam',
        'epicgameslauncher',
        'uplay',
        'origin',
        'retroarch',
        'pcsx2',
        'dolphin'
    )
    Install-ChocoPackages -Packages $games
    Write-Host "Finished installing games"
}

function Install-Game-Tools
{

    # Game Tools
    Write-Host "Installing Game Tools"
    $gametools = @(
        "ds4windows",
        "msiafterburner"
    )
    Install-ChocoPackages -Packages $gametools
    Write-Host "Finished installing game tools"
}

function Install-Fonts
{

    # Fonts
    Write-Host "Installing Fonts"
    $fonts = @(
        "cascadiafonts",
        "fira"
    )
    Install-ChocoPackages -Packages $fonts
    Write-Host "Finished installing Fonts"
}

function Install-Misc
{

    # Misc
    Write-Host "Installing Miscellaneous Tools"
    $misc = @(
        "calibre",
        "moneymanagerex",
        "microsoft-windows-terminal",
        "qbittorrent",
        "winpcap",
        "yumi-uefi",
        "androidstudio",
        "blender",
        "mousewithoutborders",
        "speedtest"
    )
    Install-ChocoPackages -Packages $misc
    Write-Host "Finished installing Miscellaneous"
}


function Windows-Custom-Settings {
    choco install -y taskbar-winconfig --params "'/INK:no /PEOPLE:no /STORE:no /TASKVIEW:no /KEYBOARD:no /LOCATION:bottom /SIZE:big /LOCKED:yes /COMBINED:no /CORTANA:no /AUTOTRAY:YES /USEPOWERSHELL:yes'"
    choco install -y desktopicons-winconfig --params "'/Desktop:YES /UserFiles:YES /ControlPanel:NO /Network:NO /RecycleBin:YES /OneDrive:NO'"
    choco install -y explorer-winconfig --params "'/SHOWEXTENSIONS:yes /SHOWFULLPATH:yes /SHOWENCRYPTED:yes /SHOWCHECKBOXES:no /USESHARINGWIZARD:no /USEVIEW:details'"
}

main
# You´re done. ;)