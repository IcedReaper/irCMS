﻿<cfscript>
	attributes.roleList  = application.security.permissionCRUD.getRoleList();
	attributes.groupList = application.security.permissionCRUD.getGroupListWithRoleCounter();
	
	include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irPermission/overview.cfm";
</cfscript>