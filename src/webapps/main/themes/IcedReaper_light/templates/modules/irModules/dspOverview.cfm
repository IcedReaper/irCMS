<cfset moduleOverview = createObject("component", "#application.rootComponentPath#system.cfc.com.irModules.irModules.moduleOverview").init(errorHandler=application.cms.errorHandler, datasource=application.datasource.user, tablePrefix=application.tablePrefix)>
<cfif arrayLen(attributes.entities) EQ 2 AND attributes.entities[1] EQ 'Seite'>
    <cfset page = attributes.entities[2]>
<cfelse>
    <cfset page = 1>
</cfif>
<cfset overview = moduleOverview.filter(pageNumber=page, numberPerPage=20)>

<table>
    <thead>
        <th>Name</th>
        <th>Erstellt von</th>
        <th>Erstellt am</th>
        <th>Tags</th>
    </thead>
    <tbody>
        <cfif arrayLen(overview) GT 0>
            <cfoutput>
                <cfloop index="i" from="1" to="#arrayLen(overview)#">
                    <tr>
                        <td><a href="#attributes.sesLink#/#overview[i].name#" title="Gucke Dir hier die Details zu #overview[i].name# an.">#overview[i].name#</a></td>
                        <td><a href="#attributes.sesLink#/Ersteller/#overview[i].creator#" title="Gucke Dir hier alle Module von #overview[i].creator# an.">#overview[i].creator#</td>
                        <td><a href="#attributes.sesLink#/#overview[i].name#" title="Gucke Dir hier die Details zu #overview[i].name# an.">#overview[i].creationDate#</a></td>
                        <td>
                            <cfloop index="j" from="1" to="#arrayLen(overview[i].tags)#">
                                <a href="#request.sesLink#/Tags/#overview[i].tags[j]#" title="Gucke Dir hier alle Module an, welche mit #overview[i].tags[j]# getaggt worden sind.">#overview[i].tags[j]#</a><br />
                            </cfloop>
                        </td>
                    </tr>
                </cfloop>
            </cfoutput>
        <cfelse>
            <td colspan="4">Es wurden keine verfügbaren Module gefunden</td>
        </cfif>
    </tbody>
</table>