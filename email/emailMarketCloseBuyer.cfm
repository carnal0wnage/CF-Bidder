
<CFMAIL QUERY="getBuyers"
	TO="#getBuyers.email#"
	FROM="#marketAdminEmail#"
	SUBJECT="Classified item #lotID# has closed"
	SERVER="#emailServer#">
This is an automated email to notify you that classified item #lotID#, which you purchased earlier, has closed.

#getLotInfo.lotName#

Price: #LSCurrencyFormat(getLotInfo.lotSellPrice,"local")#
Quantity: #getBuyers.buyQuantity#
Total: #LSCurrencyFormat(getLotInfo.lotSellPrice * getBuyers.buyQuantity,"local")#

To complete this transaction if you have not already done so, you may get in touch with the seller directly. Here is the seller's contact information.

-----------
  Seller
-----------
Username: #getSeller.username#
Name: #getLotInfo.lotContactName#
Phone: #getSeller.phone#
Email: #getLotInfo.lotContactEmail#

Your information has been forwarded to the seller as well. They will likely be contacting you in the near future to complete the purchase.

#systemURL#/lot.cfm?lotID=#lotID#

</CFMAIL>
