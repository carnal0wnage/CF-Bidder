
<CFMAIL TO="#procureAdminEmail#"
	FROM="#procureAdminEmail#"
	SUBJECT="#emailAdminSubject#"
	SERVER="#emailServer#">
#emailAdminIntro#

--------------------
 SELLER INFORMATION
--------------------

Seller ID: #checkSeller.userID# (from Member table)
Name: #checkSeller.firstName# #checkSeller.lastName#
Email: #checkSeller.email#
Username: <CFIF IsDefined("Cookie.EmazeAuction_user") AND IsDefined("Form.useCookie")>#ListGetAt(Cookie.EmazeAuction_user,2)#<CFELSE>#Form.username#</CFIF>

-----------------
 LOT INFORMATION
-----------------

Lot ID: #lotID#
Name: #lotName#

<CFIF insertionFee NEQ 0>Insertion fee: #LSCurrencyFormat(insertionFee,"local")#</CFIF>
<CFIF boldFee NEQ 0> Add-on fee for a bold lot name: #LSCurrencyFormat(boldFee,"local")#</CFIF>
<CFIF featuredCategoryFee NEQ 0> Add-on fee for having your lot featured on category page: #LSCurrencyFormat(featuredCategoryFee,"local")#</CFIF>
<CFIF featuredHomepageFee NEQ 0> Add-on fee for having your lot featured on auction homepage: #LSCurrencyFormat(featuredHomepageFee,"local")#</CFIF>

Category: #categoryName#
Template: #templateName#

Quantity: #lotQuantity#
Maximum Quantity: #lotQuantityMaximum#
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
