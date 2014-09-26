<!--- Emaze Auction version 2.1, 1.02 / Thursday, August 19, 1999 --->
<CFSETTING ENABLECFOUTPUTONLY="Yes">

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
	ORDER BY #reverseBidLogicOrder#, Bid.bidID
</CFQUERY>

<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
	<CFINCLUDE TEMPLATE="../systemProcure/procureEmailBid.cfm">
<CFELSE>
	<CFINCLUDE TEMPLATE="../system/emailBid.cfm">
</CFIF>
<CFIF e_fromnameBid NEQ "" AND e_fromnameBid NEQ " ">
	<CFSET e_fromemailBid = "#e_fromemailBid# (#e_fromnameBid#)">
</CFIF>

<!--- If low bid automatically wins, send normal email. If buyer chooses, send 2 --->
<CFIF reverseLowBidAutoWins EQ 1><CFSET emailNumber = ""><CFELSE><CFSET emailNumber = 2></CFIF>

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
					<CFINCLUDE TEMPLATE="../email/emailProcureBidLoseWin#emailNumber#.cfm">
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
					<CFINCLUDE TEMPLATE="../email/emailProcureBidQuantity#emailNumber#.cfm">
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
			<CFINCLUDE TEMPLATE="../email/emailProcureBidOutbid#emailNumber#.cfm">
		</CFIF>

	<!--- No more quantity available or will not accept partial quantity, but previously had winning bid --->
	<CFELSEIF getBids.bidWin EQ 1>
		<CFSET losers = ListAppend(losers,getBids.bidID)>
		<CFIF ListFind(forcedEmailEventsList,"outbid") OR ListFind(getBids.userEmailEvents,"outbid")>
			<CFINCLUDE TEMPLATE="../email/emailProcureBidOutbid#emailNumber#.cfm">
		</CFIF>
	</CFIF>

	<CFIF firstLosingBid EQ 1>
		<CFSET firstLosingBid = 2>
		<CFIF getBids.CurrentRow EQ getBids.RecordCount>
			<CFIF NOT IsDefined("firstPartialLoser")>
				<CFSET minimumWinningBid = Min(lotOpeningBid,getBids.bidPrice)>
			<CFELSE>
				<CFSET minimumWinningBid = Min(lotOpeningBid,firstPartialLoser)>
			</CFIF>
		<CFELSEIF getBids.bidAuto EQ 0 AND NOT IsDefined("autoBidderExists")>
			<CFSET minimumWinningBid = getBids.bidPrice>
		<CFELSEIF IsDefined("firstPartialWinner")>
			<CFSET minimumWinningBid = firstPartialWinner>
		<CFELSEIF NOT IsDefined("firstPartialLoser")>
			<CFSET minimumWinningBid = Min(getBids.bidPrice,ListGetAt(ValueList(getBids.bidPriceMaximum),getBids.CurrentRow + 1) - lotBidIncrement)>
		<CFELSE>
			<CFSET minimumWinningBid = Min(firstPartialLoser,ListGetAt(ValueList(getBids.bidPriceMaximum),getBids.CurrentRow + 1)) - lotBidIncrement>
		</CFIF>
		<CFSET newNextBidMinimum = minimumWinningBid - lotBidIncrement>
	</CFIF>
</CFLOOP>

<CFIF NOT IsDefined("newNextBidMinimum")>
	<CFIF quantityTaken LT lotQuantity>
		<CFSET minimumWinningBid = lotOpeningBid>
		<CFSET newNextBidMinimum = minimumWinningBid>
	<CFELSE>
		<CFSET minimumWinningBid = lotOpeningBid>
		<CFSET newNextBidMinimum = minimumWinningBid - lotBidIncrement>
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
		ORDER BY Bid.bidPriceMaximum DESC, Bid.bidID
	</CFQUERY>

	<CFIF NOT IsDefined("emailAutoBidderPartialQuantity")>
		<CFSET emailAutoBidderPartialQuantity = 0>
	</CFIF>

	<CFLOOP QUERY=getWinningBids>
		<CFIF getWinningBids.CurrentRow EQ getWinningBids.RecordCount AND IsDefined("firstPartialWinner")>
			<CFSET newBidPrice = firstPartialWinner - lotBidIncrement>
			<CFIF newBidPrice LT getWinningBids.bidPriceMaximum>
                <CFSET newBidPrice = getWinningBids.bidPriceMaximum>
	        </CFIF>
			<CFQUERY NAME=updateBid DATASOURCE="#EAdatasource#">
				UPDATE Bid
				SET bidPrice = #newBidPrice#
				WHERE bidID = #getWinningBids.bidID#
			</CFQUERY>
			<CFIF ListFind(forcedEmailEventsList,"autoBid") OR ListFind(getBids.userEmailEvents,"autoBid")>
				<CFINCLUDE TEMPLATE="../email/emailProcureBidAutobid#emailNumber#.cfm">
			</CFIF>
		<CFELSEIF getWinningBids.bidPrice GT minimumWinningBid>
			<CFIF getWinningBids.bidPriceMaximum LTE minimumWinningBid>
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
				<CFINCLUDE TEMPLATE="../email/emailProcureBidAutobid#emailNumber#.cfm">
			</CFIF>
		<CFELSEIF ListFind(forcedEmailEventsList,"outbid") OR ListFind(getBids.userEmailEvents,"outbid")>
			<CFIF emailAutoBidderPartialQuantity EQ getWinningBids.bidID>
				<CFINCLUDE TEMPLATE="../email/emailProcureBidQtyAutobid#emailNumber#.cfm">
			<CFELSEIF ListFind(emailAutoBidderLoseWin,getWinningBids.bidID) OR ListFind(emailAutoBidderNewQuantityWin,getWinningBids.bidID)>
				<CFINCLUDE TEMPLATE="../email/emailProcureBidLoseWinAutobid#emailNumber#.cfm">
			</CFIF>
		</CFIF>
	</CFLOOP>

	<CFIF IsDefined("checkLowestWinningBid")>
		<CFQUERY NAME=getLowestWinningBid DATASOURCE="#EAdatasource#">
			SELECT Max(bidPrice) AS minimumBidPrice
			FROM Bid
			WHERE lotID = #lotID# AND bidWin = 1
		</CFQUERY>
		<CFIF quantityTaken LT lotQuantity>
			<CFSET newNextBidMinimum = getLowestWinningBid.minimumBidPrice>
		<CFELSE>
			<CFSET newNextBidMinimum = getLowestWinningBid.minimumBidPrice - lotBidIncrement>
		</CFIF>
	</CFIF>
</CFIF>

<!--- Update Lot table --->
<CFQUERY NAME=updateLot DATASOURCE="#EAdatasource#">
	UPDATE Lot
	SET nextBidMinimum = #newNextBidMinimum#,
		nextNextBidMinimum = #newNextBidMinimum# - #lotBidIncrement#,
		lastBidDateTime = #bidDateTime#,
		secondLastBidDateTime = lastBidDateTime,
		lotQuantityTaken = #quantityTaken#,
		lotBidCount = lotBidCount + 1,
		<CFIF IsDefined("lotReservePriceMet")>lotReservePriceMet = #lotReservePriceMet#,</CFIF>
		lotBidsExist = 1,
		lotHighBid = #Min(lotOpeningBid, newNextBidMinimum + lotBidIncrement)#
	WHERE lotID = #lotID#
</CFQUERY>

</CFLOCK>
<CFSETTING ENABLECFOUTPUTONLY="No">
