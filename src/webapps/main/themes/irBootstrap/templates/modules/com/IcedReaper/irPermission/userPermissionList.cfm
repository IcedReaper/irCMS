<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <section class="widget" id="userPermissions">
                <fieldset>
                    <legend><cf_translation keyName='modules.com.IcedReaper.irPermission.permissionList.headline'></legend>
                    <div class="form-horizontal">
                        <cfloop from="1" to="#attributes.permissions.len()#" index="permissionIndex">
                            <div class="form-group">
                                <label class="col-lg-3 control-label">#attributes.permissions[permissionIndex].groupName#</label>
                                <div class="col-lg-9">
                                    <p class="form-control-static">#attributes.permissions[permissionIndex].roleName#</p>
                                </div>
                            </div>
                        </cfloop>
                    </div>
                    <cfif request.actualUser.hasPermission(groupName='irPermission', roleName='Editor')>
                        <a class="btn btn-primary" href="/Admin/Permissions/User/#attributes.userName#" title="<cf_translation keyName='modules.com.IcedReaper.irPermission.permissionList.buttons.edit.title'>"><span class="glyphicon glyphicon-edit"></span><cf_translation keyName='modules.com.IcedReaper.irPermission.permissionList.buttons.edit.caption'></a>
                    </cfif>
                </fieldset>
            </section>
        </div>
    </div>
</cfoutput>