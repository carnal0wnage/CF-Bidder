
<CFMAIL TO="#checkSeller.email#"
	FROM="#sellerAdminEmail#"
	SUBJECT="Lot #lotID# edited"
	SERVER="#emailServer#">
You just updated lot #lotID#. To view this lot:

#systemURL#/lot.cfm?lotID=#lotID#

Below is the updated information for this lot.

Name: #getNewLot.lotName#

Category: #categoryName#

Quantity: #getNewLot.lotQuantity#
<CFIF getNewLot.lotQuantityMaximum GT 0>Maximum Quantity: #getNewLot.lotQuantityMaximum#</CFIF>
Opening Bid: #LSCurrencyFormat(getNewLot.lotOpeningBid,"local")#
Bid Increment: #LSCurrencyFormat(getNewLot.lotBidIncrement,"local")#

Opens: #LSDateFormat(getNewLot.lotOpenDateTime,dateFormatDisplay)# #LSTimeFormat(getNewLot.lotOpenDateTime,timeFormatDisplay)# #timeFormatTimeZone#
Closes: #LSDateFormat(getNewLot.lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(getNewLot.lotCloseDateTime,timeFormatDisplay)# #timeFormatTimeZone#
<CFIF getNewLot.lotCloseBasis EQ "timeInactivity">Lot closes at later of closing time or #getNewLot.lotCloseInactivity# minutes after last bid.</CFIF>

<CFIF getNewLot.lotReservePrice GT getNewLot.lotOpeningBid>Reserve Price: #LSCurrencyFormat(getNewLot.lotReservePrice,"local")#</CFIF>
<CFIF getNewLot.lotSellPrice GT 0>Selling Price: #LSCurrencyFormat(getNewLot.lotSellPrice,"local")#</CFIF>
<CFIF getNewLot.lotShipping GT 0>Shipping cost: #LSCurrencyFormat(getNewLot.lotShipping,"local")#</CFIF>

<CFIF getNewLot.lotImage NEQ " ">Image: #getNewLot.lotImage#</CFIF>
<CFIF getNewLot.lotImageThumbnail NEQ " ">Thumbnail: #getNewLot.lotImageThumbnail#</CFIF>

<CFIF getNewLot.lotLocation NEQ " ">Location: #getNewLot.lotLocation#</CFIF>
<CFIF getNewLot.lotShippingPolicy NEQ " ">Shipping Policy: #getNewLot.lotShippingPolicy#</CFIF>
<CFIF getNewLot.lotPaymentMethod NEQ " ">Payment Method: #getNewLot.lotPaymentMethod#</CFIF>

<CFIF getNewLot.lotSummary NEQ " ">Summary: 
#getNewLot.lotSummary#</CFIF>

<CFIF getNewLot.lotDescription NEQ " ">Description:
#getNewLot.lotDescription#</CFIF>

</CFMAIL>
