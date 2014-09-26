
<CFMAIL TO="#getBids.email#"
	FROM="#e_fromemailBid#"
	SUBJECT="Emaze Auction - Auto Bid"
	SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that your bid has automatically been lowered using the auto-bid feature. There is no need to respond to this message or return to the site. Below is the relevant information.

Please note that the low bid does not automatically win on this item. The winning bidder(s) will be chosen after the item has closed.

Lot: #lotName#

Current bid: #LSCurrencyFormat(newBidPrice,"local")#
Previous bid: #LSCurrencyFormat(getWinningBids.bidPrice,"local")#
Minimum bid: #LSCurrencyFormat(getWinningBids.bidPriceMaximum,"local")#
Initial bid: #LSCurrencyFormat(getWinningBids.bidPriceInitial,"local")#

Requested quantity: #getWinningBids.bidQuantity#
Quantity won at current price:  #getWinningBids.bidQuantityWin#

#systemURL#/lot.cfm?lotID=#Form.lotID#

</CFMAIL>
