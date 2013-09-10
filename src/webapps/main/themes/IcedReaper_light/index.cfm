<cfoutput>
<!DOCTYPE html>
<html lang="de" class="icedreaper">
    <head>
        <title>#request.actualMenu.getTitle()#</title>
        <meta name="keywords" content="#request.actualMenu.getKeywords()#" />
        <meta name="description" content="#request.actualMenu.getDescription()#" />
        <link rel="canonical" href="#request.actualMenu.getCanonical()#" />
        
        <link href='http://fonts.googleapis.com/css?family=Condiment|New+Rocker' rel='stylesheet' type='text/css'>
        <link type="text/css" rel="stylesheet" id="mainStyle" href="themes/icedreaper/css/main.css">
    </head>
    <body>
        <cfinclude template="templates/navigation.cfm">
		<cfinclude template="templates/breadcrum.cfm">
		#request.actualMenu.getContent()#
    </body>
</html>
</cfoutput>