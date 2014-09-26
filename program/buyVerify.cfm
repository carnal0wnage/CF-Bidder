<!--- Emaze Auction version 2.1 / Tuesday, July 5, 1999 --->
<CFSET title = "Verify Purchase">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<CFFORM ACTION="#systemURL#/program/buy.cfm">
<CFOUTPUT>
<INPUT TYPE=hidden NAME=lotID VALUE="#lotID#">
<CFIF IsDefined("Form.useCookie")>
	<INPUT TYPE=hidden NAME=useCookie VALUE=1>
</CFIF>
<INPUT TYPE=hidden NAME=username VALUE="#Form.username#">
<INPUT TYPE=hidden NAME=password VALUE="#Form.password#">
<INPUT TYPE=hidden NAME=buyQuantity VALUE="#Form.buyQuantity#">
<CFIF IsDefined("Form.IamOfflineBidder")>
	<INPUT TYPE=hidden NAME=IamOfflineBidder VALUE=1>
	<INPUT TYPE=hidden NAME=buyDateMM VALUE="#Form.buyDateMM#">
	<INPUT TYPE=hidden NAME=buyDateDD VALUE="#Form.buyDateDD#">
	<INPUT TYPE=hidden NAME=buyDateYYYY VALUE="#Form.buyDateYYYY#">
	<INPUT TYPE=hidden NAME=buyTimeHH VALUE="#Form.buyTimeHH#">
	<INPUT TYPE=hidden NAME=buyTimeMM VALUE="#Form.buyTimeMM#">
	<INPUT TYPE=hidden NAME=buyTimeAMPM VALUE="#Form.buyTimeAMPM#">
</CFIF>

<CFIF verifyBuyBeforeSubmitting EQ 2>#buyVerifyOptional#<CFELSE>#buyVerifyRequired#</CFIF>

#buyVerifyText#
<P>
#buyVerifyLotName# #lotName#
<P>
<TABLE BORDER=1 CELLSPACING=4 CELLPADDING=4>
<TR><TD ALIGN=right>#buyTextPrice#</TD><TD>#LSCurrencyFormat(getLot.lotSellPrice,"local")#</TD></TR>
<CFIF lotQuantity GT 1 AND (lotQuantityMaximum EQ 0 OR lotQuantityMaximum GT 1)>
	<TR><TD ALIGN=right>#buyTextQuantity#</TD><TD>#Form.buyQuantity#</TD></TR>
</CFIF>
<TR><TD COLSPAN=2 ALIGN=center><INPUT TYPE=submit NAME=buyButton VALUE="#buyButtonReject#"> <INPUT TYPE=submit NAME=buyButton VALUE="#buyButtonSubmit#"></TD></TR>
</TABLE>
</CFOUTPUT>
</CFFORM>

<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
</BODY></HTML>
