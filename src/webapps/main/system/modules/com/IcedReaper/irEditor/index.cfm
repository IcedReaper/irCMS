<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    writeDump(attributes);

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irEditor/main.less');


    attributes.navigationController = createObject("component", "system.cfc.com.IcedReaper.modules.irEditor.navigationController").init(errorHandler = application.cms.errorHandler
                                                                                                                                       ,tablePrefix  = application.tablePrefix
                                                                                                                                       ,datasource   = application.datasource.user);

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
                        include template="newPage.cfm";
                        break;
                    }
                }
                break;
            }
            case 2: {
                switch(attributes.entities[2]) {
                    case 'Neue Version': {
                        // e.g. */navigationId+/NewVersion
                        // create new version of the page
                        break;
                    }
                    default: {
                        // e.g. */navigationId+/1.0
                        include template="showVersion.cfm";
                        break;
                    }
                }
                break;
            }
            case 3: {
                // e.g. */navigationId+/1.0/Delete
                include template="action.cfm";
                break;
            }
        }
    }
    else {
        include template="/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>