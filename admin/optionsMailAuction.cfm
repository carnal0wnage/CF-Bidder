<!--- Emaze Auction version 2.1, 1.02 / Sunday, July 4, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Mail Auction to a Friend Options</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF NOT IsDefined("Form.mailAuctionCCSender")><CFSET mailAuctionCCSender = 0></CFIF>
	<CFIF NOT IsDefined("Form.mailAuctionCCAdmin")><CFSET mailAuctionCCAdmin = 0></CFIF>

	<CFSET mailAuctionUsername = Replace(Form.mailAuctionUsername, """", "&quot;", "ALL")>
	<CFSET mailAuctionPassword = Replace(Form.mailAuctionPassword, """", "&quot;", "ALL")>
	<CFSET mailAuctionRecipient = Replace(Form.mailAuctionRecipient, """", "&quot;", "ALL")>
	<CFSET mailAuctionCCSenderText = Replace(Form.mailAuctionCCSenderText, """", "&quot;", "ALL")>
	<CFSET mailAuctionCCAdminEmail = Replace(Form.mailAuctionCCAdminEmail, """", "&quot;", "ALL")>
	<CFSET mailAuctionButtonSubmit = Replace(Form.mailAuctionButtonSubmit, """", "&quot;", "ALL")>
	<CFSET mailAuctionButtonPreview = Replace(Form.mailAuctionButtonPreview, """", "&quot;", "ALL")>
	<CFSET mailAuctionButtonReset = Replace(Form.mailAuctionButtonReset, """", "&quot;", "ALL")>
	<CFSET mailAuctionFromName = Replace(Form.mailAuctionFromName, """", "&quot;", "ALL")>
	<CFSET mailAuctionFromEmail = Replace(Form.mailAuctionFromEmail, """", "&quot;", "ALL")>
	<CFSET mailAuctionMessage = Replace(Form.mailAuctionMessage, """", "&quot;", "ALL")>
	<CFSET mailAuctionSubject = Replace(Form.mailAuctionSubject, """", "&quot;", "ALL")>
	<CFSET mailAuctionSubjectDefault = Replace(Form.mailAuctionSubjectDefault, """", "&quot;", "ALL")>
	<CFSET titleMailAuction = Replace(Form.titleMailAuction, """", "&quot;", "ALL")>
	<CFSET mailAuctionNoLot = Replace(Form.mailAuctionNoLot, """", "&quot;", "ALL")>
	<CFSET mailAuctionBlankLot = Replace(Form.mailAuctionBlankLot, """", "&quot;", "ALL")>
	<CFSET mailAuctionBadLogin = Replace(Form.mailAuctionBadLogin, """", "&quot;", "ALL")>
	<CFSET mailAuctionBlankUsername = Replace(Form.mailAuctionBlankUsername, """", "&quot;", "ALL")>
	<CFSET mailAuctionBlankPassword = Replace(Form.mailAuctionBlankPassword, """", "&quot;", "ALL")>
	<CFSET mailAuctionBlankRecipient = Replace(Form.mailAuctionBlankRecipient, """", "&quot;", "ALL")>
	<CFSET mailAuctionBadRecipient = Replace(Form.mailAuctionBadRecipient, """", "&quot;", "ALL")>
	<CFSET mailAuctionBadStatus = Replace(Form.mailAuctionBadStatus, """", "&quot;", "ALL")>

	<CFSET mailAuctionUsername = Replace(mailAuctionUsername, "##", "####", "ALL")>
	<CFSET mailAuctionPassword = Replace(mailAuctionPassword, "##", "####", "ALL")>
	<CFSET mailAuctionRecipient = Replace(mailAuctionRecipient, "##", "####", "ALL")>
	<CFSET mailAuctionCCSenderText = Replace(Form.mailAuctionCCSenderText, "##", "####", "ALL")>
	<CFSET mailAuctionCCAdminEmail = Replace(mailAuctionCCAdminEmail, "##", "####", "ALL")>
	<CFSET mailAuctionButtonSubmit = Replace(mailAuctionButtonSubmit, "##", "####", "ALL")>
	<CFSET mailAuctionButtonPreview = Replace(mailAuctionButtonPreview, "##", "####", "ALL")>
	<CFSET mailAuctionButtonReset = Replace(mailAuctionButtonReset, "##", "####", "ALL")>
	<CFSET mailAuctionFromName = Replace(mailAuctionFromName, "##", "####", "ALL")>
	<CFSET mailAuctionFromEmail = Replace(mailAuctionFromEmail, "##", "####", "ALL")>
	<CFSET mailAuctionMessage = Replace(mailAuctionMessage, "##", "####", "ALL")>
	<CFSET mailAuctionSubject = Replace(mailAuctionSubject, "##", "####", "ALL")>
	<CFSET mailAuctionSubjectDefault = Replace(mailAuctionSubjectDefault, "##", "####", "ALL")>
	<CFSET titleMailAuction = Replace(titleMailAuction, "##", "####", "ALL")>
	<CFSET mailAuctionNoLot = Replace(mailAuctionNoLot, "##", "####", "ALL")>
	<CFSET mailAuctionBlankLot = Replace(mailAuctionBlankLot, "##", "####", "ALL")>
	<CFSET mailAuctionBadLogin = Replace(mailAuctionBadLogin, "##", "####", "ALL")>
	<CFSET mailAuctionBlankUsername = Replace(mailAuctionBlankUsername, "##", "####", "ALL")>
	<CFSET mailAuctionBlankPassword = Replace(mailAuctionBlankPassword, "##", "####", "ALL")>
	<CFSET mailAuctionBlankRecipient = Replace(mailAuctionBlankRecipient, "##", "####", "ALL")>
	<CFSET mailAuctionBadRecipient = Replace(mailAuctionBadRecipient, "##", "####", "ALL")>
	<CFSET mailAuctionBadStatus = Replace(mailAuctionBadStatus, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionOptions.cfm"
		OUTPUT="<CFSET mailAuctionUsername = ""#mailAuctionUsername#"">
<CFSET mailAuctionPassword = ""#mailAuctionPassword#"">
<CFSET mailAuctionRecipient = ""#mailAuctionRecipient#"">
<CFSET mailAuctionCCSender = #mailAuctionCCSender#>
<CFSET mailAuctionCCSenderText = ""#mailAuctionCCSenderText#"">
<CFSET mailAuctionCCAdmin = #mailAuctionCCAdmin#>
<CFSET mailAuctionCCAdminEmail = ""#mailAuctionCCAdminEmail#"">
<CFSET mailAuctionPreviewOption = #Form.mailAuctionPreviewOption#>
<CFSET mailAuctionButtonSubmit = ""#mailAuctionButtonSubmit#"">
<CFSET mailAuctionButtonPreview = ""#mailAuctionButtonPreview#"">
<CFSET mailAuctionButtonReset = ""#mailAuctionButtonReset#"">
<CFSET mailAuctionFromName = ""#mailAuctionFromName#"">
<CFSET mailAuctionFromEmail = ""#mailAuctionFromEmail#"">
<CFSET mailAuctionMessage = ""#mailAuctionMessage#"">
<CFSET mailAuctionSubject = ""#mailAuctionSubject#"">
<CFSET mailAuctionSubjectDefault = ""#mailAuctionSubjectDefault#"">
<CFSET mailAuctionSubjectFixed = #Form.mailAuctionSubjectFixed#>
<CFSET titleMailAuction = ""#titleMailAuction#"">
<CFSET mailAuctionNoLot = ""#mailAuctionNoLot#"">
<CFSET mailAuctionBlankLot = ""#mailAuctionBlankLot#"">
<CFSET mailAuctionBadLogin = ""#mailAuctionBadLogin#"">
<CFSET mailAuctionBlankUsername = ""#mailAuctionBlankUsername#"">
<CFSET mailAuctionBlankPassword = ""#mailAuctionBlankPassword#"">
<CFSET mailAuctionBlankRecipient = ""#mailAuctionBlankRecipient#"">
<CFSET mailAuctionBadRecipient = ""#mailAuctionBadRecipient#"">
<CFSET mailAuctionBadStatus = ""#mailAuctionBadStatus#"">">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailMailAuction.cfm" OUTPUT="
<CFIF mailAuctionFromName NEQ """" AND mailAuctionFromName NEQ "" "">
	<CFSET mailAuctionFromEmail = ""##mailAuctionFromEmail## (##mailAuctionFromName##)"">
</CFIF>

<CFMAIL	TO=""##emailTo##""
	FROM=""##mailAuctionFromEmail##""
	SUBJECT=""##subject##""
	SERVER=""##emailServer##"">
#mailAuctionTop#

##Form.message##

#mailAuctionBottom#

</CFMAIL>

<CFIF mailAuctionCCAdmin EQ 1>
	<CFMAIL	TO=""##mailAuctionCCAdminEmail##""
		FROM=""##mailAuctionFromEmail##""
		SUBJECT=""##subject##""
		SERVER=""##emailServer##"">
#mailAuctionTop#

##Form.message##

#mailAuctionBottom#

	</CFMAIL>
</CFIF>">

	<CFIF Form.mailAuctionDefault EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionDefault.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET mailAuctionDefault = Replace(Form.mailAuctionDefault, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionDefault.cfm" OUTPUT="#mailAuctionDefault#">
	</CFIF>

	<CFIF Form.mailAuctionTop EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionTop.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET mailAuctionTop = Replace(Form.mailAuctionTop, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionTop.cfm" OUTPUT="#mailAuctionTop#">
	</CFIF>

	<CFIF Form.mailAuctionBottom EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionBottom.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET mailAuctionBottom = Replace(Form.mailAuctionBottom, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionBottom.cfm" OUTPUT="#mailAuctionBottom#">
	</CFIF>

	<CFIF Form.mailAuctionHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET mailAuctionHeader = Replace(Form.mailAuctionHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionHeader.cfm" OUTPUT="#mailAuctionHeader#">
	</CFIF>

	<CFIF Form.mailAuctionFooter EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionFooter.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET mailAuctionFooter = Replace(Form.mailAuctionFooter, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionFooter.cfm" OUTPUT="#mailAuctionFooter#">
	</CFIF>

	<CFIF Form.mailAuctionSuccess EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionSuccess.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET mailAuctionSuccess = Replace(Form.mailAuctionSuccess, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\mailAuctionSuccess.cfm" OUTPUT="#mailAuctionSuccess#">
	</CFIF>

	<H3>Mail auction to a friend options updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Mail Auction to a Friend Options</B></FONT>

<CFINCLUDE TEMPLATE="../system/mailAuctionOptions.cfm">

<CFFORM NAME=optionsMailAuction ACTION=optionsMailAuction.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Page Title: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleMailAuction SIZE=40 VALUE="#titleMailAuction#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Username: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionUsername SIZE=30 VALUE="#mailAuctionUsername#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Password: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionPassword SIZE=30 VALUE="#mailAuctionPassword#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Recipient's Email: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionRecipient SIZE=30 VALUE="#mailAuctionRecipient#"></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>CC Sender: </FONT></TD>
	<TD><INPUT TYPE=checkbox NAME=mailAuctionCCSender VALUE=1<CFIF mailAuctionCCSender EQ 1> CHECKED</CFIF>> Allow sender to send a copy of the email to him/herself<BR>
	Option Text: <CFINPUT TYPE=text NAME=mailAuctionCCSenderText SIZE=30 VALUE="#mailAuctionCCSenderText#"></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>CC Admin: </FONT></TD>
	<TD><INPUT TYPE=checkbox NAME=mailAuctionCCAdmin VALUE=1<CFIF mailAuctionCCAdmin EQ 1> CHECKED</CFIF>> Send a copy of the email to admin<BR>
	Admin email: <CFINPUT TYPE=text NAME=mailAuctionCCAdminEmail SIZE=30 VALUE="#mailAuctionCCAdminEmail#"></TD></TR>

<TR BGCOLOR="#C6E2FF" VALIGN=top><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Preview Options: </FONT></TD>
	<TD>(not yet enabled)<INPUT TYPE=hidden NAME=mailAuctionPreviewOption VALUE=-1></TD></TR>
<!---
<TR BGCOLOR="#C6E2FF" VALIGN=top><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Preview Options: </FONT></TD>
	<TD><INPUT TYPE=radio NAME=mailAuctionPreviewOption VALUE=-1<CFIF mailAuctionPreviewOption EQ -1> CHECKED</CFIF>> No preview option<BR>
	<INPUT TYPE=radio NAME=mailAuctionPreviewOption VALUE=0<CFIF mailAuctionPreviewOption EQ 0> CHECKED</CFIF>> Option to preview before email is sent<BR>
	<INPUT TYPE=radio NAME=mailAuctionPreviewOption VALUE=1<CFIF mailAuctionPreviewOption EQ 1> CHECKED</CFIF>> Must preview before email is sent</TD></TR>
--->

<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Submit button: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionButtonSubmit SIZE=20 VALUE="#mailAuctionButtonSubmit#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Preview button: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionButtonPreview SIZE=20 VALUE="#mailAuctionButtonPreview#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Reset button (clear): </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionButtonReset SIZE=20 VALUE="#mailAuctionButtonReset#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>From name: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionFromName SIZE=30 VALUE="#mailAuctionFromName#"> <FONT SIZE=2>(leave blank for no name)</FONT></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>From email: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionFromEmail SIZE=40 VALUE="#mailAuctionFromEmail#"></TD></TR>
<TR BGCOLOR="#C6E2FF" VALIGN=top><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Subject Options: </FONT></TD>
	<TD><INPUT TYPE=radio NAME=mailAuctionSubjectFixed VALUE=0<CFIF mailAuctionSubjectFixed EQ 0> CHECKED</CFIF>> Sender can choose subject <FONT SIZE=2>(subject below is initial suggestion)</FONT><BR>
	<INPUT TYPE=radio NAME=mailAuctionSubjectFixed VALUE=1<CFIF mailAuctionSubjectFixed EQ 1> CHECKED</CFIF>> Subject is set by admin <FONT SIZE=2>(subject below is sent)</FONT></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Subject: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionSubject SIZE=30 VALUE="#mailAuctionSubject#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Default Subject: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionSubjectDefault SIZE=50 VALUE="#mailAuctionSubjectDefault#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Message: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionMessage SIZE=30 VALUE="#mailAuctionMessage#"></TD></TR>
</TABLE>

<P>

<DL>
<CFFILE ACTION=Read FILE="#systemPath#\system\mailAuctionDefault.cfm" VARIABLE="mailAuctionDefault">
<CFSET mailAuctionDefault = RTrim(mailAuctionDefault)>
<DT><FONT FACE="Arial">Default Message: </FONT>
<DD><TEXTAREA NAME=mailAuctionDefault ROWS=6 COLS=70 WRAP=virtual><CFOUTPUT>#mailAuctionDefault#</CFOUTPUT></TEXTAREA>

<P>

<CFFILE ACTION=Read FILE="#systemPath#\system\mailAuctionTop.cfm" VARIABLE="mailAuctionTop">
<CFSET mailAuctionTop = RTrim(mailAuctionTop)>
<DT><FONT FACE="Arial">Automatic Message At Top: </FONT>
<DD><TEXTAREA NAME=mailAuctionTop ROWS=6 COLS=70 WRAP=virtual><CFOUTPUT>#mailAuctionTop#</CFOUTPUT></TEXTAREA>

<P>

<CFFILE ACTION=Read FILE="#systemPath#\system\mailAuctionBottom.cfm" VARIABLE="mailAuctionBottom">
<CFSET mailAuctionBottom = RTrim(mailAuctionBottom)>
<DT><FONT FACE="Arial">Automatic Message At Bottom: </FONT>
<DD><TEXTAREA NAME=mailAuctionBottom ROWS=6 COLS=70 WRAP=virtual><CFOUTPUT>#mailAuctionBottom#</CFOUTPUT></TEXTAREA>

<P>

<CFFILE ACTION=Read FILE="#systemPath#\system\mailAuctionHeader.cfm" VARIABLE="mailAuctionHeader">
<CFSET mailAuctionHeader = RTrim(mailAuctionHeader)>
<DT><FONT FACE="Arial">Header of Page: </FONT>
<DD><TEXTAREA NAME=mailAuctionHeader ROWS=6 COLS=70 WRAP=virtual><CFOUTPUT>#mailAuctionHeader#</CFOUTPUT></TEXTAREA>

<P>

<CFFILE ACTION=Read FILE="#systemPath#\system\mailAuctionFooter.cfm" VARIABLE="mailAuctionFooter">
<CFSET mailAuctionFooter = RTrim(mailAuctionFooter)>
<DT><FONT FACE="Arial">Footer of Page: </FONT>
<DD><TEXTAREA NAME=mailAuctionFooter ROWS=6 COLS=70 WRAP=virtual><CFOUTPUT>#mailAuctionFooter#</CFOUTPUT></TEXTAREA>
</DL>

<P>

<CFFILE ACTION=Read FILE="#systemPath#\system\mailAuctionSuccess.cfm" VARIABLE="mailAuctionSuccess">
<CFSET mailAuctionSuccess = RTrim(mailAuctionSuccess)>
<DT><FONT FACE="Arial">Message After Email Sent: </FONT>
<DD><TEXTAREA NAME=mailAuctionSuccess ROWS=6 COLS=70 WRAP=virtual><CFOUTPUT>#mailAuctionSuccess#</CFOUTPUT></TEXTAREA>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH COLSPAN=2><FONT COLOR=purple SIZE=4 FACE="Arial">Error Messages</FONT></TH></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No lot defined: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionNoLot SIZE=50 VALUE="#mailAuctionNoLot#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Invalid lot defined: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionBlankLot SIZE=50 VALUE="#mailAuctionBlankLot#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bad Login: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionBadLogin SIZE=50 VALUE="#mailAuctionBadLogin#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Blank Username: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionBlankUsername SIZE=50 VALUE="#mailAuctionBlankUsername#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Blank Password: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionBlankPassword SIZE=50 VALUE="#mailAuctionBlankPassword#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Blank Recipient Email: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionBlankRecipient SIZE=50 VALUE="#mailAuctionBlankRecipient#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Invalid Recipient Email: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionBadRecipient SIZE=50 VALUE="#mailAuctionBadRecipient#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>User Not Approved: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=mailAuctionBadStatus SIZE=50 VALUE="#mailAuctionBadStatus#"></TD></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">

</CFFORM>

</BODY>
</HTML>
