# ManageScriptLink

This is a script to View/AddOrUpdate/Delete the ScriptLink of the SharePoint Online site.

## Prerequitesite
You need to download SharePoint Online Client Components SDK to run this script.

https://www.microsoft.com/en-us/download/details.aspx?id=42038

You can also acquire the latest SharePoint Online Client SDK by Nuget as well.

1. You need to access the following site. 

https://www.nuget.org/packages/Microsoft.SharePointOnline.CSOM

2. Download the nupkg.
3. Change the file extension to *.zip.
4. Unzip and extract those file.
5. place them in the specified directory from the code. 

## How to Run - parameters

-siteUrl ... Target site (web) URL.

-type ... View / AddOrUpdate / Delete

-codetitle ... [required] when type is (AddOrUpdate | Delete), otherwise [optional].

-codetoadd ... [required] when type is (AddOrUpdate), otherwise [optional]

-codesequence ... [optional] The sequence number of the ScriptLink.

-username ... [optional]Site Administrator Account to Manage ScriptLink.

-password ... [optional]The password of the above user.

See examples below.


#### Example 1
To View the ScriptLink registered in the site.

.\ManageScriptLink.ps1 -siteUrl https://tenant.sharepoint.com/sites/site -type View

#### Example 2
To Insert the ScriptLink into the site.

.\ManageScriptLink.ps1 -siteUrl https://tenant.sharepoint.com/sites/site -type AddOrUpdate -codetitle NewScript -codetoadd .\sample.js

#### Example 3
To Delete the ScriptLink from the site.

.\ManageScriptLink.ps1 -siteUrl https://tenant.sharepoint.com/sites/site -type Delete -codetitle NewScript

## Reference 
Please also see the SharePoint Forum below.

https://social.msdn.microsoft.com/Forums/ja-JP/44644a7d-cc33-44f3-9f89-df568e4621db/sharepoint-online-12391125101247312479?forum=sharepointsupportteamja

