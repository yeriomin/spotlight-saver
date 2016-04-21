# These vars can be configured
# You can get MediaInfo here: https://mediaarea.net/en/MediaInfo/Download/Windows
$saveDir = [environment]::getfolderpath("MyPictures") + "\Spotlight"
$global:mediaInfoPath = ".\MediaInfoCli.exe"
$spotlightInternalDir = $env:LOCALAPPDATA + "\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
# End of configuration

function Get-FinalImageName {
    param([string]$path)
    $fileName = Split-Path $path -Leaf
    $finalImageName = $fileName + ".jpg"
    if (Test-Path $mediaInfoPath) {
        $finalFileName = ""
        $format = (Invoke-Expression ($mediaInfoPath + " `"--Inform=Image;%Format%`" `"" + $path + "`"")) | Out-String
        $format = $format -replace "`t|`n|`r",""
        $width = (Invoke-Expression ($mediaInfoPath + " `"--Inform=Image;%Width%`" `"" + $path + "`"")) | Out-String
        $width = $width -replace "`t|`n|`r",""
        $height = (Invoke-Expression ($mediaInfoPath + " `"--Inform=Image;%Height%`" `"" + $path + "`"")) | Out-String
        $height = $height -replace "`t|`n|`r",""
        $prefix = if ($width -lt $height) { "portrait" } else { "landscape" }
        if ($format -eq "JPEG" -and $width -ne $height) {
            $finalImageName = ($prefix + "_" + $width + "x" + $height + "_" + $fileName + "." + $format)
        } else {
            $finalImageName = ""
        }
    }
    $finalImageName
}

$todayDir = $saveDir + "\" + (Get-Date).ToShortDateString()
if (!(Test-Path -Path $todayDir)) {
    New-Item -ItemType directory -Path $todayDir | Out-Null
}
"Copying spotlight images to " + $todayDir
Get-ChildItem $spotlightInternalDir | 
Foreach-Object {
    $finalFileName = Get-FinalImageName($_.FullName)
    if ($finalFileName -ne "") {
        Copy-Item $_.FullName ($todayDir + "/" + $finalFileName)
        "Copied " + $finalFileName
    }
}