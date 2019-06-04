#Requires -RunAsAdministrator

Write-Output "Updating programs"

# test for chocolatey
try {
  Get-Command "choco"
  Write-Host "Found choco, continuing"
} catch {
  Write-Host "Choco not installed, exiting"
  exit
}

# upgrade chocolatey
choco upgrade chocolatey -y

# Non-Dev programs
choco upgrade firefox -y
choco upgrade googlechrome -y
choco upgrade vlc -y
choco upgrade 7zip.install -y
choco upgrade qbittorrent -y

# Git
choco upgrade git.install -params="'/GitOnlyOnPath /NoAutoCrlf /WindowsTerminal /NoShellIntegration'" -y
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
choco upgrade poshgit -y
choco upgrade Git-Credential-Manager-for-Windows -y

# Node.js
choco upgrade nodejs-lts -y
# choco upgrade nvm -y
# Write-Host "Installed NVM; reload the terminal and install Node.js"
# choco upgrade yarn -y

# Ruby
function updateGem ($gemName) {
  Write-Host "Installing/ updating: $gemName"
  if (gem list -i $gemName) {
    gem update $gemName
  } else {
    gem install $gemName
  }
}
# Note: to build local gems, need to run DevKit with `ridk install` to download and setup MSYS2
choco upgrade ruby -y
gem update --system
refreshenv
#updateGem("bundler")
#updateGem("travis")
#updateGem("rubocop")
# May need to also install 'ruby-debug-ide' and 'debase' gems

# Python
# choco upgrade python2 -y
# py -2 -m pip install --upgrade virtualenv
choco upgrade python -y
py -3 -m pip install --upgrade pip
# python 3 now recommends using venv for virtual environments
# py -3 -m pip install --upgrade virtualenv

# JDK
choco upgrade jdk8 -y
choco upgrade jre8 -y

# Meld
choco upgrade meld -y

# PuTTY
choco upgrade putty.install -y

# Ctags (for Python)
choco upgrade ctags -y

# Cmder and Hyper
choco upgrade cmder -y
choco upgrade hyper -y

# Hugo
choco upgrade hugo -y

# youtube-dl
choco upgrade youtube-dl -y
choco upgrade ffmpeg -y

# process explorer
choco upgrade procexp -y
choco upgrade sysinternals -y

# pdf
choco upgrade sumatrapdf.install -y
choco upgrade adobereader -y

# fonts
choco upgrade firacode -y
choco upgrade hackfont -y
choco upgrade inconsolata -y

# Upgrade Powershell help
# Update-Help

Write-Host "Done!"
Write-Host "Look at npm-global.txt in OneDrive for guidance on what other NPM packages to install"
Write-Host "Other steps: download and install Anaconda 3 (with default options)"
