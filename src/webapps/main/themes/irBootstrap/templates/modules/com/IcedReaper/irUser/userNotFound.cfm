<cfset request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.search.notFound.pageTitle', language=request.language)>
<cfoutput>
	<div class="row">
	    <div class="col-md-12">
	        <div class="alert alert-danger">
	            <cf_translation keyName='modules.com.IcedReaper.irUser.search.notFound.message'>
	            <a type="button" class="btn btn-default" href="#attributes.sesLink#"><cf_translation keyName='modules.com.IcedReaper.irUser.search.notFound.buttons.overview.caption'></a>
	            <a type="button" class="btn btn-default" href="#attributes.sesLink#/search"><cf_translation keyName='modules.com.IcedReaper.irUser.search.notFound.buttons.search.caption'></a>
	        </div>
	    </div>
	</div>
</cfoutput>