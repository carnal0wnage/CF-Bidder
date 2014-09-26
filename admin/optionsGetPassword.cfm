<!--- Emaze Auction version 2.1, 1.03 / Monday, September 20, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Get Password Script</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF NOT IsDefined("Form.getPasswordFields")><CFSET getPasswordFields = " "></CFIF>
	<CFIF NOT IsDefined("Form.getPasswordUsername")><CFSET getPasswordUsername = 0></CFIF>
	<CFIF NOT IsDefined("Form.getPasswordCCAdmin")><CFSET getPasswordCCAdmin = 0></CFIF>

	<CFSET getPasswordAdminEmail = Replace(Form.getPasswordAdminEmail, """", "&quot;", "ALL")>
	<CFSET getPasswordFromName = Replace(Form.getPasswordFromName, """", "&quot;", "ALL")>
	<CFSET getPasswordFromEmail = Replace(Form.getPasswordFromEmail, """", "&quot;", "ALL")>
	<CFSET getPasswordSubject = Replace(Form.getPasswordSubject, """", "&quot;", "ALL")>
	<CFSET getPasswordRecordsZero = Replace(Form.getPasswordRecordsZero, """", "&quot;", "ALL")>
	<CFSET getPasswordRecordsMultiple = Replace(Form.getPasswordRecordsMultiple, """", "&quot;", "ALL")>
	<CFSET getPasswordEmailSent = Replace(Form.getPasswordEmailSent, """", "&quot;", "ALL")>

	<CFSET getPasswordAdminEmail = Replace(getPasswordAdminEmail, "##", "####", "ALL")>
	<CFSET getPasswordFromName = Replace(getPasswordFromName, "##", "####", "ALL")>
	<CFSET getPasswordFromEmail = Replace(getPasswordFromEmail, "##", "####", "ALL")>
	<CFSET getPasswordSubject = Replace(getPasswordSubject, "##", "####", "ALL")>
	<CFSET getPasswordRecordsZero = Replace(getPasswordRecordsZero, "##", "####", "ALL")>
	<CFSET getPasswordRecordsMultiple = Replace(getPasswordRecordsMultiple, "##", "####", "ALL")>
	<CFSET getPasswordEmailSent = Replace(getPasswordEmailSent, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\getPasswordOptions.cfm"
		OUTPUT="<CFSET getPasswordFields = ""#getPasswordFields#"">
<CFSET getPasswordUsername = #getPasswordUsername#>
<CFSET getPasswordCCAdmin = #getPasswordCCAdmin#>
<CFSET getPasswordAdminEmail = ""#getPasswordAdminEmail#"">
<CFSET getPasswordFromName = ""#getPasswordFromName#"">
<CFSET getPasswordFromEmail = ""#getPasswordFromEmail#"">
<CFSET getPasswordSubject = ""#getPasswordSubject#"">
<CFSET getPasswordRecordsZero = ""#getPasswordRecordsZero#"">
<CFSET getPasswordRecordsMultiple = ""#getPasswordRecordsMultiple#"">
<CFPARAM NAME=""getPassword.email"" DEFAULT=""email"">
<CFSET getPasswordEmailSent = ""#getPasswordEmailSent#"">
">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailPassword.cfm" OUTPUT="
<CFSET password = Decrypt(getPassword.password,encryptionCode)>
<CFIF getPasswordFromName NEQ """" AND getPasswordFromName NEQ "" "">
	<CFSET getPasswordFromEmail = ""##getPasswordFromEmail## (##getPasswordFromName##)"">
</CFIF>

<CFMAIL	TO=""##getPassword.email##""
	FROM=""##getPasswordFromEmail##""
	SUBJECT=""#getPasswordSubject#""
	SERVER=""##emailServer##"">
#emailGetPassword#

</CFMAIL>

<CFIF getPasswordUsername EQ 1>
	<CFMAIL	TO=""##getPasswordAdminEmail##""
		FROM=""##getPasswordFromEmail##""
		SUBJECT=""##getPasswordSubject##""
		SERVER=""##emailServer##"">
#emailGetPasswordAdmin#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailGetPassword EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailGetPassword.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailGetPassword = Replace(Form.emailGetPassword, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailGetPassword.cfm" OUTPUT="#emailGetPassword#">
	</CFIF>

	<CFIF Form.emailGetPasswordAdmin EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailGetPasswordAdmin.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailGetPasswordAdmin = Replace(Form.emailGetPasswordAdmin, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailGetPasswordAdmin.cfm" OUTPUT="#emailGetPasswordAdmin#">
	</CFIF>

	<H3>Get password script options updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Get Password Script</B></FONT>

<CFINCLUDE TEMPLATE="../system/getPasswordOptions.cfm">

<CFFORM NAME=optionsPassword ACTION=optionsGetPassword.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TR><TD VALIGN=top ALIGN=right><FONT FACE="Arial" SIZE=2>Fields Users <BR>Must Enter: </FONT></TD>
	<TD><INPUT TYPE=checkbox NAME=getPasswordFields VALUE="email"<CFIF ListFind(getPasswordFields,"email")> CHECKED</CFIF>> Email address<BR>
	<INPUT TYPE=checkbox NAME=getPasswordFields VALUE="username"<CFIF ListFind(getPasswordFields,"username")> CHECKED</CFIF>> Username<BR>
	<INPUT TYPE=checkbox NAME=getPasswordFields VALUE="mothersMaidenName"<CFIF ListFind(getPasswordFields,"mothersMaidenName")> CHECKED</CFIF>> Mother's maiden name<BR>
	<FONT SIZE=2>(Checking no fields automatically disables the script from the help page.<BR>
	Each checked field is required.)</FONT></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD COLSPAN=2><INPUT TYPE=checkbox NAME=getPasswordUsername VALUE=1<CFIF getPasswordUsername EQ 1> CHECKED</CFIF>> Include username in email (in addition to password)</TD></TR>

<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>From name: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=getPasswordFromName SIZE=40 VALUE="#getPasswordFromName#"> <FONT SIZE=2>(leave blank for no name)</FONT></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>From email: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=getPasswordFromEmail SIZE=40 VALUE="#getPasswordFromEmail#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Subject: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=getPasswordSubject SIZE=40 VALUE="#getPasswordSubject#"></TD></TR>

<CFFILE ACTION=Read FILE="#systemPath#\system\emailGetPassword.cfm" VARIABLE="emailGetPassword">
<CFSET emailGetPassword = RTrim(emailGetPassword)>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Email to user: </FONT></TD>
	<TD><TEXTAREA NAME=emailGetPassword ROWS=8 COLS=60 WRAP=off><CFOUTPUT>#emailGetPassword#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD COLSPAN=2><INPUT TYPE=checkbox NAME=getPasswordCCAdmin VALUE=1<CFIF getPasswordCCAdmin EQ 1> CHECKED</CFIF>> Email admin with information on user requesting the password email
	<FONT SIZE=2><BR>&nbsp; &nbsp; &nbsp; &nbsp; (to track who is requesting passwords without receiving their password)</FONT></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Admin email: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=getPasswordAdminEmail SIZE=40 VALUE="#getPasswordAdminEmail#"></TD></TR>

<CFFILE ACTION=Read FILE="#systemPath#\system\emailGetPasswordAdmin.cfm" VARIABLE="emailGetPasswordAdmin">
<CFSET emailGetPasswordAdmin = RTrim(emailGetPasswordAdmin)>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Email to admin: </FONT></TD>
	<TD><TEXTAREA NAME=emailGetPasswordAdmin ROWS=5 COLS=60 WRAP=off><CFOUTPUT>#emailGetPasswordAdmin#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No Users Meet Criteria: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=getPasswordRecordsZero SIZE=55 VALUE="#getPasswordRecordsZero#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Multiple Users Meet Criteria: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=getPasswordRecordsMultiple SIZE=55 VALUE="#getPasswordRecordsMultiple#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Email Sent: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=getPasswordEmailSent SIZE=55 VALUE="#getPasswordEmailSent#"></TD></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Get Password Options">
</CFFORM>

</BODY>
</HTML>