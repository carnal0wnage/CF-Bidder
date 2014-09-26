
<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
<CFQUERY NAME=getLosers DATASOURCE="#EAdatasource#">
	SELECT Bid.bidAuto, Bid.bidPriceMaximum, Member.email
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #Form.lotID#
		AND Bid.userID <> #bidderUserID#
	<CFIF ListFind(forcedEmailEventsList,"outbid") EQ 0>AND Member.userEmailEvents LIKE '%outbid%'</CFIF>
</CFQUERY>

<CFIF getLosers.RecordCount NEQ 0>
	<CFINCLUDE TEMPLATE="../system/emailBid.cfm">
	<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
	<CFIF e_fromnameBid NEQ "" AND e_fromnameBid NEQ " ">
		<CFSET e_fromemailBid = "#e_fromemailBid# (#e_fromnameBid#)">
	</CFIF>

	<CFMAIL QUERY="getLosers"
		FROM="#e_fromemailBid#"
		TO="#getLosers.email#"
		SUBJECT="Emaze Auction - Reserve Price Met"
		SERVER="#emailServer#">
This automated email was sent by Emaze Auction to notify you that the reserve price has now been met for this lot. You do not currently have a winning bid, but we thought you might be interested in raising you bid now that the reserve price has been met. Please feel free to submit an updated bid. Below is the relevant information.

Lot: #lotName#

Current Winning Bid: #LSCurrencyFormat(bidPrice,"local")#
<CFIF getLosers.bidAuto EQ 1>Your maximum bid: <CFELSE>Your bid: </CFIF>#LSCurrencyFormat(getLosers.bidPriceMaximum,"local")#

To increase your bid, go to:
#systemURL#/lot.cfm?lotID=#Form.lotID#

	</CFMAIL>
</CFIF>
