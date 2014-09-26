
<CFMAIL TO="#lotContactEmail#"
	FROM="#sellerAdminEmail#"
	SUBJECT="Lot #lotID# has been rejected"
	SERVER="#emailServer#">
Name: #lotName#

Lot #lotID# has been rejected. It will not be open to bidding. Below is the information on this lot:

Category: #categoryName#
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
