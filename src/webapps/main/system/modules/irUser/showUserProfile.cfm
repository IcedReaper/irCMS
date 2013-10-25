<cfscript>
    attributes.moduleData.userData = createObject('component', 'system.cfc.com.irCMS.user.irUser').init(errorHandler = application.cms.errorHandler
                                                                                                       ,datasource   = application.datasource.user
                                                                                                       ,tablePrefix  = application.tablePrefix
                                                                                                       ,userName     = attributes.moduleData.userName);
    attributes.moduleData.userData.load();
    include template="/themes/#request.themeName#/templates/modules/irUser/userProfile.cfm";
</cfscript>