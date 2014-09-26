
<CFMAIL	TO="#getLotInfo.lotContactEmail#"
	FROM="#e_fromemailClose#"
	SUBJECT="Emaze Auction - Lot #lotID# has closed, Reserve price not met"
	SERVER="#emailServer#">
The bidding for the following lot has closed, but the reserve price was not met.

#getLotInfo.lotName#

Highest Bid: #LSCurrencyFormat(getLotInfo.nextBidMinimum - getLotInfo.lotBidIncrement,"local")#
Reserve Price: #LSCurrencyFormat(getLotInfo.lotReservePrice,"local")#

#systemURL#/lot.cfm?lotID=#lotID#

</CFMAIL>
