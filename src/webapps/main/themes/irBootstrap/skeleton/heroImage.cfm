<cfif isDefined("attributes.backgroundImage")>
    <cfoutput>
        <article style="background-image:url(#attributes.backgroundImage#)" class="heroImage"></article>
    </cfoutput>
</cfif>