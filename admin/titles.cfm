<!--- Emaze Auction version 2.1, 1.01 / Wednesday, June 16, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Page Titles</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFSET titleVerify = Replace(Form.titleVerify, """", "&quot;", "ALL")>
	<CFSET titleCategoryBad = Replace(Form.titleCategoryBad, """", "&quot;", "ALL")>
	<CFSET titleLotBad = Replace(Form.titleLotBad, """", "&quot;", "ALL")>
	<CFSET titleLotPrivate = Replace(Form.titleLotPrivate, """", "&quot;", "ALL")>
	<CFSET titleHelp = Replace(Form.titleHelp, """", "&quot;", "ALL")>
	<CFSET titleUserEdit = Replace(Form.titleUserEdit, """", "&quot;", "ALL")>
	<CFSET titleUser = Replace(Form.titleUser, """", "&quot;", "ALL")>
	<CFSET titleBidStatus = Replace(Form.titleBidStatus, """", "&quot;", "ALL")>
	<CFSET titleSearch = Replace(Form.titleSearch, """", "&quot;", "ALL")>
	<CFSET titleAllLotsFeatured = Replace(Form.titleAllLotsFeatured, """", "&quot;", "ALL")>
	<CFSET titleAllLotsOpening = Replace(Form.titleAllLotsOpening, """", "&quot;", "ALL")>
	<CFSET titleAllLotsClosing = Replace(Form.titleAllLotsClosing, """", "&quot;", "ALL")>
	<CFSET titleAllLots = Replace(Form.titleAllLots, """", "&quot;", "ALL")>
	<CFSET titleBidResult = Replace(Form.titleBidResult, """", "&quot;", "ALL")>
	<CFSET titleCategoryListAll = Replace(Form.titleCategoryListAll, """", "&quot;", "ALL")>
	<CFSET titleBidDescription = Replace(Form.titleBidDescription, """", "&quot;", "ALL")>
	<CFSET titleGetPassword = Replace(Form.titleGetPassword, """", "&quot;", "ALL")>
	<CFSET titleCategorySubscribe = Replace(Form.titleCategorySubscribe, """", "&quot;", "ALL")>
	<CFSET titleLotWatch = Replace(Form.titleLotWatch, """", "&quot;", "ALL")>

	<CFSET titleVerify = Replace(titleVerify, "##", "####", "ALL")>
	<CFSET titleCategoryBad = Replace(titleCategoryBad, "##", "####", "ALL")>
	<CFSET titleLotBad = Replace(titleLotBad, "##", "####", "ALL")>
	<CFSET titleLotPrivate = Replace(titleLotPrivate, "##", "####", "ALL")>
	<CFSET titleHelp = Replace(titleHelp, "##", "####", "ALL")>
	<CFSET titleUserEdit = Replace(titleUserEdit, "##", "####", "ALL")>
	<CFSET titleUser = Replace(titleUser, "##", "####", "ALL")>
	<CFSET titleBidStatus = Replace(titleBidStatus, "##", "####", "ALL")>
	<CFSET titleSearch = Replace(titleSearch, "##", "####", "ALL")>
	<CFSET titleAllLotsFeatured = Replace(titleAllLotsFeatured, "##", "####", "ALL")>
	<CFSET titleAllLotsOpening = Replace(titleAllLotsOpening, "##", "####", "ALL")>
	<CFSET titleAllLotsClosing = Replace(titleAllLotsClosing, "##", "####", "ALL")>
	<CFSET titleAllLots = Replace(titleAllLots, "##", "####", "ALL")>
	<CFSET titleBidResult = Replace(titleBidResult, "##", "####", "ALL")>
	<CFSET titleCategoryListAll = Replace(titleCategoryListAll, "##", "####", "ALL")>
	<CFSET titleBidDescriptionStore = Replace(titleBidDescription, "##", "####", "ALL")>
	<CFSET titleGetPassword = Replace(titleGetPassword, "##", "####", "ALL")>
	<CFSET titleCategorySubscribe = Replace(titleCategorySubscribe, "##", "####", "ALL")>
	<CFSET titleLotWatch = Replace(titleLotWatch, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\pageTitles.cfm"
		OUTPUT="<CFSETTING ENABLECFOUTPUTONLY=""Yes"">
<CFSET titleVerify = ""#titleVerify#"">
<CFSET titleCategoryBad = ""#titleCategoryBad#"">
<CFSET titleLotBad = ""#titleLotBad#"">
<CFSET titleLotPrivate = ""#titleLotPrivate#"">
<CFSET titleHelp = ""#titleHelp#"">
<CFSET titleUserEdit = ""#titleUserEdit#"">
<CFSET titleUser = ""#titleUser#"">
<CFSET titleBidStatus = ""#titleBidStatus#"">
<CFSET titleSearch = ""#titleSearch#"">
<CFSET titleAllLotsFeatured = ""#titleAllLotsFeatured#"">
<CFSET titleAllLotsOpening = ""#titleAllLotsOpening#"">
<CFSET titleAllLotsClosing = ""#titleAllLotsClosing#"">
<CFSET titleAllLots = ""#titleAllLots#"">
<CFSET titleBidResult = ""#titleBidResult#"">
<CFSET titleCategoryListAll = ""#titleCategoryListAll#"">
<CFSET titleBidDescriptionStore = ""#titleBidDescriptionStore#"">
<CFSET titleGetPassword = ""#titleGetPassword#"">
<CFSET titleCategorySubscribe = ""#titleCategorySubscribe#"">
<CFSET titleLotWatch = ""#titleLotWatch#"">
<CFPARAM NAME=lotID DEFAULT=""1"">
<CFSET titleBidDescription = ""#titleBidDescription#"">
<CFIF IsDefined(title)><CFSET title = Evaluate(title)></CFIF>
<CFSETTING ENABLECFOUTPUTONLY=""No"">">

	<H3>Page titles updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Page Titles</B></FONT>

<CFSET title = "title">
<CFINCLUDE TEMPLATE="../system/pageTitles.cfm">

<CFFORM NAME=titles ACTION=titles.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=4>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Verify Email:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleVerify SIZE=40 VALUE="#titleVerify#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bad Category:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleCategoryBad SIZE=40 VALUE="#titleCategoryBad#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bad Lot:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleLotBad SIZE=40 VALUE="#titleLotBad#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Private Lot Login:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleLotPrivate SIZE=40 VALUE="#titleLotPrivate#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Help:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleHelp SIZE=40 VALUE="#titleHelp#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Register:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleUser SIZE=40 VALUE="#titleUser#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Edit User:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleUserEdit SIZE=40 VALUE="#titleUserEdit#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bid Status:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleBidStatus SIZE=40 VALUE="#titleBidStatus#"></TD></TR>

<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Search:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleSearch SIZE=40 VALUE="#titleSearch#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>All Lots:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleAllLots SIZE=40 VALUE="#titleAllLots#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>All Featured Lots:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleAllLotsFeatured SIZE=40 VALUE="#titleAllLotsFeatured#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>All Open Lots:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleAllLotsOpening SIZE=40 VALUE="#titleAllLotsOpening#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>All Lots Closing Today:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleAllLotsClosing SIZE=40 VALUE="#titleAllLotsClosing#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>All Categories:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleCategoryListAll SIZE=40 VALUE="#titleCategoryListAll#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bid Result:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleBidResult SIZE=40 VALUE="#titleBidResult#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bid Description:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleBidDescription SIZE=40 VALUE="#titleBidDescriptionStore#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Get Password:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleGetPassword SIZE=40 VALUE="#titleGetPassword#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Subscribe to a Category:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleCategorySubscribe SIZE=40 VALUE="#titleCategorySubscribe#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Watch a Lot:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=titleLotWatch SIZE=40 VALUE="#titleLotWatch#"></TD></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Page Titles">
</CFFORM>

</BODY>
</HTML>
