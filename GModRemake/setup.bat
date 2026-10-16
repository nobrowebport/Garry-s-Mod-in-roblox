@echo off
title GMod Remake - setup
echo Converting assets from your local Garry's Mod install...
node "%~dp0tools\export-gmod.js" %* || goto :fail
echo.
echo Building GModRemake.rbxlx and installing the GMR Link plugin...
node "%~dp0tools\build.js" || goto :fail
echo.
echo Done. Open GModRemake.rbxlx in Roblox Studio. Run start-relay.bat to link Studios.
echo This place contains Valve/Facepunch content: keep it local, never publish it.
pause
exit /b 0
:fail
echo Setup failed.
pause
exit /b 1
