
<CFMAIL TO="#getCheckList.lotContactEmail#"
	FROM="#e_fromemailClose#"
	SUBJECT="No bids for lot #getCheckList.lotID# - Closing time extended"
	SERVER="#emailServer#">
This is an automated email to notify you that there were no bids for lot #getCheckList.lotID#.

Lot: #getCheckList.lotName#

The closing time of this lot has been extended:

FROM: #LSDateFormat(getCheckList.lotCloseDateTime,dateFormatDisplay)# / #LSTimeFormat(getCheckList.lotCloseDateTime,timeFormatDisplay)#
  TO: #LSDateFormat(newLotCloseDateTime,dateFormatDisplay)# / #LSTimeFormat(newLotCloseDateTime,timeFormatDisplay)#

It has now been extended #Evaluate(getCheckList.lotNoBidsStayOpenTimes + 1)# time(s). It may be extended a total of #noBidsStayOpenTimes# time(s).

#systemURL#/lot.cfm?lotID=#getCheckList.lotID#

</CFMAIL>
