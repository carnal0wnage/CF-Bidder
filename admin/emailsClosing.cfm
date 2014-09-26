<!--- Emaze Auction version 2.1, 1.05 / Monday, September 20, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Closing Emails</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFSET e_subjectCloseAdminCode = Replace(Form.e_subjectCloseAdmin, "##", "####", "ALL")>
	<CFSET e_subjectCloseNoBidsCode = Replace(Form.e_subjectCloseNoBids, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\emailClose.cfm"
		OUTPUT="<CFPARAM NAME=lotID DEFAULT=1>
<CFSET e_subjectCloseAdmin = ""#Form.e_subjectCloseAdmin#"">
<CFSET e_subjectCloseAdminCode = ""#e_subjectCloseAdminCode#"">
<CFSET e_subjectCloseNoBids = ""#Form.e_subjectCloseNoBids#"">
<CFSET e_subjectCloseNoBidsCode = ""#e_subjectCloseNoBidsCode#"">
<CFSET e_fromnameClose = ""#Form.e_fromnameClose#"">
<CFSET e_fromemailClose = ""#Form.e_fromemailClose#"">
<CFSET e_subjectWinner = ""#Form.e_subjectWinner#"">
<CFSET e_subjectLoser = ""#Form.e_subjectLoser#"">">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseAdmin.cfm" OUTPUT="
<CFMAIL TO=""##getLotInfo.lotContactEmail##""
	FROM=""##e_fromemailClose##""
	SUBJECT=""#e_subjectCloseAdmin#""
	SERVER=""##emailServer##"">
#emailAdmin#

</CFMAIL>">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseAdminWinners.cfm" OUTPUT="
<CFQUERY NAME=getAdminWinners DATASOURCE=""##EAdatasource##"">
	SELECT Bid.bidPrice, Bid.bidQuantityWin, Member.firstName, Member.lastName, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = ##lotID## AND Bid.bidWin = 1
	ORDER BY Bid.bidPrice, Bid.bidQuantityWin
</CFQUERY>

<CFIF getAdminWinners.RecordCount NEQ 0>
	<CFMAIL	QUERY=""getAdminWinners""
		TO=""##getLotInfo.lotContactEmail##""
		FROM=""##e_fromemailClose##""
		SUBJECT=""#e_subjectCloseAdmin#""
		SERVER=""##emailServer##"">
#emailAdmin#

#emailAdminWinners#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailAdmin EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailAdmin.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailAdmin = Replace(Form.emailAdmin, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailAdmin.cfm" OUTPUT="#emailAdmin#">
	</CFIF>

	<CFIF Form.emailAdminWinners EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailAdminWinners.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailAdminWinners = Replace(Form.emailAdminWinners, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailAdminWinners.cfm" OUTPUT="#emailAdminWinners#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseNoBids.cfm" OUTPUT="
<CFMAIL TO=""##getLotInfo.lotContactEmail##""
	FROM=""##e_fromemailClose##""
	SUBJECT=""#e_subjectCloseNoBids#""
	SERVER=""##emailServer##"">
#emailNoBidsClose#

</CFMAIL>">

	<CFIF Form.emailNoBidsClose EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailNoBidsClose.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailNoBidsClose = Replace(Form.emailNoBidsClose, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailNoBidsClose.cfm" OUTPUT="#emailNoBidsClose#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseWinner.cfm" OUTPUT="
<CFQUERY NAME=getWinningBids DATASOURCE=""##EAdatasource##"">
	SELECT Bid.bidPrice, Bid.bidQuantityWin, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = ##lotID## AND Bid.bidWin = 1
	<CFIF ListFind(forcedEmailEventsList,""winner"") EQ 0>AND Member.userEmailEvents LIKE '%winner%'</CFIF>
</CFQUERY>

<CFIF getWinningBids.RecordCount NEQ 0>
	<CFMAIL QUERY=""getWinningBids""
		TO=""##getWinningBids.email##""
		FROM=""##e_fromemailClose##""
		SUBJECT=""#e_subjectWinner#""
		SERVER=""##emailServer##"">
#emailWinner#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailWinner EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailWinner.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailWinner = Replace(Form.emailWinner, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailWinner.cfm" OUTPUT="#emailWinner#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseLoser.cfm" OUTPUT="
<CFQUERY NAME=getLosingBids DATASOURCE=""##EAdatasource##"">
	SELECT Bid.bidPrice, Bid.bidQuantity, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = ##lotID## AND Bid.bidWin = 0
	<CFIF ListFind(forcedEmailEventsList,""loser"") EQ 0>AND Member.userEmailEvents LIKE '%loser%'</CFIF>
	<CFIF NOT IsDefined(""emailAllLosers"")>AND Bid.bidWin = 0</CFIF>
</CFQUERY>

<CFIF getLosingBids.RecordCount NEQ 0>
	<CFMAIL QUERY=""getLosingBids""
		TO=""##getLosingBids.email##""
		FROM=""##e_fromemailClose##""
		SUBJECT=""#e_subjectLoser#""
		SERVER=""##emailServer##"">
#emailLoser#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailLoser EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailLoser.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailLoser = Replace(Form.emailLoser, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailLoser.cfm" OUTPUT="#emailLoser#">
	</CFIF>

	<CFSET e_subjectNoBidsExtendedCode = Replace(Form.e_subjectNoBidsExtended, "##", "####", "ALL")>
	<CFSET e_subjectNoBidsNotExtendedCode = Replace(Form.e_subjectNoBidsNotExtended, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\emailSubjectNoBids.cfm"
		OUTPUT="<CFPARAM NAME=""getCheckList.lotID"" DEFAULT=1>
<CFSET e_subjectNoBidsExtended = ""#Form.e_subjectNoBidsExtended#"">
<CFSET e_subjectNoBidsExtendedCode = ""#e_subjectNoBidsExtendedCode#"">
<CFPARAM NAME=""lotID"" DEFAULT=1>
<CFSET e_subjectNoBidsNotExtended = ""#Form.e_subjectNoBidsNotExtended#"">
<CFSET e_subjectNoBidsNotExtendedCode = ""#e_subjectNoBidsNotExtendedCode#"">">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCheckNoBidsExtended.cfm" OUTPUT="
<CFMAIL TO=""##getCheckList.lotContactEmail##""
	FROM=""##e_fromemailClose##""
	SUBJECT=""#e_subjectNoBidsExtended#""
	SERVER=""##emailServer##"">
#emailNoBidsExtended#

</CFMAIL>">

	<CFIF Form.emailNoBidsExtended EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailNoBidsExtended.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailNoBidsExtended = Replace(Form.emailNoBidsExtended, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailNoBidsExtended.cfm" OUTPUT="#emailNoBidsExtended#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseNoBidsExtendedMax.cfm" OUTPUT="
<CFMAIL TO=""##getLotInfo.lotContactEmail##""
	FROM=""##e_fromemailClose##""
	SUBJECT=""#e_subjectNoBidsNotExtended#""
	SERVER=""##emailServer##"">
#emailNoBidsExtendedMax#

</CFMAIL>">

	<CFIF Form.emailNoBidsExtendedMax EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailNoBidsExtendedMax.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailNoBidsExtendedMax = Replace(Form.emailNoBidsExtendedMax, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailNoBidsExtendedMax.cfm" OUTPUT="#emailNoBidsExtendedMax#">
	</CFIF>

	<H3>Closing emails updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Closing Emails</B></FONT>

<CFINCLUDE TEMPLATE="../system/emailClose.cfm">
<CFINCLUDE TEMPLATE="../system/emailSubjectNoBids.cfm">

<P>To update the email options, make the changes and then click on the submit button at the bottom of the page. Each email will automatically include the lot name and the appropriate bidding information.
<P>

<CFFORM ACTION=emailsClosing.cfm NAME=emailsClosing>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH BGCOLOR=FFFFCE>Email</TH>
	<TH BGCOLOR=FFFFCE>From Name</TH>
	<TH BGCOLOR=FFFFCE>Reply-to Email</TH></TR>
<TR BGCOLOR=DCDCDC><TD>Closing Lot</TD>
	<TD><CFINPUT TYPE=text NAME=e_fromnameClose SIZE=25 VALUE="#e_fromnameClose#"> <FONT SIZE=2>(leave blank for no name)</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=e_fromemailClose SIZE=25 VALUE="#e_fromemailClose#" REQUIRED="Yes" MESSAGE="You must enter a reply-to email address for the email when lots are closed."></TD></TR>
</TABLE>

<P>

<DL>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Lot Closed</B> (email to admin/seller)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectCloseAdmin SIZE=45 VALUE="#e_subjectCloseAdminCode#" REQUIRED="Yes" MESSAGE="You must enter a subject for the email sent when the lot closes"></TD></TR>
</TABLE>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailAdmin.cfm" VARIABLE="emailAdmin">
<CFSET emailAdmin = RTrim(emailAdmin)>
<DT>Message <I>without</I> list of winning bidders (option set in Close Options screen)
<DD><TEXTAREA NAME=emailAdmin ROWS=6 COLS=70 WRAP=virtual><CFOUTPUT>#emailAdmin#</CFOUTPUT></TEXTAREA>
<P>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailAdminWinners.cfm" VARIABLE="emailAdminWinners">
<CFSET emailAdminWinners = RTrim(emailAdminWinners)>
<DT>Additional text for message <I>with</I> list of winning bidders (includes above message)
<DD><TEXTAREA NAME=emailAdminWinners ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailAdminWinners#</CFOUTPUT></TEXTAREA>
</DL>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Lot closed with no bids</B> (email to admin/seller)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectCloseNoBids SIZE=55 VALUE="#e_subjectCloseNoBidsCode#" REQUIRED="Yes" MESSAGE="You must enter a subject for the winner email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailNoBidsClose.cfm" VARIABLE="emailNoBidsClose">
<CFSET emailNoBidsClose = RTrim(emailNoBidsClose)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
<TD><TEXTAREA NAME=emailNoBidsClose ROWS=6 COLS=70 WRAP=virtual><CFOUTPUT>#emailNoBidsClose#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Winner</B> (you won the bidding)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectWinner SIZE=35 VALUE="#e_subjectWinner#" REQUIRED="Yes" MESSAGE="You must enter a subject for the winner email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailWinner.cfm" VARIABLE="emailWinner">
<CFSET emailWinner = RTrim(emailWinner)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
<TD><TEXTAREA NAME=emailWinner ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailWinner#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Loser</B> (you lost the bidding)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectLoser SIZE=40 VALUE="#e_subjectLoser#" REQUIRED="Yes" MESSAGE="You must enter a subject for the loser email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailLoser.cfm" VARIABLE="emailLoser">
<CFSET emailLoser = RTrim(emailLoser)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
<TD><TEXTAREA NAME=emailLoser ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailLoser#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P><BR>

<BLOCKQUOTE>The following emails are only used if the option to extend the lot closing time has been turned on in the <I>Closing Options</I> page for the No Bids options. This includes extended the closing time and emailing the lot contact person. If these options are not checked and the lot closes with no bids, then the above <I>Lot closed with no bids</I> email will be sent instead.</BLOCKQUOTE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>No bids - closing time extended</B> (to admin/seller)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectNoBidsExtended SIZE=60 VALUE="#e_subjectNoBidsExtendedCode#" REQUIRED="Yes" MESSAGE="You must enter a subject for the closing time extended email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailNoBidsExtended.cfm" VARIABLE="emailNoBidsExtended">
<CFSET emailNoBidsExtended = RTrim(emailNoBidsExtended)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
<TD><TEXTAREA NAME=emailNoBidsExtended ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailNoBidsExtended#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>No bids - closing time <I>not</I> extended as maximum extensions has been reached</B> (to admin/seller)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectNoBidsNotExtended SIZE=60 VALUE="#e_subjectNoBidsNotExtendedCode#" REQUIRED="Yes" MESSAGE="You must enter a subject for the closing time not extended email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailNoBidsExtendedMax.cfm" VARIABLE="emailNoBidsExtendedMax">
<CFSET emailNoBidsExtendedMax = RTrim(emailNoBidsExtendedMax)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
<TD><TEXTAREA NAME=emailNoBidsExtendedMax ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailNoBidsExtendedMax#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Email Options">
</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>