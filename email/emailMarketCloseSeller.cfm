
<CFMAIL QUERY="getBuyers"
	TO="#marketCloseEmailTo#"
	FROM="#marketAdminEmail#"
	SUBJECT="Classified item #lotID# has closed"
	SERVER="#emailServer#">
This is an automated email to notify you that classified item #lotID# has closed.

#getLotInfo.lotName#

#systemURL#/lot.cfm?lotID=#lotID#

Below is a summary of the buyer(s):
<CFSET totalSale = 0><CFSET totalQuantity = 0>
<CFOUTPUT>
Username: #getBuyers.username#
Name: #getBuyers.firstName# #getBuyers.lastName#
Phone: #getBuyers.phone#
Email: #getBuyers.email#

Date/Time: #LSDateFormat(getBuyers.buyDateTime,dateFormatDisplay)# / #LSTimeFormat(getBuyers.buyDateTime,timeFormatDisplay)#
Price: #LSCurrencyFormat(getBuyers.buyPrice,"local")#
Quantity: #getBuyers.buyQuantity#
Total: #LSCurrencyFormat(getBuyers.buyPrice * getBuyers.buyQuantity,"local")#
<CFSET totalSale = totalSale + (getBuyers.buyPrice * getBuyers.buyQuantity)><CFSET totalQuantity = totalQuantity + getBuyers.buyQuantity>
</CFOUTPUT>

Total Quantity: #totalQuantity#
Total Sale: #LSCurrencyFormat(totalSale,"local")#

Please contact the buyer(s) to complete the purchase transactions.

<CFIF IsDefined("getSellerLots")><CFIF getSellerLots.RecordCount EQ 1>
The final fees for this classified item are:
<CFIF getSellerLots.insertionFee NEQ 0>Insertion Fee: #LSCurrencyFormat(getSellerLots.insertionFee,"local")#</CFIF>
<CFIF getSellerLots.boldFee NEQ 0>Bold Fee: #LSCurrencyFormat(getSellerLots.boldFee,"local")#</CFIF>
<CFIF getSellerLots.featuredCategoryFee NEQ 0>Category Featured Fee: #LSCurrencyFormat(getSellerLots.featuredCategoryFee,"local")#</CFIF>
<CFIF getSellerLots.featuredHomepageFee NEQ 0>Homepage Featured Fee: #LSCurrencyFormat(getSellerLots.featuredHomepageFee,"local")#</CFIF>
<CFIF commissionFee NEQ 0>Commission Fee: #LSCurrencyFormat(commissionFee,"local")#</CFIF>
Total Fees on this lot: #LSCurrencyFormat(getSellerLots.insertionFee + getSellerLots.boldFee + getSellerLots.featuredCategoryFee + getSellerLots.featuredHomepageFee + commissionFee,"local")#
</CFIF></CFIF>

</CFMAIL>
