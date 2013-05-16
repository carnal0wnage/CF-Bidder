<!--- Open the auction for bidding. This page is only used if the auto_open has been set.
	This page is run via a scheduled task. --->

<!--- Don't run unless the open URL parameter exists in case accidentally run --->
<cfif not structKeyExists(url,"open")><cfabort></cfif>

<!--- open the auction and delete the scheduled
	job that was started to run this page --->
<cfset application.status = true>
<cfquery datasource="#application.settings.dsn#">
	update Master 
	set mst_status = 1, mst_open_time = null
	where mst_no = 1
</cfquery>
<cfschedule action="DELETE" task="#url.task#">
