<cfscript>
    attributes.searchResults = application.user.search.forUser(userName='');
    include "/themes/#request.themeName#/templates/modules/com/Icedreaper/irUser/searchResults.cfm";
</cfscript>