DEL-MDATP-IOC.ps1 is used to delete the IOCs in Microsoft Defender ATP.
    
    DEL-MDATP-IOC.ps1 <All | IpAddress | DomainName | Url | FileSha256 | FileSha1>

Microsoft Azure token will be expired in 1 hour, so when the token expired but still have IOCs need to delete, the script will generate a new token untill all the IOCs have been deleted.

Also can find this powershell script on Powershell Gallery https://www.powershellgallery.com/packages/DEL-MDATP-IOC
