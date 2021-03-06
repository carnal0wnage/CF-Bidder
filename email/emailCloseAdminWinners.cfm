
<CFQUERY NAME=getAdminWinners DATASOURCE="#EAdatasource#">
	SELECT Bid.bidPrice, Bid.bidQuantityWin, Member.firstName, Member.lastName, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #lotID# AND Bid.bidWin = 1
	ORDER BY Bid.bidPrice, Bid.bidQuantityWin
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

Here are the winning bids:

<CFOUTPUT>Bid: #LSCurrencyFormat(getAdminWinners.bidPrice,"local")#, Quantity: #getAdminWinners.bidQuantityWin#
#getAdminWinners.lastName#, #getAdminWinners.firstName#
#getAdminWinners.email#

</CFOUTPUT>

<CFIF IsDefined("getSellerLots")><CFIF getSellerLots.RecordCount EQ 1>
The final fees for this lot are:
<CFIF getSellerLots.insertionFee NEQ 0>Insertion Fee: #LSCurrencyFormat(getSellerLots.insertionFee,"local")#</CFIF>
<CFIF getSellerLots.boldFee NEQ 0>Bold Fee: #LSCurrencyFormat(getSellerLots.boldFee,"local")#</CFIF>
<CFIF getSellerLots.featuredCategoryFee NEQ 0>Category Featured Fee: #LSCurrencyFormat(getSellerLots.featuredCategoryFee,"local")#</CFIF>
<CFIF getSellerLots.featuredHomepageFee NEQ 0>Homepage Featured Fee: #LSCurrencyFormat(getSellerLots.featuredHomepageFee,"local")#</CFIF>
<CFIF commissionFee NEQ 0>Commission Fee: #LSCurrencyFormat(commissionFee,"local")#</CFIF>
Total Fees on this lot: #LSCurrencyFormat(getSellerLots.insertionFee + getSellerLots.boldFee + getSellerLots.featuredCategoryFee + getSellerLots.featuredHomepageFee + commissionFee,"local")#
</CFIF></CFIF>

	</CFMAIL>
</CFIF>
