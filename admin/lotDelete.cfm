<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("Form.okDelete")>
	<HTML><HEAD><TITLE>Emaze Auction: Delete Lot</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
	<FORM METHOD=post ACTION=lotDelete.cfm>
	<CFOUTPUT>
		<INPUT TYPE=hidden NAME=lotID VALUE=#lotID#>
		<INPUT TYPE=hidden NAME=categoryID VALUE=#categoryID#>
	</CFOUTPUT>
	<CFOUTPUT>You have chosen to delete lot #lotID#:</CFOUTPUT><BR>
	<CFIF FileExists("#systemPath#\lot\#lotID#LotInfo.cfm") EQ "YES">
		<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">
		<CFOUTPUT><I>#lotName#</I></CFOUTPUT><P>
	</CFIF>
	<FONT SIZE=4>Are you sure you want to delete this lot?</FONT><BR>
	If yes, click the button below. Otherwise, simply back up to the previous page.
	<P>
	<INPUT TYPE=submit NAME=okDelete VALUE="Delete Lot">
	</FORM>
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML>
	<CFABORT>
</CFIF>

<CFIF FileExists("#systemPath#\lot\#Form.lotID#LotInfo.cfm") EQ "YES">
	<CFINCLUDE TEMPLATE="../lot/#Form.lotID#LotInfo.cfm">
	<CFSET systemURLlength = Len("#systemURL#/lotImage/")>
	<CFIF lotImage NEQ " ">
		<CFSET lotImageFile = Mid("#lotImage#",systemURLlength,50)>
		<CFIF FileExists("#systemPath#\lotimage\#lotImageFile#") EQ "YES">
			<CFQUERY NAME=checkImage DATASOURCE="#EAdatasource#">
				SELECT Count(lotID) AS checkCount
				FROM Lot
				WHERE lotImage = '#lotImage#'
					OR lotImageThumbnail = '#lotImage#'
			</CFQUERY>
			<CFIF checkImage.checkCount EQ 1 AND FileExists("#systemPath#\lotimage\#lotImageFile#") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\lotimage\#lotImageFile#">
				<CFSET deletedImage = 1>
			</CFIF>
		</CFIF>
	</CFIF>
	<CFIF lotImageThumbnail NEQ " ">
		<CFSET lotImageFileThumbnail = Mid("#lotImage#",systemURLlength,50)>
		<CFIF FileExists("#systemPath#\lotimage\#lotImageFileThumbnail#") EQ "YES">
			<CFQUERY NAME=checkImage DATASOURCE="#EAdatasource#">
				SELECT Count(lotID) AS checkCount
				FROM Lot
				WHERE lotImage = '#lotImageThumbnail#'
					OR lotImageThumbnail = '#lotImageThumbnail#'
			</CFQUERY>
			<CFIF checkImage.checkCount EQ 1 AND FileExists("#systemPath#\lotimage\#lotImageFileThumbnail#") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\lotimage\#lotImageFileThumbnail#">
				<CFSET deletedThumbnail = 1>
			</CFIF>
		</CFIF>
	</CFIF>
</CFIF>

<CFIF FileExists("#systemPath#\lot\#Form.lotID#LotInfo.cfm") EQ "YES">
	<CFFILE ACTION=Delete FILE="#systemPath#\lot\#Form.lotID#LotInfo.cfm">
</CFIF>
<CFIF FileExists("#systemPath#\lot\#Form.lotID#LotDescription.cfm") EQ "YES">
	<CFFILE ACTION=Delete FILE="#systemPath#\lot\#Form.lotID#LotDescription.cfm">
</CFIF>

<CFQUERY NAME=deleteLot DATASOURCE="#EAdatasource#">
	DELETE FROM Lot WHERE lotID = #Form.lotID#
</CFQUERY>
<CFQUERY NAME=deleteBid DATASOURCE="#EAdatasource#">
	DELETE FROM Bid WHERE lotID = #Form.lotID#
</CFQUERY>
<CFQUERY NAME=deleteBid DATASOURCE="#EAdatasource#">
	DELETE FROM LotWatch WHERE lotID = #Form.lotID#
</CFQUERY>
<CFQUERY NAME=deletePrivateBids DATASOURCE="#EAdatasource#">
	DELETE FROM PrivateLotUser WHERE lotID = #Form.lotID#
</CFQUERY>

<CFIF lotStatus EQ "Open">
	<CFQUERY NAME=updateCatCount DATASOURCE="#EAdatasource#">
		UPDATE Category
		SET categoryLotCount = categoryLotCount - 1
		WHERE categoryID = #Form.categoryID#
	</CFQUERY>
	<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
		SELECT categoryID1, categoryID2, categoryID3, categoryID4
		FROM Category
		WHERE categoryID = #Form.categoryID#
	</CFQUERY>
	<CFQUERY NAME=decrCatSubCount DATASOURCE="#EAdatasource#">
		UPDATE Category
		SET categorySubLotCount = categorySubLotCount - 1
		WHERE categoryID = #getCatID.categoryID1#
			OR categoryID = #getCatID.categoryID2#
			OR categoryID = #getCatID.categoryID3#
			OR categoryID = #getCatID.categoryID4#
	</CFQUERY>
</CFIF>

<H3>Lot <CFOUTPUT>#Form.lotID#</CFOUTPUT> deleted.</H3>
<CFIF IsDefined("deletedImage")>
	<CFOUTPUT>Image <I>#lotImageFile#</I> deleted from lotimage directory since it was not being used by any other lots.<BR></CFOUTPUT>
</CFIF>
<CFIF IsDefined("deletedThumbnail")>
	<CFOUTPUT>Image <I>#lotImageFileThumbnail#</I> deleted from lotimage directory since it was not being used by any other lots.</CFOUTPUT>
</CFIF>

<P><HR NOSHADE COLOR=purple><P>
<CFSET lotEdit = 1>
<CFSET order = "lotName">
<CFSET categoryID = Form.categoryID>
<CFINCLUDE TEMPLATE="categoryLots.cfm">