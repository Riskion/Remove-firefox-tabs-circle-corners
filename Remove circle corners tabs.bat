@echo off
setlocal enabledelayedexpansion

echo Closing Firefox if running...
taskkill /IM firefox.exe /F >nul 2>&1

set "FF_PROFILES=%APPDATA%\Mozilla\Firefox\Profiles"

if not exist "%FF_PROFILES%" (
    echo Error: Firefox profiles directory not found at "%FF_PROFILES%".
    echo Please make sure Firefox is installed and has been run at least once.
    pause
    exit /b
)

echo.
echo Searching for Firefox profiles...

for /D %%P in ("%FF_PROFILES%\*") do (
    set "USER_JS=%%P\user.js"
    echo Updating profile: %%~nxP
    
    :: Append the preference setting to user.js
    echo. >> "!USER_JS!"
    echo user_pref("browser.nova.enabled", false^); >> "!USER_JS!"
)

echo.
echo Success! "browser.nova.enabled" has been set to false across your Firefox profiles.
echo Start Firefox to apply the changes.
echo.
pause