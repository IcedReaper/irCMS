<cfif isDefined("attributes.backgroundImage")>
    <cfoutput>
        <article class="module heroImage" style="background-image:url(#attributes.backgroundImage#)">
            <cfif attributes.keyExists('content')>
				<div>
				    <cfif attributes.content.keyExists('headline')><h3>#attributes.content.headline#</h3></cfif>
                    <cfif attributes.content.keyExists('description')><div class="text">#attributes.content.description#</div></cfif>
                    <cfif attributes.content.keyExists('link')>
						<a <cfif attributes.content.link.keyExists('href')>href="#attributes.content.link.href#"</cfif>
						   <cfif attributes.content.link.keyExists('title')>title="#attributes.content.link.title#"</cfif>
						   <cfif attributes.content.link.keyExists('class')>class="#attributes.content.link.class#"</cfif>
						   <cfif attributes.content.link.keyExists('href')>onClick="#attributes.content.link.href#"</cfif>>
                            <cfif attributes.content.link.keyExists('icon')><span class="glyphicon glyphicon-#attributes.content.link.icon#"></span></cfif> <cfif attributes.content.link.keyExists('text')>#attributes.content.link.text#</cfif>
                        </a>
                    </cfif>
				</div>
			</cfif>
        </article>
    </cfoutput>
</cfif>