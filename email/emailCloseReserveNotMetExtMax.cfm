
<CFMAIL	TO="#getLotInfo.lotContactEmail#"
	FROM="#e_fromemailClose#"
	SUBJECT="Reserve price not met for lot #lotID#"
	SERVER="#emailServer#">
This is an automated email to notify you that the reserve price of #LSCurrencyFormat(getLotInfo.lotReservePrice,"local")# has not been met for lot #lotID#.

Lot: #getLotInfo.lotName#

The lot is now closed. The closing time of this lot would have been extended, but it has already been extended the maximum limit of #reserveStayOpenTimes# time(s).

#systemURL#/lot.cfm?lotID=#lotID#

</CFMAIL>
