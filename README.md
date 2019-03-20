# Office-365-Detailed-License-Report

How to get a detailed license report for your users in Office 365. 
Although you can get a license report from the Office 365 Admin Center; this report will give you the license packs assigned to each user, and not a list of services that are enabled or disabled within each license pack. [https://admin.microsoft.com/Adminportal/Home?source=applauncher#/users]
 
You can get a detailed report for a list of users (.csv file required) and for all users who have licenses assigned to them by executing this PowerShell Script. 

About the Script and Output Sample: 
This script was created for organizations that have multiple license packs (SKU with services disabled or enabled). It is a tedious task for an administrator to pull a report of or find out who has what license. If you assign licenses via Group-Based licenses, then it might be difficult to find out which group is responsible for assigning the custom license pack. 
This script is simplified to a point that it requires minimal inputs and should be run as is. 
The output file will have the following information: User’s UserPrincipalName, License Pack, Services within the license pack, Status of each service and if I you have assigned the license via Groups the ObjectID of the group (this column will be blank if you are not using group-based licenses). You can then filter the results using Excel’s built in filters. 
 

Script Execution: 
1)	Run PowerShell as Admin and connect to MSOL service by running Connect-MsolService. For details on how to connect to MSOL reference the link:  Connect to Office 365 PowerShell: https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell 
2)	Once you run the script you will be prompted with 2 choices. 

a.	All Users: Use this option if you want to get a detailed report for all users in your organization. The script would prompt you for a location to export the file.  
b.	Select Users: Use this option if you want to run a report for a select set of users. To use this option, you would need a .csv file with a list of users. The column name would need to be UserPrincipalName. You would be prompted for the Input file location and the export location for the file. A sample input file is attached (file name: userlist)


About the Script. (how does it work): 
To get a breakdown of the script and find out how the script works feel free to visit my blog www.O365inside.com  

