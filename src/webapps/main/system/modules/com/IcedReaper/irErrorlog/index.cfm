<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    writedump(var="#attributes#");

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irErrorlog/main.less');

    //include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irBlog/dspEntry.cfm";
</cfscript>