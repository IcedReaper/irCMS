<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irThemes/main.less');
    
    if(application.security.permission.hasPermission(userName=request.userName, groupName='irTheme', roleName='Reader')) {
        switch(attributes.entities.len()) {
        	case 0: {
        		include template="overview.cfm";
        		break;
        	}
            case 1: {
                switch(attributes.entities[1]) {
                    case 'Suche': {
                        include template="search.cfm";
                        break;
                    }
                    case 'Neu': {
                        include template="create.cfm";
                    }
                    default: {
                        include template="showTheme.cfm";
                    }
                }
                break;
            }
        }
    }
    else {
        include template="/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>