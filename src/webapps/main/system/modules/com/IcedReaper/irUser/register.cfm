<cfscript>
    if(! request.isLoggedIn) {
        if(isDefined("form") && ! form.isEmpty()) {
            attributes.userCreation = application.user.userCRUD.createUser(userData=form);

            if(attributes.userCreation.success) {
                session.userName = form.username;
            }
        }

        include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/userRegistration.cfm";
    }
    else {
        include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/alreadyRegistered.cfm";
    }
</cfscript>