<cfcomponent extends="AbstractApplication">

<cffunction name="onRequestStart" access="public" returnType="boolean" output="false">
	    <cfargument type="String" name="targetPage" required="true">

	<cfif session.level neq "admin">
        <cfinclude template="login.cfm">
        <cfabort>
    </cfif>
	<cfreturn true>
</cffunction>

</cfcomponent>


