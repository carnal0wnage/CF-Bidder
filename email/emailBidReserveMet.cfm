
<CFINCLUDE TEMPLATE="../system/emailBid.cfm">
<CFIF e_fromnameBid NEQ "" AND e_fromnameBid NEQ " ">
	<CFSET e_fromemailBid = "#e_fromemailBid# (#e_fromnameBid#)">
</CFIF>

<CFMAIL TO="#lotContactEmail#"
	FROM="#e_fromemailBid#"
	SUBJECT="Emaze Auction - Reserve Price Met for Lot 1"
	SERVER="#emailServer#">
This is an automated email to notify you that the reserve price of #LSCurrencyFormat(lotReservePrice,"local")# has been met for lot #Form.lotID#.

Lot: #lotName#

#systemURL#/lot.cfm?lotID=#Form.lotID#

</CFMAIL>
