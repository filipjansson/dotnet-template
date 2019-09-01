@echo off

set Name="Example"

for %%I in (.) do set CurrentDirectoryName=%%~nxI
echo %CurrentDirectoryName%

set Name=%CurrentDirectoryName%

:CheckUsingDefault
set /P udn=Do you want to use '%CurrentDirectoryName%' as the solution and base projectname [y/n]?
if /I "%udn%" EQU "y" goto :Print
if /I "%udn%" EQU "n" goto :SetDefaultName
goto :CheckUsingDefault

:SetDefaultName
set /P Name=Enter custom name: 
goto :Print

:Print
echo Print %Name% %CurrentDirectoryName%

:SetupDotNet
echo Setting upp dotnet projects and solution

dotnet new web -n %Name%.Web -o src/Web/%Name%.Web
dotnet new classlib -n %Name%.EntityFramework -o src/Web/%Name%.EntityFramework
dotnet new sln -n %Name%

dotnet sln add src/Web/%Name%.Web/%Name%.Web.csproj
dotnet sln add src/Web/%Name%.EntityFramework/%Name%.EntityFramework.csproj