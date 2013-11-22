<cfif isDefined("attributes.backgroundImage")>
    <cfoutput>
            <img src="#attributes.backgroundImage#">
        <article class="module heroImage" <cfif attributes.keyExists('height')>style="height:#attributes.height#"</cfif>>
            <cfif attributes.keyExists('content')>
				<div>#attributes.content#</div>
			</cfif>
        </article>
    </cfoutput>
</cfif>