<CFIF NOT IsDefined("categoryID")>
	<CFSET title = "titleCategoryBad">
	<CFINCLUDE TEMPLATE="system/navigate.cfm">
	<H3>No categoryID has been specified.</H3>
	<CFINCLUDE TEMPLATE="program/copyright.cfm">
	<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF FileExists("#systemPath#\category\#categoryID#CategoryInfo.cfm") EQ "NO">
	<CFSET title = "titleCategoryBad">
	<CFINCLUDE TEMPLATE="system/navigate.cfm">
	<H3>This category does not exist.</H3>
	<CFINCLUDE TEMPLATE="program/copyright.cfm">
	<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFQUERY NAME=updateCatViewCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categoryViewCount = categoryViewCount + 1
	WHERE categoryID = #categoryID#
</CFQUERY>

<CFINCLUDE TEMPLATE="category/#categoryID#CategoryInfo.cfm">
<CFINCLUDE TEMPLATE="template/#templateFile#">

<CFINCLUDE TEMPLATE="program/copyright.cfm">
<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
