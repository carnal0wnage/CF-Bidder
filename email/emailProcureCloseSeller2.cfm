
<CFQUERY NAME=getAdminWinners DATASOURCE="#EAdatasource#">
	SELECT Bid.bidPrice, Bid.bidQuantity, Member.firstName, Member.lastName, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #lotID#
	ORDER BY Bid.bidPrice, Bid.bidQuantity
</CFQUERY>

<CFIF getAdminWinners.RecordCount NEQ 0>
	<CFMAIL	QUERY="getAdminWinners"
		TO="#getLotInfo.lotContactEmail#"
		FROM="#e_fromemailClose#"
		SUBJECT="Emaze Auction - Lot #lotID# has closed"
		SERVER="#emailServer#">
The bidding for the following lot has closed:

#getLotInfo.lotName#

#systemURL#/lot.cfm?lotID=#lotID#

You must now select the winning bidder(s). To do so, please log into your seller homepage at:

#systemURL#/seller/sellerIndex.cfm

Then just click on the link to choose the winning bidder(s). The bidders will automatically be emailed with their updated status afterwards. Bidders have already been notified that the item has closed and that you must now select the winning bidder(s).

Here are the bids:

<CFOUTPUT>Bid: #LSCurrencyFormat(getAdminWinners.bidPrice,"local")#, Quantity: #getAdminWinners.bidQuantity#
#getAdminWinners.lastName#, #getAdminWinners.firstName#
#getAdminWinners.email#

</CFOUTPUT>

	</CFMAIL>
</CFIF>
