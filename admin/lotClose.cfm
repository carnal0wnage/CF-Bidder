<!--- Emaze Auction version 2.1, 1.02 / Monday, September 7, 1999 --->
<CFIF NOT IsDefined("IamTheAdmin")>
	<CFSET IamTheAdmin = 1>
	<CFINCLUDE TEMPLATE="../program/closeCheck.cfm">
	<CFLOCATION URL="#systemURL#/admin/lotClose.cfm?IamTheAdmin=1">
<CFELSE>
	<CFQUERY NAME=getLotClose MAXROWS=5 DATASOURCE="#EAdatasource#">
		SELECT lotID, lotType
		FROM Lot
		WHERE lotCloseQueue = 2
		ORDER BY lotCloseDateTime
	</CFQUERY>

	<CFIF getLotClose.RecordCount EQ 0 AND IamTheAdmin EQ 1>
		<CFIF IsDefined("Cookie.EmazeAuction_master")>
			<HTML>
			<HEAD><TITLE>Emaze Auction: Close Lots</TITLE></HEAD>
			<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
			<H2><FONT COLOR=purple>No lots need to be closed at this time.</FONT></H2>
			</BODY></HTML>
		</CFIF>
		<CFABORT>
	<CFELSEIF getLotClose.RecordCount NEQ 0>
		<CFINCLUDE TEMPLATE="../system/userList.cfm">
		<CFLOOP QUERY="getLotClose">
			<CFSET lotID = getLotClose.lotID>
			<CFIF getLotClose.lotType EQ 1>
				<CFINCLUDE TEMPLATE="../program/closeLot.cfm">
			<CFELSEIF getLotClose.lotType EQ 0 AND FileExists("#systemPath#\program\closeMarket.cfm")>
				<CFINCLUDE TEMPLATE="../program/closeMarket.cfm">
			<CFELSEIF lotType EQ -1 AND FileExists("#systemPath#\program\closeReverse.cfm")>
				<CFINCLUDE TEMPLATE="../program/closeReverse.cfm">
			<CFELSE>
				<CFINCLUDE TEMPLATE="../program/closeLot.cfm">
			</CFIF>
		</CFLOOP>
	</CFIF>

	<CFIF getLotClose.RecordCount EQ 5>
		<CFLOCATION URL="#systemURL#/admin/lotClose.cfm?IamTheAdmin=#IncrementValue(IamTheAdmin)#">
	<CFELSE>
		<CFIF IsDefined("Cookie.EmazeAuction_master")>
			<HTML>
			<HEAD><TITLE>Emaze Auction: Close Lots</TITLE></HEAD>
			<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
			<H2><FONT COLOR=purple>All lots waiting to be closed have been closed successfully!</FONT></H2>
			<H3>Here is a list of the lots that have been closed:</H3>
	
			<CFQUERY NAME=getClosedLots DATASOURCE="#EAdatasource#">
				SELECT lotID, lotName
				FROM Lot
				WHERE lotCloseQueue = 4 OR lotCloseQueue = 5
				ORDER BY lotName
			</CFQUERY>
			<CFOUTPUT QUERY=getClosedLots>
				<A HREF="#systemURL#/lot.cfm?lotID=#getClosedLots.lotID#">#getClosedLots.lotID#</A>. #getClosedLots.lotName#<BR>
			</CFOUTPUT>
			</BODY></HTML>
		</CFIF>
		<CFQUERY NAME=updateClosedLots DATASOURCE="#EAdatasource#">
			UPDATE Lot
			SET lotCloseQueue = 3
			WHERE lotCloseQueue = 4
		</CFQUERY>
		<CFABORT>
	</CFIF>
</CFIF>
