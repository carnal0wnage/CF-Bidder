
<CFMAIL TO="#getLotInfo.lotContactEmail#"
	FROM="#e_fromemailClose#"
	SUBJECT="Emaze Auction - Lot #lotID# has closed"
	SERVER="#emailServer#">
The bidding for the following lot has closed:

#getLotInfo.lotName#

#systemURL#/lot.cfm?lotID=#lotID#

</CFMAIL>
