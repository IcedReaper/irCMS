<cfscript>
    application.themes.irBootstrap.cfstatic.include('/js/core/')
                                           .include('/css/bootstrap/bootstrap.less')
                                           .include('/css/core/main.less')
                                           .include( '/system/js/jquery/jquery-2.0.3.min.js')
                                           .include( '/system/js/bootstrap/bootstrap.js')
                                           .include( '/system/js/modernizr/modernizr-2.6.2-respond-1.1.0.min.js');;
</cfscript>
<cfoutput>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7 IcedReaper"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8 IcedReaper"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9 IcedReaper"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js IcedReaper"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>#request.actualMenu.getTitle()#</title>
        <meta name="description" content="#request.actualMenu.getDescription()#" />
        <meta name="keywords" content="#request.actualMenu.getKeywords()#" />
        <meta name="viewport" content="width=device-width">

        #application.themes.irBootstrap.cfstatic.renderIncludes('css')#
        <style>
            body {
                padding-top: 50px;
                padding-bottom: 20px;
            }
        </style>
        <script src="/system/js/modernizr/modernizr-2.6.2-respond-1.1.0.min.js"></script>
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->
        <header>
            <cfmodule template="templates/default/navigation.cfm" position="#request.actualMenu.getTopNavigationName()#">
            <!---<cfinclude template="templates/default/login.cfm">--->
        </header>
        <section class="content">
            #request.content#
        </section>

        <footer>
            <p>&copy; IcedReaper 2013</p>
        </footer>
        <!---<cfinclude template="templates/default/footer.cfm">--->

        #application.themes.irBootstrap.cfstatic.renderIncludes('js')#

        <!---<script>
            var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
            (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
            g.src='//www.google-analytics.com/ga.js';
            s.parentNode.insertBefore(g,s)}(document,'script'));
        </script>--->
    </body>
</html>
</cfoutput>