<cfif isDefined("attributes.backgroundImage")>
    <cfoutput>
        <article style="background-image:#attributes.backgroundImage#" class="heroImage"></article>
    </cfoutput>
</cfif>