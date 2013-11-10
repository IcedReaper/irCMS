<cfif isDefined("attributes.backgroundImage")>
    <cfoutput>
        <article class="module heroImage" style="background-image:url(#attributes.backgroundImage#)"></article>
    </cfoutput>
</cfif>