<#
 This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment. 

 THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, 
 INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.  

 We grant you a nonexclusive, royalty-free right to use and modify the sample code and to reproduce and distribute the object 
 code form of the Sample Code, provided that you agree: 
    (i)   to not use our name, logo, or trademarks to market your software product in which the sample code is embedded; 
    (ii)  to include a valid copyright notice on your software product in which the sample code is embedded; and 
    (iii) to indemnify, hold harmless, and defend us and our suppliers from and against any claims or lawsuits, including 
          attorneys' fees, that arise or result from the use or distribution of the sample code.

Please note: None of the conditions outlined in the disclaimer above will supercede the terms and conditions contained within 
             the Premier Customer Services Description.
#>
param(
    [Parameter(Mandatory=$true)]
    $siteUrl,
    $username,
    $password
)

[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")
[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")

if ($username -eq $null)
{
    $Cred = Get-Credential
    $username = $Cred.UserName
    $securepwd = $Cred.Password
}
else {
    $securepwd = ConvertTo-SecureString $password -AsPlainText -Force
}

$script:context = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$spocred = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securepwd)
$script:context.Credentials = $spocred

$web = $script:context.Web
$actions = $web.UserCustomActions
$script:context.Load($web)
$script:context.Load($actions)
$script:context.ExecuteQuery()

foreach($action in $actions)
{
    if ($action.Location -eq "ScriptLink")
    {
        $action | select Title, Sequence, ScriptBlock
    }
}
