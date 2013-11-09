<cfoutput>
    <article class="textBlock widget">
        <cfif isDefined("attributes.h1")><h1>#attributes.h1#</h1></cfif>
        <cfif isDefined("attributes.h4")><h4 class="subline">#attributes.h4#</h4></cfif>
        <cfif isDefined("attributes.text")><div class="text">#attributes.text#</div></cfif>
    </article>
</cfoutput>