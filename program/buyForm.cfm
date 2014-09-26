<!--- Emaze Auction version 2.1, 1.01 / Friday, July 2, 1999 --->
<!---
Always have username/password fields.
Check for cookie. If exists, put checkbox to use instead.
JavaScript for quantity, buy, maximum buy

2 more JavaScript scripts:
1. If enforcing increment, ensure increment is correct
2. If checkbox exists, either checkbox must be checked or username/password cannot be blank.
--->

<CFINCLUDE TEMPLATE="../system/useCookies.cfm">
<CFINCLUDE TEMPLATE="../systemMarket/marketBuyOptions.cfm">

<CFFORM ACTION="#systemURL#/program/buy.cfm">
<CFOUTPUT><INPUT TYPE=hidden NAME=lotID VALUE="#lotID#"></CFOUTPUT>

<CFIF IsDefined("Form.IamOfflineBuyer")>
	<INPUT TYPE=hidden NAME=IamOfflineBuyer VALUE=1>
	<CFOUTPUT>
		<INPUT TYPE=hidden NAME=buyDateMM VALUE="#Form.buyDateMM#">
		<INPUT TYPE=hidden NAME=buyDateDD VALUE="#Form.buyDateDD#">
		<INPUT TYPE=hidden NAME=buyDateYYYY VALUE="#Form.buyDateYYYY#">
		<INPUT TYPE=hidden NAME=buyTimeHH VALUE="#Form.buyTimeHH#">
		<INPUT TYPE=hidden NAME=buyTimeMM VALUE="#Form.buyTimeMM#">
		<INPUT TYPE=hidden NAME=buyTimeAMPM VALUE="#Form.buyTimeAMPM#">
	</CFOUTPUT>
</CFIF>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>

<CFIF NOT IsDefined("badBuy")><CFSET badBuy = 0></CFIF>
<CFIF NOT IsDefined("Form.username") OR ListFind(badBuy,"badCookie") OR ListFind(badBuy,"badLogin") OR ListFind(badBuy,"blankLogin")>
	<TR><TD ALIGN=right><CFOUTPUT>#buyTextUsername#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED="Yes" MESSAGE="#buyTextUsernameError#"></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#buyTextPassword#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=password NAME=password SIZE=20 REQUIRED="Yes" MESSAGE="#buyTextPasswordError#"></TD></TR>
<CFELSEIF allowCookieBuy EQ 1 AND IsDefined("Cookie.EmazeAuction_user")>
	<TR><TD ALIGN=right COLSPAN=2><INPUT TYPE=checkbox NAME=useCookie VALUE=1 CHECKED></TD>
	<TD><CFOUTPUT>#buyTextCookieLogin#</CFOUTPUT></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#buyTextUsername#</CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=username SIZE=20<CFIF IsDefined("Form.username")><CFOUTPUT> VALUE="#Form.username#"</CFOUTPUT></CFIF>></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#buyTextPassword#</CFOUTPUT></TD>
	<TD><INPUT TYPE=password NAME=password SIZE=20<CFIF IsDefined("Form.password")><CFOUTPUT> VALUE="#Form.password#"</CFOUTPUT></CFIF>></TD></TR>
<CFELSE>
	<TR><TD ALIGN=right><CFOUTPUT>#buyTextUsername#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 VALUE="#Form.username#" REQUIRED="Yes" MESSAGE="#buyTextUsernameError#"></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#buyTextPassword#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=password NAME=password SIZE=20 VALUE="#Form.password#" REQUIRED="Yes" MESSAGE="#buyTextPasswordError#"></TD></TR>
</CFIF>

<TR><TD ALIGN=right><BR>Price: </TD><TD><BR><CFOUTPUT>#LSCurrencyFormat(lotSellPrice)#</CFOUTPUT></TD></TR>

<CFIF lotQuantity EQ 1 OR lotQuantityMaximum EQ 1>
	<INPUT TYPE=hidden NAME=buyQuantity VALUE=1>
<CFELSE>
	<CFIF NOT IsDefined("buyQuantity")><CFSET buyQuantity = 1></CFIF>
	<CFIF lotQuantityMaximum EQ 0 OR lotQuantityMaximum GTE lotQuantity>
		<CFSET maxQuantityAvailable = lotQuantity - getLot.lotQuantityTaken>
	<CFELSE>
		<CFSET maxQuantityAvailable = Min(lotQuantity - getLot.lotQuantityTaken,lotQuantityMaximum)>
	</CFIF>
	<CFINCLUDE TEMPLATE="../systemMarket/marketBuyOptions.cfm">
	<TR><TD ALIGN=right><CFOUTPUT>#buyTextQuantity#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME="buyQuantity" SIZE=4 VALUE=#buyQuantity# REQUIRED="Yes" RANGE="1,#maxQuantityAvailable#" VALIDATE="integer" MESSAGE="#buyTextQuantityError#"> (<CFOUTPUT>#buyTextQuantityMaximum##maxQuantityAvailable#</CFOUTPUT>)</TD></TR>
</CFIF>

<CFOUTPUT>
<TR><TD ALIGN=right HEIGHT=40><INPUT TYPE=reset VALUE="#buyButtonClear#"></TD>
<TD HEIGHT=40>&nbsp; 
<CFIF verifyBuyBeforeSubmitting EQ 0> <INPUT TYPE=submit NAME=buyButton VALUE="#buyButtonSubmit#">
<CFELSEIF verifyBuyBeforeSubmitting EQ 1> <INPUT TYPE=submit NAME=buyButton VALUE="#buyButtonPreview#"> 
<CFELSE><INPUT TYPE=submit NAME=buyButton VALUE="#buyButtonPreview#"> <INPUT TYPE=submit NAME=buyButton VALUE="#buyButtonSubmit#"></CFIF>
</CFOUTPUT>
</TD></TR>
</TABLE>
</CFFORM>
