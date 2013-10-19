﻿<cfscript>
    application.themes.icedreaper_light.cfstatic.include('/js/core/')
                                                .include('/css/core/main.less');
</cfscript>
<cfoutput>
<!DOCTYPE html>
<html lang="de" class="icedreaper">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>#request.actualMenu.getTitle()#</title>
        <meta name="keywords" content="#request.actualMenu.getKeywords()#" />
        <meta name="description" content="#request.actualMenu.getDescription()#" />
        <link rel="canonical" href="#request.actualMenu.getCanonical()#" />
        
        <link href='http://fonts.googleapis.com/css?family=Condiment|New+Rocker' rel='stylesheet' type='text/css'>
        #application.themes.icedreaper_light.cfstatic.renderIncludes('css')#
    </head>
    <body>
        <header>
            <cfmodule template="templates/default/navigation.cfm" position="#request.actualMenu.getTopNavigationName()#">
			<cfinclude template="templates/default/login.cfm">
		</header>
    	<!---<cfinclude template="templates/default/breadcrum.cfm">--->
		<section class="content">
            #request.content#
        </section>
        <footer>
            <cfinclude template="templates/default/footer.cfm">
        </footer>
        #application.themes.icedreaper_light.cfstatic.renderIncludes('js')#
    </body>
</html>
</cfoutput>