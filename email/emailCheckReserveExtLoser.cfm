
<CFQUERY NAME=getReserveLoser DATASOURCE="#EAdatasource#">
	SELECT Bid.bidPrice, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #getCheckList.lotID# AND Bid.bidWin = 0
	<CFIF ListFind(forcedEmailEventsList,"loser") EQ 0>AND Member.userEmailEvents LIKE '%loser%'</CFIF>
</CFQUERY>

<CFIF getReserveLoser.RecordCount NEQ 0>
	<CFINCLUDE TEMPLATE="../system/emailClose.cfm">
	<CFIF e_fromnameClose NEQ "" AND e_fromnameClose NEQ " ">
		<CFSET e_fromemailClose = "#e_fromemailClose# (#e_fromnameClose#)">
	</CFIF>

	<CFMAIL QUERY="getReserveLoser"
		TO="#getReserveLoser.email#"
		FROM="#e_fromemailClose#"
		SUBJECT="Emaze Auction - Reserve Price Not Met"
		SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that no bid reached the reserve price for this lot. Therefore, no bidder has yet won the lot. The closing time of this lot has been extended. Please feel free to submit an updated bid. Below is the relevant information.

Lot: #getCheckList.lotName#

New closing time: #LSDateFormat(newLotCloseDateTime,dateFormatDisplay)# / #LSTimeFormat(newLotCloseDateTime,timeFormatDisplay)#
Bid: #LSCurrencyFormat(getReserveLoser.bidPrice,"local")#

#systemURL#/lot.cfm?lotID=#getCheckList.lotID#

	</CFMAIL>
</CFIF>
