<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Bid Options</TITLE></HEAD>
<BODY BGCOLOR=white bidText=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF NOT IsDefined("Form.allowBidFullQuantityOnly")><CFSET allowBidFullQuantityOnly = 0></CFIF>
	<CFIF NOT IsDefined("Form.bidIncrementStrict")><CFSET bidIncrementStrict = 0></CFIF>

	<CFSET bidTextBidError = Replace(Form.bidTextBidError, "##", "####", "ALL")>
	<CFSET bidTextQuantityError = Replace(Form.bidTextQuantityError, "##", "####", "ALL")>
	<CFSET bidTextQuantityMaximumError = Replace(Form.bidTextQuantityMaximumError, "##", "####", "ALL")>
	<CFSET bidTextBidMaximumError = Replace(Form.bidTextBidMaximumError, "##", "####", "ALL")>

	<CFSET bidTextUsername = Replace(Form.bidTextUsername, """", "&quot;", "ALL")>
	<CFSET bidTextPassword = Replace(Form.bidTextPassword, """", "&quot;", "ALL")>
	<CFSET bidTextUsernameError = Replace(Form.bidTextUsernameError, """", "&quot;", "ALL")>
	<CFSET bidTextPasswordError = Replace(Form.bidTextPasswordError, """", "&quot;", "ALL")>
	<CFSET bidTextCookieLogin = Replace(Form.bidTextCookieLogin, """", "&quot;", "ALL")>
	<CFSET bidTextCurrencySign = Replace(Form.bidTextCurrencySign, """", "&quot;", "ALL")>
	<CFSET bidTextBid = Replace(Form.bidTextBid, """", "&quot;", "ALL")>
	<CFSET bidTextBidError = Replace(bidTextBidError, """", "&quot;", "ALL")>
	<CFSET bidTextQuantity = Replace(Form.bidTextQuantity, """", "&quot;", "ALL")>
	<CFSET bidTextQuantityMaximum = Replace(Form.bidTextQuantityMaximum, """", "&quot;", "ALL")>
	<CFSET bidTextQuantityError = Replace(bidTextQuantityError, """", "&quot;", "ALL")>
	<CFSET bidTextQuantityMaximumError = Replace(bidTextQuantityMaximumError, """", "&quot;", "ALL")>
	<CFSET bidTextFullQuantityOnly = Replace(Form.bidTextFullQuantityOnly, """", "&quot;", "ALL")>
	<CFSET bidTextBidMaximum = Replace(Form.bidTextBidMaximum, """", "&quot;", "ALL")>
	<CFSET bidTextBidMaximumError = Replace(bidTextBidMaximumError, """", "&quot;", "ALL")>
	<CFSET bidTextBidAuto = Replace(Form.bidTextBidAuto, """", "&quot;", "ALL")>
	<CFSET bidTextBidMaximumAuto = Replace(Form.bidTextBidMaximumAuto, """", "&quot;", "ALL")>
	<CFSET bidButtonClear = Replace(Form.bidButtonClear, """", "&quot;", "ALL")>
	<CFSET bidButtonSubmit = Replace(Form.bidButtonSubmit, """", "&quot;", "ALL")>
	<CFSET bidButtonPreview = Replace(Form.bidButtonPreview, """", "&quot;", "ALL")>
	<CFSET bidButtonReject = Replace(Form.bidButtonReject, """", "&quot;", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\bidOptionsAdmin.cfm"
		OUTPUT="<CFSET allowAutoBid = #Form.allowAutoBid#>
<CFSET allowBidFullQuantityOnly = #allowBidFullQuantityOnly#>
<CFSET verifyBidBeforeSubmitting = #Form.verifyBidBeforeSubmitting#>
<CFSET displayBidResultAfterBid = #Form.displayBidResultAfterBid#>
<CFSET bidLogicOrder = ""#Form.bidLogicOrder#"">
<CFSET bidIncrementStrict = #bidIncrementStrict#>

<CFSET bidTextUsername = ""#bidTextUsername#"">
<CFSET bidTextPassword = ""#bidTextPassword#"">
<CFSET bidTextUsernameError = ""#bidTextUsernameError#"">
<CFSET bidTextPasswordError = ""#bidTextPasswordError#"">
<CFSET bidTextCookieLogin = ""#bidTextCookieLogin#"">
<CFSET bidTextCurrencySign = ""#bidTextCurrencySign#"">
<CFSET bidTextBid = ""#bidTextBid#"">
<CFSET bidTextBidError = ""#bidTextBidError#"">
<CFSET bidTextQuantity = ""#bidTextQuantity#"">
<CFSET bidTextQuantityMaximum = ""#bidTextQuantityMaximum#"">
<CFSET bidTextQuantityError = ""#bidTextQuantityError#"">
<CFSET bidTextQuantityMaximumError = ""#bidTextQuantityMaximumError#"">
<CFSET bidTextFullQuantityOnly = ""#bidTextFullQuantityOnly#"">
<CFSET bidTextBidMaximum = ""#bidTextBidMaximum#"">
<CFSET bidTextBidMaximumError = ""#bidTextBidMaximumError#"">
<CFSET bidTextBidAuto = ""#bidTextBidAuto#"">
<CFSET bidTextBidMaximumAuto = ""#bidTextBidMaximumAuto#"">
<CFSET bidButtonClear = ""#bidButtonClear#"">
<CFSET bidButtonSubmit = ""#bidButtonSubmit#"">
<CFSET bidButtonPreview = ""#bidButtonPreview#"">
<CFSET bidButtonReject = ""#bidButtonReject#"">
">

	<CFSET bidTextUsername = Replace(Form.bidTextUsername, """", "&quot;", "ALL")>
	<CFSET bidTextPassword = Replace(Form.bidTextPassword, """", "&quot;", "ALL")>
	<CFSET bidTextUsernameError = Replace(Form.bidTextUsernameError, """", "&quot;", "ALL")>
	<CFSET bidTextPasswordError = Replace(Form.bidTextPasswordError, """", "&quot;", "ALL")>
	<CFSET bidTextCookieLogin = Replace(Form.bidTextCookieLogin, """", "&quot;", "ALL")>
	<CFSET bidTextCurrencySign = Replace(Form.bidTextCurrencySign, """", "&quot;", "ALL")>
	<CFSET bidTextBid = Replace(Form.bidTextBid, """", "&quot;", "ALL")>
	<CFSET bidTextBidError = Replace(Form.bidTextBidError, """", "&quot;", "ALL")>
	<CFSET bidTextQuantity = Replace(Form.bidTextQuantity, """", "&quot;", "ALL")>
	<CFSET bidTextQuantityMaximum = Replace(Form.bidTextQuantityMaximum, """", "&quot;", "ALL")>
	<CFSET bidTextQuantityError = Replace(Form.bidTextQuantityError, """", "&quot;", "ALL")>
	<CFSET bidTextQuantityMaximumError = Replace(Form.bidTextQuantityMaximumError, """", "&quot;", "ALL")>
	<CFSET bidTextFullQuantityOnly = Replace(Form.bidTextFullQuantityOnly, """", "&quot;", "ALL")>
	<CFSET bidTextBidMaximum = Replace(Form.bidTextBidMaximum, """", "&quot;", "ALL")>
	<CFSET bidTextBidMaximumError = Replace(Form.bidTextBidMaximumError, """", "&quot;", "ALL")>
	<CFSET bidTextBidAuto = Replace(Form.bidTextBidAuto, """", "&quot;", "ALL")>
	<CFSET bidTextBidMaximumAuto = Replace(Form.bidTextBidMaximumAuto, """", "&quot;", "ALL")>
	<CFSET bidButtonClear = Replace(Form.bidButtonClear, """", "&quot;", "ALL")>
	<CFSET bidButtonSubmit = Replace(Form.bidButtonSubmit, """", "&quot;", "ALL")>
	<CFSET bidButtonPreview = Replace(Form.bidButtonPreview, """", "&quot;", "ALL")>
	<CFSET bidButtonReject = Replace(Form.bidButtonReject, """", "&quot;", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\bidOptions.cfm"
		OUTPUT="<CFSET allowAutoBid = #Form.allowAutoBid#>
<CFSET allowBidFullQuantityOnly = #allowBidFullQuantityOnly#>
<CFSET verifyBidBeforeSubmitting = #Form.verifyBidBeforeSubmitting#>
<CFSET displayBidResultAfterBid = #Form.displayBidResultAfterBid#>
<CFSET bidLogicOrder = ""#Form.bidLogicOrder#"">
<CFSET bidIncrementStrict = #bidIncrementStrict#>

<CFSET bidTextUsername = ""#bidTextUsername#"">
<CFSET bidTextPassword = ""#bidTextPassword#"">
<CFSET bidTextUsernameError = ""#bidTextUsernameError#"">
<CFSET bidTextPasswordError = ""#bidTextPasswordError#"">
<CFSET bidTextCookieLogin = ""#bidTextCookieLogin#"">
<CFSET bidTextCurrencySign = ""#bidTextCurrencySign#"">
<CFSET bidTextBid = ""#bidTextBid#"">
<CFSET bidTextBidError = ""#bidTextBidError#"">
<CFSET bidTextQuantity = ""#bidTextQuantity#"">
<CFSET bidTextQuantityMaximum = ""#bidTextQuantityMaximum#"">
<CFSET bidTextQuantityError = ""#bidTextQuantityError#"">
<CFSET bidTextQuantityMaximumError = ""#bidTextQuantityMaximumError#"">
<CFSET bidTextFullQuantityOnly = ""#bidTextFullQuantityOnly#"">
<CFSET bidTextBidMaximum = ""#bidTextBidMaximum#"">
<CFSET bidTextBidMaximumError = ""#bidTextBidMaximumError#"">
<CFSET bidTextBidAuto = ""#bidTextBidAuto#"">
<CFSET bidTextBidMaximumAuto = ""#bidTextBidMaximumAuto#"">
<CFSET bidButtonClear = ""#bidButtonClear#"">
<CFSET bidButtonSubmit = ""#bidButtonSubmit#"">
<CFSET bidButtonPreview = ""#bidButtonPreview#"">
<CFSET bidButtonReject = ""#bidButtonReject#"">
">

	<CFSET bidVerifyTitle = Replace(Form.bidVerifyTitle, """", "&quot;", "ALL")>
	<CFSET bidVerifyRequired = Replace(Form.bidVerifyRequired, """", "&quot;", "ALL")>
	<CFSET bidVerifyOptional = Replace(Form.bidVerifyOptional, """", "&quot;", "ALL")>
	<CFSET bidVerifyText = Replace(Form.bidVerifyText, """", "&quot;", "ALL")>
	<CFSET bidVerifyLotName = Replace(Form.bidVerifyLotName, """", "&quot;", "ALL")>
	<CFSET bidVerifyFullQuantityOnly = Replace(Form.bidVerifyFullQuantityOnly, """", "&quot;", "ALL")>
	<CFSET bidVerifyInitialBid = Replace(Form.bidVerifyInitialBid, """", "&quot;", "ALL")>
	<CFSET bidButtonReject = Replace(Form.bidButtonReject, """", "&quot;", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\bidOptionsVerify.cfm"
		OUTPUT="<CFSET bidVerifyTitle = ""#bidVerifyTitle#"">
<CFSET bidVerifyRequired = ""#bidVerifyRequired#"">
<CFSET bidVerifyOptional = ""#bidVerifyOptional#"">
<CFSET bidVerifyText = ""#bidVerifyText#"">
<CFSET bidVerifyLotName = ""#bidVerifyLotName#"">
<CFSET bidVerifyFullQuantityOnly = ""#bidVerifyFullQuantityOnly#"">
<CFSET bidVerifyInitialBid = ""#bidVerifyInitialBid#"">
<CFSET bidButtonReject = ""#bidButtonReject#"">
">

	<CFIF Form.bidResultHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET bidResultHeader = Replace(Form.bidResultHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultHeader.cfm" OUTPUT="#bidResultHeader#">
	</CFIF>

	<CFIF Form.bidResultHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET bidResultHeader = Replace(Form.bidResultHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultHeader.cfm" OUTPUT="#bidResultHeader#">
	</CFIF>

	<CFIF Form.bidResultWinner EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultWinner.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET bidResultWinner = Replace(Form.bidResultWinner, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultWinner.cfm" OUTPUT="#bidResultWinner#">
	</CFIF>

	<CFIF Form.bidResultReserve EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultReserve.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET bidResultReserve = Replace(Form.bidResultReserve, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultReserve.cfm" OUTPUT="#bidResultReserve#">
	</CFIF>

	<CFIF Form.bidResultLoser EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultLoser.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET bidResultLoser = Replace(Form.bidResultLoser, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultLoser.cfm" OUTPUT="#bidResultLoser#">
	</CFIF>

	<CFIF Form.bidResultFooter EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultFooter.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET bidResultFooter = Replace(Form.bidResultFooter, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\bidResultFooter.cfm" OUTPUT="#bidResultFooter#">
	</CFIF>

	<H3>Bid options updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Bid Options</B></FONT>

<CFINCLUDE TEMPLATE="../system/bidOptionsAdmin.cfm">
<CFINCLUDE TEMPLATE="../system/bidOptionsVerify.cfm">

<CFFORM NAME=optionsBid ACTION=optionsBid.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TR><TD ROWSPAN=2 ALIGN=right BGCOLOR="#FFFFCE" VALIGN=top>Strict Bid &nbsp;<BR>Increment: </TD>
	<TD><INPUT TYPE=checkbox NAME=bidIncrementStrict VALUE=1<CFIF bidIncrementStrict EQ 1> CHECKED</CFIF>> Enforce increment as mandatory multiple (rather than minimum)</TD></TR>
<TR><TD BGCOLOR="#DCDCDC"><FONT SIZE=2>Enforcing increment means a bid must be greater than the previous bid by the bid<BR>
	increment, or a multiple of the bid increment. Not enforcing means any bid is accepted<BR>
	as long as it is greater than the previous bid by at least the bid increment.</FONT></TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE" VALIGN=top>Auto-Bid: </TD>
	<TD><INPUT TYPE=radio NAME=allowAutoBid VALUE=0<CFIF allowAutoBid EQ 0> CHECKED</CFIF>> Do not allow autobid on any lots<BR>
	<INPUT TYPE=radio NAME=allowAutoBid VALUE=1<CFIF allowAutoBid EQ 1> CHECKED</CFIF>> Optional autobid on all lots - <I>with checkbox</I><BR>
	<INPUT TYPE=radio NAME=allowAutoBid VALUE=2<CFIF allowAutoBid EQ 2> CHECKED</CFIF>> Optional autobid on all lots - <I>without checkbox</I><BR>
	<INPUT TYPE=radio NAME=allowAutoBid VALUE=3<CFIF allowAutoBid EQ 3> CHECKED</CFIF>> All bids automatically use autobid
	</TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE" VALIGN=top>Full Quantity: </TD>
	<TD><INPUT TYPE=checkbox NAME=allowBidFullQuantityOnly VALUE=1<CFIF allowBidFullQuantityOnly EQ 1> CHECKED</CFIF>> Bidder has option of accepting full quantity only on multiple-quantity lots</TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE" VALIGN=top>Bid Verification: </TD>
	<TD><INPUT TYPE=radio NAME=verifyBidBeforeSubmitting VALUE=0<CFIF verifyBidBeforeSubmitting EQ 0> CHECKED</CFIF>> Do not verify bids before they are submitted<BR>
	<INPUT TYPE=radio NAME=verifyBidBeforeSubmitting VALUE=1<CFIF verifyBidBeforeSubmitting EQ 1> CHECKED</CFIF>> All bids must be verified before they are submitted<BR>
	<INPUT TYPE=radio NAME=verifyBidBeforeSubmitting VALUE=2<CFIF verifyBidBeforeSubmitting EQ 2> CHECKED</CFIF>> Bidder has option of verifying bid before it is submitted</TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE" VALIGN=top>Bid Results: </TD>
	<TD><INPUT TYPE=radio NAME=displayBidResultAfterBid VALUE=1<CFIF displayBidResultAfterBid EQ 1> CHECKED</CFIF>> Display bid results after bid is processed<BR>
	<INPUT TYPE=radio NAME=displayBidResultAfterBid VALUE=0<CFIF displayBidResultAfterBid EQ 0> CHECKED</CFIF>> Reload lot page after bid is processed</TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE" VALIGN=top>Bid Logic: </TD>
	<TD><INPUT TYPE=radio NAME=bidLogicOrder VALUE="Bid.bidPriceMaximum DESC, Bid.bidQuantity DESC, Bid.bidEditDateTime"<CFIF bidLogicOrder EQ "Bid.bidPriceMaximum DESC, Bid.bidQuantity DESC, Bid.bidEditDateTime"> CHECKED</CFIF>> Maximum Bid, Bid Quantity, Bid Date/Time<BR>
<INPUT TYPE=radio NAME=bidLogicOrder VALUE="Bid.bidPriceMaximum DESC, Bid.bidEditDateTime, Bid.bidQuantity DESC"<CFIF bidLogicOrder EQ "Bid.bidPriceMaximum DESC, Bid.bidEditDateTime, Bid.bidQuantity DESC"> CHECKED</CFIF>> Maximum Bid, Bid Date/Time, Bid Quantity<BR>
<INPUT TYPE=radio NAME=bidLogicOrder VALUE="Bid.bidPriceMaximum DESC, Bid.bidEditDateTime"<CFIF bidLogicOrder EQ "Bid.bidPriceMaximum DESC, Bid.bidEditDateTime"> CHECKED</CFIF>> Maximum Bid, Bid Date/Time</TD></TR>
<TR><TD COLSPAN=2 ALIGN=center HEIGHT=40><INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Bid Options"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH="600">
<TH COLSPAN=2 BGCOLOR=purple><FONT SIZE=4 COLOR=yellow>Bid Form</FONT></TH>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Username: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextUsername SIZE=20 VALUE="#bidTextUsername#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Password: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextPassword SIZE=20 VALUE="#bidTextPassword#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Username blank: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextUsernameError SIZE=20 VALUE="#bidTextUsernameError#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Password blank: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextPasswordError SIZE=20 VALUE="#bidTextPasswordError#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Cookie login: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextCookieLogin SIZE=55 VALUE="#bidTextCookieLogin#"></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Currency symbol: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextCurrencySign SIZE=5 VALUE="#bidTextCurrencySign#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bid: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextBid SIZE=20 VALUE="#bidTextBid#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bid Error: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextBidError SIZE=55 VALUE="#bidTextBidError#"></TD></TR>

<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Quantity</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextQuantity SIZE=20 VALUE="#bidTextQuantity#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Maximum quantity: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextQuantityMaximum SIZE=20 VALUE="#bidTextQuantityMaximum#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Quantity error: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextQuantityError SIZE=55 VALUE="#bidTextQuantityError#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Max. quantity error: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextQuantityMaximumError SIZE=55 VALUE="#bidTextQuantityMaximumError#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Full quantity only: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextFullQuantityOnly SIZE=55 VALUE="#bidTextFullQuantityOnly#"></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Maximum bid: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextBidMaximum SIZE=55 VALUE="#bidTextBidMaximum#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Maximum bid error: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextBidMaximumError SIZE=55 VALUE="#bidTextBidMaximumError#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Autobid checkbox: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextBidAuto SIZE=55 VALUE="#bidTextBidAuto#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Max. bid auto message: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidTextBidMaximumAuto SIZE=55 VALUE="#bidTextBidMaximumAuto#"></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Clear bid button: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidButtonClear SIZE=20 VALUE="#bidButtonClear#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Submit bid button: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidButtonSubmit SIZE=20 VALUE="#bidButtonSubmit#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Preview bid button: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidButtonPreview SIZE=20 VALUE="#bidButtonPreview#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH="600">
<TH COLSPAN=2 BGCOLOR=purple><FONT SIZE=4 COLOR=yellow>Bid Verification Screen</FONT></TH>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bid Verify Title: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidVerifyTitle SIZE=20 VALUE="#bidVerifyTitle#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Verify Required: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidVerifyRequired SIZE=50 VALUE="#bidVerifyRequired#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Verify Optional: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidVerifyOptional SIZE=50 VALUE="#bidVerifyOptional#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Text: </FONT></TD>
	<TD><TEXTAREA NAME=bidVerifyText ROWS=4 COLS=55 WRAP=virtual><CFOUTPUT>#bidVerifyText#</CFOUTPUT></TEXTAREA></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Lot Name Heading: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidVerifyLotName SIZE=20 VALUE="#bidVerifyLotName#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Full Quantity Only Chosen: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidVerifyFullQuantityOnly SIZE=20 VALUE="#bidVerifyFullQuantityOnly#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Initial Bid (when autobid only): </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidVerifyInitialBid SIZE=20 VALUE="#bidVerifyInitialBid#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Reject Button: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=bidButtonReject SIZE=20 VALUE="#bidButtonReject#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH="600">
<TH COLSPAN=2 BGCOLOR=purple><FONT SIZE=4 COLOR=yellow>Bid Result Screen</FONT></TH>

<CFFILE ACTION=Read FILE="#systemPath#\system\bidResultHeader.cfm" VARIABLE="bidResultHeader">
<CFSET bidResultHeader = RTrim(bidResultHeader)>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Header: </FONT></TD>
<TD><TEXTAREA NAME=bidResultHeader ROWS=4 COLS=55 WRAP=virtual><CFOUTPUT>#bidResultHeader#</CFOUTPUT></TEXTAREA></TD></TR>

<CFFILE ACTION=Read FILE="#systemPath#\system\bidResultWinner.cfm" VARIABLE="bidResultWinner">
<CFSET bidResultWinner = RTrim(bidResultWinner)>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Winning Bid: </FONT></TD>
<TD><TEXTAREA NAME=bidResultWinner ROWS=4 COLS=55 WRAP=virtual><CFOUTPUT>#bidResultWinner#</CFOUTPUT></TEXTAREA></TD></TR>

<CFFILE ACTION=Read FILE="#systemPath#\system\bidResultReserve.cfm" VARIABLE="bidResultReserve">
<CFSET bidResultReserve = RTrim(bidResultReserve)>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>High bid, but reserve Not Met: </FONT></TD>
<TD><TEXTAREA NAME=bidResultReserve ROWS=4 COLS=55 WRAP=virtual><CFOUTPUT>#bidResultReserve#</CFOUTPUT></TEXTAREA></TD></TR>

<CFFILE ACTION=Read FILE="#systemPath#\system\bidResultLoser.cfm" VARIABLE="bidResultLoser">
<CFSET bidResultLoser = RTrim(bidResultLoser)>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Not Winning Bid: </FONT></TD>
<TD><TEXTAREA NAME=bidResultLoser ROWS=4 COLS=55 WRAP=virtual><CFOUTPUT>#bidResultLoser#</CFOUTPUT></TEXTAREA></TD></TR>

<CFFILE ACTION=Read FILE="#systemPath#\system\bidResultFooter.cfm" VARIABLE="bidResultFooter">
<CFSET bidResultFooter = RTrim(bidResultFooter)>
<TR><TD ALIGN=right VALIGN=top><FONT FACE="Arial" SIZE=2>Footer: </FONT></TD>
<TD><TEXTAREA NAME=bidResultFooter ROWS=4 COLS=55 WRAP=virtual><CFOUTPUT>#bidResultFooter#</CFOUTPUT></TEXTAREA></TD></TR>

</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Bid Options">

</CFFORM>

</BODY>
</HTML>