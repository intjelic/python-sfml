param(
    [Parameter(Mandatory = $true)]
    [string]$Version,
    [Parameter(Mandatory = $true)]
    [string]$Prefix,
    [string]$Architecture = "x64"
)

$ErrorActionPreference = "Stop"

$cmakeExe = if ($env:CMAKE_EXE) { $env:CMAKE_EXE } else { "cmake" }
if (Test-Path $cmakeExe -PathType Container) {
    $cmakeExe = Join-Path $cmakeExe "cmake.exe"
}

if (-not ($cmakeExe -like "*.exe") -and $cmakeExe -ne "cmake") {
    $candidateExe = Join-Path $cmakeExe "cmake.exe"
    if (Test-Path $candidateExe -PathType Leaf) {
        $cmakeExe = $candidateExe
    }
}

if ($cmakeExe -ne "cmake" -and -not (Test-Path $cmakeExe -PathType Leaf)) {
    throw "Configured CMake executable was not found: $cmakeExe"
}

$Prefix = [System.IO.Path]::GetFullPath($Prefix)
$configHeader = Join-Path $Prefix "include\SFML\Config.hpp"

if (Test-Path $configHeader) {
    exit 0
}

New-Item -ItemType Directory -Force -Path $Prefix | Out-Null

$cmakeInstallPrefix = $Prefix -replace '\\', '/'

$generatorArch = if ($Architecture -eq "x86") { "Win32" } else { "x64" }
$srcDir = Join-Path $env:RUNNER_TEMP "sfml-src"
$buildDir = Join-Path $env:RUNNER_TEMP "sfml-build"
$archivePath = Join-Path $env:RUNNER_TEMP "sfml-src.zip"

if (Test-Path $srcDir) {
    Remove-Item $srcDir -Recurse -Force
}

if (Test-Path $buildDir) {
    Remove-Item $buildDir -Recurse -Force
}

if (Test-Path $archivePath) {
    Remove-Item $archivePath -Force
}

$archiveUrl = "https://github.com/SFML/SFML/archive/refs/tags/$Version.zip"
Invoke-WebRequest -Uri $archiveUrl -OutFile $archivePath
Expand-Archive -Path $archivePath -DestinationPath $env:RUNNER_TEMP -Force

$extractedDir = Join-Path $env:RUNNER_TEMP "SFML-$Version"
if (-not (Test-Path $extractedDir)) {
    throw "Downloaded SFML source archive did not extract to expected directory: $extractedDir"
}

Move-Item -Path $extractedDir -Destination $srcDir
& $cmakeExe -S $srcDir -B $buildDir -G "Visual Studio 17 2022" -A $generatorArch `
    -DBUILD_SHARED_LIBS=ON `
    -DCMAKE_BUILD_TYPE=Release `
    "-DCMAKE_INSTALL_PREFIX=$cmakeInstallPrefix" `
    -DSFML_BUILD_DOC=OFF `
    -DSFML_BUILD_EXAMPLES=OFF `
    -DSFML_BUILD_TEST_SUITE=OFF
& $cmakeExe --build $buildDir --config Release
& $cmakeExe --install $buildDir --config Release

if (-not (Test-Path $configHeader)) {
    throw "SFML install did not produce expected header: $configHeader"
}