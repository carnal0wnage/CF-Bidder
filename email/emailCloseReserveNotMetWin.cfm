
<CFQUERY NAME=getWinningBids DATASOURCE="#EAdatasource#">
	SELECT Bid.bidPrice, Bid.bidQuantity, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #lotID# AND Bid.bidWin = 1
	<CFIF ListFind(forcedEmailEventsList,"loser") EQ 0>AND Member.userEmailEvents LIKE '%loser%'</CFIF>
</CFQUERY>

<CFIF getWinningBids.RecordCount NEQ 0>
	<CFMAIL QUERY="getWinningBids"
		TO="#getWinningBids.email#"
		FROM="#e_fromemailClose#"
		SUBJECT="Emaze Auction - Reserve Price Not Met"
		SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that, although your bid was higher than other bidders, no bid reached the reserve price for this lot. Therefore, no bidder has won the lot. This lot is now closed, so no further bidding is permitted. Below is the relevant information.

Lot: #getLotInfo.lotName#

Bid: #LSCurrencyFormat(getWinningBids.bidPrice,"local")#
Quantity: #getWinningBids.bidQuantity#

#systemURL#/lot.cfm?lotID=#lotID#

	</CFMAIL>
</CFIF>
