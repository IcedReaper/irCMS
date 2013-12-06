<cfscript>
    request.pageTitle = "#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irPermission.user.pageTitle', language=request.language)# #attributes.userName#";
    
    application.themes.irBootstrap.cfstatic.include('/js/modules/com/IcedReaper/irPermission/user.js');
</cfscript>
<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    <cf_translation keyName='modules.com.IcedReaper.irPermission.user.headline'> #attributes.userName#
                    <small><cf_translation keyName='modules.com.IcedReaper.irPermission.user.subTitle'></small>
                </h2>
            </header>
        </div>
    </div>
    <cfif isDefined("attributes.saveSuccessfull") AND attributes.saveSuccessfull>
        <div class="row">
            <div class="col-md-12">
                <div class="alert alert-success">
                    <cf_translation keyName='modules.com.IcedReaper.irPermission.group.update.successfull'>
                </div>
            </div>
        </div>
    </cfif>
    <section class="row">
        <section class="col-sm-12">
            <article class="widget">
                <form action="#request.sesLink#" method="post" class="form-horizontal">
                    <fieldset>
                        <legend><cf_translation keyName='modules.com.IcedReaper.irPermission.user.headline'></legend>
                        <cfloop from="1" to="#attributes.groupList.len()#" index="groupIndex">
                            <div class="form-group">
                                <label class="col-lg-3 control-label">#attributes.groupList[groupIndex].name#</label>
                                <div class="col-lg-9">
                                    <select name="#attributes.groupList[groupIndex].name#">
                                        <option value="guest" selected="selected"><cf_translation keyName='modules.com.IcedReaper.irPermission.overview.roleName.guest'></option>
                                        <cfloop from="1" to="#attributes.roleList.len()#" index="roleIndex">
                                            <option value="#attributes.roleList[roleIndex].id#" <cfif attributes.user.hasPermission(groupName=attributes.groupList[groupIndex].name, roleName=attributes.roleList[roleIndex].name)>selected="selected"</cfif>><cf_translation keyName='modules.com.IcedReaper.irPermission.overview.roleName.#attributes.roleList[roleIndex].name#'></option>
                                        </cfloop>
                                    </select>
                                </div>
                            </div>
                        </cfloop>
                        <div class="form-group">
                            <div class="col-md-12">
                                <a href="/User/#attributes.userName#" class="btn btn-warning" title="<cf_translation keyName='modules.com.IcedReaper.irPermission.user.button.cancel.title'>"><cf_translation keyName='modules.com.IcedReaper.irPermission.user.button.cancel.caption'></a>
                                <button name="action" id="save" value="save" class="pull-right btn btn-success" title="<cf_translation keyName='modules.com.IcedReaper.irPermission.user.button.save.title'>"><span class="glyphicon glyphicon-floppy-disk"></span> <cf_translation keyName='modules.com.IcedReaper.irPermission.user.button.save.title'></button>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </acticle>
        </section>
    </section>
</cfoutput>