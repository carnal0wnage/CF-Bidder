
<CFMAIL TO="#lotContactEmail#"
	FROM="#marketAdminEmail#"
	SUBJECT="Classified item #lotID# has been rejected"
	SERVER="#emailServer#">
Name: #lotName#

Classified item #lotID# has been rejected. It will not be open to buyers. Below is the information on this lot:

Category: #categoryName#

Selling Price: #LSCurrencyFormat(lotSellPrice,"local")#
Quantity: #lotQuantity#
<CFIF lotQuantityMaximum GT 0>Maximum Quantity: #lotQuantityMaximum#</CFIF>

Opens: #LSDateFormat(lotOpenDateTime,dateFormatDisplay)# #LSTimeFormat(lotOpenDateTime,timeFormatDisplay)#
Closes: #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)#

<CFIF lotShipping GT 0>Shipping cost: #LSCurrencyFormat(lotShipping,"local")#</CFIF>

<CFIF lotImage NEQ " ">Image: #lotImage#</CFIF>
<CFIF lotImageThumbnail NEQ " ">Thumbnail: #lotImageThumbnail#</CFIF>

<CFIF lotSummary NEQ " ">Summary: 
#lotSummary#</CFIF>

</CFMAIL>
