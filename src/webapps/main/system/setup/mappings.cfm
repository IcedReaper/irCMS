<cfscript>
    application.mappings['/'] = getDirectoryFromPath(getCurrentTemplatePath());
</cfscript>