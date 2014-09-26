
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
		SUBJECT="Emaze Auction - Lot #lotID# has closed"
		SERVER="#emailServer#">
The user who posted the following item has selected the winning bidder(s) for this item. You were not selected as a winning bidder.

Lot: #getLotInfo.lotName#

Bid: #LSCurrencyFormat(getLosingBids.bidPrice,"local")#
Quantity: #getLosingBids.bidQuantity#

#systemURL#/lot.cfm?lotID=#lotID#

	</CFMAIL>
</CFIF>
