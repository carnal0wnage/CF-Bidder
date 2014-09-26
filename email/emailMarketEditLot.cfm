
<CFMAIL TO="#checkSeller.email#"
	FROM="#marketAdminEmail#"
	SUBJECT="Classified item #lotID# edited"
	SERVER="#emailServer#">
You just updated classified item #lotID#. To view this item:

#systemURL#/lot.cfm?lotID=#lotID#

Below is the updated information for this item.

Name: #getNewLot.lotName#

Category: #categoryName#

Selling Price: #LSCurrencyFormat(getNewLot.lotSellPrice,"local")#
Quantity: #getNewLot.lotQuantity#
<CFIF getNewLot.lotQuantityMaximum GT 0>Maximum Quantity: #getNewLot.lotQuantityMaximum#</CFIF>

Opens: #LSDateFormat(getNewLot.lotOpenDateTime,dateFormatDisplay)# #LSTimeFormat(getNewLot.lotOpenDateTime,timeFormatDisplay)# #timeFormatTimeZone#
Closes: #LSDateFormat(getNewLot.lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(getNewLot.lotCloseDateTime,timeFormatDisplay)# #timeFormatTimeZone#

<CFIF getNewLot.lotShipping GT 0>Shipping cost: #LSCurrencyFormat(getNewLot.lotShipping,"local")#</CFIF>

<CFIF getNewLot.lotImage NEQ " ">Image: #getNewLot.lotImage#</CFIF>
<CFIF getNewLot.lotImageThumbnail NEQ " ">Thumbnail: #getNewLot.lotImageThumbnail#</CFIF>

<CFIF getNewLot.lotLocation NEQ " ">Location: #getNewLot.lotLocation#</CFIF>
<CFIF getNewLot.lotShippingPolicy NEQ " ">Shipping Policy: #getNewLot.lotShippingPolicy#</CFIF>
<CFIF getNewLot.lotPaymentMethod NEQ " ">Payment Method: #getNewLot.lotPaymentMethod#</CFIF>

<CFIF getNewLot.lotSummary NEQ " ">Summary: 
#getNewLot.lotSummary#</CFIF>

</CFMAIL>
