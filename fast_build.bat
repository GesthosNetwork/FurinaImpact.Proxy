@echo off
cd .\FurinaImpact.Proxy
dotnet publish -c Release -r win-x64 /p:PublishSingleFile=true /p:IncludeNativeLibrariesForSelfExtract=true

for %%c in ("%~dp0bin\Release\net9.0\win-x64\publish\*") do (
    if exist "%%~c" (
        move "%%~c" "%~dp0bin" >nul
    )
)

for %%d in (
	"%~dp0bin\Debug"
	"%~dp0bin\Release"
	"%~dp0FurinaImpact.Proxy\obj"
) do (
    if exist "%%~d" (
        rmdir /s /q "%%~d" >nul
    )
)

for %%e in (
    "%~dp0bin\FurinaImpact.Proxy.pdb"
) do (
    if exist "%%~e" del "%%~e" >nul
)

pause
taskkill /F /IM dotnet.exe >nul
exit
