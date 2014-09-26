
<CFMAIL TO="#getBids.email#"
	FROM="#e_fromemailBid#"
	SUBJECT="Emaze Auction - Losing Bid"
	SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that you do not currently have a winning bid on the lot. You may lower your bid at any time before the lot closes. Submitting a new bid will automatically update your original bid.

Lot: #lotName#

<CFIF getBids.bidAuto EQ 1>Your minimum bid: <CFELSE>Your bid: </CFIF>#LSCurrencyFormat(getBids.bidPriceMaximum,"local")#
Your requested quantity: #getBids.bidQuantity#

To lower your bid, go to:
#systemURL#/lot.cfm?lotID=#Form.lotID#

</CFMAIL>
