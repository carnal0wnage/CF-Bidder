
<CFQUERY NAME=getWinningBids DATASOURCE="#EAdatasource#">
	SELECT Bid.bidPrice, Bid.bidQuantityWin, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #lotID# AND Bid.bidWin = 1
	<CFIF ListFind(forcedEmailEventsList,"winner") EQ 0>AND Member.userEmailEvents LIKE '%winner%'</CFIF>
</CFQUERY>

<CFIF getWinningBids.RecordCount NEQ 0>
	<CFMAIL QUERY="getWinningBids"
		TO="#getWinningBids.email#"
		FROM="#e_fromemailClose#"
		SUBJECT="Emaze Auction - Lot #lotID# has closed"
		SERVER="#emailServer#">
The user who posted the following item has selected the winning bidder(s) for this item. You were selected as a winning bidder!

Lot: #getLotInfo.lotName#

Bid: #LSCurrencyFormat(getWinningBids.bidPrice,"local")#
Quantity: #getWinningBids.bidQuantityWin#

Total: #LSCurrencyFormat(getWinningBids.bidPrice * getWinningBids.bidQuantityWin,"local")#

#systemURL#/lot.cfm?lotID=#lotID#

	</CFMAIL>
</CFIF>
