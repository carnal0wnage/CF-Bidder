<!--- Emaze Auction version 2.1, 1.01 / Monday, September 20, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Emails</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFSET e_subjectReserveMetCode = Replace(Form.e_subjectReserveMet, "##", "####", "ALL")>
	<CFSET e_subjectReserveNotMetCode = Replace(Form.e_subjectReserveNotMet, "##", "####", "ALL")>
	<CFSET e_subjectReserveExtendedCode = Replace(Form.e_subjectReserveExtended, "##", "####", "ALL")>
	<CFSET e_subjectReserveNotExtendedCode = Replace(Form.e_subjectReserveNotExtended, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\emailSubjectReserve.cfm"
		OUTPUT="<CFPARAM NAME=""getCheckList.lotID"" DEFAULT=1>
<CFSET e_subjectReserveExtended = ""#Form.e_subjectReserveExtended#"">
<CFSET e_subjectReserveExtendedCode = ""#e_subjectReserveExtendedCode#"">
<CFPARAM NAME=""lotID"" DEFAULT=1>
<CFSET e_subjectReserveNotExtended = ""#Form.e_subjectReserveNotExtended#"">
<CFSET e_subjectReserveNotExtendedCode = ""#e_subjectReserveNotExtendedCode#"">
<CFSET e_subjectReserveMet = ""#Form.e_subjectReserveMet#"">
<CFSET e_subjectReserveMetCode = ""#e_subjectReserveMetCode#"">
<CFSET e_subjectReserveNotMet = ""#Form.e_subjectReserveNotMet#"">
<CFSET e_subjectReserveNotMetCode = ""#e_subjectReserveNotMetCode#"">
<CFSET e_subjectReserveMetLoser = ""#Form.e_subjectReserveMetLoser#"">
<CFSET e_subjectReserveExtWinner = ""#Form.e_subjectReserveExtWinner#"">
<CFSET e_subjectReserveExtLoser = ""#Form.e_subjectReserveExtLoser#"">
<CFSET e_subjectReserveCloseWinner = ""#Form.e_subjectReserveCloseWinner#"">
<CFSET e_subjectReserveCloseLoser = ""#Form.e_subjectReserveCloseLoser#"">">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailBidReserveMet.cfm" OUTPUT="
<CFINCLUDE TEMPLATE=""../system/emailBid.cfm"">
<CFIF e_fromnameBid NEQ """" AND e_fromnameBid NEQ "" "">
	<CFSET e_fromemailBid = ""##e_fromemailBid## (##e_fromnameBid##)"">
</CFIF>

<CFMAIL TO=""##lotContactEmail##""
	FROM=""##e_fromemailBid##""
	SUBJECT=""#e_subjectReserveMet#""
	SERVER=""##emailServer##"">
#emailReserveMet#

</CFMAIL>">

	<CFIF Form.emailReserveMet EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveMet.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveMet = Replace(Form.emailReserveMet, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveMet.cfm" OUTPUT="#emailReserveMet#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseReserveNotMet.cfm" OUTPUT="
<CFMAIL	TO=""##getLotInfo.lotContactEmail##""
	FROM=""##e_fromemailClose##""
	SUBJECT=""#e_subjectReserveNotMet#""
	SERVER=""##emailServer##"">
#emailReserveNotMet#

</CFMAIL>">

	<CFIF Form.emailReserveNotMet EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveNotMet.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveNotMet = Replace(Form.emailReserveNotMet, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveNotMet.cfm" OUTPUT="#emailReserveNotMet#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailBidReserveMetLoser.cfm" OUTPUT="
<CFINCLUDE TEMPLATE=""../system/emailEventsList.cfm"">
<CFQUERY NAME=getLosers DATASOURCE=""##EAdatasource##"">
	SELECT Bid.bidAuto, Bid.bidPriceMaximum, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = ##Form.lotID##
		AND Bid.userID <> ##bidderUserID##
	<CFIF ListFind(forcedEmailEventsList,""outbid"") EQ 0>AND Member.userEmailEvents LIKE '%outbid%'</CFIF>
</CFQUERY>

<CFIF getLosers.RecordCount NEQ 0>
	<CFINCLUDE TEMPLATE=""../system/emailBid.cfm"">
	<CFINCLUDE TEMPLATE=""../system/emailEventsList.cfm"">
	<CFIF e_fromnameBid NEQ """" AND e_fromnameBid NEQ "" "">
		<CFSET e_fromemailBid = ""##e_fromemailBid## (##e_fromnameBid##)"">
	</CFIF>

	<CFMAIL QUERY=""getLosers""
		FROM=""##e_fromemailBid##""
		TO=""##getLosers.email##""
		SUBJECT=""#e_subjectReserveMetLoser#""
		SERVER=""##emailServer##"">
#emailReserveMetLoser#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailReserveMetLoser EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveMetLoser.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveMetLoser = Replace(Form.emailReserveMetLoser, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveMetLoser.cfm" OUTPUT="#emailReserveMetLoser#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCheckReserveExtWin.cfm" OUTPUT="
<CFQUERY NAME=getReserveWinner DATASOURCE=""##EAdatasource##"">
	SELECT Bid.bidPrice, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = ##getCheckList.lotID## AND Bid.bidWin = 1
	<CFIF ListFind(forcedEmailEventsList,""winner"") EQ 0>AND Member.userEmailEvents LIKE '%winner%'</CFIF>
</CFQUERY>

<CFIF getReserveWinner.RecordCount NEQ 0>
	<CFINCLUDE TEMPLATE=""../system/emailClose.cfm"">
	<CFIF e_fromnameClose NEQ """" AND e_fromnameClose NEQ "" "">
		<CFSET e_fromemailClose = ""##e_fromemailClose## (##e_fromnameClose##)"">
	</CFIF>

	<CFMAIL QUERY=""getReserveWinner""
		TO=""##getReserveWinner.email##""
		FROM=""##e_fromemailClose##""
		SUBJECT=""#e_subjectReserveExtWinner#""
		SERVER=""##emailServer##"">
#emailReserveExtWinner#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailReserveExtWinner EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveExtWinner.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveExtWinner = Replace(Form.emailReserveExtWinner, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveExtWinner.cfm" OUTPUT="#emailReserveExtWinner#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCheckReserveExtLoser.cfm" OUTPUT="
<CFQUERY NAME=getReserveLoser DATASOURCE=""##EAdatasource##"">
	SELECT Bid.bidPrice, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = ##getCheckList.lotID## AND Bid.bidWin = 0
	<CFIF ListFind(forcedEmailEventsList,""loser"") EQ 0>AND Member.userEmailEvents LIKE '%loser%'</CFIF>
</CFQUERY>

<CFIF getReserveLoser.RecordCount NEQ 0>
	<CFINCLUDE TEMPLATE=""../system/emailClose.cfm"">
	<CFIF e_fromnameClose NEQ """" AND e_fromnameClose NEQ "" "">
		<CFSET e_fromemailClose = ""##e_fromemailClose## (##e_fromnameClose##)"">
	</CFIF>

	<CFMAIL QUERY=""getReserveLoser""
		TO=""##getReserveLoser.email##""
		FROM=""##e_fromemailClose##""
		SUBJECT=""#e_subjectReserveExtLoser#""
		SERVER=""##emailServer##"">
#emailReserveExtLoser#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailReserveExtLoser EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveExtLoser.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveExtLoser = Replace(Form.emailReserveExtLoser, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveExtLoser.cfm" OUTPUT="#emailReserveExtLoser#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseReserveNotMetWin.cfm" OUTPUT="
<CFQUERY NAME=getWinningBids DATASOURCE=""##EAdatasource##"">
	SELECT Bid.bidPrice, Bid.bidQuantity, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = ##lotID## AND Bid.bidWin = 1
	<CFIF ListFind(forcedEmailEventsList,""loser"") EQ 0>AND Member.userEmailEvents LIKE '%loser%'</CFIF>
</CFQUERY>

<CFIF getWinningBids.RecordCount NEQ 0>
	<CFMAIL QUERY=""getWinningBids""
		TO=""##getWinningBids.email##""
		FROM=""##e_fromemailClose##""
		SUBJECT=""#e_subjectReserveCloseWinner#""
		SERVER=""##emailServer##"">
#emailReserveCloseWinner#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailReserveCloseWinner EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveCloseWinner.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveCloseWinner = Replace(Form.emailReserveCloseWinner, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveCloseWinner.cfm" OUTPUT="#emailReserveCloseWinner#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseReserveLoser.cfm" OUTPUT="
<CFQUERY NAME=getLosingBids DATASOURCE=""##EAdatasource##"">
	SELECT Member.email, Bid.bidQuantity, Bid.bidPrice
	FROM Member INNER JOIN Bid ON Member.userID = Bid.userID
	WHERE Bid.lotID = ##lotID## AND Bid.bidWin = 0
	<CFIF ListFind(forcedEmailEventsList,""loser"") EQ 0>AND Member.userEmailEvents LIKE '%loser%'</CFIF>
</CFQUERY>

<CFIF getLosingBids.RecordCount NEQ 0>
	<CFMAIL QUERY=""getLosingBids""
		TO=""##getLosingBids.email##""
		FROM=""##e_fromemailClose##""
		SUBJECT=""#e_subjectReserveCloseLoser#""
		SERVER=""##emailServer##"">
#emailReserveCloseLoser#

	</CFMAIL>
</CFIF>">

	<CFIF Form.emailReserveCloseLoser EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveCloseLoser.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveCloseLoser = Replace(Form.emailReserveCloseLoser, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveCloseLoser.cfm" OUTPUT="#emailReserveCloseLoser#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCheckReserveExt.cfm" OUTPUT="
<CFINCLUDE TEMPLATE=""../system/emailClose.cfm"">
<CFIF e_fromnameClose NEQ """" AND e_fromnameClose NEQ "" "">
	<CFSET e_fromemailClose = ""##e_fromemailClose## (##e_fromnameClose##)"">
</CFIF>

<CFMAIL TO=""##getCheckList.lotContactEmail##""
	FROM=""##e_fromemailClose##""
	SUBJECT=""#e_subjectReserveExtended#""
	SERVER=""##emailServer##"">
#emailReserveNotMetExt#

</CFMAIL>">

	<CFIF Form.emailReserveNotMetExt EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveNotMetExt.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveNotMetExt = Replace(Form.emailReserveNotMetExt, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveNotMetExt.cfm" OUTPUT="#emailReserveNotMetExt#">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailCloseReserveNotMetExtMax.cfm" OUTPUT="
<CFMAIL	TO=""##getLotInfo.lotContactEmail##""
	FROM=""##e_fromemailClose##""
	SUBJECT=""#e_subjectReserveNotExtended#""
	SERVER=""##emailServer##"">
#emailReserveNotMetExtMax#

</CFMAIL>">

	<CFIF Form.emailReserveNotMetExtMax EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveNotMetExtMax.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET emailReserveNotMetExtMax = Replace(Form.emailReserveNotMetExtMax, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\emailReserveNotMetExtMax.cfm" OUTPUT="#emailReserveNotMetExtMax#">
	</CFIF>

	<H3>Reserve emails updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Emails - Reserve Price</B></FONT>

<CFINCLUDE TEMPLATE="../system/emailSubjectReserve.cfm">

<P>To update the email options, make the changes and then click on the submit button at the bottom of the page. Each email will automatically include the lot name and the appropriate bidding information.
<P>

<CFFORM ACTION=emailsReserve.cfm NAME=emailsReserve>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Reserve Price Met</B> (notify admin or seller that reserve price has been met)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveMet SIZE=55 VALUE="#e_subjectReserveMetCode#" REQUIRED="Yes" MESSAGE="You must enter a subject for the reserve price met email"></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveMet.cfm" VARIABLE="emailReserveMet">
<CFSET emailReserveMet = RTrim(emailReserveMet)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailReserveMet ROWS=8 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveMet#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Reserve Price Not Met</B> (notify admin or seller after lot closes that reserve price was not met)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveNotMet SIZE=55 VALUE="#e_subjectReserveNotMetCode#" REQUIRED="Yes" MESSAGE="You must enter a subject for the reserve price met email"></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveNotMet.cfm" VARIABLE="emailReserveNotMet">
<CFSET emailReserveNotMet = RTrim(emailReserveNotMet)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailReserveNotMet ROWS=8 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveNotMet#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Reserve Price Met - Loser</B> (notify losing bidders that reserve price has been met)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveMetLoser SIZE=40 VALUE="#e_subjectReserveMetLoser#" REQUIRED="Yes" MESSAGE="You must enter a subject for the reserve price met email to losers."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveMetLoser.cfm" VARIABLE="emailReserveMetLoser">
<CFSET emailReserveMetLoser = RTrim(emailReserveMetLoser)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailReserveMetLoser ROWS=8 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveMetLoser#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Lot Closed - Winner</B> (winning bid, but still less than reserve price)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveCloseWinner SIZE=40 VALUE="#e_subjectReserveCloseWinner#" REQUIRED="Yes" MESSAGE="You must enter a subject for the lot closed, winner email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveCloseWinner.cfm" VARIABLE="emailReserveCloseWinner">
<CFSET emailReserveCloseWinner = RTrim(emailReserveCloseWinner)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailReserveCloseWinner ROWS=8 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveCloseWinner#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Lot Closed -  Loser</B> (losing bid, but winning bid less than reserve price)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveCloseLoser SIZE=40 VALUE="#e_subjectReserveCloseLoser#" REQUIRED="Yes" MESSAGE="You must enter a subject for the lot closed, loser email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveCloseLoser.cfm" VARIABLE="emailReserveCloseLoser">
<CFSET emailReserveCloseLoser = RTrim(emailReserveCloseLoser)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailReserveCloseLoser ROWS=8 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveCloseLoser#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P><BR>

<BLOCKQUOTE>The following emails are only used if the option to extend the lot closing time has been turned on in the <I>Closing Options</I> page for the Reserve Not Met option. This includes extended the closing time and emailing the lot contact person. If these options are not checked and the lot closes with the reserve price not being met, then the above <I>Reserve Price Not Met</I> email will be sent instead.</BLOCKQUOTE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Closing Time Extended - Winner</B> (winning bid, but still less than reserve price)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveExtWinner SIZE=40 VALUE="#e_subjectReserveExtWinner#" REQUIRED="Yes" MESSAGE="You must enter a subject for the closing time extended, winner email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveExtWinner.cfm" VARIABLE="emailReserveExtWinner">
<CFSET emailReserveExtWinner = RTrim(emailReserveExtWinner)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailReserveExtWinner ROWS=8 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveExtWinner#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Closing Time Extended - Loser</B> (losing bid, but winning bid less than reserve price)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveExtLoser SIZE=40 VALUE="#e_subjectReserveExtLoser#" REQUIRED="Yes" MESSAGE="You must enter a subject for the closing time extended, loser email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveExtLoser.cfm" VARIABLE="emailReserveExtLoser">
<CFSET emailReserveExtLoser = RTrim(emailReserveExtLoser)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
	<TD><TEXTAREA NAME=emailReserveExtLoser ROWS=8 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveExtLoser#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Reserve not met - closing time extended</B> (to admin/seller)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveExtended SIZE=60 VALUE="#e_subjectReserveExtendedCode#" REQUIRED="Yes" MESSAGE="You must enter a subject for the closing time extended email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveNotMetExt.cfm" VARIABLE="emailReserveNotMetExt">
<CFSET emailReserveNotMetExt = RTrim(emailReserveNotMetExt)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
<TD><TEXTAREA NAME=emailReserveNotMetExt ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveNotMetExt#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2><B>Reseve not met - closing time <I>not</I> extended as maximum extensions has been reached</B> (to admin/seller)</TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
<TD><CFINPUT TYPE=text NAME=e_subjectReserveNotExtended SIZE=60 VALUE="#e_subjectReserveNotExtendedCode#" REQUIRED="Yes" MESSAGE="You must enter a subject for the closing time not extended email."></TD></TR>
<CFFILE ACTION=Read FILE="#systemPath#\system\emailReserveNotMetExtMax.cfm" VARIABLE="emailReserveNotMetExtMax">
<CFSET emailReserveNotMetExtMax = RTrim(emailReserveNotMetExtMax)>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>
<TD><TEXTAREA NAME=emailReserveNotMetExtMax ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#emailReserveNotMetExtMax#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Reserve Email">
</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</>
</HTML>