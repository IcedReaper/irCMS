<cfset moduleOverview = createObject("component", "system.cfc.com.IcedReaper.modules.irModule.moduleOverview").init(errorHandler = application.cms.errorHandler
                                                                                                                   ,datasource   = application.datasource.user
                                                                                                                   ,tablePrefix  = application.tablePrefix)>
<cfif arrayLen(attributes.entities) EQ 2 AND attributes.entities[1] EQ 'Seite'>
    <cfset page = attributes.entities[2]>
<cfelse>
    <cfset page = 1>
</cfif>
<cfset overview = moduleOverview.filter(pageNumber=page, numberPerPage=20)>

<cfinclude template="/themes/#request.themeName#/templates/modules/com/Icedreaper/irModule/dspOverview.cfm">