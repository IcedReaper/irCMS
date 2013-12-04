<cfscript>
	param name="attributes.keyName" default="";
	param name="attributes.language" default=request.language;
	if(attributes.keyName != "") {
		writeOutput(application.tools.i18n.getTranslation(keyName=attributes.keyName, language=attributes.language));
	}
</cfscript>