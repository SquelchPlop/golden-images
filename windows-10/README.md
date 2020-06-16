# Download Windows 10 ISO
1. Get the [Media Creation Tool](https://go.microsoft.com/fwlink/?LinkId=691209)
2. Run the tool with the arguments `/Eula Accept /Retail /MediaLangCode en-GB /MediaArch x64 /MediaEdition Enterprise`
    - A setup key may be needed.  See [KMS client setup keys](https://docs.microsoft.com/en-gb/windows-server/get-started/kmsclientkeys)
3. Mount the ISO and copy to `C:\Win10Image\`

# Convert ESD to WIM (optional)
A `.wim` is needed for tools like WSIM

1. Find the index of the SKU in the `install.esd` file:
    - `dism.exe /Get-WimInfo /WimFile:C:\Win10Image\sources\install.esd`
2. Create the `install.wim` with only the desired SKU:
    - `dism.exe /Export-Image /SourceImageFile:C:\Win10Image\sources\install.esd /SourceIndex:MYINDEX /DestinationImageFile:C:\Win10Image\sources\install.WIM /Compress:max /CheckIntegrity`
3. Delete the `install.esd`

# Add files to the image
Try to avoid using Sysprep, captures etc.  Stick with a clean image - easier to maintain.

1. Copy `autounattend.xml` to the root of the image at `C:\Win10Image\`
    - Windows setup will automatically find this file
2. Copy `SetupComplete.cmd` to `C:\Win10Image\sources\$OEM$\$$\Setup\Scripts\`
    - Windows setup will run this after OOBE
    - Make sure to replace the JC key

# Create an ISO from the image
1. Run `./oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,bc:\Win10Image\boot\etfsboot.com#pEF,e,bc:\Win10Image\efi\microsoft\boot\efisys.bin c:\Win10Image c:\ISOs\Win10_2004_Ent_x64.iso -lWin10_2004_Ent_x64`

