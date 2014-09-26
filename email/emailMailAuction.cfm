
<CFIF mailAuctionFromName NEQ "" AND mailAuctionFromName NEQ " ">
	<CFSET mailAuctionFromEmail = "#mailAuctionFromEmail# (#mailAuctionFromName#)">
</CFIF>

<CFMAIL	TO="#emailTo#"
	FROM="#mailAuctionFromEmail#"
	SUBJECT="#subject#"
	SERVER="#emailServer#">
This email was sent via Emaze Auction at the request of a bidder who thought you might be interested in this item.

#Form.message#

If you received this email by mistake, please email us and we will take care of it.

</CFMAIL>

<CFIF mailAuctionCCAdmin EQ 1>
	<CFMAIL	TO="#mailAuctionCCAdminEmail#"
		FROM="#mailAuctionFromEmail#"
		SUBJECT="#subject#"
		SERVER="#emailServer#">
This email was sent via Emaze Auction at the request of a bidder who thought you might be interested in this item.

#Form.message#

If you received this email by mistake, please email us and we will take care of it.

	</CFMAIL>
</CFIF>
