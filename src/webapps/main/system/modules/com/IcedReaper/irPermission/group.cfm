<cfscript>
    attributes.groupName = attributes.entities[1];
    attributes.editable  = request.actualUser.hasPermission(groupName='irPermission', roleName='Editor');
    
    if(isDefined("form") && ! form.isEmpty()) {
        if(attributes.editable) {
        	switch(form.action) {
        	    case 'save': {
        	        application.security.permissionCRUD.updatePermission(groupName=attributes.groupName, roleData=DeserializeJSON(form.roles));
        	        attributes.saveSuccessfull = true;
        	        
        	        break;
        	    }
        	}
        }
        else {
            throw(type="permissionInsufficient", message="The required permission isn't assigned", detail="irPermission;Editor");
        }
    }
    
    attributes.roles = application.security.permissionCRUD.getRoleList();
    attributes.roleData = [];
    for(i = 1; i <= attributes.roles.len(); i++) {
    	attributes.roleData[i] = {
    		'roleName': attributes.roles[i].name,
    		'user':     application.security.permissionCRUD.getUserWithPermission(groupName = attributes.groupName, roleName = attributes.roles[i].name)
    	};
    }
    attributes.userWithoutPermission = application.security.permissionCRUD.getUserWithoutPermission(groupName = attributes.groupName);
    
    include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irPermission/group.cfm";
</cfscript>