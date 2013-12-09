<cfscript>
    if(thisTag.executionMode == 'Start') {
        param name="attributes.keyName" default="";
    	param name="attributes.language" default=request.language;
    }
    
    if(thisTag.executionMode == 'End' || ! thisTag.hasEndTag) {
        if(attributes.keyName != "") {
            translationText = application.tools.i18n.getTranslation(keyName=attributes.keyName, language=attributes.language);
            
            if((isDefined("thisTag.param")) && thisTag.param.len() > 0) {
                for(i = 0; i < thisTag.param.len(); i++) {
                   translationText = translationText.replace('{{' & i & '}}', thisTag.param[i + 1].content);
                }
            }
            thisTag.generatedContent = "";
            
            writeOutput(translationText);
        }
    }
</cfscript>