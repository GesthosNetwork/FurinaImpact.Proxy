@echo off
rd /s /q bin >nul
pushd FurinaImpact.Proxy
dotnet publish
popd

for /d %%d in (bin\Release\*) do for %%f in ("%%~d\win-x64\publish\*") do move "%%~f" bin >nul 2>&1
rd /s /q "bin\Debug" "bin\Release" "FurinaImpact.Proxy\obj" & del "bin\*.pdb" >nul 2>&1

pause
taskkill /F /IM dotnet.exe >nul
exit
