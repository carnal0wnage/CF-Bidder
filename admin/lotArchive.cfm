<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("Form.okArchive")>
	<HTML><HEAD><TITLE>Emaze Auction: Archive Lot</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
	<FORM METHOD=post ACTION=lotArchive.cfm>
	<CFOUTPUT>
		<INPUT TYPE=hidden NAME=lotID VALUE=#lotID#>
		<INPUT TYPE=hidden NAME=categoryID VALUE=#categoryID#>
	</CFOUTPUT>
	<CFOUTPUT>You have chosen to archive lot #lotID#:</CFOUTPUT><BR>
	<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">
	<CFOUTPUT><I>#lotName#</I></CFOUTPUT><P>
	<FONT SIZE=4>Are you sure you want to archive this lot?</FONT><BR>
	If yes, click the button below. Otherwise, simply back up to the previous page.
	<P>
	<INPUT TYPE=submit NAME=okArchive VALUE="Archive Lot">
	</FORM>
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML>
	<CFABORT>
</CFIF>

<CFIF FileExists("#systemPath#\lot\#Form.lotID#LotInfo.cfm") EQ "YES">
	<CFFILE ACTION=Move SOURCE="#systemPath#\lot\#Form.lotID#LotInfo.cfm"
		DESTINATION="#systemPath#\archive\#Form.lotID#LotInfo.cfm">
</CFIF>
<CFIF FileExists("#systemPath#\lot\#Form.lotID#LotDescription.cfm") EQ "YES">
	<CFFILE ACTION=Move SOURCE="#systemPath#\lot\#Form.lotID#LotDescription.cfm"
		DESTINATION="#systemPath#\archive\#Form.lotID#LotDescription.cfm">
</CFIF>

<CFQUERY NAME=deleteLot DATASOURCE="#EAdatasource#">
	DELETE * FROM Lot WHERE lotID = #Form.lotID#
</CFQUERY>

<CFQUERY NAME=getBids DATASOURCE="#EAdatasource#">
	SELECT * FROM Bid WHERE lotID = #Form.lotID#
	ORDER BY bidID
</CFQUERY>
<CFFILE ACTION=Write FILE="#systemPath#\archive\#Form.lotID#LotBidding.cfm"
	OUTPUT="bidID,bidDateTime,bidEditDateTime,userID,bidPrice,bidQuantity,bidAuto,bidPriceMaximum,bidFullQuantityOnly,lotID,bidWin,bidPriceInitial,bidQuantityWin">
<CFLOOP QUERY=getBids>
	<CFFILE ACTION=Append FILE="#systemPath#\archive\#Form.lotID#LotBidding.cfm"
		OUTPUT="#bidID#,#bidDateTime#,#bidEditDateTime#,#userID#,#bidPrice#,#bidQuantity#,#bidAuto#,#bidPriceMaximum#,#bidFullQuantityOnly#,#Form.lotID#,#bidWin#,#bidPriceInitial#,#bidQuantityWin#">
</CFLOOP>
<CFQUERY NAME=deletePrivateUsers DATASOURCE="#EAdatasource#">
	DELETE * FROM Bid WHERE lotID = #Form.lotID#
</CFQUERY>

<CFINCLUDE TEMPLATE="../archive/#Form.lotID#LotInfo.cfm">
<CFIF lotPublic EQ 0>
	<CFQUERY NAME=getPrivateUsers DATASOURCE="#EAdatasource#">
		SELECT * FROM PrivateLotUser WHERE lotID = #Form.lotID#
	</CFQUERY>
	<CFFILE ACTION=Append FILE="#systemPath#\lot\#Form.lotID#LotPrivateUser.cfm"
		OUTPUT="<CFSET userID = ""#ValueList(getPrivateUsers.userID)#"">">
	<CFQUERY NAME=deletePrivateUsers DATASOURCE="#EAdatasource#">
		DELETE * FROM PrivateLotUser WHERE lotID = #Form.lotID#
	</CFQUERY>
</CFIF>

<H3>Lot <CFOUTPUT>#Form.lotID#</CFOUTPUT> archived.</H3>
<P><HR NOSHADE COLOR=purple><P>
<CFSET lotEdit = 1>
<CFSET order = "lotName">
<CFSET categoryID = Form.categoryID>
<CFINCLUDE TEMPLATE="categoryLots.cfm">