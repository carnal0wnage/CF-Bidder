<CFIF FileExists("#systemPath#\template\#indexTemplate#")>
	<CFINCLUDE TEMPLATE="template/#indexTemplate#">
	<CFINCLUDE TEMPLATE="program/copyright.cfm">
	<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
<CFELSE>
	<CFSET title = "">
	<CFINCLUDE TEMPLATE="system/navigate.cfm">
	<H3>This page does not exist.</H3>
	<CFINCLUDE TEMPLATE="program/copyright.cfm">
	<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
	<BODY></HTML>
</CFIF>
