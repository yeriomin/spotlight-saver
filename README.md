# spotlight-saver
A script which saves Windows Spotlight pictures to an arbitrary folder

This is a Windows PowerShell script which simply copies all files from Windows Spotlight storage folder to user's Pictures library. It might be a good idea to [create a scheduled task](https://technet.microsoft.com/en-us/library/cc748993.aspx) so that this script would run once a day.

If [MediaInfo](https://mediaarea.net/en/MediaInfo/Download/Windows) CLI executable is available, the script will check the copied files, so that only wallpapers are copied. Also it gives files names which are a little more readable.

## Usage
Download and doubleclick.

## Configuration
There are three configurable options:
* Target folder (where to put pics)
* MediaInfo executable location
* Spotlight storage folder

## Download
* [Script only](https://raw.githubusercontent.com/yeriomin/spotlight-saver/master/spotlight.ps1)
* [Script with MediaInfo v0.7.84 executable and a Windows Scheduler task example](https://github.com/yeriomin/spotlight-saver/archive/with-mediainfo.zip)
