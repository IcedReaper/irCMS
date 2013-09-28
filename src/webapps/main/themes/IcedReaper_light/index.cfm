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
        <link type="text/css" rel="stylesheet" id="mainStyle" href="/themes/IcedReaper_light/css/main.css">
    </head>
    <body>
        <header>
            <cfinclude template="templates/default/navigation.cfm">
			<cfinclude template="templates/default/login.cfm">
		</header>
    	<!---<cfinclude template="templates/default/breadcrum.cfm">--->
		<section class="content">
            <h2>Content:</h2>
            #request.actualMenu.getContent()#

            <h2>Entity:</h2>
            #request.actualMenu.getEntity()#
        </section>
        <footer>
            <cfinclude template="templates/default/footer.cfm">
        </footer>
    </body>
</html>
</cfoutput>