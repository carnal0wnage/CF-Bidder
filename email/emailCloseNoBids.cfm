
<CFMAIL TO="#getLotInfo.lotContactEmail#"
	FROM="#e_fromemailClose#"
	SUBJECT="Emaze Auction - Lot #lotID# has closed with no bids"
	SERVER="#emailServer#">
The bidding for the following lot has closed without any bids:

#getLotInfo.lotName#

#systemURL#/lot.cfm?lotID=#lotID#

</CFMAIL>
