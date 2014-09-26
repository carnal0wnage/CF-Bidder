<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFIF IsDefined("featured")>
	<CFSET title = "titleAllLotsFeatured">
<CFELSEIF IsDefined("opening")>
	<CFSET title = "titleAllLotsOpening">
<CFELSEIF IsDefined("closing")>
	<CFSET title = "titleAllLotsClosing">
<CFELSE>
	<CFSET title = "titleAllLots">
</CFIF>

<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<P>

<CFSET lotDateTime1 = CreateODBCDateTime(CreateDateTime(Year(Now()), Month(Now()), Day(Now()), 00, 00, 00))>
<CFSET lotDateTime2 = CreateODBCDateTime(CreateDateTime(Year(Now()), Month(Now()), Day(Now()), 23, 59, 59))>

<CFQUERY NAME=getAllLots DATASOURCE="#EAdatasource#">
	SELECT Lot.lotID, Lot.lotName, Lot.categoryID, Lot.lotBold, Lot.lotType, Category.categoryName
	FROM Category INNER JOIN Lot ON Category.categoryID = Lot.categoryID
	WHERE Lot.lotCloseQueue = 1
	<CFIF IsDefined("featured")> AND Lot.lotFeaturedHomepage = 1
	<CFELSEIF IsDefined("opening")>AND Lot.lotOpenDateTime BETWEEN #lotDateTime1# AND #lotDateTime2#
	<CFELSEIF IsDefined("closing")>AND Lot.lotCloseDateTime BETWEEN #lotDateTime1# AND #lotDateTime2#
	</CFIF>
	<CFIF IsDefined("market")>AND lotType = 0
	<CFELSEIF IsDefined("procure")>AND lotType = -1
	<CFELSEIF IsDefined("auction")>AND lotType = 1
	</CFIF>
	<CFIF IsDefined("categoryID")>AND Lot.categoryID = #categoryID#</CFIF>
	ORDER BY Category.categoryName, Lot.lotType DESC, Lot.lotName
</CFQUERY>

<CFINCLUDE TEMPLATE="../system/listMessages.cfm">
<CFIF getAllLots.RecordCount EQ 0>
	<CFIF IsDefined("featured")><CFOUTPUT>#lotsFeaturedNone#</CFOUTPUT>
	<CFELSEIF IsDefined("opening")><CFOUTPUT>#lotsOpeningTodayNone#</CFOUTPUT>
	<CFELSEIF IsDefined("closing")><CFOUTPUT>#lotsClosingTodayNone#</CFOUTPUT>
	<CFELSE><CFOUTPUT>#lotsOpenNone#</CFOUTPUT>
	</CFIF>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFSET previousCategoryID = 0>
<CFSET previousLotType = -3>
<CFOUTPUT QUERY="getAllLots">
	<CFIF previousCategoryID NEQ categoryID>
		<P><FONT SIZE=4><B>#categoryName#</B></FONT> (<A HREF="#systemURL#/category.cfm?categoryID=#categoryID#">#categoryGoLink#</A>)<BR>
	</CFIF>
	<CFIF previousLotType NEQ lotType AND (FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm"))>
		<BR><I><B><CFIF lotType EQ 1>Auction<CFELSEIF lotType EQ 0>Classified<CFELSE>Procure</CFIF></B></I><BR>
		<CFSET previousLotType = lotType>
	</CFIF>
	<A HREF="#systemURL#/lot.cfm?lotID=#lotID#">#lotID#</A>. <CFIF lotBold EQ 1><B>#lotName#</B><CFELSE>#lotName#</CFIF><BR>
	<CFSET previousCategoryID = categoryID>
</CFOUTPUT>

<P>
<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
<CFINCLUDE TEMPLATE="closeCheck.cfm">
</BODY></HTML>