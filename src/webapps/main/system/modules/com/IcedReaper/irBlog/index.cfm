<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    writedump(var="#attributes#");

    article = createObject("component", "irCMS.system.cfc.com.IcedReaper.modules.irBlog.article").init(datasource  = application.datasource.user
                                                                                             ,tablePrefix = application.tablePrefix
                                                                                             ,articleId   = 1)>

    application.themes[request.themeName].cfstatic.include('/css/modules/com/Icedreaper/irBlog/main.less');

    include template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irBlog/dspEntry.cfm";
</cfscript>