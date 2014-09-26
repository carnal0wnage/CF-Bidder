
<CFMAIL TO="#lotContactEmail#"
	FROM="#procureAdminEmail#"
	SUBJECT="Lot #lotID# has been approved"
	SERVER="#emailServer#">
Name: #lotName#

Lot #lotID# has been approved. Here is the URL to the lot:

#systemURL#/lot.cfm?lotID=#lotID#

The lot is listed in the following category:
#categoryName#
#systemURL#/category.cfm?categoryID=#categoryID#

Below is the information on this lot. This lot will open at the opening time listed below. It will be available on the site in preview mode until that time.

Quantity: #lotQuantity#
<CFIF lotQuantityMaximum GT 0>Maximum Quantity: #lotQuantityMaximum#</CFIF>
Opening Bid: #LSCurrencyFormat(lotOpeningBid,"local")#
Bid Increment: #LSCurrencyFormat(lotBidIncrement,"local")#

Opens: #LSDateFormat(lotOpenDateTime,dateFormatDisplay)# #LSTimeFormat(lotOpenDateTime,timeFormatDisplay)#
Closes: #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)#
<CFIF lotCloseBasis EQ "timeInactivity">Lot closes at later of closing time or #lotCloseInactivity# minutes after last bid.</CFIF>

<CFIF lotReservePrice GT lotOpeningBid>Reserve Price: #LSCurrencyFormat(lotReservePrice,"local")#</CFIF>
<CFIF lotSellPrice GT 0>Selling Price: #LSCurrencyFormat(lotSellPrice,"local")#</CFIF>
<CFIF lotShipping GT 0>Shipping cost: #LSCurrencyFormat(lotShipping,"local")#</CFIF>

<CFIF lotImage NEQ " ">Image: #lotImage#</CFIF>
<CFIF lotImageThumbnail NEQ " ">Thumbnail: #lotImageThumbnail#</CFIF>

<CFIF lotSummary NEQ " ">Summary: 
#lotSummary#</CFIF>

</CFMAIL>
