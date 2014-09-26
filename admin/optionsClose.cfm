<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Closing Options</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF IsDefined("Form.useScheduler")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\useScheduler.cfm" OUTPUT="<CFSET useScheduler = 1>">
	<CFELSE>
		<CFFILE ACTION=Write FILE="#systemPath#\system\useScheduler.cfm" OUTPUT="<CFSET useScheduler = 0>">
	</CFIF>

	<CFIF IsDefined("Form.closeLotEmailList")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\closeLotEmailList.cfm" OUTPUT="<CFSET closeLotEmailList = ""#closeLotEmailList#"">">
	<CFELSE>
		<CFFILE ACTION=Write FILE="#systemPath#\system\closeLotEmailList.cfm" OUTPUT="<CFSET closeLotEmailList = "" "">">
	</CFIF>

	<CFIF NOT IsDefined("Form.noBidsEmail")><CFSET noBidsEmail = 0></CFIF>
	<CFIF NOT IsDefined("Form.noBidsStayOpen")><CFSET noBidsStayOpen = 0></CFIF>
	<CFFILE ACTION=Write FILE="#systemPath#\system\noBids.cfm"
		OUTPUT="<CFSET noBidsEmail = #noBidsEmail#>
<CFSET noBidsStayOpen = #noBidsStayOpen#>
<CFSET noBidsStayOpenNumber = #Form.noBidsStayOpenNumber#>
<CFSET noBidsStayOpenUnit = ""#Form.noBidsStayOpenUnit#"">
<CFSET noBidsStayOpenTimes = #Form.noBidsStayOpenTimes#>">

	<CFIF NOT IsDefined("Form.reserveMetEmail")><CFSET reserveMetEmail = 0></CFIF>
	<CFIF NOT IsDefined("Form.reserveMetLoserEmail")><CFSET reserveMetLoserEmail = 0></CFIF>
	<CFIF NOT IsDefined("Form.reserveNotMetEmail")><CFSET reserveNotMetEmail = 0></CFIF>
	<CFIF NOT IsDefined("Form.reserveStayOpen")><CFSET reserveStayOpen = 0></CFIF>
	<CFIF NOT IsDefined("Form.reserveExtendedEmailWinners")><CFSET reserveExtendedEmailWinners = 0></CFIF>
	<CFIF NOT IsDefined("Form.reserveExtendedEmailLosers")><CFSET reserveExtendedEmailLosers = 0></CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\system\reserve.cfm"
		OUTPUT="<CFSET reserveMetEmail = #reserveMetEmail#>
<CFSET reserveMetLoserEmail = #reserveMetLoserEmail#>
<CFSET reserveNotMetEmail = #reserveNotMetEmail#>
<CFSET reserveStayOpen = #reserveStayOpen#>
<CFSET reserveStayOpenNumber = #Form.reserveStayOpenNumber#>
<CFSET reserveStayOpenUnit = ""#Form.reserveStayOpenUnit#"">
<CFSET reserveStayOpenTimes = #Form.reserveStayOpenTimes#>
<CFSET reserveCloseWinnerEmail = ""#Form.reserveCloseWinnerEmail#"">
<CFSET reserveCloseLoserEmail = ""#Form.reserveCloseLoserEmail#"">
<CFSET reserveExtendedEmailWinners = #reserveExtendedEmailWinners#>
<CFSET reserveExtendedEmailLosers = #reserveExtendedEmailLosers#>">

	<H3>Closing options updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Closing Options</B></FONT>

<CFINCLUDE TEMPLATE="../system/closeLotEmailList.cfm">
<CFINCLUDE TEMPLATE="../system/useScheduler.cfm">
<CFINCLUDE TEMPLATE="../system/noBids.cfm">
<CFINCLUDE TEMPLATE="../system/reserve.cfm">

<CFFORM NAME=optionsClose ACTION=optionsClose.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

