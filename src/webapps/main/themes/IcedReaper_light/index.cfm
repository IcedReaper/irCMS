<cfoutput>
<!DOCTYPE html>
<html lang="de" class="icedreaper">
    <head>
        <title>#request.actualMenu.getTitle()#</title>
        <meta name="keywords" content="#request.actualMenu.getKeywords()#" />
        <meta name="description" content="#request.actualMenu.getDescription()#" />
        <link rel="canonical" href="#request.actualMenu.getCanonical()#" />
        
        <link href='http://fonts.googleapis.com/css?family=Condiment|New+Rocker' rel='stylesheet' type='text/css'>
        <link type="text/css" rel="stylesheet" id="mainStyle" href="themes/icedreaper_light/css/main.css">
    </head>
    <body>
        <header>
            <cfinclude template="templates/navigation.cfm">
			<cfinclude template="templates/login.cfm">
		</header>
    	<!---<cfinclude template="templates/breadcrum.cfm">--->
		<section class="content">
            #request.actualMenu.getContent()#
        </section>
        <footer>
            <cfinclude template="templates/footer.cfm">
        </footer>
    </body>
</html>
</cfoutput>