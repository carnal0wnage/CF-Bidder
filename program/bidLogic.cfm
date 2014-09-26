<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFSETTING ENABLECFOUTPUTONLY="Yes">

<!---
1. Get all bidders in order of bidPriceMaximum DESC, bidID
2. Loop thru list of bidders in reserve order to determine who has winning bids and their quantity
	If bidQuantityWin is different than before, update bidQuantityWin
3. If won partial quantity and not autobidder:
	- Send partial quantity email if requested and if necessary
	- Update Bid to bidWin = 1, bid quantity if necessary
4. If previously had a winning bid, but now a losing bid:
	- Send loser before closing email if requested
	- Update Bid to bidWin = 0
5. Minimum winning bid is equal to next bid after quantity runs out
6. Get winning bidders by bidPriceMaximum, bidID
7. Determine bid for each autobidder
8. If bidPrice or bidQuantityWin changed and if necessary, email autobidder
9. If partial quality autobidder had different bidPrice or bidQuantityWin, and if necessary, email
10. Update minimum winning bid, bid quantity win, etc. in Lot table
--->

<CFLOCK TIMEOUT=10 NAME="#systemDomain#emaze#lotID#">

<CFSET quantityTaken = 0>
<!--- <CFSET quantityRequested = 0> --->
<CFSET lowestWinningBidPrice = 0>
<CFSET firstLosingBid = 0>
<CFSET emailAutoBidderNewQuantityWin = 0>
<CFSET emailAutoBidderLoseWin = 0>
<CFSET losers = 0>

<CFQUERY NAME=getBids DATASOURCE="#EAdatasource#">
	SELECT Bid.bidID, Bid.bidPriceMaximum, Bid.bidQuantity, Bid.bidPrice,
		Bid.bidAuto, Bid.bidFullQuantityOnly, Bid.bidQuantityWin, Bid.bidEditDateTime,
		Bid.bidPriceInitial, Bid.bidWin, Member.email, Member.userEmailEvents
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #lotID#
	ORDER BY #bidLogicOrder#, Bid.bidID
</CFQUERY>

<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
<CFINCLUDE TEMPLATE="../system/emailBid.cfm">
<CFIF e_fromnameBid NEQ "" AND e_fromnameBid NEQ " ">
	<CFSET e_fromemailBid = "#e_fromemailBid# (#e_fromnameBid#)">
</CFIF>

