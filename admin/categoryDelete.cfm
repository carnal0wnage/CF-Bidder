<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Delete Category</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF NOT IsDefined("categoryID")>
	<H3>You did not choose the category to delete.</H3>
<CFELSE>
	<CFQUERY NAME=checkSubCategory DATASOURCE="#EAdatasource#">
		SELECT categoryID
		FROM Category
		WHERE categoryID <> #categoryID#
			AND (categoryID1 = #categoryID#
				OR categoryID2 = #categoryID#
				OR categoryID3 = #categoryID#
				OR categoryID4 = #categoryID#)
	</CFQUERY>
	<CFIF checkSubCategory.RecordCount NEQ 0>
		<H3>This category has at least one subcategory. You may not delete a category which has subcategories. You must delete the subcategories first.</H3>
		</BODY></HTML><CFABORT>
	</CFIF>

	<CFQUERY NAME=checkLots DATASOURCE="#EAdatasource#">
		SELECT lotID
		FROM Lot
		WHERE categoryID = #categoryID#
	</CFQUERY>
	<CFIF checkLots.RecordCount NEQ 0>
		<H3>This category has at least one lot. You may not delete a category which has lots. You must delete the lots first.</H3>
		</BODY></HTML><CFABORT>
	</CFIF>

	<CFSET catCount = 2>
	<CFQUERY NAME=getCategoryName DATASOURCE="#EAdatasource#">
		SELECT categoryID, categoryName, categoryID1, categoryID2,
			categoryID3, categoryID4
		FROM Category
		WHERE categoryID = #ListGetAt(categoryID,1)#
			<CFLOOP INDEX="catCount" LIST="#categoryID#">
				OR categoryID = #catCount#
			</CFLOOP>
		ORDER BY categoryName
	</CFQUERY>

	<H3>
	<CFLOOP QUERY="getCategoryName">
		<CFQUERY NAME=deleteCategory DATASOURCE="#EAdatasource#">
			DELETE FROM Category WHERE categoryID = #categoryID#
		</CFQUERY>
		<CFQUERY NAME=deleteCategory DATASOURCE="#EAdatasource#">
			DELETE FROM CategorySubscribe WHERE categoryID = #categoryID#
		</CFQUERY>

		<CFIF FileExists("#systemPath#\category\#categoryID#CategoryFooter.cfm")>
			<CFFILE ACTION=Delete FILE="#systemPath#\category\#categoryID#CategoryFooter.cfm">
		</CFIF>
		<CFIF FileExists("#systemPath#\category\#categoryID#CategoryHeader.cfm")>
			<CFFILE ACTION=Delete FILE="#systemPath#\category\#categoryID#CategoryHeader.cfm">
		</CFIF>
		<CFIF FileExists("#systemPath#\category\#categoryID#CategoryInfo.cfm")>
			<CFFILE ACTION=Delete FILE="#systemPath#\category\#categoryID#CategoryInfo.cfm">
		</CFIF>
		<CFIF FileExists("#systemPath#\category\#categoryID#CategorySpecial.cfm")>
			<CFFILE ACTION=Delete FILE="#systemPath#\category\#categoryID#CategorySpecial.cfm">
		</CFIF>
		Category <CFOUTPUT>#categoryName#</CFOUTPUT> deleted<BR>
	</CFLOOP>
	</H3>
</CFIF>

<P><HR NOSHADE COLOR=purple><P>
<CFSET noHeader = 1>
<CFINCLUDE TEMPLATE="categoryHome.cfm">