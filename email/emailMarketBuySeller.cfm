
<CFMAIL TO="#marketBuySellerTo#"
	FROM="#marketAdminEmail#"
	SUBJECT="Classified item #lotID# purchase notice"
	SERVER="#emailServer#">
This is an automated email to notify you that a user just purchased classified item #lotID#.

#lotName#

#systemURL#/lot.cfm?lotID=#lotID#

Price: #LSCurrencyFormat(lotSellPrice,"local")#
Quantity: #Form.buyQuantity#
Total: #LSCurrencyFormat(lotSellPrice * Form.buyQuantity,"local")#

To complete this transaction, you may get in touch with the buyer.

Username: #Form.username#
Name: #checkUser.firstName# #checkUser.lastName#
Phone: #checkUser.phone#
Email: #checkUser.email#

Your information has been forwarded to the buyer as well.

More information can be found on this buyer by logging into your seller homepage at:

#systemURL#/seller/sellerIndex.cfm

</CFMAIL>
