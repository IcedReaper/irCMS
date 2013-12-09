<cfoutput>
    <div class="form-group">
        <div class="col-md-12">
            <header class="widget">
                <h2><cf_translation keyName='core.permissionNotSufficient.headline'></h2>
            </header>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12">
            <div class="alert alert-danger">
                <cf_translation keyName='core.permissionNotSufficient.text'>
                    <cf_translationParam>#attributes.groupName#</cf_translationParam>
                    <cf_translationParam>#attributes.roleName#</cf_translationParam>
                </cf_translation>
                <a type="button" class="btn btn-default" href="/"><cf_translation keyName='core.permissionNotSufficient.backToStart'></a>
            </div>
        </div>
    </div>
</cfoutput>