# Download Windows 10 ISO
1. Get the [Media Creation Tool](https://go.microsoft.com/fwlink/?LinkId=691209)
2. Run the tool with the arguments `/Eula Accept /Retail /MediaLangCode en-GB /MediaArch x64 /MediaEdition Enterprise`
    - A setup key may be needed.  See [KMS client setup keys](https://docs.microsoft.com/en-gb/windows-server/get-started/kmsclientkeys)
3. Copy the ISO contents to `C:\Win10Image\`

# Convert ESD to WIM (optional)
A `.wim` is needed for tools like WSIM

1. Find the index of the SKU in the `install.esd` file:
    - `dism.exe /Get-WimInfo /WimFile:C:\Win10Image\sources\install.esd`
2. Create the `install.wim` with only the desired SKU:
    - `dism.exe /Export-Image /SourceImageFile:C:\Win10Image\sources\install.esd /SourceIndex:MYINDEX /DestinationImageFile:C:\Win10Image\sources\install.WIM /Compress:max /CheckIntegrity`
3. Delete the `install.esd`

# Add files to the image
Try to avoid using Sysprep, captures etc.  Stick with a clean image - easier to maintain.

1. Run `_build-iso.ps1`.  This will
    - Copy `autounattend.xml` to the root of the image at `C:\Win10Image\`
        - Windows setup will automatically find this file
    - Copy `SetupComplete.cmd` to `C:\Win10Image\sources\$OEM$\$$\Setup\Scripts\`
        - Windows setup will run this after OOBE and store log files at `C:\Windows\Panther\UnattendGC\Setupact.log`
