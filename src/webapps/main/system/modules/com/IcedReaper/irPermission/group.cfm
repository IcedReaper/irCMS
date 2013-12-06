<cfscript>
    attributes.groupName = attributes.entities[1];
    attributes.editable  = request.actualUser.hasPermission(groupName='irPermission', roleName='Editor');
    
    if(isDefined("form") && ! form.isEmpty()) {
        if(attributes.editable) {
        	switch(form.action) {
        	    case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irPermission.group.button.save.value', language=request.language): {
        	        application.security.permissionCRUD.setPermission(groupName=attributes.groupName, roleData=DeserializeJSON(form.roles));
        	        break;
        	    }
        	}
        }
        else {
        	include "/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
        }
    }
    
    attributes.roles = application.security.permissionCRUD.getRoleList();
    attributes.roleData = [];
    for(i = 1; i <= attributes.roles.len(); i++) {
    	attributes.roleData[i] = {
    		'roleName': attributes.roles[i],
    		'user':     application.security.permissionCRUD.getUserWithPermission(groupName = attributes.groupName, roleName = attributes.roles[i])
    	};
    }
    attributes.userWithoutPermission = application.security.permissionCRUD.getUserWithoutPermission(groupName = attributes.groupName);
    
    include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irPermission/group.cfm";
</cfscript>