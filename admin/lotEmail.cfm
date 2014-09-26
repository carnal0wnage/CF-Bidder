<!--- Emaze Auction version 2.1, 1.03 / Thursday, July 15, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF IsDefined("Form.first")>
	<CFQUERY NAME=getLotName DATASOURCE="#EAdatasource#">
		SELECT lotName, categoryID FROM Lot WHERE lotID = #Form.lotID#
	</CFQUERY>

	<CFIF Form.bidder EQ "winner">
		<CFSET bidderBidWin = 1>
	<CFELSE>
		<CFSET bidderBidWin = 0>
	</CFIF>	

	<CFQUERY NAME=getBidders DATASOURCE="#EAdatasource#">
		SELECT Bid.bidPrice, Bid.bidQuantity, Member.email
		FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
		WHERE Bid.lotID = #Form.lotID# AND Bid.bidWin = #bidderBidWin#
		<CFIF NOT IsDefined("Form.sendToAll")>AND Member.userEmailEvents LIKE '%#Form.bidder#%'</CFIF>
	</CFQUERY>

	<CFIF Form.fromname NEQ "" AND Form.fromname NEQ " ">
		<CFSET fromemail = "#Form.fromemail# (#Form.fromname#)">
	</CFIF>
	<CFINCLUDE TEMPLATE="../email/emailAdminLotEmail.cfm">

	<CFSET categoryID = Form.categoryID>
	<CFINCLUDE TEMPLATE="categoryLots.cfm">
	<CFABORT>
</CFIF>

<HTML>
<HEAD><TITLE>Emaze Auction: Email Winners/Losers</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<FONT COLOR=purple SIZE=6><B>
<CFIF bidder EQ "winner">Email Winners<CFELSE>Email Losers</CFIF>
</B></FONT>

<CFQUERY NAME=getLotName DATASOURCE="#EAdatasource#">
	SELECT lotName, categoryID FROM Lot WHERE lotID = #lotID#
</CFQUERY>

<CFFORM METHOD=post ACTION=lotEmail.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>
<CFOUTPUT>
	<INPUT TYPE=hidden NAME=lotID VALUE=#lotID#>
	<INPUT TYPE=hidden NAME=categoryID VALUE="#getLotName.categoryID#">
	<INPUT TYPE=hidden NAME=bidder VALUE=#bidder#>
</CFOUTPUT>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">
<CFINCLUDE TEMPLATE="../system/emailClose.cfm">

<TR><TD ALIGN=right>From name: </TD>
	<TD><CFINPUT TYPE=text NAME=fromname SIZE=30 VALUE="#e_fromnameClose#"> <FONT SIZE=2>(leave blank for no name)</FONT></TD></TR>
<TR><TD ALIGN=right>From email: </TD>
	<TD><CFINPUT TYPE=text NAME=fromemail SIZE=30 REQUIRED="Yes" MESSAGE="From email cannot be blank." VALUE="#e_fromemailClose#"></TD></TR>

<CFIF bidder EQ "winner">
	<TR><TD ALIGN=right>Subject: </TD>
		<TD><CFINPUT TYPE=text NAME=subject SIZE=40 REQUIRED="Yes" MESSAGE="Subject field cannot be blank." VALUE="#e_subjectWinner#"></TD></TR>
	<TR><TD ALIGN=right VALIGN=top>Message: </TD>
		<TD><TEXTAREA NAME=message ROWS=10 COLS=55 WRAP=virtual><CFOUTPUT>Lot ###lotID#
#getLotName.lotName#</CFOUTPUT>
</TEXTAREA></TD></TR>

<CFELSE><!--- IF bidder EQ "loser" --->
	<TR><TD ALIGN=right>Subject: </TD>
		<TD><CFINPUT TYPE=text NAME=subject SIZE=40 REQUIRED="Yes" MESSAGE="Subject field cannot be blank." VALUE="#e_subjectLoser#"></TD></TR>
	<TR><TD ALIGN=right VALIGN=top>Message: </TD>
		<TD><TEXTAREA NAME=message ROWS=10 COLS=55 WRAP=virtual><CFOUTPUT>Lot ###lotID#
#getLotName.lotName#</CFOUTPUT>
</TEXTAREA></TD></TR>
</CFIF>

	<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
	<CFIF bidder EQ "winner" AND ListContains(forcedEmailEventsList,"winner") NEQ 0>
		<CFSET sendToAll = 1>
	<CFELSEIF bidder EQ "loser" AND ListContains(forcedEmailEventsList,"loser") NEQ 0>
		<CFSET sendToAll = 1>
	</CFIF>
	<TR><TD ALIGN=right><INPUT TYPE=checkbox NAME=sendToAll VALUE=1<CFIF IsDefined("sendToAll")> CHECKED</CFIF>></TD>
		<TD>Send email to all <CFOUTPUT>#bidder#</CFOUTPUT>s regardless of user option.</TD></TR>
	<TR><TD COLSPAN=2><INPUT TYPE=reset VALUE="Clear"> <INPUT TYPE=submit VALUE="Send Email"></TD></TR>
</TABLE>
</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>