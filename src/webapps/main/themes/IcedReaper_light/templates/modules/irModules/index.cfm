<cfparam name="attributes.entities" default="[]">
<cfparam name="attributes.show"     default="All">

<section class="irModules">
    <cfswitch expression="#arrayLen(attributes.entities)#">
        <cfcase value="0">
            <cfswitch expression="#attributes.show#">
                <cfcase value="Top">
                    <cfinclude template="dspTop.cfm">
                </cfcase>
                <cfdefaultCase>
                    <cfinclude template="dspOverview.cfm">
                </cfdefaultCase>
            </cfswitch>
        </cfcase>
        <cfcase value="1">
            <cfswitch expression="#attributes.entities[1]#">
                <cfcase value="Tags">
                    <cfinclude template="dspTagOverview.cfm">
                </cfcase>
                <cfdefaultcase>
                    <cfinclude template="dspDetail.cfm">
                </cfdefaultcase>
            </cfswitch>
        </cfcase>
        <cfcase value="2">
            <cfswitch expression="#attributes.entities[1]#">
                <cfcase value="Tags">
                    <cfinclude template="dspTag.cfm">
                </cfcase>
                <cfcase value="Ersteller">
                    <cfinclude template="dspCreator.cfm">
                </cfcase>
                <cfcase value="Seite">
                    <cfinclude template="dspOverview.cfm">
                </cfcase>
            </cfswitch>
        </cfcase>
        <cfdefaultcase>
            
        </cfdefaultcase>
    </cfswitch>
</section>