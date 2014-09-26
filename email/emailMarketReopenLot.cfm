
<CFMAIL TO="#checkSeller.email#"
	FROM="#marketAdminEmail#"
	SUBJECT="Classified item #lotID# re-opened"
	SERVER="#emailServer#">
You just re-opened classified item #lotID#. To view this item:

#systemURL#/lot.cfm?lotID=#lotID#

Below are the new opening and closing times for this item:

 Opens: #LSDateFormat(lotOpenDateTime,dateFormatDisplay)# #LSTimeFormat(lotOpenDateTime,timeFormatDisplay)#
Closes: #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)#

</CFMAIL>
