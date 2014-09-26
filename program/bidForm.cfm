<!--- Emaze Auction version 2.1, 1.01 / Friday, July 2, 1999 --->
<!---
Always have username/password fields.
Check for cookie. If exists, put checkbox to use instead.
JavaScript for quantity, bid, maximum bid

2 more JavaScript scripts:
1. If enforcing increment, ensure increment is correct
2. If checkbox exists, either checkbox must be checked or username/password cannot be blank.
--->

<CFINCLUDE TEMPLATE="../system/useCookies.cfm">
<CFINCLUDE TEMPLATE="../system/bidOptions.cfm">

<CFFORM ACTION="#systemURL#/program/bid.cfm">
<CFOUTPUT><INPUT TYPE=hidden NAME=lotID VALUE="#lotID#"></CFOUTPUT>

<CFIF IsDefined("Form.IamOfflineBuyer")>
	<INPUT TYPE=hidden NAME=IamOfflineBuyer VALUE=1>
	<CFOUTPUT>
		<INPUT TYPE=hidden NAME=bidDateMM VALUE="#Form.bidDateMM#">
		<INPUT TYPE=hidden NAME=bidDateDD VALUE="#Form.bidDateDD#">
		<INPUT TYPE=hidden NAME=bidDateYYYY VALUE="#Form.bidDateYYYY#">
		<INPUT TYPE=hidden NAME=bidTimeHH VALUE="#Form.bidTimeHH#">
		<INPUT TYPE=hidden NAME=bidTimeMM VALUE="#Form.bidTimeMM#">
		<INPUT TYPE=hidden NAME=bidTimeAMPM VALUE="#Form.bidTimeAMPM#">
	</CFOUTPUT>
</CFIF>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>

<CFIF NOT IsDefined("badBid")><CFSET badBid = 0></CFIF>
<CFIF NOT IsDefined("Form.username") OR ListFind(badBid,"badCookie") OR ListFind(badBid,"badLogin") OR ListFind(badBid,"blankLogin")>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextUsername#</CFOUTPUT></TD><TD></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED="Yes" MESSAGE="#bidTextUsernameError#"></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextPassword#</CFOUTPUT></TD><TD></TD>
	<TD><CFINPUT TYPE=password NAME=password SIZE=20 REQUIRED="Yes" MESSAGE="#bidTextPasswordError#"></TD></TR>
<CFELSEIF allowCookieBid EQ 1 AND IsDefined("Cookie.EmazeAuction_user")>
	<TR><TD ALIGN=right COLSPAN=2><INPUT TYPE=checkbox NAME=useCookie VALUE=1 CHECKED></TD>
	<TD><CFOUTPUT>#bidTextCookieLogin#</CFOUTPUT></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextUsername#</CFOUTPUT></TD><TD></TD>
	<TD><INPUT TYPE=text NAME=username SIZE=20<CFIF IsDefined("Form.username")><CFOUTPUT> VALUE="#Form.username#"</CFOUTPUT></CFIF>></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextPassword#</CFOUTPUT></TD><TD></TD>
	<TD><INPUT TYPE=password NAME=password SIZE=20<CFIF IsDefined("Form.password")><CFOUTPUT> VALUE="#Form.password#"</CFOUTPUT></CFIF>></TD></TR>
<CFELSE>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextUsername#</CFOUTPUT></TD><TD></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 VALUE="#Form.username#" REQUIRED="Yes" MESSAGE="#bidTextUsernameError#"></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextPassword#</CFOUTPUT></TD><TD></TD>
	<TD><CFINPUT TYPE=password NAME=password SIZE=20 VALUE="#Form.password#" REQUIRED="Yes" MESSAGE="#bidTextPasswordError#"></TD></TR>
</CFIF>

<CFIF allowAutoBid EQ 3>
	<CFOUTPUT><INPUT TYPE=hidden NAME=bidPrice VALUE="#getLot.nextBidMinimum#"></CFOUTPUT>
<CFELSE>
	<TR><TD ALIGN=right><BR><CFOUTPUT>#bidTextBid#</CFOUTPUT></TD><TD><BR><CFOUTPUT>#bidTextCurrencySign#</CFOUTPUT></TD><TD><BR>
	<CFIF NOT IsDefined("bidPrice")><CFSET bidPrice = getLot.nextBidMinimum></CFIF>
	<CFINPUT TYPE=text NAME="bidPrice" SIZE=10 VALUE="#Replace(DecimalFormat(bidPrice), ',', '', 'ALL')#" REQUIRED="Yes" RANGE="#Iif(bidLogicOrder EQ 'Bid.bidPriceMaximum DESC, Bid.bidQuantity DESC, Bid.bidEditDateTime', getLot.nextBidMinimum, lotOpeningBid)#" VALIDATE="float" MESSAGE="#bidTextBidError#">
	</TD></TR>
</CFIF>

<CFIF lotQuantity EQ 1 OR lotQuantityMaximum EQ 1>
	<INPUT TYPE=hidden NAME=bidQuantity VALUE=1>
