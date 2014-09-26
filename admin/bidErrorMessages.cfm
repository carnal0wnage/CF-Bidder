<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Bid Error Fields</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFSET lotClosedBody = Replace(Form.lotClosedBody, """", "&quot;", "ALL")>
	<CFSET emailNotVerifiedTitle = Replace(Form.emailNotVerifiedTitle, """", "&quot;", "ALL")>
	<CFSET emailNotVerifiedBody = Replace(Form.emailNotVerifiedBody, """", "&quot;", "ALL")>
	<CFSET badBidTitle = Replace(Form.badBidTitle, """", "&quot;", "ALL")>
	<CFSET badBidBody = Replace(Form.badBidBody, """", "&quot;", "ALL")>
	<CFSET badBidFooter = Replace(Form.badBidFooter, """", "&quot;", "ALL")>
	<CFSET bidderBanishedTitle = Replace(Form.bidderBanishedTitle, """", "&quot;", "ALL")>
	<CFSET bidderBanishedBody = Replace(Form.bidderBanishedBody, """", "&quot;", "ALL")>
	<CFSET badCookie = Replace(Form.badCookie, """", "&quot;", "ALL")>
	<CFSET badLogin = Replace(Form.badLogin, """", "&quot;", "ALL")>
	<CFSET badBlankLogin = Replace(Form.badBlankLogin, """", "&quot;", "ALL")>
	<CFIF NOT IsDefined("Form.badBidLoginRegisterLink")><CFSET badBidLoginRegisterLink = 0></CFIF>
	<CFSET badBidLoginRegisterText = Replace(Form.badBidLoginRegisterText, """", "&quot;", "ALL")>
	<CFSET badBidLoginRegisterUser = Replace(Form.badBidLoginRegisterUser, """", "&quot;", "ALL")>
	<CFSET badBidPriceEmpty = Replace(Form.badBidPriceEmpty, """", "&quot;", "ALL")>
	<CFSET badBidPriceLow = Replace(Form.badBidPriceLow, """", "&quot;", "ALL")>
	<CFSET badBidPriceIncrement = Replace(Form.badBidPriceIncrement, """", "&quot;", "ALL")>
	<CFSET badBidQuantityEmpty = Replace(Form.badBidQuantityEmpty, """", "&quot;", "ALL")>
	<CFSET badBidQuantityZero = Replace(Form.badBidQuantityZero, """", "&quot;", "ALL")>
	<CFSET badBidQuantityGreater = Replace(Form.badBidQuantityGreater, """", "&quot;", "ALL")>
	<CFSET badBidQuantityMaximum = Replace(Form.badBidQuantityMaximum, """", "&quot;", "ALL")>
	<CFSET badBidPriceMaximumEmpty = Replace(Form.badBidPriceMaximumEmpty, """", "&quot;", "ALL")>
	<CFSET badBidPriceMaximumLow = Replace(Form.badBidPriceMaximumLow, """", "&quot;", "ALL")>
	<CFSET badBidPriceMaximumIncrement = Replace(Form.badBidPriceMaximumIncrement, """", "&quot;", "ALL")>
	<CFSET badUpdateBidPriceLess = Replace(Form.badUpdateBidPriceLess, """", "&quot;", "ALL")>
	<CFSET badUpdateBidPriceMaximumLess = Replace(Form.badUpdateBidPriceMaximumLess, """", "&quot;", "ALL")>
	<CFSET noBidOnOwnItemTitle = Replace(Form.noBidOnOwnItemTitle, """", "&quot;", "ALL")>
	<CFSET noBidOnOwnItemBody = Replace(Form.noBidOnOwnItemBody, """", "&quot;", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\bidErrors.cfm"
		OUTPUT="<CFSET lotClosedTitle = ""#lotClosedTitle#"">
<CFSET lotClosedBody = ""#lotClosedBody#"">
<CFSET emailNotVerifiedTitle = ""#emailNotVerifiedTitle#"">
<CFSET emailNotVerifiedBody = ""#emailNotVerifiedBody#"">
<CFSET badBidTitle = ""#badBidTitle#"">
<CFSET badBidBody = ""#badBidBody#"">
<CFSET badBidFooter = ""#badBidFooter#"">
<CFSET bidderBanishedTitle = ""#bidderBanishedTitle#"">
<CFSET bidderBanishedBody = ""#bidderBanishedBody#"">
<CFSET badCookie = ""#badCookie#"">
<CFSET badLogin = ""#badLogin#"">
<CFSET badBlankLogin = ""#badBlankLogin#"">
<CFSET badBidLoginRegisterLink = #badBidLoginRegisterLink#>
<CFSET badBidLoginRegisterText = ""#badBidLoginRegisterText#"">
<CFSET badBidLoginRegisterUser = ""#badBidLoginRegisterUser#"">
<CFSET badBidPriceEmpty = ""#badBidPriceEmpty#"">
<CFSET badBidPriceLow = ""#badBidPriceLow#"">
<CFSET badBidPriceIncrement = ""#badBidPriceIncrement#"">
<CFSET badBidQuantityEmpty = ""#badBidQuantityEmpty#"">
<CFSET badBidQuantityZero = ""#badBidQuantityZero#"">
<CFSET badBidQuantityGreater = ""#badBidQuantityGreater#"">
<CFSET badBidQuantityMaximum = ""#badBidQuantityMaximum#"">
<CFSET badBidPriceMaximumEmpty = ""#badBidPriceMaximumEmpty#"">
<CFSET badBidPriceMaximumLow = ""#badBidPriceMaximumLow#"">
<CFSET badBidPriceMaximumIncrement = ""#badBidPriceMaximumIncrement#"">
<CFSET badUpdateBidPriceLess = ""#badUpdateBidPriceLess#"">
<CFSET badUpdateBidPriceMaximumLess = ""#badUpdateBidPriceMaximumLess#"">
<CFSET noBidOnOwnItemTitle = ""#noBidOnOwnItemTitle#"">
<CFSET noBidOnOwnItemBody = ""#noBidOnOwnItemBody#"">
">

	<H3>Bid Submissions Error Messages Updated.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=500 ALIGN=left><P>
</CFIF>

<CFPARAM NAME="Form.first" DEFAULT=" ">
<CFINCLUDE TEMPLATE="../system/bidErrors.cfm">

<CFFORM NAME=bidErrorMessages ACTION="bidErrorMessages.cfm">
<INPUT TYPE=hidden NAME=first VALUE=1>

<H1><FONT COLOR="purple">Bid Submissions Error Messages</FONT></H1>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=4 WIDTH="600">
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Lot Closed Title:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=lotClosedTitle SIZE=55 VALUE="#lotClosedTitle#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Lot Closed Body:</FONT></TD>
	<TD><TEXTAREA NAME=lotClosedBody ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#lotClosedBody#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Email Address Not Verified Title:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=emailNotVerifiedTitle SIZE=55 VALUE="#emailNotVerifiedTitle#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Email Address Not Verified Body:</FONT></TD>
	<TD><TEXTAREA NAME=emailNotVerifiedBody ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#emailNotVerifiedBody#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Seller cannot Bid on Own Lot Title:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=noBidOnOwnItemTitle SIZE=55 VALUE="#noBidOnOwnItemTitle#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Seller cannot Bid on Own Lot Body:</FONT></TD>
	<TD><TEXTAREA NAME=noBidOnOwnItemBody ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#noBidOnOwnItemBody#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bad Bid Title:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=badBidTitle SIZE=55 VALUE="#badBidTitle#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bad Bid Header:</FONT></TD>
	<TD><TEXTAREA NAME=badBidBody ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidBody#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bad Bid Footer:</FONT></TD>
	<TD><TEXTAREA NAME=badBidFooter ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidFooter#</CFOUTPUT></TEXTAREA></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bidder Banished Title:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidderBanishedTitle SIZE=55 VALUE="#bidderBanishedTitle#"></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bidder Banished Body:</FONT></TD>
	<TD><TEXTAREA NAME=bidderBanishedBody ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#bidderBanishedBody#</CFOUTPUT></TEXTAREA></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bad Cookie:</FONT></TD>
	<TD><TEXTAREA NAME=badCookie ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badCookie#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bad Login:</FONT></TD>
	<TD><TEXTAREA NAME=badLogin ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badLogin#</CFOUTPUT></TEXTAREA></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Login Name Blank:</FONT></TD>
	<TD><TEXTAREA NAME=badBlankLogin ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBlankLogin#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD ALIGN=right VALIGN=top NOWRAP><FONT FACE="Arial" SIZE=2>Link to Register<BR>When Bad Login:</TD>
	<TD><INPUT TYPE=checkbox NAME=badBidLoginRegisterLink VALUE=1<CFIF badBidLoginRegisterLink EQ 1> CHECKED</CFIF>> <FONT SIZE=2>If bid failed because bidder may not be a registered user (bad login or<BR>
	&nbsp; &nbsp; &nbsp; &nbsp; bad cookie) display link to registration and keep bid information.</FONT></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Link Display<BR>To Register:</FONT></TD>
	<TD><TEXTAREA NAME=badBidLoginRegisterText ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidLoginRegisterText#</CFOUTPUT></TEXTAREA><BR>
	<FONT SIZE=2>NOTE: &quot;LINK&quot; will automatically be replaced with the proper link in both statements.</FONT></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Link Display<BR>To Re-Bid:</FONT></TD>
	<TD><TEXTAREA NAME=badBidLoginRegisterUser ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidLoginRegisterUser#</CFOUTPUT></TEXTAREA></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bid Amount Field Empty:</FONT></TD>
	<TD><TEXTAREA NAME=badBidPriceEmpty ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidPriceEmpty#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bid Amount Entered Too Low:</FONT></TD>
	<TD><TEXTAREA NAME=badBidPriceLow ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidPriceLow#</CFOUTPUT></TEXTAREA></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Increment Amount Incorrect:</FONT></TD>
	<TD><TEXTAREA NAME=badBidPriceIncrement ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidPriceIncrement#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bid Quantity Amount Empty:</FONT></TD>
	<TD><TEXTAREA NAME=badBidQuantityEmpty ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidQuantityEmpty#</CFOUTPUT></TEXTAREA></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Bid Quantity Amount Zero:</FONT></TD>
	<TD><TEXTAREA NAME=badBidQuantityZero ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidQuantityZero#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2></FONT>Bid Qty Greater than Qty:</FONT></TD>
	<TD><TEXTAREA NAME=badBidQuantityGreater ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidQuantityGreater#</CFOUTPUT></TEXTAREA></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2></FONT>Bid Qty Greater than Max:</FONT></TD>
	<TD><TEXTAREA NAME=badBidQuantityMaximum ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidQuantityMaximum#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Auto Bid Max Price Empty:</FONT></TD>
	<TD><TEXTAREA NAME=badBidPriceMaximumEmpty ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidPriceMaximumEmpty#</CFOUTPUT></TEXTAREA></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Auto Bid Max Price Too Low:</FONT></TD>
	<TD><TEXTAREA NAME=badBidPriceMaximumLow ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidPriceMaximumLow#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2></FONT>Auto Bid Increment Not Met:</FONT></TD>
	<TD><TEXTAREA NAME=badBidPriceMaximumIncrement ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badBidPriceMaximumIncrement#</CFOUTPUT></TEXTAREA></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2></FONT>Updated Bid Amount Invalid:</FONT></TD>
	<TD><TEXTAREA NAME=badUpdateBidPriceLess ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badUpdateBidPriceLess#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2></FONT>Updated Bid Amount Too Low:</FONT></TD>
	<TD><TEXTAREA NAME=badUpdateBidPriceMaximumLess ROWS=3 COLS=55 WRAP=virtual><CFOUTPUT>#badUpdateBidPriceMaximumLess#</CFOUTPUT></TEXTAREA></TD></TR>

<TR><TD COLSPAN="2" ALIGN="Center"><INPUT TYPE=submit VALUE="Update Error Messages"></TD></TR></TABLE>
</TABLE>
</CFFORM>
</body>
</html>
