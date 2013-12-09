<cfsilent><cfif thisTag.ExecutionMode eq "Start"><cfassociate basetag="cf_translation" datacollection="param"></cfif></cfsilent>
<cfscript>
if(thisTag.ExecutionMode == "Start") {
    param name="attributes.content" type="string" default="";
}
else {
    attributes.content = thisTag.generatedContent;
    thisTag.generatedContent = "";
}
</cfscript>