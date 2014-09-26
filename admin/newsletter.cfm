<!--- Emaze Auction version 2.1, 1.02 / Wednesday, June 30, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">
<HTML>
<HEAD><TITLE>Emaze Auction: Send Newsletter</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<FONT COLOR=purple SIZE=6><B>Send Newsletter</B></FONT>

<CFIF IsDefined("Form.first")>
	<CFQUERY NAME=getSubscribers DATASOURCE="#EAdatasource#">
		SELECT email FROM Member
	</CFQUERY>
	<CFINCLUDE TEMPLATE="../email/emailNewsletter.cfm">

	<H1>Newsletter successfully sent!</H1>

	<CFFILE ACTION=Write FILE="#systemPath#\system\newsletterLastSent.cfm"
		OUTPUT="<CFSET newsletterLastSent = ""#CreateODBCDateTime(Now())#"">">

	<CFSET e_fromemailNewsletter = Replace(Form.e_fromemailNewsletter, """", "&quot;", "ALL")>
	<CFSET e_fromnameNewsletter = Replace(Form.e_fromnameNewsletter, """", "&quot;", "ALL")>
	<CFSET e_subjectNewsletter = Replace(Form.e_subjectNewsletter, """", "&quot;", "ALL")>

	<CFSET e_fromemailNewsletter = Replace(e_fromemailNewsletter, "##", "####", "ALL")>
	<CFSET e_fromnameNewsletter = Replace(e_fromnameNewsletter, "##", "####", "ALL")>
	<CFSET e_subjectNewsletter = Replace(e_subjectNewsletter, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\newsletterOptions.cfm"
		OUTPUT="<CFSET e_fromemailNewsletter = ""#e_fromemailNewsletter#"">
<CFSET e_fromnameNewsletter = ""#e_fromnameNewsletter#"">
<CFSET e_subjectNewsletter = ""#e_subjectNewsletter#"">">

	Below is a list of the subscribers to which the newsletter has been sent:<P>
	<CFOUTPUT QUERY="getSubscribers">#email#<BR></CFOUTPUT>
	</BODY></HTML><CFABORT>
</CFIF>

<CFINCLUDE TEMPLATE="../system/newsletterOptions.cfm">
<CFINCLUDE TEMPLATE="../system/newsletterLastSent.cfm">

<P><FONT SIZE=4>Newsletter last sent on <CFOUTPUT>#DateFormat(newsletterLastSent,"dddd, mmmm dd, yyyy")# at #TimeFormat(newsletterLastSent,"hh:mm tt")#</CFOUTPUT></FONT><P>

<CFFORM METHOD=post ACTION=newsletter.cfm?RequestTimeout=500>
<INPUT TYPE=hidden NAME=first VALUE=1>

<CFIF FileExists("#systemPath#\system\newsletterOptions.cfm")>
	<CFINCLUDE TEMPLATE="../system/newsletterOptions.cfm">
<CFELSE>
	<CFSET e_fromemailNewsletter = "">
	<CFSET e_fromnameNewsletter = "">
	<CFSET e_subjectNewsletter = "Auction Newsletter">
</CFIF>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD ALIGN=right>From name: </TD>
	<TD><CFINPUT TYPE=text NAME=e_fromnameNewsletter SIZE=30 VALUE="#e_fromnameNewsletter#"> <FONT SIZE=2>(leave blank for no name)</FONT></TD></TR>
<TR><TD ALIGN=right>From email: </TD>
	<TD><CFINPUT TYPE=text NAME=e_fromemailNewsletter SIZE=30 REQUIRED="Yes" MESSAGE="From email cannot be blank." VALUE="#e_fromemailNewsletter#"></TD></TR>
<TR><TD ALIGN=right>Subject: </TD>
	<TD><CFINPUT TYPE=text NAME=e_subjectNewsletter SIZE=40 REQUIRED="Yes" MESSAGE="Subject field cannot be blank." VALUE="#e_subjectNewsletter#"></TD></TR>
<TR><TD ALIGN=right VALIGN=top>Message: </TD>

<CFINCLUDE TEMPLATE="../system/newsletterLastSent.cfm">
<CFQUERY NAME=getNewLots DATASOURCE="#EAdatasource#">
	SELECT lotID, lotName, lotOpeningBid, lotCloseDateTime
	FROM Lot
	WHERE lotDateTimeCreated >= #newsletterLastSent#
		AND lotCloseQueue <> -1
	ORDER BY lotName
</CFQUERY>

<TD><TEXTAREA NAME=message ROWS=20 COLS=55 WRAP=virtual>Below are the new lots posted since the last newsletter:

<CFOUTPUT QUERY=getNewLots>Item: #lotName#
Opening Bid: #LSCurrencyFormat(lotOpeningBid,"local")#
Closes: #LSDateFormat(lotCloseDateTime,'dddd, mmmm dd, yyyy')# / #LSTimeFormat(lotCloseDateTime,'hh:mm tt')#
#systemURL#/lot.cfm?lotID=#lotID#

</CFOUTPUT>

</TEXTAREA></TD></TR>

<TR><TD COLSPAN=2><INPUT TYPE=reset VALUE="Clear"> <INPUT TYPE=submit VALUE="Send Newsletter"></TD></TR>
</TABLE>
</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>
