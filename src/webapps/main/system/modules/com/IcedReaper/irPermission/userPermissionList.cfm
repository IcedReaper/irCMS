<cfscript>
    if(request.actualUser.hasPermission(groupName='irPermission', roleName='Reader')) {
        userId = application.user.userCRUD.getId(userName=attributes.userName);
        if(userId == 0) {
            throw(type="notFound", message="User was not found", detail=attributes.userName);
        }
        
        attributes.permissions = application.security.permissionCRUD.getUserPermission(userId=userId);
        
        include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irPermission/userPermissionList.cfm";
    }
    else {
        include "/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>