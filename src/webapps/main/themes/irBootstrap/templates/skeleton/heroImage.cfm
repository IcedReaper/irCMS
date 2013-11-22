<cfif isDefined("attributes.backgroundImage")>
    <cfoutput>
        <article class="module heroImage" <cfif attributes.keyExists('height')>style="#attributes.height#"</cfif>>
            <img src="#attributes.backgroundImage#">
            <cfif attributes.keyExists('content')>
				<div>#attributes.content#</div>
			</cfif>
        </article>
    </cfoutput>
</cfif>