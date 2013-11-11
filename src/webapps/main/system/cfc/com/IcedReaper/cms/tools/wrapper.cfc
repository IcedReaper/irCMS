<cfcomponent>
    <cffunction name="HTMLHead" output="false" returnType="void">
        <cfargument name="text" type="string" required="yes">
        <cfhtmlhead text="#text#">
    </cffunction>
</cfcomponent>