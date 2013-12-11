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
                        attributes.validation = attributes.navigationCRUD.createNewMajorVersion(coreNavigation = application.cms.navigationCRUD,
                                                                                                userId         = request.actualUser.getUserId(),
                                                                                                navigationId   = attributes.entities[1]);
                        
                        if(attributes.validation.success) {
                            location(url="/Admin/Pages/#attributes.entities[1]#/#attributes.validation.majorVersion#/#attributes.validation.minorVersion#", addToken=false);
                        }
                        break;
                    }
                }
                break;
            }
            case 3: {
                switch(attributes.entities[2]) {
                    case 'newMinor': {
                        // create new version of the page
                        attributes.validation = attributes.navigationCRUD.createNewMinorVersion(coreNavigation = application.cms.navigationCRUD,
                                                                                                userId         = request.actualUser.getUserId(),
                                                                                                navigationId   = attributes.entities[1],
                                                                                                majorVersion   = attributes.entities[3]);
                        
                        if(attributes.validation.success) {
                            location(url="/Admin/Pages/#attributes.entities[1]#/#attributes.validation.majorVersion#/#attributes.validation.minorVersion#", addToken=false);
                        }
                        break;
                    }
                    default: {
                        include "showVersion.cfm";
                        break;
                    }
                }
                break;
            }
            case 4: {
                // e.g. */navigationId+/Delete/1/0
                include "action.cfm";
                break;
            }
        }
    }
    else {
        throw(type="permissionInsufficient", message="The required permission isn't assigned", detail="irEditor;Reader");
    }
</cfscript>