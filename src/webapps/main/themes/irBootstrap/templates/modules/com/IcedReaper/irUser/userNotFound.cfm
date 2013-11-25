<cfset request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.search.notFound.pageTitle', language=request.language)>
<cfoutput>
	<div class="row">
	    <div class="col-md-12">
	        <div class="alert alert-danger">
	            #application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.search.notFound.message', language=request.language)#
	            <a type="button" class="btn btn-default" href="/User">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.search.notFound.buttons.overview.caption', language=request.language)#</a>
	            <a type="button" class="btn btn-default" href="/User/Suche">#application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.search.notFound.buttons.search.caption', language=request.language)#</a>
	        </div>
	    </div>
	</div>
</cfoutput>