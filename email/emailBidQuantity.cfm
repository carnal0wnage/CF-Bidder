
<CFMAIL TO="#getBids.email#"
	FROM="#e_fromemailBid#"
	SUBJECT="Emaze Auction - Not Full Quantity"
	SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that while your bid is a winning bid, it is not sufficient to win the full quantity you requested. You will still win at least 1 unit though. If you would like to increase your bid, and thus your chances of winning the full quantity you requested, you may increase your bid at any time before the lot closes. Submitting a new bid will automatically update your original bid.

Lot: #lotName#

Your bid: #LSCurrencyFormat(getBids.bidPriceMaximum,"local")#
Your requested quantity: #getBids.bidQuantity#
Quantity you will win with this bid: #newBidQuantityWin#

To increase your bid, go to:
#systemURL#/lot.cfm?lotID=#Form.lotID#

</CFMAIL>
