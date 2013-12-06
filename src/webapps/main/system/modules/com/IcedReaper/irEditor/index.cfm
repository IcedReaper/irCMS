<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irEditor/main.less');


    attributes.navigationCRUD = createObject("component", "system.cfc.com.IcedReaper.modules.irEditor.navigationCRUD").init(tablePrefix = application.tablePrefix
                                                                                                                           ,datasource  = application.datasource.admin);

    if(request.actualUser.hasPermission(groupName='irEditor', roleName='Reader')) {
        switch(attributes.entities.len()) {
            case 0: {
                include "dashboard.cfm";
                break;
            }
            case 1: {
                switch(attributes.entities[1]) {
                    case 'newPage': {
                        // create a new page
                        include "newPage.cfm";
                        break;
                    }
                }
                break;
            }
            case 2: {
                switch(attributes.entities[2]) {
                    case 'newMajor': {
                        // create new version of the page
                        attributes.validation = attributes.navigationCRUD.createNewMajorVersion(coreNavigation = application.cms.navigationCRUD, userId = 1, navigationId = attributes.entities[1]);
                        
                        if(attributes.validation.success) {
                            location(url="/Admin/Pages/#attributes.entities[1]#/#attributes.validation.majorVersion#.0", addToken=false);
                        }
                        else {
                            // TODO: show error
                        }
                        break;
                    }
                    case 'newMinor': {
                        // create new version of the page
                        break;
                    }
                    default: {
                        // e.g. */navigationId+D/1.0
                        include "showVersion.cfm";
                        break;
                    }
                }
                break;
            }
            case 3: {
                // e.g. */navigationId+/1.0/Delete
                include "action.cfm";
                break;
            }
        }
    }
    else {
        include "/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>