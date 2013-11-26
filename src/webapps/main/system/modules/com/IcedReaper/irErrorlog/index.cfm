<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";
    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irErrorlog/main.less');
</cfscript>