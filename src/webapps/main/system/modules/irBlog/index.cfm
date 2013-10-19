<cfset article = createObject("component", "irCMS.system.cfc.com.irModules.irBlog.article").init(datasource  = application.datasource.user
                                                                                                ,tablePrefix = application.tablePrefix
                                                                                                ,articleId   = 1)>

<cfinclude template="/themes/#request.themeName#/templates/modules/irBlog/dspEntry.cfm">