Below are the options for which emails are automatically sent upon closing a lot. Please note that the more emails you send automatically, the more system resources are required. Sending the email to notify the contact person that the lot has closed is not processor-intensive. However, all other types of emails require a query to the database and/or sending multiple emails.
<P>
Please note that the emails to the winning and losing bidders can be sent manually via the Emaze Auction Admin screens. (Not manually as in sending the email to each bidder manually, but manually choosing the option to send the emails which also enables you to customize the email for that lot.)
<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TR><TH BGCOLOR="#FFFFCE">Automatic Emails</TH></TR>
<TR><TD NOWRAP>
<INPUT TYPE=checkbox NAME=closeLotEmailList VALUE=adminEmail<CFIF ListContains(closeLotEmailList,"adminEmail") NEQ 0> CHECKED</CFIF>> Automatically email lot contact person to notify that auction has closed<BR>
&nbsp; &nbsp; &nbsp; <INPUT TYPE=checkbox NAME=closeLotEmailList VALUE=adminWin<CFIF ListContains(closeLotEmailList,"adminWin") NEQ 0> CHECKED</CFIF>> Include list of winning bidders in email<BR>
<INPUT TYPE=checkbox NAME=closeLotEmailList VALUE=winner<CFIF ListContains(closeLotEmailList,"winner") NEQ 0> CHECKED</CFIF>> Automatically email winning bidders <FONT SIZE=2>(who choose option)</FONT><BR>
<INPUT TYPE=checkbox NAME=closeLotEmailList VALUE=loser<CFIF ListContains(closeLotEmailList,"loser") NEQ 0> CHECKED</CFIF>> Automatically email losing bidders <FONT SIZE=2>(who choose option)</FONT><BR>
</TD></TR>

<TR><TH BGCOLOR="#FFFFCE">Sending Emails: CF Scheduler vs. Emaze Auction script</TH></TR>
<TR><TD NOWRAP><INPUT TYPE=checkbox NAME=useScheduler VALUE=1<CFIF useScheduler EQ 1> CHECKED</CFIF>> I am using the Cold Fusion Scheduler to send the automated emails</TD></TR>
<TR><TD NOWRAP BGCOLOR="#DCDCDC"><FONT SIZE=2 COLOR=blue>&nbsp; &nbsp; &nbsp; The Scheduler must be registered in the CF Administrator. If you check this option,<BR>
&nbsp; &nbsp; &nbsp; but have not actually set up the Scheduler, the above emails will never get sent<BR>
&nbsp; &nbsp; &nbsp; unless you click the <I>Close Lots</I> link in the Admin screens.</FONT></TD></TR>

<TR><TH BGCOLOR="#FFFFCE">Extending closing time if no bids are received for a lot</TH></TR>
<TR><TD><INPUT TYPE=checkbox NAME=noBidsEmail VALUE=1<CFIF noBidsEmail EQ 1> CHECKED</CFIF>> Email lot contact person<BR>
<INPUT TYPE=checkbox NAME=noBidsStayOpen VALUE=1<CFIF noBidsStayOpen EQ 1> CHECKED</CFIF>> Extend lot closing time:
	<CFINPUT TYPE=text NAME=noBidsStayOpenNumber SIZE=2 VALUE="#noBidsStayOpenNumber#" REQUIRED="Yes" VALIDATE="integer" MESSAGE="Number of hours or days to extend lot closing time when no bids must be an integer.">
	<SELECT NAME=noBidsStayOpenUnit SIZE=1>
	<OPTION VALUE="h"<CFIF noBidsStayOpenUnit EQ "h"> SELECTED</CFIF>>hours(s)
	<OPTION VALUE="d"<CFIF noBidsStayOpenUnit EQ "d"> SELECTED</CFIF>>day(s)
	</SELECT>, 
	<CFINPUT TYPE=text NAME=noBidsStayOpenTimes SIZE=1 VALUE="#noBidsStayOpenTimes#" REQUIRED="Yes" VALIDATE="integer" MESSAGE="Number of times to extend closing time when no bids must be an integer."> time(s)<BR>
</TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TH COLSPAN=2 BGCOLOR="#20A491"><FONT COLOR=purple SIZE=5>Reserve Price Options</FONT></TD>
<TR><TD COLSPAN=2><INPUT TYPE=checkbox NAME=reserveMetEmail VALUE=1<CFIF reserveMetEmail EQ 1> CHECKED</CFIF>> When reserve is met, email lot contact person.<BR>
	<INPUT TYPE=checkbox NAME=reserveMetLoserEmail VALUE=1<CFIF reserveMetLoserEmail EQ 1> CHECKED</CFIF>> When reserve is met, email losing bidders to notify them.</TD></TR>
	<TR><TD COLSPAN=2 BGCOLOR="#DCDCDC"><I>When reserve price is not met:</I></TD></TR>
	<TR><TD COLSPAN=2><INPUT TYPE=checkbox NAME=reserveNotMetEmail VALUE=1<CFIF reserveNotMetEmail EQ 1> CHECKED</CFIF>> Email lot contact person<BR>
	<INPUT TYPE=checkbox NAME=reserveStayOpen VALUE=1<CFIF reserveStayOpen EQ 1> CHECKED</CFIF>> Extend lot closing time: 
	<CFINPUT TYPE=text NAME=reserveStayOpenNumber SIZE=2 VALUE="#reserveStayOpenNumber#" REQUIRED="Yes" VALIDATE="integer" MESSAGE="Number of hours or days to extend lot closing time when reserve price is not met must be an integer.">
	<SELECT NAME=reserveStayOpenUnit SIZE=1>
	<OPTION VALUE="h"<CFIF reserveStayOpenUnit EQ "h"> SELECTED</CFIF>>hours(s)
	<OPTION VALUE="d"<CFIF reserveStayOpenUnit EQ "d"> SELECTED</CFIF>>day(s)
	</SELECT>, 
	<CFINPUT TYPE=text NAME=reserveStayOpenTimes SIZE=1 VALUE="#reserveStayOpenTimes#" REQUIRED="Yes" VALIDATE="integer" MESSAGE="Number of times to extend closing time when reserve price is not met must be an integer."> time(s)<BR>
	&nbsp; &nbsp; &nbsp; <INPUT TYPE=checkbox NAME=reserveExtendedEmailWinners VALUE=1<CFIF reserveExtendedEmailWinners EQ 1> CHECKED</CFIF>> Email current winning bidders when extending lot closing time.<BR>
	&nbsp; &nbsp; &nbsp; <INPUT TYPE=checkbox NAME=reserveExtendedEmailLosers VALUE=1<CFIF reserveExtendedEmailLosers EQ 1> CHECKED</CFIF>> Email current losing bidders when extending lot closing time.
	</TD></TR>
<TR><TD COLSPAN=2 BGCOLOR="#DCDCDC"><I>When reserve price is not met and lot is closed:</I></TD></TR>
<TR><TD BGCOLOR="#FFFFCE"><FONT SIZE=2>Email to &quot;winning&quot; bidders</FONT></TD>
	<TD BGCOLOR="#FFFFCE"><FONT SIZE=2>Email to &quot;losing&quot; bidders</FONT></TD></TR>
<TR><TD><INPUT TYPE=radio NAME=reserveCloseWinnerEmail VALUE="none"<CFIF reserveCloseWinnerEmail EQ "none"> CHECKED</CFIF>>Do not email<BR>
	<INPUT TYPE=radio NAME=reserveCloseWinnerEmail VALUE="reserve"<CFIF reserveCloseWinnerEmail EQ "reserve"> CHECKED</CFIF>>Send reserve &quot;winner&quot; email<BR>
	<INPUT TYPE=radio NAME=reserveCloseWinnerEmail VALUE="normal"<CFIF reserveCloseWinnerEmail EQ "normal"> CHECKED</CFIF>>Send normal loser email</TD>
	<TD><INPUT TYPE=radio NAME=reserveCloseLoserEmail VALUE="none"<CFIF reserveCloseLoserEmail EQ "none"> CHECKED</CFIF>>Do not email<BR>
	<INPUT TYPE=radio NAME=reserveCloseLoserEmail VALUE="reserve"<CFIF reserveCloseLoserEmail EQ "reserve"> CHECKED</CFIF>>Send reserve loser email<BR>
	<INPUT TYPE=radio NAME=reserveCloseLoserEmail VALUE="normal"<CFIF reserveCloseLoserEmail EQ "normal"> CHECKED</CFIF>>Send normal loser email</TD></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">

</CFFORM>

</BODY>
</HTML>