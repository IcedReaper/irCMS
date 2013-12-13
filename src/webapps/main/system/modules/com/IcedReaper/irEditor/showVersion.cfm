<cfscript>
    attributes.navigationId = attributes.entities[1];
    attributes.majorVersion = attributes.entities[2];
    attributes.minorVersion = attributes.entities[3];
    
    attributes.groups = application.security.permissionCRUD.getGroupList();
    attributes.roles  = application.security.permissionCRUD.getRoleList();

    if(isDefined("form") && ! form.isEmpty() && application.security.permission.hasPermission(userName=request.userName, groupName='irEditor', roleName='Editor')) {
        switch(form.action) {
            case 'save': {
                attributes.contentUpdate = application.cms.navigationCRUD.updateContentVersion(navigationId = attributes.navigationId
                                                                                              ,userId       = request.actualUser.getUserId()
                                                                                              ,majorVersion = attributes.majorVersion
                                                                                              ,minorVersion = attributes.minorVersion
                                                                                              ,versionData  = form);
                break;
            }
            case 'release': {
                application.cms.navigationCRUD.releaseContentVersion(navigationId = attributes.navigationId,
                                                                     majorVersion = attributes.majorVersion,
                                                                     minorVersion = attributes.minorVersion);
                break;
            }
            case 'approve': {
                application.cms.navigationCRUD.approveContentVersion(navigationId = attributes.navigationId,
                                                                     majorVersion = attributes.majorVersion,
                                                                     minorVersion = attributes.minorVersion);
                break;
            }
            case 'reject': {
                application.cms.navigationCRUD.rejectContentVersion(navigationId = attributes.navigationId,
                                                                    majorVersion = attributes.majorVersion,
                                                                    minorVersion = attributes.minorVersion);
                break;
            }
            case 'delete': {
                application.cms.navigationCRUD.deleteContentVersion(navigationId = attributes.navigationId,
                                                                    majorVersion = attributes.majorVersion,
                                                                    minorVersion = attributes.minorVersion);
                break;
            }
            case 'revoke': {
                application.cms.navigationCRUD.revokeContentVersion(navigationId = attributes.navigationId,
                                                                    majorVersion = attributes.majorVersion,
                                                                    minorVersion = attributes.minorVersion);
                break;
            }
            default: {
                break;
            }
        }
    }

    attributes.pageToShow = createObject("component", "system.cfc.com.IcedReaper.modules.irEditor.navigationVersion").init(tablePrefix  = application.tablePrefix,
                                                                                                                           datasource   = application.datasource.user,
                                                                                                                           navigationId = attributes.navigationId,
                                                                                                                           majorVersion = attributes.majorVersion,
                                                                                                                           minorVersion = attributes.minorVersion);
    
    if(attributes.pageToShow.load()) {
        include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irEditor/showVersionOfPage.cfm";
    }
    else {
        throw(type="notFound", message="Navigation was found", detail=attributes.sesLink);
    }
</cfscript>