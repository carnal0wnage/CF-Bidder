
<CFMAIL TO="#lotContactEmail#"
	FROM="#marketAdminEmail#"
	SUBJECT="Classified item #lotID# has been approved"
	SERVER="#emailServer#">
Name: #lotName#

Classified item #lotID# has been approved. Here is the URL to the item:

#systemURL#/lot.cfm?lotID=#lotID#

The itemis listed in the following category:
#categoryName#
#systemURL#/category.cfm?categoryID=#categoryID#

Below is the information on this item. This item will open at the opening time listed below. It will be available on the site in preview mode until that time.

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
