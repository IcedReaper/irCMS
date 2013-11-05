<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irEditor/main.less');


    attributes.navigationCRUD = createObject("component", "system.cfc.com.IcedReaper.modules.irEditor.navigationCRUD").init(tablePrefix = application.tablePrefix
                                                                                                                                       ,datasource  = application.datasource.admin);

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
                    case 'Neue Majorversion': {
                        // e.g. */navigationId+/Neue Majorversion
                        // create new version of the page
                        attributes.validation = attributes.navigationCRUD.createNewMajorVersion(coreNavigation = application.cms.navigation, userId = 1, navigationId = attributes.entities[1]);
                        
                        if(attributes.validation.success) {
                            location(url="/Admin/Pages/#attributes.entities[1]#/#attributes.validation.majorVersion#.0", addToken=false);
                        }
                        else {
                            // TODO: show error
                        }
                        break;
                    }
                    case 'Neue Minorversion': {
                        // e.g. */navigationId+/Neue Minorversion
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