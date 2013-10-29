<cfscript>
    include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/searchForm.cfm";

    if(isDefined("form") && ! form.isEmpty()) {
        if(form.userName != '') {
            attributes.moduleData.searchResults = application.user.search.forUser(userName=form.userName);
        }
        include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/searchResults.cfm";
    }
</cfscript>