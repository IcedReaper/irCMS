<cfscript>
    param name="attributes.entities" default="[]";
    param name="attributes.show"     default="All";

    writedump(var="#attributes#");

    article = createObject("component", "irCMS.system.cfc.com.irModules.irBlog.article").init(datasource  = application.datasource.user
                                                                                             ,tablePrefix = application.tablePrefix
                                                                                             ,articleId   = 1)>

    application.themes[request.themeName].cfstatic.include('/js/modules/irBlog.less');

    include template="/themes/#request.themeName#/templates/modules/irBlog/dspEntry.cfm";
</cfscript>