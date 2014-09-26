
<CFMAIL TO="#getBids.email#"
	FROM="#e_fromemailBid#"
	SUBJECT="Emaze Auction - Winning Bid Again"
	SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that you either have a winning bid again or the quantity of your winning bid has increased. (This was likely caused by a bidder who was not willing to accept a partial quantity.) You do not need to lower your bid at this time. You will be emailed again if your bid is no longer a winning bid.

Lot: #lotName#

Your bid: #LSCurrencyFormat(getBids.bidPriceMaximum,"local")#
Requested quantity: #getBids.bidQuantity#
Quantity won at current price:  #getBids.bidQuantityWin#

To lower your bid, go to:
#systemURL#/lot.cfm?lotID=#Form.lotID#

</CFMAIL>
