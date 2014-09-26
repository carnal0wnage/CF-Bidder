
<CFMAIL	TO="#getRecipient.email#"
	FROM="#emailOtherUserFromEmail#"
	SUBJECT="Email from another registered user"
	SERVER="#emailServer#">
#Form.recipientUsername#,

This email was sent to you by another registered user at the Emaze Auction site.

Your email address and other personal information were NOT revealed to the sender.

Sender Information
#senderInformation#

To reply to this user, you may use the following form:

#systemURL#/program/help.cfm?##email

Message:

#Form.message#

</CFMAIL>

<CFIF emailOtherUserCCAdmin EQ 1 OR IsDefined("Form.CCSender")>
	<CFIF emailOtherUserCCAdmin EQ 1 AND IsDefined("Form.CCSender")>
		<CFSET cfmailTo = "#emailOtherUserAdminEmail#,#getSender.email#">
	<CFELSEIF emailOtherUserCCAdmin EQ 1>
		<CFSET cfmailTo = emailOtherUserAdminEmail>
	<CFELSE>
		<CFSET cfmailTo = getSender.email>
	</CFIF>

	<CFMAIL	TO="#cfmailTo#"
		FROM="#emailOtherUserFromEmail#"
		SUBJECT="Email from another registered user"
		SERVER="#emailServer#">
#Form.recipientUsername#,

This email was sent to you by another registered user at the Emaze Auction site.

Your email address and other personal information were NOT revealed to the sender.

Sender Information
#senderInformation#

To reply to this user, you may use the following form:

#systemURL#/program/help.cfm?##email

Message:

#Form.message#

	</CFMAIL>
</CFIF>
