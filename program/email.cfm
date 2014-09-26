<!--- Emaze Auction version 2.1, 1.01 / Wednesday, June 30, 1999 --->
<CFINCLUDE TEMPLATE="../system/emailOtherUserOptions.cfm">

<CFSET title = titleEmailOtherUser>
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<P>

<CFIF NOT IsDefined("Form.recipientUsername")>
	<CFOUTPUT>#emailOtherUserBadRecipient#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF Form.recipientUsername EQ "">
	<CFOUTPUT>#emailOtherUserBadRecipient#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF NOT IsDefined("Form.username") OR NOT IsDefined("Form.password")>
	<CFOUTPUT>#emailOtherUserBadLogin#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF Form.username EQ "" OR Form.password EQ "">
	<CFOUTPUT>#emailOtherUserBadLogin#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFQUERY NAME=getRecipient DATASOURCE="#EAdatasource#">
	SELECT email
	FROM Member
	WHERE username = '#Form.recipientUsername#'
</CFQUERY>
<CFIF getRecipient.RecordCount NEQ 1>
	<CFOUTPUT>#emailOtherUserBadRecipient#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF getRecipient.email EQ "" OR getRecipient.email EQ " ">
	<CFOUTPUT>#emailOtherUserBadRecipient#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFQUERY NAME=getSender DATASOURCE="#EAdatasource#">
	SELECT email, password, firstName, lastName, phone, phoneExtension,
		phone2, phone2Extension, organization, feedbackRating, userStatus
	FROM Member
	WHERE username = '#Form.username#'
</CFQUERY>
<CFIF getSender.RecordCount NEQ 1>
	<CFOUTPUT>#emailOtherUserBadLogin#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF Form.password NEQ Decrypt(getSender.password,encryptionCode)>
	<CFOUTPUT>#emailOtherUserBadLogin#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF getSender.userStatus NEQ 1>
	<CFOUTPUT>#emailOtherUserBadStatus#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFSET senderInformation = "">
<CFIF ListFind(emailOtherUserSenderFields,"username")>
	<CFSET senderInformation = "#emailOtherUserSenderUsername# #Form.username#">
</CFIF>

<CFIF ListFind(emailOtherUserSenderFields,"firstName") AND ListFind(emailOtherUserSenderFields,"lastName")
		AND getSender.firstName NEQ "" AND getSender.firstName NEQ " " AND getSender.lastName NEQ "" AND getSender.lastName NEQ " ">
	<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderName# #getSender.firstName# #getSender.lastName#">

<CFELSEIF ListFind(emailOtherUserSenderFields,"firstName") AND getSender.firstName NEQ "" AND getSender.firstName NEQ " ">
	<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderFirstName# #getSender.firstName#">

<CFELSEIF ListFind(emailOtherUserSenderFields,"lastName") AND getSender.lastName NEQ "" AND getSender.lastName NEQ " ">
	<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderLastName# #getSender.lastName#">
</CFIF>

<CFIF ListFind(emailOtherUserSenderFields,"email") AND getSender.email NEQ "" AND getSender.email NEQ " ">
	<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderEmail# #getSender.email#">
</CFIF>

<CFIF ListFind(emailOtherUserSenderFields,"organization") AND getSender.organization NEQ "" AND getSender.organization NEQ " ">
	<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderOrganization# #getSender.organization#">
</CFIF>

<CFIF ListFind(emailOtherUserSenderFields,"phone") AND getSender.phone NEQ "" AND getSender.phone NEQ " ">
	<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderPhone# #getSender.phone# #getSender.phoneExtension#">
</CFIF>

<CFIF ListFind(emailOtherUserSenderFields,"phone2") AND getSender.phone2 NEQ "" AND getSender.phone2 NEQ " ">
	<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderPhone2# #getSender.phone2# #getSender.phone2Extension#">
</CFIF>

<CFIF ListFind(emailOtherUserSenderFields,"feedbackRating") AND emailOtherUserLeaveFeedback NEQ "">
		<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderFeedbackRating# #getSender.feedbackRating#
#emailOtherUserLeaveFeedback#
#systemURL#/feedback/feedback.cfm?username=#URLEncodedFormat(Form.username)#">
<CFELSEIF ListFind(emailOtherUserSenderFields,"feedbackRating")>
	<CFSET senderInformation = "#senderInformation#
#emailOtherUserSenderFeedbackRating# #getSender.feedbackRating#">
</CFIF>

<CFIF emailOtherUserFromName NEQ "" AND emailOtherUserFromName NEQ " ">
	<CFSET emailOtherUserFromEmail = "#emailOtherUserFromEmail# (#emailOtherUserFromName#)">
</CFIF>
<CFINCLUDE TEMPLATE="../email/emailRegisteredUser.cfm">

<CFOUTPUT>#emailOtherUserSent#</CFOUTPUT>

<P>
<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>

</body>
</html>