<CFLOOP QUERY=getBids>
	<!--- <CFSET quantityRequested = quantityRequested + getBids.bidQuantity> --->
	<CFIF (quantityTaken + getBids.bidQuantity) LTE lotQuantity>
		<CFSET quantityTaken = quantityTaken + getBids.bidQuantity>

		<CFIF getBids.bidQuantity NEQ getBids.bidQuantityWin OR getBids.bidWin EQ 0>
			<CFQUERY NAME=updateBid DATASOURCE="#EAdatasource#">
				UPDATE Bid
				SET	bidWin = 1,
					bidQuantityWin = #getBids.bidQuantity#,
					bidUpdateDateTime = #bidDateTime#
				WHERE bidID = #getBids.bidID#
			</CFQUERY>

			<CFIF ListFind(forcedEmailEventsList,"outbid") OR ListFind(getBids.userEmailEvents,"outbid")>
				<CFIF getBids.bidAuto EQ 0>
					<CFINCLUDE TEMPLATE="../email/emailBidLoseWin.cfm">
				<CFELSEIF getBids.bidWin EQ 0>
					<CFSET emailAutoBidderLoseWin = ListAppend(emailAutoBidderLoseWin,getBids.bidID)>
				<CFELSE>
					<CFSET emailAutoBidderNewQuantityWin = ListAppend(emailAutoBidderNewQuantityWin,getBids.bidID)>
				</CFIF>
			</CFIF>
		</CFIF>

		<CFIF getBids.bidAuto EQ 1><CFSET autoBidderExists = 1></CFIF>
		<CFIF quantityTaken EQ lotQuantity><CFSET firstLosingBid = 1></CFIF>

	<!--- If accept partial quantity --->
	<CFELSEIF quantityTaken LT lotQuantity AND getBids.bidFullQuantityOnly EQ 0>
		<CFSET newBidQuantityWin = lotQuantity - quantityTaken>
		<CFSET quantityTaken = lotQuantity>

		<CFIF newBidQuantityWin NEQ getBids.bidQuantityWin OR getBids.bidWin EQ 0>
			<CFQUERY NAME=updatePartial DATASOURCE="#EAdatasource#">
				UPDATE Bid
				SET	bidWin = 1,
					bidQuantityWin = #newBidQuantityWin#,
					bidUpdateDateTime = #bidDateTime#
				WHERE bidID = #getBids.bidID#
			</CFQUERY>

			<CFIF ListFind(forcedEmailEventsList,"outbid") OR ListFind(getBids.userEmailEvents,"outbid")>
				<CFIF bidAuto EQ 0 AND NOT IsDefined("autoBidderExists")>
					<CFINCLUDE TEMPLATE="../email/emailBidQuantity.cfm">
				<CFELSEIF getBids.bidWin EQ 0>
					<CFSET emailAutoBidderLoseWin = ListAppend(emailAutoBidderLoseWin,getBids.bidID)>
				<CFELSE><!--- IF newBidQuantityWin NEQ getBids.bidQuantityWin --->
					<CFSET emailAutoBidderPartialQuantity = getBids.bidID>
				</CFIF>
			</CFIF>
		</CFIF>

		<CFIF getBids.bidAuto EQ 1><CFSET autoBidderExists = 1></CFIF>
		<CFSET firstLosingBid = 1>
		<CFSET firstPartialWinner = getBids.bidPriceMaximum>

	<!--- No more quantity available. Will not accept partial quantity, but still needs to influence price --->
	<CFELSEIF quantityTaken LT lotQuantity AND NOT IsDefined("firstPartialLoser")>
		<CFSET firstPartialLoser = getBids.bidPriceMaximum>
		<CFSET losers = ListAppend(losers,getBids.bidID)>
		<CFIF ListFind(forcedEmailEventsList,"outbid") OR ListFind(getBids.userEmailEvents,"outbid")>
			<CFINCLUDE TEMPLATE="../email/emailBidOutbid.cfm">
		</CFIF>

	<!--- No more quantity available or will not accept partial quantity, but previously had winning bid --->
	<CFELSEIF getBids.bidWin EQ 1>
		<CFSET losers = ListAppend(losers,getBids.bidID)>
		<CFIF ListFind(forcedEmailEventsList,"outbid") OR ListFind(getBids.userEmailEvents,"outbid")>
			<CFINCLUDE TEMPLATE="../email/emailBidOutbid.cfm">
		</CFIF>
	</CFIF>

	<CFIF firstLosingBid EQ 1>
		<CFSET firstLosingBid = 2>
		<CFIF getBids.CurrentRow EQ getBids.RecordCount>
			<CFIF NOT IsDefined("firstPartialLoser")>
				<CFSET minimumWinningBid = Max(lotOpeningBid,getBids.bidPrice)>
			<CFELSE>
				<CFSET minimumWinningBid = Max(lotOpeningBid,firstPartialLoser)>
			</CFIF>
		<CFELSEIF getBids.bidAuto EQ 0 AND NOT IsDefined("autoBidderExists")>
			<CFSET minimumWinningBid = getBids.bidPrice>
		<CFELSEIF IsDefined("firstPartialWinner")>
			<CFSET minimumWinningBid = firstPartialWinner>
		<CFELSEIF NOT IsDefined("firstPartialLoser")>
			<CFSET minimumWinningBid = Max(getBids.bidPrice,ListGetAt(ValueList(getBids.bidPriceMaximum),getBids.CurrentRow + 1) + lotBidIncrement)>
		<CFELSE>
			<CFSET minimumWinningBid = Max(firstPartialLoser,ListGetAt(ValueList(getBids.bidPriceMaximum),getBids.CurrentRow + 1)) + lotBidIncrement>
		</CFIF>
		<CFSET newNextBidMinimum = minimumWinningBid + lotBidIncrement>
	</CFIF>
</CFLOOP>

<CFIF NOT IsDefined("newNextBidMinimum")>
	<CFIF quantityTaken LT lotQuantity>
		<CFSET minimumWinningBid = lotOpeningBid>
		<CFSET newNextBidMinimum = minimumWinningBid>
	<CFELSE>
		<CFSET minimumWinningBid = lotOpeningBid>
		<CFSET newNextBidMinimum = minimumWinningBid + lotBidIncrement>
	</CFIF>
</CFIF>

<CFIF losers NEQ 0>
	<CFQUERY NAME=updateLosers DATASOURCE="#EAdatasource#">
		UPDATE Bid
		SET bidWin = 0,
			bidQuantityWin = 0,
			bidUpdateDateTime = #bidDateTime#,
			bidPrice = bidPriceMaximum
		WHERE bidID = #ListGetAt(losers,2)#
		<CFLOOP INDEX="bidCount" FROM=3 TO=#ListLen(losers)#>
			OR bidID = #ListGetAt(losers,bidCount)#
		</CFLOOP>
	</CFQUERY>
</CFIF>

