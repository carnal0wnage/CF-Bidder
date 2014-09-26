<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Bid Error Fields</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFSET lotsFeaturedNone = Replace(Form.lotsFeaturedNone, """", "&quot;", "ALL")>
	<CFSET lotsOpeningTodayNone = Replace(Form.lotsOpeningTodayNone, """", "&quot;", "ALL")>
	<CFSET lotsClosingTodayNone = Replace(Form.lotsClosingTodayNone, """", "&quot;", "ALL")>
	<CFSET lotsOpenNone = Replace(Form.lotsOpenNone, """", "&quot;", "ALL")>
	<CFSET categoryGoLink = Replace(Form.categoryGoLink, """", "&quot;", "ALL")>

	<CFSET lotsFeaturedNone = Replace(lotsFeaturedNone, "##", "####", "ALL")>
	<CFSET lotsOpeningTodayNone = Replace(lotsOpeningTodayNone, "##", "####", "ALL")>
	<CFSET lotsClosingTodayNone = Replace(lotsClosingTodayNone, "##", "####", "ALL")>
	<CFSET lotsOpenNone = Replace(lotsOpenNone, "##", "####", "ALL")>
	<CFSET categoryGoLink = Replace(categoryGoLink, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\listMessages.cfm"
		OUTPUT="<CFSET lotsFeaturedNone = ""#lotsFeaturedNone#"">
<CFSET lotsOpeningTodayNone = ""#lotsOpeningTodayNone#"">
<CFSET lotsClosingTodayNone = ""#lotsClosingTodayNone#"">
<CFSET lotsOpenNone = ""#lotsOpenNone#"">
<CFSET categoryGoLink = ""#categoryGoLink#"">">

	<H3>List, Status Messages Updated.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=500 ALIGN=left><P>
</CFIF>

<CFINCLUDE TEMPLATE="../system/listMessages.cfm">
<!--- <CFINCLUDE TEMPLATE="../system/statusMessages.cfm"> --->

<CFFORM NAME=listStatusMessages ACTION="listStatusMessages.cfm">
<INPUT TYPE=hidden NAME=first VALUE=1>

<H1><FONT COLOR="purple">List, Status Messages</FONT></H1>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=4 WIDTH="600">
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Go to category page:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=categoryGoLink SIZE=10 VALUE="#categoryGoLink#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No open lots:</FONT></TD>
	<TD><TEXTAREA NAME=lotsOpenNone ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#lotsOpenNone#</CFOUTPUT></TEXTAREA></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No featured lots:</FONT></TD>
	<TD><TEXTAREA NAME=lotsFeaturedNone ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#lotsFeaturedNone#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No lots opening today:</FONT></TD>
	<TD><TEXTAREA NAME=lotsOpeningTodayNone ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#lotsOpeningTodayNone#</CFOUTPUT></TEXTAREA></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No lots closing today:</FONT></TD>
	<TD><TEXTAREA NAME=lotsClosingTodayNone ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#lotsClosingTodayNone#</CFOUTPUT></TEXTAREA></TD></TR>
</TABLE>

<P>

<INPUT TYPE=submit VALUE="Update List, Status Messages">

</CFFORM>
</body>
</html>
