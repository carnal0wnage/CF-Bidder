<!--- Emaze Auction version 2.1, 1.01 / Tuesday, September 7, 1999 --->

<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("deleteLotIDs")>
	<HTML>
	<HEAD><TITLE>Update Category Lot Count</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

	<H1><FONT COLOR=purple>Update Category Lot Count . . .</FONT></H1>
</CFIF>

<CFQUERY NAME=catLotCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categoryLotCount = 0,
		categorySubLotCount = 0
	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
		, categoryMarketCount = 0,
		categorySubMarketCount = 0
	</CFIF>
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
		, categoryProcureCount = 0,
		categorySubProcureCount = 0
	</CFIF>
	WHERE categoryID > 0
</CFQUERY>

<CFQUERY NAME=catLotCount DATASOURCE="#EAdatasource#">
	SELECT categoryID
	FROM Category
</CFQUERY>

<CFLOOP QUERY=catLotCount>
	<CFIF NOT FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<CFQUERY NAME=countSelect DATASOURCE="#EAdatasource#">
		    SELECT Count(lotID) as lotCount
		    FROM Lot
		    WHERE categoryID = #catLotCount.categoryID#
				AND lotCloseQueue = 1
				AND lotType <> 0
		</CFQUERY>
	<CFELSE>
		<CFQUERY NAME=countSelect DATASOURCE="#EAdatasource#" >
		    SELECT Count(lotID) as lotCount
		    FROM Lot
		    WHERE categoryID = #catLotCount.categoryID#
				AND lotCloseQueue = 1
				AND lotType = 1
		</CFQUERY>
		<CFQUERY NAME=countSelect2 DATASOURCE="#EAdatasource#">
		    SELECT Count(lotID) as lotCount
		    FROM Lot
		    WHERE categoryID = #catLotCount.categoryID#
				AND lotCloseQueue = 1
				AND lotType = -1
		</CFQUERY>
		<CFSET procureCount = countSelect2.lotCount>
	</CFIF>

	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
		<CFQUERY NAME=countSelect3 DATASOURCE="#EAdatasource#" >
		    SELECT Count(lotID) as lotCount
		    FROM Lot
		    WHERE categoryID = #catLotCount.categoryID#
				AND lotCloseQueue = 1
				AND lotType = 0
		</CFQUERY>
		<CFSET marketCount = countSelect3.lotCount>
	</CFIF>

	<CFQUERY NAME=catUpdate DATASOURCE="#EAdatasource#">
	    UPDATE Category
	    SET categoryLotCount = #countSelect.lotCount#
		<CFIF IsDefined("marketCount")>, categoryMarketCount = #marketCount#</CFIF>
		<CFIF IsDefined("procureCount")>, categoryProcureCount = #procureCount#</CFIF>
	    WHERE categoryID = #catLotCount.categoryID#
	</CFQUERY>

	<!---
	<CFOUTPUT>
	categoryID = #catLotCount.categoryID#<BR>
	categoryLotCount = #countSelect.lotCount#<BR>
	<CFIF IsDefined("marketCount")>categoryMarketCount = #marketCount#<BR></CFIF>
	<CFIF IsDefined("procureCount")>categoryProcureCount = #procureCount#</CFIF><P>
	</CFOUTPUT>
	--->
</CFLOOP>

<CFLOOP QUERY=catLotCount>
	<CFQUERY NAME=catLotCountSelect DATASOURCE="#EAdatasource#">
	    SELECT categoryLotCount
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>, categoryMarketCount</CFIF>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, categoryProcureCount</CFIF>
	    FROM Category
	    WHERE categoryID1 = #catLotCount.categoryID#
			OR categoryID2 = #catLotCount.categoryID#
			OR categoryID3 = #catLotCount.categoryID#
			OR categoryID4 = #catLotCount.categoryID#
	</CFQUERY>

	<CFSET categorySubLotCount = 0>
	<CFSET categorySubMarketCount = 0>
	<CFSET categorySubProcureCount = 0>
	<CFLOOP QUERY=catLotCountSelect>
		<CFSET categorySubLotCount = categorySubLotCount + catLotCountSelect.categoryLotCount>
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
			<CFSET categorySubMarketCount = categorySubMarketCount + catLotCountSelect.categoryMarketCount>
		</CFIF>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
			<CFSET categorySubProcureCount = categorySubProcureCount + catLotCountSelect.categoryProcureCount>
		</CFIF>
	</CFLOOP> 
	<CFQUERY NAME=catUpdate DATASOURCE="#EAdatasource#">
	    UPDATE Category
	    SET categorySubLotCount = #categorySubLotCount#
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>, categorySubMarketCount = #categorySubMarketCount#</CFIF>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, categorySubProcureCount = #categorySubProcureCount#</CFIF>
	    WHERE categoryID = #catLotCount.categoryID#
	</CFQUERY>

	<!---
	<CFOUTPUT>
	categoryID = #catLotCount.categoryID#<BR>
    categorySubLotCount = #categorySubLotCount#<BR>
	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>categorySubMarketCount = #categorySubMarketCount#<BR></CFIF>
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>categorySubProcureCount = #categorySubProcureCount#</CFIF>
	</CFOUTPUT><P>
	--->
</CFLOOP>

<CFIF NOT IsDefined("deleteLotIDs")>
	<BR><BR>
	<H1><FONT COLOR=purple>Category lot counts successfully updated.</FONT></H1>
	</body></html>
</CFIF>
