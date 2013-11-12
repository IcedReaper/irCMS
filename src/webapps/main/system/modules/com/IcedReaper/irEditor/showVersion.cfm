<cfscript>
    attributes.navigationId = attributes.entities[1];
    attributes.version      = attributes.entities[2];

    if(isDefined("form") && ! form.isEmpty()) {
        switch(form.action) {
            case 'save': {
                attributes.contentUpdate = application.cms.navigationCRUD.updateContentVersion(navigationId = attributes.navigationId
                                                                                              ,userId       = request.actualUser.getUserId()
                                                                                              ,version      = attributes.version
                                                                                              ,versionData  = form);
                break;
            }
            case 'release': {
                application.cms.navigationCRUD.releaseContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case 'approve': {
                application.cms.navigationCRUD.approveContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case 'reject': {
                application.cms.navigationCRUD.rejectContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case 'delete': {
                break;
            }
            case 'revoke': {
                application.cms.navigationCRUD.revokeContentVersion(navigationId = attributes.navigationId);
                break;
            }
            default: {
                break;
            }
        }
    }

    attributes.pageToShow = createObject("component", "system.cfc.com.IcedReaper.modules.irEditor.navigationVersion").init(tablePrefix  = application.tablePrefix
                                                                                                                          ,datasource   = application.datasource.user
                                                                                                                          ,navigationId = attributes.navigationId
                                                                                                                          ,version      = attributes.version);
    
    if(attributes.pageToShow.load()) {
        include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irEditor/showVersionOfPage.cfm";
    }
    else {
        throw(type="notFound", message="Navigation was found", detail=arguments.sesLink);
    }
</cfscript>