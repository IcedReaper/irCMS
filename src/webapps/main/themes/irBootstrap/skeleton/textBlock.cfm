<cfoutput>
    <article class="textBlock widget">
        <cfif isDefined("arguments.h1")><h1>#arguments.h1#</h1></cfif>
        <cfif isDefined("arguments.h4")><h4 class="subline">#arguments.h4#</h4></cfif>
        <cfif isDefined("arguments.text")><div class="text">#arguments.text#</div></cfif>
    </article>
</cfoutput>