<!--- Emaze Auction version 2.1, 1.01 / Wednesday, July 7, 1999 --->
<CFIF NOT IsDefined("IamTheScheduler")>
	<CFSET IamTheScheduler = 1>
	<CFINCLUDE TEMPLATE="closeCheck.cfm">
	<CFLOCATION URL="#systemURL#/program/scheduler.cfm?IamTheScheduler=1">
<CFELSE>
	<CFQUERY NAME=getLotClose MAXROWS=5 DATASOURCE="#EAdatasource#">
		SELECT lotID, lotType
		FROM Lot
		WHERE lotCloseQueue = 2
		ORDER BY lotCloseDateTime
	</CFQUERY>

	<CFINCLUDE TEMPLATE="../system/userList.cfm">
	<CFLOOP QUERY="getLotClose">
		<CFSET lotID = getLotClose.lotID>
		<CFIF getLotClose.lotType EQ 1>
			<CFINCLUDE TEMPLATE="closeLot.cfm">
		<CFELSEIF getLotClose.lotType EQ 0 AND FileExists("#systemPath#\program\closeMarket.cfm")>
			<CFINCLUDE TEMPLATE="closeMarket.cfm">
		<CFELSEIF getLotClose.lotType EQ -1 AND FileExists("#systemPath#\program\closeReverse.cfm")>
			<CFINCLUDE TEMPLATE="closeReverse.cfm">
		<CFELSE>
			<CFINCLUDE TEMPLATE="closeLot.cfm">
		</CFIF>
	</CFLOOP>

	<CFIF getLotClose.RecordCount EQ 5>
		<CFSET IamTheScheduler = IamTheScheduler + 1>
		<CFLOCATION URL="#systemURL#/program/scheduler.cfm?IamTheScheduler=#IamTheScheduler#">
	</CFIF>
</CFIF>