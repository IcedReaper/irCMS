<cfparam name="attributes.entities" default="[]">
<cfparam name="attributes.show"     default="All">

<section class="irModules">
    <cfswitch expression="#arrayLen(attributes.entities)#">
        <cfcase value="0">
            <cfswitch expression="#attributes.show#">
                <cfcase value="Top">
                    <cfinclude template="top.cfm">
                </cfcase>
                <cfdefaultCase>
                    <cfinclude template="overview.cfm">
                </cfdefaultCase>
            </cfswitch>
        </cfcase>
        <cfcase value="1">
            <cfswitch expression="#attributes.entities[1]#">
                <cfcase value="Tags">
                    <cfinclude template="tagOverview.cfm">
                </cfcase>
                <cfdefaultcase>
                    <cfinclude template="detail.cfm">
                </cfdefaultcase>
            </cfswitch>
        </cfcase>
        <cfcase value="2">
            <cfswitch expression="#attributes.entities[1]#">
                <cfcase value="Tags">
                    <cfinclude template="tag.cfm">
                </cfcase>
                <cfcase value="Ersteller">
                    <cfinclude template="creator.cfm">
                </cfcase>
                <cfcase value="Seite">
                    <cfinclude template="overview.cfm">
                </cfcase>
            </cfswitch>
        </cfcase>
        <cfdefaultcase>
            
        </cfdefaultcase>
    </cfswitch>
</section>