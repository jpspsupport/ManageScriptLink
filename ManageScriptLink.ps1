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

switch ($type.ToLower()) {
    "addorupdate" { 
        .\SetScriptLink.ps1 -siteUrl $siteUrl -Title $codetitle -ScriptBlockFile $codetoadd -Sequence $codesequence -username $username -password $password
     }
     "delete" {
         .\RemoveScriptLink.ps1 -siteUrl $siteUrl -Title $codetitle -username $username -password $password
     }
    Default {
        .\GetScriptLink.ps1 -siteUrl $siteUrl -username $username -password $password
    }
}

