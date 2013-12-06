<cfscript>
    request.pageTitle = "#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irPermission.group.pageTitle', language=request.language)# #attributes.groupName#";
    
    if(attributes.editable) {
        application.themes.irBootstrap.cfstatic.include('/js/modules/com/IcedReaper/irPermission/');
    }
</cfscript>
<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <header class="widget">
                <h2>
                    <cf_translation keyName='modules.com.IcedReaper.irPermission.group.headline'> #attributes.groupName#
                    <small><cf_translation keyName='modules.com.IcedReaper.irPermission.group.subTitle'></small>
                </h2>
            </header>
        </div>
    </div>
    <cfif attributes.editable>
        <div class="row" id="actionBar">
            <div class="col-md-12">
                <section class="widget">
                    <form action="#attributes.sesLink#/#attributes.groupName#" method="post">
                        <input name="roles" id="newRoleStruct" type="hidden">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="pull-left">
                                     <a href="#attributes.sesLink#" class="btn btn-sm btn-warning" title="<cf_translation keyName='modules.com.IcedReaper.irPermission.group.button.cancel.title'>"><span class="glyphicon glyphicon-off"></span> <cf_translation keyName='modules.com.IcedReaper.irPermission.group.button.cancel.caption'></a>
                                </div>
                                <div class="pull-right">
                                     <button class="btn btn-primary" type="submit" name="action" value="<cf_translation keyName='modules.com.IcedReaper.irPermission.group.button.save.value'>" title="<cf_translation keyName='modules.com.IcedReaper.irPermission.group.button.save.title'>" id="save"><span class="glyphicon glyphicon-floppy-disk"></span> <cf_translation keyName='modules.com.IcedReaper.irPermission.group.button.save.caption'></button>
                                </div>
                            </div>
                        </div>
                    </form>
                </section>
            </div>
        </div>
    </cfif>
    
    <section class="row">
        <section class="col-md-9">
            <section class="row">
                <cfloop from="1" to="#attributes.roleData.len()#" index="roleDataIndex">
                    <section class="col-md-3">
                        <article class="widget">
                            <fieldset>
                                <legend>#attributes.roleData[roleDataIndex].roleName#</legend>
                                <ul class="list-group" data-roleName="#attributes.roleData[roleDataIndex].roleName#">
                                    <cfloop from="1" to="#attributes.roleData[roleDataIndex].user.len()#" index="userIndex">
                                        <li class="list-group-item"
                                            draggable="true"
                                            id="user#attributes.roleData[roleDataIndex].user[userIndex].userId#"
                                            data-userId="#attributes.roleData[roleDataIndex].user[userIndex].userId#">#attributes.roleData[roleDataIndex].user[userIndex].userName#</li>
                                    </cfloop>
                                </ul>
                            </fieldset>
                        </article>
                    </section>
                </cfloop>
            </section>
        </section>
        <section class="col-md-3">
            <article class="widget">
                <fieldset>
                    <legend><cf_translation keyName='modules.com.IcedReaper.irPermission.group.userList'></legend>
                    <ul class="list-group" id="userList">
                        <cfloop from="1" to="#attributes.userWithoutPermission.len()#" index="userIndex">
                            <li class="list-group-item" 
                                draggable="true"
                                id="user#attributes.userWithoutPermission[userIndex].userId#"
                                data-userId="#attributes.roleData[roleDataIndex].user[userIndex].userId#">#attributes.userWithoutPermission[userIndex].userName#</li>
                        </cfloop>
                    </ul>
                </fieldset>
            </article>
        </section>
    </section>
    
    <script type="html/text" id="dummyUser">
        <li class="list-group-item dummy" id="dummy"><cf_translation keyName='modules.com.IcedReaper.irPermission.group.addAUser'></li>
    </script>
</cfoutput>