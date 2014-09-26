
<CFMAIL TO="#getBids.email#"
	FROM="#e_fromemailBid#"
	SUBJECT="Emaze Auction - Not Full Quantity"
	SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that while your bid is a winning bid, it is not sufficient to win the full quantity you requested. You will still win at least 1 unit though. If you would like to lower your bid, and thus your chances of winning the full quantity you requested, you may lower your bid at any time before the lot closes. Submitting a new bid will automatically update your original bid.

Please note that the low bid does not automatically win on this item. The winning bidder(s) will be chosen after the item has closed.

Lot: #lotName#

Current bid: #LSCurrencyFormat(getWinningBids.bidPrice,"local")#
Minimum bid: #LSCurrencyFormat(getWinningBids.bidPriceMaximum,"local")#
Initial bid: #LSCurrencyFormat(getWinningBids.bidPriceInitial,"local")#

Requested quantity: #getWinningBids.bidQuantity#
Quantity won at current price:  #getWinningBids.bidQuantityWin#

#systemURL#/lot.cfm?lotID=#Form.lotID#

</CFMAIL>
