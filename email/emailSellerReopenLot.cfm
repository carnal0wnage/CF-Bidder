
<CFMAIL TO="#checkSeller.email#"
	FROM="#sellerAdminEmail#"
	SUBJECT="Lot #lotID# re-opened"
	SERVER="#emailServer#">
You just re-opened lot #lotID#. To view this lot:#systemURL#/lot.cfm?lotID=#lotID#Below are the new opening and closing times for this lot: Opens: #LSDateFormat(lotOpenDateTime,dateFormatDisplay)# #LSTimeFormat(lotOpenDateTime,timeFormatDisplay)#Closes: #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)#

</CFMAIL>
