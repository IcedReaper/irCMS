<cfscript>
    if(application.security.permission.hasPermission(userName=request.userName, groupName='irEditor', roleName='Editor')) {
        attributes.navigationId = attributes.entities[1];
        attributes.version      = attributes.entities[2];

        switch(attributes.entities[3]) {
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
        
        location(url="/Admin/Pages", addToken=false);
    }
    else {
        include template="/themes/#request.themeName#/templates/core/permissionIsNotSufficient.cfm";
    }
</cfscript>