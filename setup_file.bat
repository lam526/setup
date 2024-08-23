@echo off
setlocal

:: Tải xuống Python
echo Downloading Python...
curl -o python-installer.exe https://www.python.org/ftp/python/3.12.5/python-3.12.5-amd64.exe
echo Installing Python...
start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1

:: Tải xuống VS Code
echo Downloading Visual Studio Code...
curl -o vscode-installer.exe https://update.code.visualstudio.com/latest/win32-x64-user/stable
echo Installing Visual Studio Code...
start /wait vscode-installer.exe /silent /mergetasks=!runcode

:: Tải xuống Git
echo Downloading Git...
curl -o git-installer.exe https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.1/Git-2.42.0-64-bit.exe
echo Installing Git...
start /wait git-installer.exe /silent

:: Dọn dẹp file cài đặt
echo Cleaning up...
del python-installer.exe
del vscode-installer.exe
del git-installer.exe

echo Installation completed!

endlocal
pause
