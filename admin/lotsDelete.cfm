<!--- Emaze Auction version 2.1, 1.01 / Tuesday, June 15, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML><HEAD><TITLE>Emaze Auction: Delete Lot</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
<FONT SIZE=6 COLOR=purple><B>Delete Lots</B></FONT>
<P>

<CFIF NOT IsDefined("Form.okDelete")>
	<FONT SIZE=4>The checkbox verifying your request to delete these lots was not checked.
	<P>
	To delete the requested lots, you must back up, check the checkbox below the <I>Delete Lots</I> button, and then click the button.
	</FONT>
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML>
	<CFABORT>
<CFELSEIF IsDefined("Form.closeDays")>
	<CFIF Form.okDelete NEQ "YES">
		<FONT SIZE=4>You must enter <I>YES</I> in the text field to verify your request.</FONT>
		</BODY></HTML><CFABORT>
	<CFELSEIF Form.closeDays EQ "" OR NOT IsNumeric("#Form.closeDays#")>
		<FONT SIZE=4>You must enter the number of days after the lot has closed.</FONT>
		</BODY></HTML><CFABORT>
	</CFIF>

	<CFSET finalLotCloseDateTime = CreateODBCDateTime(DateAdd("d",-1 * Form.closeDays,Now()))>
	<CFQUERY NAME=getLots DATASOURCE="#EAdatasource#">
		SELECT lotID
		FROM Lot
		WHERE lotCloseQueue = 3
			AND lotCloseDateTime <= #finalLotCloseDateTime#
	</CFQUERY>
	<CFIF getLots.RecordCount EQ 0>
		<FONT SIZE=4>No lots have been closed for more than <CFOUTPUT>#Form.closeDays#</CFOUTPUT> days.</FONT>
		</BODY></HTML><CFABORT>
	</CFIF>
	<CFSET deleteLotIDs = ValueList(getLots.lotID)>

<CFELSEIF NOT IsDefined("Form.deleteLotIDs")>
	<FONT SIZE=4>You did not check any lots to delete. No lots were deleted.
	<P>
	To return to the list of lots in this category, <CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#Form.categoryID#&order=lotName">click here</A></CFOUTPUT>.
	</FONT>
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML>
	<CFABORT>
</CFIF>

<CFSET systemURLlength = Len("#systemURL#/lotImage/")>
<CFLOOP INDEX=lotID LIST="#deleteLotIDs#">
	<CFIF FileExists("#systemPath#\lot\#lotID#LotInfo.cfm") EQ "YES">
		<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">
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

	<CFIF FileExists("#systemPath#\lot\#lotID#LotInfo.cfm") EQ "YES">
		<CFFILE ACTION=Delete FILE="#systemPath#\lot\#lotID#LotInfo.cfm">
	</CFIF>
	<CFIF FileExists("#systemPath#\lot\#lotID#LotDescription.cfm") EQ "YES">
		<CFFILE ACTION=Delete FILE="#systemPath#\lot\#lotID#LotDescription.cfm">
	</CFIF>

	Lot <CFOUTPUT>#lotID#</CFOUTPUT> deleted.<BR>
	<CFIF IsDefined("deletedImage")>
		<CFOUTPUT>&nbsp; &nbsp; Image <I>#lotImageFile#</I> deleted from lotimage directory since it was not being used by any other lots.<BR></CFOUTPUT>
	</CFIF>
	<CFIF IsDefined("deletedThumbnail")>
		<CFOUTPUT>&nbsp; &nbsp; Image <I>#lotImageFileThumbnail#</I> deleted from lotimage directory since it was not being used by any other lots.</CFOUTPUT>
	</CFIF>
</CFLOOP>

<CFQUERY NAME=deleteBid DATASOURCE="#EAdatasource#">
	DELETE FROM Bid
	WHERE lotID IN (#deleteLotIDs#)
</CFQUERY>
<CFQUERY NAME=deleteBid DATASOURCE="#EAdatasource#">
	DELETE FROM LotWatch
	WHERE lotID IN (#deleteLotIDs#)
</CFQUERY>
<CFQUERY NAME=deletePrivateBids DATASOURCE="#EAdatasource#">
	DELETE FROM PrivateLotUser
	WHERE lotID IN (#deleteLotIDs#)
</CFQUERY>

<CFQUERY NAME=deleteLotCount DATASOURCE="#EAdatasource#">
	SELECT lotID
	FROM Lot
	WHERE lotCloseQueue = 1 AND lotID IN (#deleteLotIDs#)
</CFQUERY>
<CFQUERY NAME=deleteLot DATASOURCE="#EAdatasource#">
	DELETE FROM Lot
	WHERE lotID IN (#deleteLotIDs#)
</CFQUERY>

<CFINCLUDE TEMPLATE="categoryCount.cfm">

<!--- 
<CFQUERY NAME=updateCatCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categoryLotCount = categoryLotCount - #deleteLotCount.RecordCount#
	WHERE categoryID = #Form.categoryID#
</CFQUERY>
<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
	SELECT categoryID1, categoryID2, categoryID3, categoryID4
	FROM Category
	WHERE categoryID = #Form.categoryID#
</CFQUERY>
<CFQUERY NAME=incrCatSubCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categorySubLotCount = categorySubLotCount - #deleteLotCount.RecordCount#
	WHERE categoryID = #getCatID.categoryID1#
		OR categoryID = #getCatID.categoryID2#
		OR categoryID = #getCatID.categoryID3#
		OR categoryID = #getCatID.categoryID4#
</CFQUERY>
--->

<FONT SIZE=5 COLOR=purple>Lots successfully deleted.<BR>Category lot counts have been updated.</FONT>
<P>
<CFIF IsDefined("Form.categoryID")>
	To return to the list of lots in this category, <CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#Form.categoryID#&order=lotName">click here</A></CFOUTPUT>.
</CFIF>
<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY></HTML>