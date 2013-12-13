<cfscript>
    if(request.actualUser.hasPermission(groupName='irEditor', roleName='Editor')) {
        if(isDefined("form") && ! form.isEmpty()) {
            attributes.contentUpdate = application.cms.navigationCRUD.addNavigation(navigationData = form,
                                                                                    userId         = request.actualUser.getUserId());
            
            if(attributes.contentUpdate.success) {
                location(url=attributes.sesLink&"/"&attributes.contentUpdate.navigationId&"/1/0?showSuccessMessage=true", addToken=false);
            }
        }
        include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irEditor/newPage.cfm";
    }
    else {
        throw(type="permissionInsufficient", message="The required permission isn't assigned", detail="irEditor;Editor");
    }
</cfscript>