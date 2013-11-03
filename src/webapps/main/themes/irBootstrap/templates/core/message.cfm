<cfscript>
    param name="attributes.headline" default="";
    param name="attributes.text"     default="";
    param name="attributes.type"     default="danger"; // success || info || warning || danger (http://getbootstrap.com/components/#alerts)
</cfscript>
<cfif attributes.headline NEQ "" AND attributes.text NEQ "">
    <div class="alert alert-#attributes.type#">
        <cfif attributes.text NEQ "">
            <h3>#attributes.headline#</h3>
        </cfif>
        #attributes.text#
    </div>
</cfif>