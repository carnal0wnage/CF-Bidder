<!--- Emaze Auction version 2.1, 1.03 / Monday, September 20, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Bidding Emails</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFFILE ACTION=Write FILE="#systemPath#\system\emailBid.cfm"
		OUTPUT="<CFSET e_fromnameBid = ""#Form.e_fromnameBid#"">
<CFSET e_fromemailBid = ""#Form.e_fromemailBid#"">
<CFSET e_subjectOutbid = ""#Form.e_subjectOutbid#"">
<CFSET e_subjectLoseWin = ""#Form.e_subjectLoseWin#"">
<CFSET e_subjectQuantity = ""#Form.e_subjectQuantity#"">
<CFSET e_subjectAutobid = ""#Form.e_subjectAutobid#"">">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailBidOutbid.cfm" OUTPUT="
<CFMAIL TO=""##getBids.email##""
	FROM=""##e_fromemailBid##""
	SUBJECT=""#e_subjectOutbid#""
	SERVER=""##emailServer##"">
#emailOutbid#

</CFMAIL>">

	<CFIF Form.emailOutbid EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailOutbid.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailOutbid = Replace(Form.emailOutbid, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailOutbid.cfm" OUTPUT="#emailOutbid#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailBidLoseWin.cfm" OUTPUT="
<CFMAIL TO=""##getBids.email##""
	FROM=""##e_fromemailBid##""
	SUBJECT=""#e_subjectLoseWin#""
	SERVER=""##emailServer##"">
#emailLoseWin#

</CFMAIL>">

	<CFIF Form.emailLoseWin EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailLoseWin.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailLoseWin = Replace(Form.emailLoseWin, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailLoseWin.cfm" OUTPUT="#emailLoseWin#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailBidLoseWinAutobid.cfm" OUTPUT="
<CFMAIL TO=""##getBids.email##""
	FROM=""##e_fromemailBid##""
	SUBJECT=""#e_subjectLoseWin#""
	SERVER=""##emailServer##"">
#emailLoseWinAutobid#

</CFMAIL>">

	<CFIF Form.emailLoseWinAutobid EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailLoseWinAutobid.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailLoseWinAutobid = Replace(Form.emailLoseWinAutobid, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailLoseWinAutobid.cfm" OUTPUT="#emailLoseWinAutobid#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailBidQuantity.cfm" OUTPUT="
<CFMAIL TO=""##getBids.email##""
	FROM=""##e_fromemailBid##""
	SUBJECT=""#e_subjectQuantity#""
	SERVER=""##emailServer##"">
#emailQuantity#

</CFMAIL>">

	<CFIF Form.emailQuantity EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailQuantity.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailQuantity = Replace(Form.emailQuantity, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailQuantity.cfm" OUTPUT="#emailQuantity#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailBidQtyAutobid.cfm" OUTPUT="
<CFMAIL TO=""##getBids.email##""
	FROM=""##e_fromemailBid##""
	SUBJECT=""#e_subjectQuantity#""
	SERVER=""##emailServer##"">
#emailQuantityAutobid#

</CFMAIL>">

	<CFIF Form.emailQuantityAutobid EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailQuantityAutobid.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailQuantityAutobid = Replace(Form.emailQuantityAutobid, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailQuantityAutobid.cfm" OUTPUT="#emailQuantityAutobid#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailBidAutobid.cfm" OUTPUT="
<CFMAIL TO=""##getBids.email##""
	FROM=""##e_fromemailBid##""
	SUBJECT=""#e_subjectAutobid#""
	SERVER=""##emailServer##"">
#emailAutobid#

</CFMAIL>">

	<CFIF Form.emailAutobid EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailAutobid.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailAutobid = Replace(Form.emailAutobid, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailAutobid.cfm" OUTPUT="#emailAutobid#">
	</CFIF>

	<H3>Bidding emails updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Bidding Emails</B></FONT>

<CFINCLUDE TEMPLATE="../system/emailBid.cfm">

<P>To update the email options, make the changes and then click on the submit button at the bottom of the page. Each email will automatically include the lot name and the appropriate bidding information.
<P>

<CFFORM ACTION=emailsBidding.cfm NAME=emailsBidding>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH BGCOLOR=FFFFCE>Email</TH>
	<TH BGCOLOR=FFFFCE>From Name</TH>
	<TH BGCOLOR=FFFFCE>Reply-to Email</TH></TR>
<TR><TD>Bid Status</TD>
	<TD><CFINPUT TYPE=text NAME=e_fromnameBid SIZE=25 VALUE="#e_fromnameBid#"> <FONT SIZE=2>(leave blank for no name)</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=e_fromemailBid SIZE=25 VALUE="#e_fromemailBid#" REQUIRED="Yes" MESSAGE="You must enter a from email address."></TD></TR>
</TABLE>

<P>

<DL>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Outbid</B> (need to raise bid to win)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectOutbid SIZE=40 VALUE="#e_subjectOutbid#" REQUIRED="Yes" MESSAGE="You must enter a subject for the outbid email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailOutbid.cfm" VARIABLE="emailOutbid">
<CFSET emailOutbid = RTrim(emailOutbid)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailOutbid ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailOutbid#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Losing Bid Wins Again</B> (former losing bid is now a winning bid)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectLoseWin SIZE=40 VALUE="#e_subjectLoseWin#" REQUIRED="Yes" MESSAGE="You must enter a subject for the previously losing, but now winning email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailLoseWin.cfm" VARIABLE="emailLoseWin">
<CFSET emailLoseWin = RTrim(emailLoseWin)>
<TR><TD ALIGN=right VALIGN=top>Message:<BR>(fixed bid)</TD>
	<TD><TEXTAREA NAME=emailLoseWin ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailLoseWin#</CFOUTPUT></TEXTAREA></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailLoseWinAutobid.cfm" VARIABLE="emailLoseWinAutobid">
<CFSET emailLoseWinAutobid = RTrim(emailLoseWinAutobid)>
<TR><TD ALIGN=right VALIGN=top>Message: <BR>(auto bid)</TD>
	<TD><TEXTAREA NAME=emailLoseWinAutobid ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailLoseWinAutobid#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Losing Quantity</B> (will only win partial quantity with current bid)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
	<TD><CFINPUT TYPE=text NAME=e_subjectQuantity SIZE=40 VALUE="#e_subjectQuantity#" REQUIRED="Yes" MESSAGE="You must enter a subject for the losing quantity email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailQuantity.cfm" VARIABLE="emailQuantity">
<CFSET emailQuantity = RTrim(emailQuantity)>
<TR><TD ALIGN=right VALIGN=top>Message: <BR>(fixed bid)</TD>
	<TD><TEXTAREA NAME=emailQuantity ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailQuantity#</CFOUTPUT></TEXTAREA></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailQuantityAutobid.cfm" VARIABLE="emailQuantityAutobid">
<CFSET emailQuantityAutobid = RTrim(emailQuantityAutobid)>
<TR><TD ALIGN=right VALIGN=top>Message: <BR>(auto bid)</TD>
	<TD><TEXTAREA NAME=emailQuantityAutobid ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailQuantityAutobid#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Auto Bid</B> (your bid was automatically increased)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
	<TD><CFINPUT TYPE=text NAME=e_subjectAutobid SIZE=40 VALUE="#e_subjectAutobid#" REQUIRED="Yes" MESSAGE="You must enter a subject for the auto bid email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailAutobid.cfm" VARIABLE="emailAutobid">
<CFSET emailAutobid = RTrim(emailAutobid)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailAutobid ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailAutobid#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Email Options">
</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>