<CFELSE>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextQuantity#</CFOUTPUT></TD><TD></TD><TD>
	<CFIF NOT IsDefined("bidQuantity")><CFSET bidQuantity = 1></CFIF>
	<CFIF lotQuantityMaximum EQ 0 OR lotQuantityMaximum GTE lotQuantity>
		<CFINPUT TYPE=text NAME="bidQuantity" SIZE=4 VALUE=#bidQuantity# REQUIRED="Yes" RANGE="1,#lotQuantity#" VALIDATE="integer" MESSAGE="#bidTextQuantityError#"> (<CFOUTPUT>#bidTextQuantityMaximum##lotQuantity#</CFOUTPUT>)
	<CFELSE>
		<CFINPUT TYPE=text NAME="bidQuantity" SIZE=4 VALUE=#bidQuantity# REQUIRED="Yes" RANGE="1,#lotQuantityMaximum#" VALIDATE="integer" MESSAGE="#bidTextQuantityMaximumError#"> (<CFOUTPUT>#bidTextQuantityMaximum##lotQuantityMaximum#</CFOUTPUT>)
	</CFIF>
	</TD></TR>
	<CFIF allowBidFullQuantityOnly EQ 1>
		<TR><TD></TD><TD></TD>
		<TD><INPUT TYPE=checkbox NAME=bidFullQuantityOnly VALUE=1<CFIF IsDefined("Form.bidFullQuantityOnly")> CHECKED</CFIF>> <CFOUTPUT>#bidTextFullQuantityOnly#</CFOUTPUT></TD></TR>
	</CFIF>
</CFIF>

<CFIF allowAutoBid EQ 3>
	<CFIF NOT IsDefined("bidPriceMaximum")><CFSET bidPriceMaximum = Replace(DecimalFormat(getLot.nextBidMinimum), ",", "", "ALL")></CFIF>
	<INPUT TYPE=hidden NAME=bidAuto VALUE=1>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextBidMaximum#</CFOUTPUT></TD><TD><CFOUTPUT>#bidTextCurrencySign#</CFOUTPUT></TD>
	<CFIF NOT IsDefined("bidPriceMaximum")><CFSET bidPriceMaximum = "">
	<CFELSE><CFSET bidPriceMaximum = Replace(DecimalFormat(bidPriceMaximum), ",", "", "ALL")></CFIF>
	<TD><CFINPUT TYPE=text NAME="bidPriceMaximum" SIZE=10 VALUE="#bidPriceMaximum#" REQUIRED="Yes" RANGE="#getLot.nextBidMinimum#" VALIDATE="float" MESSAGE="#bidTextBidError#"></TD></TR>
<CFELSEIF allowAutoBid EQ 2>
	<CFIF NOT IsDefined("bidPriceMaximum")><CFSET bidPriceMaximum = "">
	<CFELSEIF bidPriceMaximum EQ 0 OR bidPriceMaximum EQ ""><CFSET bidPriceMaximum = "">
	<CFELSE><CFSET bidPriceMaximum = Replace(DecimalFormat(bidPriceMaximum), ",", "", "ALL")></CFIF>
	<INPUT TYPE=hidden NAME=bidAuto VALUE=2>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextBidMaximum#</CFOUTPUT></TD><TD><CFOUTPUT>#bidTextCurrencySign#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME="bidPriceMaximum" SIZE=10 VALUE="#bidPriceMaximum#" RANGE="#getLot.nextNextBidMinimum#" VALIDATE="float" MESSAGE="#bidTextBidMaximumError#"> <CFOUTPUT>#bidTextBidMaximumAuto#</CFOUTPUT></TD></TR>
<CFELSEIF allowAutoBid EQ 1>
	<TR><TD></TD><TD></TD>
	<TD><INPUT TYPE=checkbox NAME=bidAuto VALUE=1<CFIF IsDefined("Form.bidAuto")> CHECKED</CFIF>> <CFOUTPUT>#bidTextBidAuto#</CFOUTPUT></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#bidTextBidMaximum#</CFOUTPUT></TD><TD><CFOUTPUT>#bidTextCurrencySign#</CFOUTPUT></TD>
	<CFIF NOT IsDefined("bidPriceMaximum")><CFSET bidPriceMaximum = "">
	<CFELSEIF bidPriceMaximum EQ 0 OR bidPriceMaximum EQ ""><CFSET bidPriceMaximum = "">
	<CFELSE><CFSET bidPriceMaximum = Replace(DecimalFormat(bidPriceMaximum), ",", "", "ALL")></CFIF>
	<TD><CFINPUT TYPE=text NAME="bidPriceMaximum" SIZE=10 VALUE="#bidPriceMaximum#" RANGE="#getLot.nextNextBidMinimum#" VALIDATE="float" MESSAGE="#bidTextBidMaximumError#"> <CFOUTPUT>#bidTextBidMaximumAuto#</CFOUTPUT></TD></TR>
</CFIF>

<CFOUTPUT>
<TR><TD ALIGN=right HEIGHT=40><INPUT TYPE=reset VALUE="#bidButtonClear#"></TD>
<TD></TD><TD HEIGHT=40>
<CFIF verifyBidBeforeSubmitting EQ 0> <INPUT TYPE=submit NAME=bidButton VALUE="#bidButtonSubmit#">
<CFELSEIF verifyBidBeforeSubmitting EQ 1> <INPUT TYPE=submit NAME=bidButton VALUE="#bidButtonPreview#"> 
<CFELSE><INPUT TYPE=submit NAME=bidButton VALUE="#bidButtonPreview#"> <INPUT TYPE=submit NAME=bidButton VALUE="#bidButtonSubmit#"></CFIF>
</CFOUTPUT>
</TD></TR>
</TABLE>
</CFFORM>
