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
    [Parameter(Mandatory=$false)]
    [ValidateSet("View","AddorUpdate","Delete")]
    $type = "View",
    [Parameter(Mandatory=$false)]
    $codetitle,
    [Parameter(Mandatory=$false)]
    $codetoadd,
    [Parameter(Mandatory=$false)]
    $codesequence = 10,
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

switch ($type.ToLower()) {
    "addorupdate" { 
        if (($codetoadd -eq $null) -or ($codetitle -eq $null))
        {
            Write-Host "You need to specify -codetoadd and -codetitle to add."
        } 
        $updated = $false

        foreach ($action in $actions)
        {
            if ((($action.Location -eq "ScriptLink")) -and ($action.Title -eq $codeTitle))
            {
                $action.Title = $codeTitle
                $action.Sequence = $codesequence
                $action.ScriptBlock = (Get-Content $codetoadd -Raw)
                $action.Update()
                $script:context.ExecuteQuery()
                $updated = $true
                Write-Host ("ScriptLink " + $codeTitle + " is updated.")
            }
        }

        if (!$updated)
        {
            $action1 = $actions.Add()
            $action1.Location = "ScriptLink"
            $action1.Title = $codeTitle
            $action1.Sequence = $codesequence
            $action1.ScriptBlock = (Get-Content $codetoadd -Raw)
            $action1.Update()
            $script:context.ExecuteQuery()
            Write-Host ("ScriptLink " + $codeTitle + " is added.")
        }
     }
     "delete" {
        foreach ($action in $actions)
        {
            if ((($action.Location -eq "ScriptLink")) -and ($action.Title -eq $codeTitle))
            {
                $action.DeleteObject()
                $script:context.ExecuteQuery()
                Write-Host ("ScriptLink " + $codeTitle + " is deleted.")
                break
           }
        }
     }
    Default {
        foreach($action in $actions)
        {
            if ($action.Location -eq "ScriptLink")
            {
                $action | select Title, Sequence, ScriptBlock
            }
        }
    }
}

