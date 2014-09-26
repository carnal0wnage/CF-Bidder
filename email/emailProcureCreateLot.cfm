
<CFMAIL TO="#checkSeller.email#"
	FROM="#procureAdminEmail#"
	SUBJECT="Lot #lotID# created"
	SERVER="#emailServer#">
You just created lot #lotID#. To view this lot:

#systemURL#/lot.cfm?lotID=#lotID#

<CFIF lotStatus EQ "Open">The lot is active, so it will automatically open at the opening time you requested.
<CFELSE>Please note that the Administrator must approve your lot before it is public.<CFIF sellerLotEmailApprove EQ 1> You will automatically be emailed when your lot is approved.</CFIF></CFIF>

Below is the relevant information for this lot.

Name: #lotName#

<CFIF insertionFee NEQ 0>Insertion fee: #LSCurrencyFormat(insertionFee,"local")#</CFIF>
<CFIF boldFee NEQ 0> Add-on fee for a bold lot name: #LSCurrencyFormat(boldFee,"local")#</CFIF>
<CFIF featuredCategoryFee NEQ 0> Add-on fee for having your lot featured on category page: #LSCurrencyFormat(featuredCategoryFee,"local")#</CFIF>
<CFIF featuredHomepageFee NEQ 0> Add-on fee for having your lot featured on auction homepage: #LSCurrencyFormat(featuredHomepageFee,"local")#</CFIF>

Category: #categoryName#
Quantity: #lotQuantity#
<CFIF lotQuantityMaximum GT 0>Maximum Quantity: #lotQuantityMaximum#</CFIF>
Opening Bid: #LSCurrencyFormat(lotOpeningBid,"local")#
Bid Increment: #LSCurrencyFormat(lotBidIncrement,"local")#

Opens: #LSDateFormat(lotOpenDateTime,dateFormatDisplay)# #LSTimeFormat(lotOpenDateTime,timeFormatDisplay)# #timeFormatTimeZone#
Closes: #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)# #timeFormatTimeZone#
<CFIF lotCloseBasis EQ "timeInactivity">Lot closes at later of closing time or #lotCloseInactivity# minutes after last bid.</CFIF>

<CFIF lotReservePrice GT lotOpeningBid>Reserve Price: #LSCurrencyFormat(lotReservePrice,"local")#</CFIF>
<CFIF lotSellPrice GT 0>Selling Price: #LSCurrencyFormat(lotSellPrice,"local")#</CFIF>
<CFIF lotShipping GT 0>Shipping cost: #LSCurrencyFormat(lotShipping,"local")#</CFIF>

<CFIF lotImage NEQ " ">Image: #lotImage#</CFIF>
<CFIF lotImageThumbnail NEQ " ">Thumbnail: #lotImageThumbnail#</CFIF>

<CFIF lotLocation NEQ " ">Location: #lotLocation#</CFIF>
<CFIF lotShippingPolicy NEQ " ">Shipping Policy: #lotShippingPolicy#</CFIF>
<CFIF lotPaymentMethod NEQ " ">Payment Method: #lotPaymentMethod#</CFIF>

<CFIF lotSummary NEQ " ">Summary: 
#lotSummary#</CFIF>

</CFMAIL>
