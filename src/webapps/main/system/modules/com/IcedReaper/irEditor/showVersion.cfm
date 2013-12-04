<cfscript>
    attributes.navigationId = attributes.entities[1];
    attributes.version      = attributes.entities[2];

    if(isDefined("form") && ! form.isEmpty() && application.security.permission.hasPermission(userName=request.userName, groupName='irEditor', roleName='Editor')) {
        switch(form.action) {
            case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.actionKeys.save', language=request.language): {
                attributes.contentUpdate = application.cms.navigationCRUD.updateContentVersion(navigationId = attributes.navigationId
                                                                                              ,userId       = request.actualUser.getUserId()
                                                                                              ,version      = attributes.version
                                                                                              ,versionData  = form);
                break;
            }
            case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.actionKeys.release', language=request.language): {
                application.cms.navigationCRUD.releaseContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.actionKeys.approve', language=request.language): {
                application.cms.navigationCRUD.approveContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.actionKeys.reject', language=request.language): {
                application.cms.navigationCRUD.rejectContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.actionKeys.delete', language=request.language): {
                application.cms.navigationCRUD.deleteContentVersion(navigationId = attributes.navigationId, version = attributes.version);
                break;
            }
            case application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irEditor.actionKeys.revoke', language=request.language): {
                application.cms.navigationCRUD.revokeContentVersion(navigationId = attributes.navigationId, version = attributes.version);
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