<!--- Get winning bidders to determine auto-bidders current price, determine whether to send emails --->
<CFIF IsDefined("autoBidderExists") OR IsDefined("emailAutoBidderPartialQuantity")>
	<CFQUERY NAME=getWinningBids DATASOURCE="#EAdatasource#">
		SELECT Bid.bidID, Bid.bidPriceMaximum, Bid.bidQuantity, Bid.bidPrice,
			Bid.bidAuto, Bid.bidQuantityWin, Bid.bidPriceInitial,
			Member.email, Member.userEmailEvents
		FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
		WHERE Bid.lotID = #lotID# AND Bid.bidAuto = 1 AND Bid.bidWin = 1
		ORDER BY Bid.bidPriceMaximum, Bid.bidID
	</CFQUERY>

	<CFIF NOT IsDefined("emailAutoBidderPartialQuantity")>
		<CFSET emailAutoBidderPartialQuantity = 0>
	</CFIF>

	<!---
	If bidPrice LT minimumWinningBid:
		bidPrice = minimumWinningBid
		Update Bid
		If should be emailed, send email
	Elseif should be emailed:
		If partial winning (emailAutoBidderPartialQuantity = bidID), send email
		Elseif bidWin changed (bidID in emailAutoBidderLoseWin), send email
		Elseif won full quantity after partial quantity before (bidID in emailAutoBidderNewQuantityWin), send email
	--->

	<CFLOOP QUERY=getWinningBids>
		<CFIF getWinningBids.CurrentRow EQ getWinningBids.RecordCount AND IsDefined("firstPartialWinner")>
			<CFSET newBidPrice = firstPartialWinner + lotBidIncrement>
			<CFIF newBidPrice GT getWinningBids.bidPriceMaximum>
                <CFSET newBidPrice = getWinningBids.bidPriceMaximum>
	        </CFIF>
			<CFQUERY NAME=updateBid DATASOURCE="#EAdatasource#">
				UPDATE Bid
				SET bidPrice = #newBidPrice#
				WHERE bidID = #getWinningBids.bidID#
			</CFQUERY>
			<CFIF ListFind(forcedEmailEventsList,"autoBid") OR ListFind(getBids.userEmailEvents,"autoBid")>
				<CFINCLUDE TEMPLATE="../email/emailBidAutobid.cfm">
			</CFIF>
		<CFELSEIF getWinningBids.bidPrice LT minimumWinningBid>
			<CFIF getWinningBids.bidPriceMaximum GTE minimumWinningBid>
				<CFSET newBidPrice = minimumWinningBid>
			<CFELSE>
				<CFSET newBidPrice = getWinningBids.bidPriceMaximum>
				<CFSET checkLowestWinningBid = 1>
			</CFIF>
			<CFQUERY NAME=updateBid DATASOURCE="#EAdatasource#">
				UPDATE Bid
				SET bidPrice = #newBidPrice#
				WHERE bidID = #getWinningBids.bidID#
			</CFQUERY>
			<CFIF ListFind(forcedEmailEventsList,"autoBid") OR ListFind(getBids.userEmailEvents,"autoBid")>
				<CFINCLUDE TEMPLATE="../email/emailBidAutobid.cfm">
			</CFIF>
		<CFELSEIF ListFind(forcedEmailEventsList,"outbid") OR ListFind(getBids.userEmailEvents,"outbid")>
			<CFIF emailAutoBidderPartialQuantity EQ getWinningBids.bidID>
				<CFINCLUDE TEMPLATE="../email/emailBidQtyAutobid.cfm">
			<CFELSEIF ListFind(emailAutoBidderLoseWin,getWinningBids.bidID) OR ListFind(emailAutoBidderNewQuantityWin,getWinningBids.bidID)>
				<CFINCLUDE TEMPLATE="../email/emailBidLoseWinAutobid.cfm">
			</CFIF>
		</CFIF>
	</CFLOOP>

	<CFIF IsDefined("checkLowestWinningBid")>
		<CFQUERY NAME=getLowestWinningBid DATASOURCE="#EAdatasource#">
			SELECT Min(bidPrice) AS minimumBidPrice
			FROM Bid
			WHERE lotID = #lotID# AND bidWin = 1
		</CFQUERY>
		<CFIF quantityTaken LT lotQuantity>
			<CFSET newNextBidMinimum = getLowestWinningBid.minimumBidPrice>
		<CFELSE>
			<CFSET newNextBidMinimum = getLowestWinningBid.minimumBidPrice + lotBidIncrement>
		</CFIF>
	</CFIF>
</CFIF>

<!--- Update Lot table --->
<CFQUERY NAME=updateLot DATASOURCE="#EAdatasource#">
	UPDATE Lot
	SET nextBidMinimum = #newNextBidMinimum#,
		nextNextBidMinimum = #newNextBidMinimum# + #lotBidIncrement#,
		lastBidDateTime = #bidDateTime#,
		secondLastBidDateTime = lastBidDateTime,
		lotQuantityTaken = #quantityTaken#,
		lotBidCount = lotBidCount + 1,
		<CFIF IsDefined("lotReservePriceMet")>lotReservePriceMet = #lotReservePriceMet#,</CFIF>
		lotBidsExist = 1,
		lotHighBid = #Max(lotOpeningBid, newNextBidMinimum - lotBidIncrement)#
	WHERE lotID = #lotID#
</CFQUERY>

</CFLOCK>
<CFSETTING ENABLECFOUTPUTONLY="No">
