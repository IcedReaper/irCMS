<cfif isDefined("attributes.backgroundImage")>
    <cfoutput>
        <article class="module heroImage" style="background-image:url(#attributes.backgroundImage#)">
            <cfif attributes.keyExists('content')>
				<div>#attributes.content#</div>
			</cfif>
        </article>
    </cfoutput>
</cfif>