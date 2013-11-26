<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";
    
    attributes.showPerPage = 30;
    
    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irErrorlog/main.less');
</cfscript>