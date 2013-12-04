<cfset request.pageTitle = application.tools.i18n.getTranslation(keyName='modules.com.IcedReaper.irUser.search.pageTitle', language=request.language)>
<cfoutput>
    <section class="widget">
        <div class="row">
            <div class="col-md-12">
                <header>
                    <h2><cf_translation keyName='modules.com.IcedReaper.irUser.search.headline'></h2>
                </header>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <form id="userData" class="form-horizontal" role="form" method="post" action="#request.sesLink#">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="<cf_translation keyName='modules.com.IcedReaper.irUser.search.placeholder'>" name="userName">
                        <span class="input-group-btn">
                            <button class="btn btn-success" type="button"><cf_translation keyName='modules.com.IcedReaper.irUser.search.submit'></button>
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </section>
</cfoutput>