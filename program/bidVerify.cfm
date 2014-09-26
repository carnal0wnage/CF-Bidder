<!--- Emaze Auction version 2.1, 1.01 / Thursday, September 2, 1999 --->
<CFINCLUDE TEMPLATE="../system/bidOptionsAdmin.cfm">
<CFINCLUDE TEMPLATE="../system/bidOptionsVerify.cfm">

<CFSET title = bidVerifyTitle>
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<CFFORM ACTION="#systemURL#/program/bid.cfm">
<CFOUTPUT>
<INPUT TYPE=hidden NAME=lotID VALUE="#lotID#">
<CFIF IsDefined("Form.useCookie")>
	<INPUT TYPE=hidden NAME=useCookie VALUE=1>
</CFIF>
<INPUT TYPE=hidden NAME=username VALUE="#Form.username#">
<INPUT TYPE=hidden NAME=password VALUE="#Form.password#">
<INPUT TYPE=hidden NAME=bidPrice VALUE="#Form.bidPrice#">
<INPUT TYPE=hidden NAME=bidQuantity VALUE="#Form.bidQuantity#">
<CFIF IsDefined("Form.bidFullQuantityOnly")>
	<INPUT TYPE=hidden NAME=bidFullQuantityOnly VALUE=1>
</CFIF>
<CFIF IsDefined("Form.bidAuto")>
	<INPUT TYPE=hidden NAME=bidAuto VALUE=#Form.bidAuto#>
	<INPUT TYPE=hidden NAME=bidPriceMaximum VALUE="#Form.bidPriceMaximum#">
</CFIF>
<CFIF IsDefined("Form.IamOfflineBidder")>
	<INPUT TYPE=hidden NAME=IamOfflineBidder VALUE=1>
	<INPUT TYPE=hidden NAME=bidDateMM VALUE="#Form.bidDateMM#">
	<INPUT TYPE=hidden NAME=bidDateDD VALUE="#Form.bidDateDD#">
	<INPUT TYPE=hidden NAME=bidDateYYYY VALUE="#Form.bidDateYYYY#">
	<INPUT TYPE=hidden NAME=bidTimeHH VALUE="#Form.bidTimeHH#">
	<INPUT TYPE=hidden NAME=bidTimeMM VALUE="#Form.bidTimeMM#">
	<INPUT TYPE=hidden NAME=bidTimeAMPM VALUE="#Form.bidTimeAMPM#">
</CFIF>

<CFIF verifyBidBeforeSubmitting EQ 1>#bidVerifyRequired#<CFELSE>#bidVerifyOptional#</CFIF>

#bidVerifyText#
<P>
#bidVerifyLotName# #lotName#
<P>
<TABLE BORDER=1 CELLSPACING=4 CELLPADDING=4>
<CFIF lotQuantity GT 1 AND (lotQuantityMaximum EQ 0 OR lotQuantityMaximum GT 1)>
	<TR><TD ALIGN=right>#bidTextQuantity#</TD><TD>#Form.bidQuantity#
	<CFIF IsDefined("Form.bidFullQuantityOnly")> #bidVerifyFullQuantityOnly#</CFIF>
	</TD></TR>
</CFIF>
<CFIF allowAutoBid EQ 3>
	<TR><TD ALIGN=right>#bidVerifyInitialBid#</TD><TD>#LSCurrencyFormat(Form.bidPrice,"local")#</TD></TR>
	<TR><TD ALIGN=right>#bidTextBidMaximum#</TD><TD>#LSCurrencyFormat(Form.bidPriceMaximum,"local")#</TD></TR>
<CFELSE>
	<TR><TD ALIGN=right>#bidTextBid#</TD><TD>#LSCurrencyFormat(Form.bidPrice,"local")#</TD></TR>
	<CFIF IsDefined("Form.bidAuto")><CFIF Form.bidPriceMaximum NEQ "">
		<TR><TD ALIGN=right>#bidTextBidMaximum#</TD><TD>#LSCurrencyFormat(Form.bidPriceMaximum,"local")#</TD></TR>
	</CFIF></CFIF>
</CFIF>
<TR><TD COLSPAN=2 ALIGN=center><INPUT TYPE=submit NAME=bidButton VALUE="#bidButtonReject#"> <INPUT TYPE=submit NAME=bidButton VALUE="#bidButtonSubmit#"></TD></TR>
</TABLE>
</CFOUTPUT>
</CFFORM>

<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
</BODY></HTML>
