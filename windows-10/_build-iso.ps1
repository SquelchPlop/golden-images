$imageLocation = "C:\Win10Image\"
$scriptsLocation = "$imageLocation\sources\`$OEM$\`$$\Setup\Scripts\"
$outputImageName = "Win10Ent64_" + (Get-Date -Format "yyyyMMdd")
$outputImageDir = "C:\ISOs\"

Copy-Item ./autounattend.xml -Destination $imageLocation -Force

New-Item -Type dir $scriptsLocation -Force
Copy-Item ./SetupComplete.cmd -Destination $scriptsLocation -Force

$confirmation = Read-Host "Have you copied in the JC key to $scriptsLocation\SetupComplete.cmd ?"
if ($confirmation -eq 'y') {
    # proceed
}

New-Item -Type dir $outputImageDir -Force
Start-Process ./oscdimg.exe -NoNewWindow -Wait -ArgumentList "-m -o -u2 -udfver102 -bootdata:2#p0,e,bc:\Win10Image\boot\etfsboot.com#pEF,e,bc:\Win10Image\efi\microsoft\boot\efisys.bin c:\Win10Image c:\ISOs\$outputImageName.iso -l$outputImageName"