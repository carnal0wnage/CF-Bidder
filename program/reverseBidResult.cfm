<!--- Emaze Auction version 2.1, 1.01 / Wednesday, August 18, 1999 --->
<CFSET title = "titleBidResult">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<!--- 
1. If first bid, they have winning bid
2. Check reserve price
3. If other bids, display whether have winning bid
4. If autobid option, display current bid if not the initial bid
5. If autobid only, display initial bid
6. If not winning bid, display current winning bid to beat
7. If multiple items, display quantity they won
8. If multiple items, 
--->

<CFQUERY NAME=getStatus DATASOURCE="#EAdatasource#">
	SELECT bidPrice, bidPriceMaximum, bidWin, bidQuantity, bidQuantityWin, bidAuto
	FROM Bid
	WHERE lotID = #Form.lotID# AND userID = #bidderUserID#
</CFQUERY>

<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
	<CFINCLUDE TEMPLATE="../systemProcure/procureBidResultHeader.cfm">
<CFELSE>
	<CFINCLUDE TEMPLATE="../system/bidResultHeader.cfm">
</CFIF>

<CFIF getStatus.RecordCount EQ 1>
	<CFIF getStatus.bidWin EQ 0>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
			<CFINCLUDE TEMPLATE="../systemProcure/procureBidResultLoser.cfm">
		<CFELSE>
			<CFINCLUDE TEMPLATE="../system/bidResultLoser.cfm">
		</CFIF>
	<CFELSEIF lotReservePrice NEQ 0 AND getStatus.bidPriceMaximum LT lotReservePrice>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
			<CFINCLUDE TEMPLATE="../systemProcure/procureBidResultReserve.cfm">
		<CFELSE>
			<CFINCLUDE TEMPLATE="../system/bidResultReserve.cfm">
		</CFIF>
	<CFELSEIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<CFINCLUDE TEMPLATE="../systemProcure/procureBidResultWinner.cfm">
	<CFELSE>
		<CFINCLUDE TEMPLATE="../system/bidResultWinner.cfm">
	</CFIF>	
<CFELSEIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
	<CFINCLUDE TEMPLATE="../systemProcure/procureBidResultLoser.cfm">
<CFELSE>
	<CFINCLUDE TEMPLATE="../system/bidResultLoser.cfm">
</CFIF>

<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
	<CFINCLUDE TEMPLATE="../systemProcure/procureBidResultFooter.cfm">
<CFELSE>
	<CFINCLUDE TEMPLATE="../system/bidResultFooter.cfm">
</CFIF>
<P>
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
<CFINCLUDE TEMPLATE="copyright.cfm">
<P>
</body>
</html>
