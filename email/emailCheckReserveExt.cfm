
<CFINCLUDE TEMPLATE="../system/emailClose.cfm">
<CFIF e_fromnameClose NEQ "" AND e_fromnameClose NEQ " ">
	<CFSET e_fromemailClose = "#e_fromemailClose# (#e_fromnameClose#)">
</CFIF>

<CFMAIL TO="#getCheckList.lotContactEmail#"
	FROM="#e_fromemailClose#"
	SUBJECT="Reserve price not met for lot #getCheckList.lotID# - Closing time extended"
	SERVER="#emailServer#">
This is an automated email to notify you that the reserve price of #LSCurrencyFormat(getCheckList.lotReservePrice,"local")# has not been met for lot #getCheckList.lotID#.

The closing time of this lot has been extended:

FROM: #LSDateFormat(getCheckList.lotCloseDateTime,dateFormatDisplay)# / #LSTimeFormat(getCheckList.lotCloseDateTime,timeFormatDisplay)#
  TO: #LSDateFormat(newLotCloseDateTime,dateFormatDisplay)# / #LSTimeFormat(newLotCloseDateTime,timeFormatDisplay)#

It has now been extended #Evaluate("#getCheckList.lotReserveStayOpenTimes# + 1")# time(s). It may be extended a total of #reserveStayOpenTimes# time(s).

#systemURL#/lot.cfm?lotID=#getCheckList.lotID#

</CFMAIL>
