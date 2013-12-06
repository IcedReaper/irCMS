<cfscript>
    include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/searchForm.cfm";

    if(isDefined("form") && ! form.isEmpty()) {
        if(form.userName != '') {
            attributes.searchResults = application.user.search.forUser(userName=form.userName);
        }
        include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/searchResults.cfm";
    }
</cfscript>