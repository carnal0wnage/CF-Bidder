<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
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

<CFINCLUDE TEMPLATE="../system/bidResultHeader.cfm">

<CFIF getStatus.RecordCount EQ 1>
	<CFIF getStatus.bidWin EQ 0>
		<CFINCLUDE TEMPLATE="../system/bidResultLoser.cfm">
	<CFELSEIF lotReservePrice NEQ 0 AND getStatus.bidPriceMaximum LT lotReservePrice>
		<CFINCLUDE TEMPLATE="../system/bidResultReserve.cfm">
	<CFELSE>
		<CFINCLUDE TEMPLATE="../system/bidResultWinner.cfm">
	</CFIF>	
<CFELSE>
	<CFINCLUDE TEMPLATE="../system/bidResultLoser.cfm">
</CFIF>

<CFINCLUDE TEMPLATE="../system/bidResultFooter.cfm">
<P>
<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">

</body>
</html>
