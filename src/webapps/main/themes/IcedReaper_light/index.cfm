<cfscript>
    application.themes.icedreaper_light.cfstatic.include('/js/core/')
                                                .include('/css/core/');
</cfscript>
<cfoutput>
<!DOCTYPE html>
<html lang="de" class="icedreaper">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!---<title>#request.actualMenu.getTitle()#</title>
        <meta name="keywords" content="#request.actualMenu.getKeywords()#" />
        <meta name="description" content="#request.actualMenu.getDescription()#" />
        <link rel="canonical" href="#request.actualMenu.getCanonical()#" />--->
        
        <link href='http://fonts.googleapis.com/css?family=Condiment|New+Rocker' rel='stylesheet' type='text/css'>
        #application.themes.icedreaper_light.cfstatic.renderIncludes('css')#
    </head>
    <body>
        <header>
            <cfinclude template="templates/default/navigation.cfm">
			<cfinclude template="templates/default/login.cfm">
		</header>
    	<!---<cfinclude template="templates/default/breadcrum.cfm">--->
		<section class="content">
            <cfif request.actualMenu.checkShowContent()>
                #request.actualMenu.getContent(cleanArticle=false)#
            </cfif>
            <cfif request.actualMenu.checkShowModule()>
                #request.actualMenu.getModuleContent()#
            </cfif>
        </section>
        <footer>
            <cfinclude template="templates/default/footer.cfm">
        </footer>
        #application.themes.icedreaper_light.cfstatic.renderIncludes('js')#
    </body>
</html>
</cfoutput>