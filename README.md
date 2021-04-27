
# DEL-MDATP-IOC
[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1+-purple.svg)](https://github.com/PowerShell/PowerShell) ![Cross Platform](https://img.shields.io/badge/platform-windows-lightgrey)
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/DEL-MDATP-IOC)](https://www.powershellgallery.com/packages/DEL-MDATP-IOC) [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/DEL-MDATP-IOC)](https://www.powershellgallery.com/packages/DEL-MDATP-IOC)


DEL-MDATP-IOC.ps1 is used to delete the IOCs on Microsoft Defender ATP.
    
    DEL-MDATP-IOC.ps1 <All | IpAddress | DomainName | Url | FileSha256 | FileSha1>

Microsoft Azure token will be expired in 1 hour, so when the token expired but still have IOCs need to delete, the script will generate a new token untill all the IOCs have been deleted.

Also can find this powershell script on Powershell Gallery https://www.powershellgallery.com/packages/DEL-MDATP-IOC
