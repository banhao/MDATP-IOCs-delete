<#PSScriptInfo

.VERSION 1.00

.GUID 134de175-8fd8-4938-9812-053ba39eed83

.AUTHOR banhao@gmail.com

.COMPANYNAME

.COPYRIGHT

.TAGS

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES

.PRIVATEDATA

.SYNOPSIS
	Delete MDATP IOCs
.EXAMPLE
	DEL-MDATP-IOC.ps1 <All | IpAddress | DomainName | Url | FileSha256 | FileSha1>

.DESCRIPTION 
	Creation Date:  <10/08/2020>
	https://github.com/banhao/MDATP-IOCs-delete
	https://www.powershellgallery.com/packages/DEL-MDATP-IOC

.Parameter

#> 
#-------------------------------------------------------------------------------------------------------------------------------------------------------
#variables
[CmdletBinding(DefaultParameterSetName="IndicatorType")]
Param(
	[Parameter(Mandatory=$true, Position=0, ParameterSetName="IndicatorType", HelpMessage="---USAGE: DEL-MDATP-IOC.ps1 <All | IpAddress | DomainName | Url | FileSha256 | FileSha1>---")] 
	[ValidateNotNullOrEmpty()]
	[ValidateSet("All", "IpAddress", "DomainName", "Url", "FileSha256", "FileSha1")]
	[string[]] $IndicatorType
)


function authentication {
	$tenantId = '' ### Paste your Tenant ID here
	$appId = ''    ### Paste your Application ID here
	$appSecret = ''  ### Paste your Application key here

	$resourceAppIdUri = 'https://api.securitycenter.windows.com'
	$oAuthUri = "https://login.windows.net/$tenantId/oauth2/token"
	$authBody = [Ordered] @{
		resource = "$resourceAppIdUri"
		client_id = "$appId"
		client_secret = "$appSecret"
		grant_type = 'client_credentials'
	}
	$authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
	$global:token = $authResponse.access_token
	$global:tokenexpire = $authResponse.expires_on
	return $token, $tokenexpire
}


function Del_IOC {
	if ( $IndicatorType.ToLower() -eq "all" ){
		$url = "https://api.securitycenter.windows.com/api/indicators?"
	}else{
		$url = "https://api.securitycenter.windows.com/api/indicators?`$filter=indicatorType+eq+'$IndicatorType'"
		}
	$headers = @{
		'Content-Type' = 'application/json'
		Accept = 'application/json'
		Authorization = "Bearer $token"
		}
	$response = Invoke-WebRequest -Method GET -Uri $url -Headers $headers -ErrorAction Stop
	if ( !([string]::IsNullOrEmpty(($response | ConvertFrom-Json).value)) ){
		foreach( $line in (($response | ConvertFrom-Json).value[0..1499] | Select id, indicatorType) ) {
			$request = 'https://api.securitycenter.windows.com/api/indicators/'+ $line.id
			$delIOCresponse = Invoke-WebRequest -Method DELETE -Uri $request -Headers $headers -ErrorAction Stop
			Start-Sleep -s 2.4
			}
	}else{
		Write-Output "No IOC Needs To Delete."
		exit
	}
}

cls
If($IndicatorType:paramMissing){
	throw "---USAGE: DEL_MDATP_IOC.ps1 <All | IpAddress | DomainName | Url | FileSha256 | FileSha1>---"
} 
while ($true) {
	authentication
	Del_IOC	
}
