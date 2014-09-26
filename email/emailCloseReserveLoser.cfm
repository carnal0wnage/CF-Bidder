
<CFQUERY NAME=getLosingBids DATASOURCE="#EAdatasource#">
	SELECT Member.email, Bid.bidQuantity, Bid.bidPrice
	FROM Member INNER JOIN Bid ON Member.userID = Bid.userID
	WHERE Bid.lotID = #lotID# AND Bid.bidWin = 0
	<CFIF ListFind(forcedEmailEventsList,"loser") EQ 0>AND Member.userEmailEvents LIKE '%loser%'</CFIF>
</CFQUERY>

<CFIF getLosingBids.RecordCount NEQ 0>
	<CFMAIL QUERY="getLosingBids"
		TO="#getLosingBids.email#"
		FROM="#e_fromemailClose#"
		SUBJECT="Emaze Auction - Reserve Price Not Met"
		SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that no bid reached the reserve price for this lot. Therefore, no bidder has won the lot. This lot is now closed, so no further bidding is permitted. Below is the relevant information.

Lot: #getLotInfo.lotName#

Bid: #LSCurrencyFormat(getLosingBids.bidPrice,"local")#
Quantity: #getLosingBids.bidQuantity#

#systemURL#/lot.cfm?lotID=#lotID#

	</CFMAIL>
</CFIF>
