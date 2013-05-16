<!--- Close the auction or bidding on an individual item
	This page is only used if the auto_close feature is enabled
	to set an auto close time for the entire auction or an individual item.
	This page is run via a scheduled task. --->

<!--- Don't run unless the close URL parameter exists in case accidentally run --->
<cfif not structKeyExists(url,"close")><cfabort></cfif>

<!--- Close the particular item or the entire auction and delete the scheduled
	job that was started to run this page --->
<cfif structKeyExists(url,"no")>
	<cfquery datasource="#application.settings.dsn#">
		update Item
		set status = 0, close_time = null
		where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
	</cfquery>
	<cfschedule action="DELETE" task="#url.task#">
<cfelse>
	<cfset application.status = false>
	<cfquery datasource="#application.settings.dsn#">
		update Master 
		set mst_status = 0, mst_close_time = null
		where mst_no = 1
	</cfquery>
	<cfschedule action="DELETE" task="#url.task#">
</cfif>