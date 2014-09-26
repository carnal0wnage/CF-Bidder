<!--- Emaze Auction version 2.1, 1.03 / Monday, September 20, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Registration Emails</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFFILE ACTION=Write FILE="#systemPath#\system\emailUser.cfm"
		OUTPUT="<CFSET e_fromnameVerify = ""#Form.e_fromnameVerify#"">
<CFSET e_fromemailVerify = ""#Form.e_fromemailVerify#"">
<CFSET e_subjectVerify = ""#Form.e_subjectVerify#"">
<CFSET e_fromnameRegister = ""#Form.e_fromnameRegister#"">
<CFSET e_fromemailRegister = ""#Form.e_fromemailRegister#"">
<CFSET e_subjectRegister = ""#Form.e_subjectRegister#"">">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailVerifyEmail.cfm" OUTPUT="
<CFINCLUDE TEMPLATE=""../system/emailUser.cfm"">
<CFIF e_fromnameVerify NEQ """" AND e_fromnameVerify NEQ "" "">
	<CFSET e_fromemailVerify = ""##e_fromemailVerify## (##e_fromnameVerify##)"">
</CFIF>

<CFMAIL TO=""##email##""
	FROM=""##e_fromemailVerify##""
	SUBJECT=""#e_subjectVerify#""
	SERVER=""##emailServer##"">
#emailVerify#

</CFMAIL>">

	<CFIF Form.emailVerify EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailVerify.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailVerify = Replace(Form.emailVerify, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailVerify.cfm" OUTPUT="#emailVerify#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailUserRegister.cfm" OUTPUT="
<CFINCLUDE TEMPLATE=""../system/emailUser.cfm"">
<CFIF e_fromnameRegister NEQ """" AND e_fromnameRegister NEQ "" "">
	<CFSET e_fromemailRegister = ""##e_fromemailRegister## (##e_fromnameRegister##)"">
</CFIF>
<CFIF emailUserAgreement EQ 1>
	<CFFILE ACTION=Read FILE=""##systemPath##\system\userAgreementText.cfm"" VARIABLE=""userAgreementText"">
</CFIF>

<CFMAIL TO=""##email##""
	FROM=""##e_fromemailRegister##""
	SUBJECT=""#e_subjectRegister#""
	SERVER=""##emailServer##"">
#emailRegister#

</CFMAIL>">

	<CFIF Form.emailRegister EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailRegister.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailRegister = Replace(Form.emailRegister, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailRegister.cfm" OUTPUT="#emailRegister#">
	</CFIF>

	<H3>Registration emails updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Registration Email</B></FONT>

<CFINCLUDE TEMPLATE="../system/emailUser.cfm">

<P>To update the email options, make the changes and then click on the submit button at the bottom of the page. Each email will automatically include the lot name and the appropriate bidding information.
<P>

<CFFORM ACTION=emailsRegister.cfm NAME=emailsRegister>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH BGCOLOR=FFFFCE>Email</TH>
	<TH BGCOLOR=FFFFCE>From Name</TH>
	<TH BGCOLOR=FFFFCE>Reply-to Email</TH></TR>
<TR VALIGN=top><TD>Email Verification</TD>
	<TD><CFINPUT TYPE=text NAME=e_fromnameVerify SIZE=25 VALUE="#e_fromnameVerify#"><BR><FONT SIZE=2>(leave blank for no name)</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=e_fromemailVerify SIZE=25 VALUE="#e_fromemailVerify#" REQUIRED="Yes" MESSAGE="You must enter a reply-to email address for the email to verify a valid email address."></TD></TR>
<TR BGCOLOR=DCDCDC VALIGN=top><TD>User Registration</TD>
	<TD><CFINPUT TYPE=text NAME=e_fromnameRegister SIZE=25 VALUE="#e_fromnameRegister#"><BR><FONT SIZE=2>(leave blank for no name)</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=e_fromemailRegister SIZE=25 VALUE="#e_fromemailRegister#" REQUIRED="Yes" MESSAGE="You must enter a reply-to email address for the email after user registration."></TD></TR>
</TABLE>

<P>

<DL>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Verify Email</B> (for verifying valid email address of new bidders)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
	<TD><CFINPUT TYPE=text NAME=e_subjectVerify SIZE=40 VALUE="#e_subjectVerify#" REQUIRED="Yes" MESSAGE="You must enter a subject for the email to verify a valid demail address."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailVerify.cfm" VARIABLE="emailVerify">
<CFSET emailVerify = RTrim(emailVerify)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailVerify ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailVerify#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Register</B> (send username/password and/or user agreement after registering)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
	<TD><CFINPUT TYPE=text NAME=e_subjectRegister SIZE=40 VALUE="#e_subjectRegister#" REQUIRED="Yes" MESSAGE="You must enter a subject for the register email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailRegister.cfm" VARIABLE="emailRegister">
<CFSET emailRegister = RTrim(emailRegister)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailRegister ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailRegister#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Email Options">
</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>