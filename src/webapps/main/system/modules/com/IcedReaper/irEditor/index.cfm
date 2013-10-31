<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irEditor/main.less');

    if(application.security.permission.hasPermission(userName=request.userName, groupName='irEditor', roleName='Reader')) {
        switch(attributes.entities.len()) {
            case 0: {
                include template="dashboard.cfm";
                break;
            }
            case 1: {
                switch(attributes.entities[1]) {
                    case 'Neu': {
                        // create a new page
                        break;
                    }
                    default: {
                        // e.g. */PageSES
                        // show actual version of page 
                        break;
                    }
                }
                break;
            }
            case 2: {
                switch(attributes.entities[2]) {
                    case 'Neue Version': {
                        // e.g. */PageSES/NewVersion
                        // create new version of the page
                        break;
                    }
                }
            }
            case 3: {
                // e.g. */PageSES/Version/1.0
                // show specific version of page
                break;
            }
        }
    }
    else {
        include template="/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>