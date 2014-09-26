
<CFMAIL TO="#getLotInfo.lotContactEmail#"
	FROM="#e_fromemailClose#"
	SUBJECT="No bids for lot #lotID#"
	SERVER="#emailServer#">
This is an automated email to notify you that there were no bids for lot #lotID#.

Lot: #getLotInfo.lotName#

The lot is now closed. The closing time of this lot would have been extended, but it has already been extended the maximum limit of #noBidsStayOpenTimes# time(s).

#systemURL#/lot.cfm?lotID=#lotID#

</CFMAIL>
