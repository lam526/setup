@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Cập nhật hệ thống
echo Updating system...
powershell -Command "Start-Process cmd.exe -ArgumentList '/c", "choco upgrade all -y' -Verb RunAs"

:: Tải Python phiên bản mới nhất
echo Downloading latest Python installer...
set "PYTHON_URL=https://www.python.org/ftp/python/3.12.5/python-3.12.5-amd64.exe"
set "PYTHON_INSTALLER=python-latest-win64.exe"
powershell -Command "Invoke-WebRequest -Uri %PYTHON_URL% -OutFile %PYTHON_INSTALLER%"

:: Cài đặt Python
echo Installing Python...
start /wait %PYTHON_INSTALLER% /quiet InstallAllUsers=1 PrependPath=1

:: Tải Sublime Text 4
echo Downloading Sublime Text 4 installer...
set "SUBLIME_URL=https://download.sublimetext.com/sublime_text_build_4180_x64_setup.exe"
set "SUBLIME_INSTALLER=Sublime_Text_4_Setup.exe"
powershell -Command "Invoke-WebRequest -Uri %SUBLIME_URL% -OutFile %SUBLIME_INSTALLER%"

:: Cài đặt Sublime Text 4
echo Installing Sublime Text 4...
start /wait %SUBLIME_INSTALLER% /silent


:: Tải font FiraCode
echo Downloading FiraCode font...
set "FIRACODE_URL=https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2_Windows.zip"
set "FIRACODE_ZIP=FiraCode_v6.2_Windows.zip"
powershell -Command "Invoke-WebRequest -Uri %FIRACODE_URL% -OutFile %FIRACODE_ZIP%"

:: Giải nén file zip
echo Extracting FiraCode font...
powershell -Command "Expand-Archive -Path %FIRACODE_ZIP% -DestinationPath FiraCode"

:: Cài đặt font
echo Installing FiraCode font...
for %%f in (FiraCode\*.ttf) do (
    powershell -Command "Add-Type -TypeDefinition @"
    [DllImport("gdi32.dll", CharSet = CharSet.Auto)] public static extern int AddFontResource(string lpFileName);
    [DllImport("gdi32.dll", CharSet = CharSet.Auto)] public static extern int RemoveFontResource(string lpFileName);
    @"
    $fontPath = "%%f"
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject(
        [System.Drawing.Text.PrivateFontCollection]::new().AddFontFile($fontPath)
    ) | Out-Null
    AddFontResource($fontPath) | Out-Null
    "@
)


:: Xóa file tải về
echo Cleaning up...
del %PYTHON_INSTALLER%

:: Kiểm tra cài đặt
echo Verifying installation...
python --version

echo Python installation completed successfully!

:: Xóa file tải về
echo Cleaning up...
del %SUBLIME_INSTALLER%

:: Kiểm tra cài đặt
echo Sublime Text installation completed successfully!

:: Xóa file tải về và thư mục giải nén
echo Cleaning up...
del %FIRACODE_ZIP%
rmdir /s /q FiraCode

:: Kiểm tra cài đặt
echo FiraCode font installation completed successfully!

ENDLOCAL
pause


