
<CFQUERY NAME=getLosingBids DATASOURCE="#EAdatasource#">
	SELECT Bid.bidPrice, Bid.bidQuantity, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #lotID# AND Bid.bidWin = 0
	<CFIF ListFind(forcedEmailEventsList,"loser") EQ 0>AND Member.userEmailEvents LIKE '%loser%'</CFIF>
	<CFIF NOT IsDefined("emailAllLosers")>AND Bid.bidWin = 0</CFIF>
</CFQUERY>

<CFIF getLosingBids.RecordCount NEQ 0>
	<CFMAIL QUERY="getLosingBids"
		TO="#getLosingBids.email#"
		FROM="#e_fromemailClose#"
		SUBJECT="Emaze Auction - Not Win"
		SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that you were not a winner in the auction for the lot. Bidding for this lot has closed.

Lot: #getLotInfo.lotName#

Bid: #LSCurrencyFormat(getLosingBids.bidPrice,"local")#
Quantity: #getLosingBids.bidQuantity#

#systemURL#/lot.cfm?lotID=#lotID#

	</CFMAIL>
</CFIF>
