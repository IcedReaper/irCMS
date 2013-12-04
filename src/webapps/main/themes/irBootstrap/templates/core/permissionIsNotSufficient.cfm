<cfoutput>
    <div class="form-group">
        <div class="col-md-12">
            <header class="widget">
                <h2>#application.tools.i18n.getTranslation(keyName='core.permissionNotSufficient.headline', language=request.language)#</h2>
            </header>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-12">
            <div class="alert alert-danger">
                #application.tools.i18n.getTranslation(keyName='core.permissionNotSufficient.text', language=request.language)#
                <a type="button" class="btn btn-default" href="/">#application.tools.i18n.getTranslation(keyName='core.permissionNotSufficient.backToStart', language=request.language)#</a>
            </div>
        </div>
    </div>
</cfoutput>