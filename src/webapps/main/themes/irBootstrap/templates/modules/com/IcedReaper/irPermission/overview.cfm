<cfset request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irPermission.overview.pageTitle', language=request.language)>
<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    <cf_translation keyName='modules.com.IcedReaper.irPermission.overview.headline'>
                    <small><cf_translation keyName='modules.com.IcedReaper.irPermission.overview.subTitle'></small>
                </h2>
            </header>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <section class="widget">
                <table class="table table-striped">
                    <thead>
                        <th><cf_translation keyName='modules.com.IcedReaper.irPermission.overview.groupName'></th>
                        <cfloop from="1" to="#attributes.roleList.len()#" index="roleIndex">
                            <th class="col-md-2"><cf_translation keyName='modules.com.IcedReaper.irPermission.overview.roleName.#attributes.roleList[roleIndex]#'></th>
						</cfloop>
                        <th class="col-md-1">&nbsp;</th>
                    </thead>
                    <tbody>
                        <cfloop from="1" to="#attributes.groupList.len()#" index="groupIndex">
							<tr>
							    <td>
							        <a href="#attributes.sesLink#/#attributes.groupList[groupIndex].name#">#attributes.groupList[groupIndex].name#</a>
                                </td>
                                <cfloop from="1" to="#attributes.groupList[groupIndex].roles.len()#" index="roleIndex">
									<td>
									    #attributes.groupList[groupIndex].roles[roleIndex]#
									</td>
							    </cfloop>
                                <td>
                                    <a class="btn btn-default pull-right" title="<cf_translation keyName='modules.com.IcedReaper.irPermission.overview.buttons.edit.title'>" href="#attributes.sesLink#/#attributes.groupList[groupIndex].name#"><span class="glyphicon glyphicon-pencil"></span></a>
                                </td>
							</tr>
                        </cfloop>
                    </tbody>
                </table>
            </section>
        </div>
    </div>
</cfoutput>