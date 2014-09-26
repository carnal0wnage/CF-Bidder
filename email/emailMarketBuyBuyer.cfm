
<CFMAIL TO="#marketBuyBuyerTo#"
	FROM="#marketAdminEmail#"
	SUBJECT="Classified item #lotID# purchase confirmation"
	SERVER="#emailServer#">
#Form.username#,

This is an automated email to confirm that you have just purchased classified item #lotID#.

#lotName#

Price: #LSCurrencyFormat(lotSellPrice,"local")#
Quantity: #Form.buyQuantity#
Total: #LSCurrencyFormat(lotSellPrice * Form.buyQuantity,"local")#

To complete this transaction, you may get in touch with the seller directly. Here is the seller's contact information.

Username: #getSeller.username#
Name: #lotContactName#
Phone: #getSeller.phone#
Email: #lotContactEmail#

Your information has been forwarded to the seller as well.

#systemURL#/lot.cfm?lotID=#lotID#

</CFMAIL>
