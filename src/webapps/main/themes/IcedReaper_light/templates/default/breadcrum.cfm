<cfset breadcrum = request.actualMenu.getBreadcrum()>
<cfif arrayLen(breadcrum) GT 0>
	<cfoutput>
		<section class="breadcrum">
    	    <nav>
    	        <ul>
                    <cfloop from="1" to="#arrayLen(breadcrum)#" index="i">
                    	<li><a href="#breadcrum[i].sesLink#">#breadcrum[i].linkname#</a></li> <cfif i NEQ arrayLen(breadcrum)>/</cfif> 
                    </cfloop>
                </ul>
            </nav>
        </section>
    </cfoutput>
</cfif>