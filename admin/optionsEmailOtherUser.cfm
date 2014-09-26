<!--- Emaze Auction version 2.1, 1.03 / Monday, September 20, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Email Other Users Options</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF NOT IsDefined("Form.emailOtherUser")><CFSET emailOtherUser = 0></CFIF>
	<CFIF NOT IsDefined("Form.emailOtherUserCCAdmin")><CFSET emailOtherUserCCAdmin = 0></CFIF>
	<CFIF NOT IsDefined("Form.emailOtherUserCCSender")><CFSET emailOtherUserCCSender = 0></CFIF>
	<CFIF NOT IsDefined("Form.emailOtherUserSenderFields")><CFSET emailOtherUserSenderFields = " "></CFIF>

	<CFSET emailOtherUserFromName = Replace(Form.emailOtherUserFromName, """", "&quot;", "ALL")>
	<CFSET emailOtherUserFromEmail = Replace(Form.emailOtherUserFromEmail, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSubject = Replace(Form.emailOtherUserSubject, """", "&quot;", "ALL")>
	<CFSET emailOtherUserAdminEmail = Replace(Form.emailOtherUserAdminEmail, """", "&quot;", "ALL")>
	<CFSET emailOtherUserBadLogin = Replace(Form.emailOtherUserBadLogin, """", "&quot;", "ALL")>
	<CFSET emailOtherUserBadRecipient = Replace(Form.emailOtherUserBadRecipient, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSent = Replace(Form.emailOtherUserSent, """", "&quot;", "ALL")>
	<CFSET titleEmailOtherUser = Replace(Form.titleEmailOtherUser, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderUsername = Replace(Form.emailOtherUserSenderUsername, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderEmail = Replace(Form.emailOtherUserSenderEmail, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderFirstName = Replace(Form.emailOtherUserSenderFirstName, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderLastName = Replace(Form.emailOtherUserSenderLastName, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderName = Replace(Form.emailOtherUserSenderName, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderPhone = Replace(Form.emailOtherUserSenderPhone, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderPhone2 = Replace(Form.emailOtherUserSenderPhone2, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderOrganization = Replace(Form.emailOtherUserSenderOrganization, """", "&quot;", "ALL")>
	<CFSET emailOtherUserSenderFeedbackRating = Replace(Form.emailOtherUserSenderFeedbackRating, """", "&quot;", "ALL")>
	<CFSET emailOtherUserLeaveFeedback = Replace(Form.emailOtherUserLeaveFeedback, """", "&quot;", "ALL")>
	<CFSET emailOtherUserBadStatus = Replace(Form.emailOtherUserBadStatus, """", "&quot;", "ALL")>

	<CFSET emailOtherUserFromName = Replace(emailOtherUserFromName, "##", "####", "ALL")>
	<CFSET emailOtherUserFromEmail = Replace(emailOtherUserFromEmail, "##", "####", "ALL")>
	<CFSET emailOtherUserSubject = Replace(emailOtherUserSubject, "##", "####", "ALL")>
	<CFSET emailOtherUserAdminEmail = Replace(emailOtherUserAdminEmail, "##", "####", "ALL")>
	<CFSET emailOtherUserBadLogin = Replace(emailOtherUserBadLogin, "##", "####", "ALL")>
	<CFSET emailOtherUserBadRecipient = Replace(emailOtherUserBadRecipient, "##", "####", "ALL")>
	<CFSET emailOtherUserSent = Replace(emailOtherUserSent, "##", "####", "ALL")>
	<CFSET titleEmailOtherUser = Replace(titleEmailOtherUser, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderUsername = Replace(emailOtherUserSenderUsername, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderEmail = Replace(emailOtherUserSenderEmail, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderFirstName = Replace(emailOtherUserSenderFirstName, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderLastName = Replace(emailOtherUserSenderLastName, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderName = Replace(emailOtherUserSenderName, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderPhone = Replace(emailOtherUserSenderPhone, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderPhone2 = Replace(emailOtherUserSenderPhone2, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderOrganization = Replace(emailOtherUserSenderOrganization, "##", "####", "ALL")>
	<CFSET emailOtherUserSenderFeedbackRating = Replace(emailOtherUserSenderFeedbackRating, "##", "####", "ALL")>
	<CFSET emailOtherUserLeaveFeedback = Replace(emailOtherUserLeaveFeedback, "##", "####", "ALL")>
	<CFSET emailOtherUserBadStatus = Replace(emailOtherUserBadStatus, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\emailOtherUserOptions.cfm"
		OUTPUT="<CFSETTING ENABLECFOUTPUTONLY=""Yes"">
<CFSET emailOtherUser = #emailOtherUser#>
<CFSET emailOtherUserCCAdmin = #emailOtherUserCCAdmin#>
<CFSET emailOtherUserCCSender = #emailOtherUserCCSender#>
<CFSET emailOtherUserSenderFields = ""#emailOtherUserSenderFields#"">
<CFSET emailOtherUserFromName = ""#emailOtherUserFromName#"">
<CFSET emailOtherUserFromEmail = ""#emailOtherUserFromEmail#"">
<CFSET emailOtherUserSubject = ""#emailOtherUserSubject#"">
<CFSET emailOtherUserAdminEmail = ""#emailOtherUserAdminEmail#"">
<CFSET emailOtherUserBadLogin = ""#emailOtherUserBadLogin#"">
<CFSET emailOtherUserBadRecipient = ""#emailOtherUserBadRecipient#"">
<CFSET emailOtherUserSent = ""#emailOtherUserSent#"">
<CFSET titleEmailOtherUser = ""#titleEmailOtherUser#"">
<CFSET emailOtherUserSenderUsername = ""#emailOtherUserSenderUsername#"">
<CFSET emailOtherUserSenderEmail = ""#emailOtherUserSenderEmail#"">
<CFSET emailOtherUserSenderFirstName = ""#emailOtherUserSenderFirstName#"">
<CFSET emailOtherUserSenderLastName = ""#emailOtherUserSenderLastName#"">
<CFSET emailOtherUserSenderName = ""#emailOtherUserSenderName#"">
<CFSET emailOtherUserSenderPhone = ""#emailOtherUserSenderPhone#"">
<CFSET emailOtherUserSenderPhone2 = ""#emailOtherUserSenderPhone2#"">
<CFSET emailOtherUserSenderOrganization = ""#emailOtherUserSenderOrganization#"">
<CFSET emailOtherUserSenderFeedbackRating = ""#emailOtherUserSenderFeedbackRating#"">
<CFSET emailOtherUserLeaveFeedback = ""#emailOtherUserLeaveFeedback#"">
<CFSET emailOtherUserBadStatus = ""#emailOtherUserBadStatus#"">
<CFSETTING ENABLECFOUTPUTONLY=""No"">">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailRegisteredUser.cfm" OUTPUT="
<CFMAIL	TO=""##getRecipient.email##""
	FROM=""##emailOtherUserFromEmail##""
	SUBJECT=""#emailOtherUserSubject#""
	SERVER=""##emailServer##"">
#emailOtherUserEmail#

</CFMAIL>

<CFIF emailOtherUserCCAdmin EQ 1 OR IsDefined(""Form.CCSender"")>
	<CFIF emailOtherUserCCAdmin EQ 1 AND IsDefined(""Form.CCSender"")>
		<CFSET cfmailTo = ""##emailOtherUserAdminEmail##,##getSender.email##"">
	<CFELSEIF emailOtherUserCCAdmin EQ 1>
		<CFSET cfmailTo = emailOtherUserAdminEmail>
	<CFELSE>
		<CFSET cfmailTo = getSender.email>
	</CFIF>

	<CFMAIL	TO=""##cfmailTo##""
		FROM=""##emailOtherUserFromEmail##""
		SUBJECT=""#emailOtherUserSubject#""
		SERVER=""##emailServer##"">
#emailOtherUserEmail#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailOtherUserEmail EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailOtherUserEmail.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailOtherUserEmail = Replace(RTrim(Form.emailOtherUserEmail), "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailOtherUserEmail.cfm" OUTPUT="#emailOtherUserEmail#">
	</CFIF>

	<H3>Email other user options updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Email Other User Options</B></FONT>

<CFINCLUDE TEMPLATE="../system/emailOtherUserOptions.cfm">

<CFFORM NAME=optionsEmailOtherUser ACTION=optionsEmailOtherUser.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TD COLSPAN=2><INPUT TYPE=checkbox NAME=emailOtherUser VALUE=1<CFIF emailOtherUser EQ 1> CHECKED</CFIF>> <FONT SIZE=4>Let users email each other without revealing email address of recipient</FONT> (from help)</TD></TR>
<TR BGCOLOR="#C6E2FF"><TD COLSPAN=2>&nbsp; &nbsp; &nbsp; <I>Include the following sender fields in the email:</I>
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
	<TR><TD WIDTH=20 ROWSPAN=9>&nbsp;</TD><TH>Field</TH><TD WIDTH=10 ROWSPAN=9>&nbsp;</TD><TH>Text in Email</TH></TR>
	<TR><TD VALIGN=top><INPUT TYPE=checkbox NAME=emailOtherUserSenderFields VALUE="username"<CFIF ListFind(emailOtherUserSenderFields,"username")> CHECKED</CFIF>> Username</TD>
		<TD><CFINPUT TYPE=text NAME=emailOtherUserSenderUsername VALUE="#emailOtherUserSenderUsername#"></TD></TR>
	<TR><TD VALIGN=top><INPUT TYPE=checkbox NAME=emailOtherUserSenderFields VALUE="email"<CFIF ListFind(emailOtherUserSenderFields,"email")> CHECKED</CFIF>> Email</TD>
		<TD><CFINPUT TYPE=text NAME=emailOtherUserSenderEmail VALUE="#emailOtherUserSenderEmail#"></TD></TR>
	<TR><TD VALIGN=top><INPUT TYPE=checkbox NAME=emailOtherUserSenderFields VALUE="firstName"<CFIF ListFind(emailOtherUserSenderFields,"firstName")> CHECKED</CFIF>> First name</TD>
		<TD><CFINPUT TYPE=text NAME=emailOtherUserSenderFirstName VALUE="#emailOtherUserSenderFirstName#"></TD>
		<TD ROWSPAN=2 VALIGN=center><CFINPUT TYPE=text NAME=emailOtherUserSenderName VALUE="#emailOtherUserSenderName#"></TD></TR>
	<TR><TD VALIGN=top><INPUT TYPE=checkbox NAME=emailOtherUserSenderFields VALUE="lastName"<CFIF ListFind(emailOtherUserSenderFields,"lastName")> CHECKED</CFIF>> Last name</TD>
		<TD><CFINPUT TYPE=text NAME=emailOtherUserSenderLastName VALUE="#emailOtherUserSenderLastName#"></TD></TR>
	<TR><TD VALIGN=top><INPUT TYPE=checkbox NAME=emailOtherUserSenderFields VALUE="phone"<CFIF ListFind(emailOtherUserSenderFields,"phone")> CHECKED</CFIF>>Phone number</TD>
		<TD><CFINPUT TYPE=text NAME=emailOtherUserSenderPhone VALUE="#emailOtherUserSenderPhone#"></TD></TR>
	<TR><TD VALIGN=top><INPUT TYPE=checkbox NAME=emailOtherUserSenderFields VALUE="phone2"<CFIF ListFind(emailOtherUserSenderFields,"phone2")> CHECKED</CFIF>>Phone number 2</TD>
		<TD><CFINPUT TYPE=text NAME=emailOtherUserSenderPhone2 VALUE="#emailOtherUserSenderPhone2#"></TD></TR>
	<TR><TD VALIGN=top><INPUT TYPE=checkbox NAME=emailOtherUserSenderFields VALUE="organization"<CFIF ListFind(emailOtherUserSenderFields,"organization")> CHECKED</CFIF>>Organization</TD>
		<TD><CFINPUT TYPE=text NAME=emailOtherUserSenderOrganization VALUE="#emailOtherUserSenderOrganization#"></TD></TR>
	<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
		<TR><TD VALIGN=top><INPUT TYPE=checkbox NAME=emailOtherUserSenderFields VALUE="feedbackRating"<CFIF ListFind(emailOtherUserSenderFields,"feedbackRating")> CHECKED</CFIF>>Feedback Rating</TD>
		<TD COLSPAN=2><CFINPUT TYPE=text NAME=emailOtherUserSenderFeedbackRating VALUE="#emailOtherUserSenderFeedbackRating#"><BR>
		<CFINPUT TYPE=text NAME=emailOtherUserLeaveFeedback SIZE=40 VALUE="#emailOtherUserLeaveFeedback#"><BR>
		<FONT SIZE=2>If not blank, will display URL to leave feedback about user.</FONT></TD></TR>
	<CFELSE>
		<CFOUTPUT>
		<INPUT TYPE=hidden NAME=emailOtherUserSenderFeedbackRating VALUE="#emailOtherUserSenderFeedbackRating#">
		<INPUT TYPE=hidden NAME=emailOtherUserLeaveFeedback VALUE="#emailOtherUserLeaveFeedback#">
		</CFOUTPUT>
	</CFIF>
	</TABLE>
</TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>From name: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=emailOtherUserFromName SIZE=40 VALUE="#emailOtherUserFromName#"> <FONT SIZE=2>(leave blank for no name)</FONT></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>From email: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=emailOtherUserFromEmail SIZE=40 VALUE="#emailOtherUserFromEmail#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Subject: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=emailOtherUserSubject SIZE=40 VALUE="#emailOtherUserSubject#"></TD></TR>

<CFFILE ACTION=Read FILE="#systemPath#\system\emailOtherUserEmail.cfm" VARIABLE="emailOtherUserEmail">
<CFSET emailOtherUserEmail = RTrim(emailOtherUserEmail)>
<TR BGCOLOR="#C6E2FF"><TD COLSPAN=2><FONT FACE="Arial" SIZE=2>Message: </FONT><BR>
	<TEXTAREA NAME=emailOtherUserEmail ROWS=14 COLS=75 WRAP=off><CFOUTPUT>#emailOtherUserEmail#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD COLSPAN=2><INPUT TYPE=checkbox NAME=emailOtherUserCCSender VALUE=1<CFIF emailOtherUserCCSender EQ 1> CHECKED</CFIF>> Allow sender to receive copy of email</TD></TR>
<TR BGCOLOR="#C6E2FF"><TD COLSPAN=2><INPUT TYPE=checkbox NAME=emailOtherUserCCAdmin VALUE=1<CFIF emailOtherUserCCAdmin EQ 1> CHECKED</CFIF>> Send copy of email to admin: <CFINPUT TYPE=text NAME=emailOtherUserAdminEmail SIZE=40 VALUE="#emailOtherUserAdminEmail#"></TD></TR>
<TR><TD COLSPAN=2>Message displayed if username/password of sender is wrong:<BR>
	<CFINPUT TYPE=text NAME=emailOtherUserBadLogin SIZE=75 VALUE="#emailOtherUserBadLogin#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD COLSPAN=2>Message displayed if username of recipient is not valid:<BR>
	<CFINPUT TYPE=text NAME=emailOtherUserBadRecipient SIZE=75 VALUE="#emailOtherUserBadRecipient#"></TD></TR>
<TR><TD COLSPAN=2>Message displayed if user is not approved:<BR>
	<CFINPUT TYPE=text NAME=emailOtherUserBadStatus SIZE=75 VALUE="#emailOtherUserBadStatus#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD COLSPAN=2>Message displayed after email is sent:<BR>
	<CFINPUT TYPE=text NAME=emailOtherUserSent SIZE=75 VALUE="#emailOtherUserSent#"></TD></TR>
<TR><TD ALIGN=right>Page Title:</TD>
	<TD><CFINPUT TYPE=text NAME=titleEmailOtherUser SIZE=40 VALUE="#titleEmailOtherUser#"></TD></TR>
</TABLE>

<P>
<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">

</CFFORM>

</BODY>
</HTML>
