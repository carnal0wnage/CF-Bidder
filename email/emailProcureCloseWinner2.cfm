
<CFQUERY NAME=getWinningBids DATASOURCE="#EAdatasource#">
	SELECT Bid.bidPrice, Bid.bidQuantity, Member.email
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
This automated email was sent by Emaze Auction to notify you that you submitted a low bid for this item. However, the winning bidder is going to be chosen manually.

The user who posted the item has been notified that the item has closed and that the winning bidder(s) must now be chosen. As soon as the decision is made, you will receive an updated email.

Lot: #getLotInfo.lotName#

Bid: #LSCurrencyFormat(getWinningBids.bidPrice,"local")#
Quantity: #getWinningBids.bidQuantity#

#systemURL#/lot.cfm?lotID=#lotID#

	</CFMAIL>
</CFIF>
