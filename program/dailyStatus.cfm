<!--- Emaze Auction version 2.1, 1.03 / Wednesday, June 30, 1999 --->
<CFIF Find("emazedaily", CGI.QUERY_STRING) EQ 0>
	<H1>This is not your beautiful house.</H1>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<!---
1. Get list of categories with new items since last email
2. Get list of users who have:
	- bid on a lot that is still open
	- bid on a lot that has closed since last email
	- watched lot that is still open
	- watched lot that has closed since last email
	- subscribed to a category (or subcategory) with new items since the last email
3. Loop thru bidders - Get the appropriate lots for each bidder. Output in order.

OPEN LOTS USER BID ON
	Lot ID : #lotID#
	Name: #lotName#
	Quantity: #lotQuantity#
	Closes: #lotCloseDateTime#
	High Bid: #lotHighBid#
	Next Bid: #nextBidMinimum#

	Winning Bid? No/Yes (#bidQuantityWin# of #bidQuantity# requested)
	Your Bid: #bidPrice# (initial: #bidPriceInitial / max: #bidPriceMaximum#)
	Reserve Price Met/Not Met
	If Winning Bid: Total Price: #bidPrice# * #bidQuantityWin#

	Link to Lot

CLOSED LOTS USER BID ON
	Just do not display next bid
OPEN LOTS USER IS WATCHING
	Do not display any bid info
CLOSED LOTS USER IS WATCHING
	Just do not display next bid

NEW ITEMS FROM CATEGORIES SUBSCRIBED TO AND NOT WATCHING/BID ON

--->

<CFINCLUDE TEMPLATE="../system/dailyStatusOptions.cfm">
<CFIF e_fromnameDailyStatus NEQ "" AND e_fromnameDailyStatus NEQ " ">
	<CFSET e_fromemailDailyStatus = "#e_fromemailDailyStatus# (#e_fromnameDailyStatus#)">
</CFIF>

<CFINCLUDE TEMPLATE="../system/dailyStatusLastSent.cfm">

<CFIF subscribedCategory EQ 1>
	<CFQUERY NAME=getCategories DATASOURCE="#EAdatasource#">
		SELECT DISTINCT(Lot.categoryID), Category.categoryID1, categoryID2, categoryID3
		FROM Lot INNER JOIN Category ON Lot.categoryID = Category.categoryID
		WHERE Lot.lotCloseQueue = 1 AND Lot.lotDateTimeCreated >= #dailyStatusLastSent#
	</CFQUERY>
	<CFIF getCategories.RecordCount NEQ 0><CFSET subscribedCategory = 2></CFIF>
</CFIF>

<CFQUERY NAME=getBidders DATASOURCE="#EAdatasource#">
	<CFIF subscribedCategory EQ 2>
		SELECT DISTINCT(CategorySubscribe.userID), Member.email, Member.username
		FROM CategorySubscribe INNER JOIN Member ON CategorySubscribe.userID = Member.userID
		WHERE CategorySubscribe.categoryID = #ListFirst(ValueList(getCategories.categoryID))#
			OR CategorySubscribe.categoryID = #ListFirst(ValueList(getCategories.categoryID1))#
			OR CategorySubscribe.categoryID = #ListFirst(ValueList(getCategories.categoryID2))#
			OR CategorySubscribe.categoryID = #ListFirst(ValueList(getCategories.categoryID3))#
		<CFLOOP INDEX=catCount FROM=2 TO=#getCategories.RecordCount#>
			OR CategorySubscribe.categoryID = #ListGetAt(ValueList(getCategories.categoryID),catCount)#
			OR CategorySubscribe.categoryID = #ListGetAt(ValueList(getCategories.categoryID1),catCount)#
			OR CategorySubscribe.categoryID = #ListGetAt(ValueList(getCategories.categoryID2),catCount)#
			OR CategorySubscribe.categoryID = #ListGetAt(ValueList(getCategories.categoryID3),catCount)#
		</CFLOOP>
	</CFIF>
	<CFIF openLotsBid EQ 1 OR closedLotsBid EQ 1>
		<CFIF subscribedCategory EQ 2>UNION</CFIF>
		SELECT DISTINCT(Bid.userID), Member.email, Member.username
		FROM (Bid INNER JOIN Lot ON Bid.lotID = Lot.lotID) INNER JOIN Member ON Bid.userID = Member.userID
		<CFIF openLotsBid EQ 1 OR closedLotsBid EQ 1>
			WHERE Lot.lotCloseQueue = 1 OR (Lot.lotCloseQueue > 1 AND Lot.lotCloseDateTime >= #dailyStatusLastSent#)
		<CFELSEIF openLotsBid EQ 1>
			WHERE Lot.lotCloseQueue = 1
		<CFELSE>
			WHERE Lot.lotCloseQueue > 1 AND Lot.lotCloseDateTime >= #dailyStatusLastSent#
		</CFIF>
	</CFIF>
	<CFIF openLotsWatch EQ 1 OR closedLotsWatch EQ 1>
		<CFIF subscribedCategory EQ 2 OR openLotsBid EQ 1 OR closedLotsBid EQ 1>UNION</CFIF>
		SELECT DISTINCT(LotWatch.userID), Member.email, Member.username
		FROM (LotWatch INNER JOIN Lot ON LotWatch.lotID = Lot.lotID) INNER JOIN Member ON LotWatch.userID = Member.userID
		<CFIF openLotsWatch EQ 1 OR closedLotsWatch EQ 1>
			WHERE Lot.lotCloseQueue = 1 OR (Lot.lotCloseQueue > 1 AND Lot.lotCloseDateTime >= #dailyStatusLastSent#)
		<CFELSEIF openLotsWatch EQ 1>
			WHERE Lot.lotCloseQueue = 1
		<CFELSE>
			WHERE Lot.lotCloseQueue > 1 AND Lot.lotCloseDateTime >= #dailyStatusLastSent#
		</CFIF>
	</CFIF>
</CFQUERY>

<CFLOOP QUERY=getBidders>
	<CFSET bidderUserID = getBidders.userID>
	<CFSET bidderEmail = getBidders.email>
	<CFSET bidderUsername = getBidders.username>

	<CFSET dailyStatusEmail = " ">

	<CFIF openLotsBid EQ 1 OR closedLotsBid EQ 1>
		<CFQUERY NAME=getBids DATASOURCE="#EAdatasource#">
			SELECT Bid.lotID, Bid.bidPrice, Bid.bidAuto, Bid.bidPriceInitial, Bid.bidPriceMaximum,
				Bid.bidQuantity, Bid.bidQuantityWin, Bid.bidWin, Lot.lotName, Lot.lotQuantity,
				Lot.lotCloseDateTime, Lot.lotHighBid, Lot.nextBidMinimum, Lot.lotCloseQueue, Lot.lotReservePriceMet
			FROM Bid INNER JOIN Lot ON Bid.lotID = Lot.lotID
			WHERE Bid.userID = #bidderUserID#
			<CFIF openLotsBid EQ 1 OR closedLotsBid EQ 1>
				AND (Lot.lotCloseQueue = 1 OR (Lot.lotCloseQueue > 1 AND Lot.lotCloseDateTime >= #dailyStatusLastSent#))
			<CFELSEIF openLotsBid EQ 1>
				AND Lot.lotCloseQueue = 1
			<CFELSE>
				AND Lot.lotCloseQueue > 1 AND Lot.lotCloseDateTime >= #dailyStatusLastSent#)
			</CFIF>
			ORDER BY Lot.lotCloseQueue, Lot.lotCloseDateTime
		</CFQUERY>

		<CFSET beginOpenLotBidsDisplay = 0>
		<CFSET beginClosedLotBidsDisplay = 0>
		<CFIF ListFind(ValueList(getBids.lotCloseQueue),2)>
			<CFSET lastOpenLotBid = ListFind(ValueList(getBids.lotCloseQueue),2) - 1>
		<CFELSEIF ListFind(ValueList(getBids.lotCloseQueue),3)>
			<CFSET lastOpenLotBid = ListFind(ValueList(getBids.lotCloseQueue),3) - 1>
		<CFELSEIF ListFind(ValueList(getBids.lotCloseQueue),4)>
			<CFSET lastOpenLotBid = ListFind(ValueList(getBids.lotCloseQueue),4) - 1>
		<CFELSE>
			<CFSET lastOpenLotBid = 0>
		</CFIF>

		<CFLOOP QUERY=getBids>
			<CFIF lotCloseQueue EQ 1 AND beginOpenLotBidsDisplay EQ 0>
				<CFSET beginOpenLotBidsDisplay = 1>	
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#newLotSeparator#
#openLotsBidHeading#
#newLotSeparator#">
			<CFELSEIF lotCloseQueue GT 1 AND beginClosedLotBidsDisplay EQ 0>
				<CFSET beginClosedLotBidsDisplay = 1>	
				<CFSET dailyStatusEmail = "#dailyStatusEmail#

#newLotSeparator#
#closedLotsBidHeading#
#newLotSeparator#">
			</CFIF>

			<CFSET dailyStatusEmail = "#dailyStatusEmail#

#lotIDHeading# #lotID#
#lotNameHeading# #lotName#
#lotQuantityHeading# #lotQuantity#
#lotCloseDateTimeHeading# #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)#
#lotHighBidHeading# #LSCurrencyFormat(lotHighBid,'local')#">

			<CFIF lotCloseQueue EQ 1>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#nextBidMinimumHeading# #LSCurrencyFormat(nextBidMinimum,'local')#">
			</CFIF>

			<CFSET dailyStatusEmail = "#dailyStatusEmail#

#bidWinHeading# #Iif(bidWin EQ 1,'bidWinYesHeading','bidWinNoHeading')# (#bidQuantityWin# #bidQuantityWinHeading# #bidQuantity# #bidQuantityHeading#)
#bidPriceHeading# #LSCurrencyFormat(bidPrice,'local')#">

			<CFIF bidAuto EQ 1>
				<CFSET dailyStatusEmail = "#dailyStatusEmail# (#bidPriceInitialHeading# #LSCurrencyFormat(bidPriceInitial,'local')# / #bidPriceMaximumHeading# #LSCurrencyFormat(bidPriceMaximum,'local')#)">
			</CFIF>
			<CFIF bidWin EQ 1>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#bidTotalPriceHeading# #LSCurrencyFormat(bidPrice * bidQuantityWin,'local')#">
			</CFIF>
			<CFIF lotReservePriceMet EQ 0>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#lotReservePriceNotMetHeading#">
			<CFELSEIF lotReservePriceMet EQ 1>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#lotReservePriceMetHeading#">
			</CFIF>

			<CFSET dailyStatusEmail = "#dailyStatusEmail#

#systemURL#/lot.cfm?lotID=#lotID#">

			<CFIF getBids.CurrentRow NEQ getBids.RecordCount AND getBids.CurrentRow NEQ lastOpenLotBid>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#

#newLotSeparator#">
			</CFIF>
		</CFLOOP>
	</CFIF>


	<CFIF openLotsWatch EQ 1 OR closedLotsWatch EQ 1>
		<CFQUERY NAME=getWatch DATASOURCE="#EAdatasource#">
			SELECT LotWatch.lotID, Lot.lotName, Lot.lotQuantity, Lot.lotCloseQueue,
				Lot.lotCloseDateTime, Lot.lotHighBid, Lot.nextBidMinimum, Lot.lotReservePriceMet
			FROM LotWatch INNER JOIN Lot ON LotWatch.lotID = Lot.lotID
			WHERE LotWatch.userID = #bidderUserID#
			<CFIF openLotsWatch EQ 1 OR closedLotsWatch EQ 1>
				AND (Lot.lotCloseQueue = 1 OR (Lot.lotCloseQueue > 1 AND Lot.lotCloseDateTime >= #dailyStatusLastSent#))
			<CFELSEIF openLotsWatch EQ 1>
				AND Lot.lotCloseQueue = 1
			<CFELSE>
				AND Lot.lotCloseQueue > 1 AND Lot.lotCloseDateTime >= #dailyStatusLastSent#)
			</CFIF>
			ORDER BY Lot.lotCloseQueue, Lot.lotCloseDateTime
		</CFQUERY>

		<CFSET beginOpenLotWatchDisplay = 0>
		<CFSET beginClosedLotWatchDisplay = 0>
		<CFIF ListFind(ValueList(getWatch.lotCloseQueue),2)>
			<CFSET lastOpenLotWatch = ListFind(ValueList(getWatch.lotCloseQueue),2) - 1>
		<CFELSEIF ListFind(ValueList(getWatch.lotCloseQueue),3)>
			<CFSET lastOpenLotWatch = ListFind(ValueList(getWatch.lotCloseQueue),3) - 1>
		<CFELSEIF ListFind(ValueList(getWatch.lotCloseQueue),4)>
			<CFSET lastOpenLotWatch = ListFind(ValueList(getWatch.lotCloseQueue),4) - 1>
		<CFELSE>
			<CFSET lastOpenLotWatch = 0>
		</CFIF>

		<CFLOOP QUERY=getWatch>
			<CFIF lotCloseQueue EQ 1 AND beginOpenLotWatchDisplay EQ 0>
				<CFSET beginOpenLotWatchDisplay = 1>	
				<CFSET dailyStatusEmail = "#dailyStatusEmail#

#newLotSeparator#
#openLotsWatchHeading#
#newLotSeparator#">
			<CFELSEIF lotCloseQueue GT 1 AND beginClosedLotWatchDisplay EQ 0>
				<CFSET beginClosedLotWatchDisplay = 1>	
				<CFSET dailyStatusEmail = "#dailyStatusEmail#

#newLotSeparator#
#closedLotsWatchHeading#
#newLotSeparator#">
			</CFIF>

			<CFSET dailyStatusEmail = "#dailyStatusEmail#

#lotIDHeading# #lotID#
#lotNameHeading# #lotName#
#lotQuantityHeading# #lotQuantity#
#lotCloseDateTimeHeading# #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)#
#lotHighBidHeading# #LSCurrencyFormat(lotHighBid,'local')#">

			<CFIF lotCloseQueue EQ 1>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#nextBidMinimumHeading# #LSCurrencyFormat(nextBidMinimum,'local')#">
			</CFIF>
			<CFIF lotReservePriceMet EQ 0>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#lotReservePriceNotMetHeading#">
			<CFELSEIF lotReservePriceMet EQ 1>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#lotReservePriceMetHeading#">
			</CFIF>

			<CFSET dailyStatusEmail = "#dailyStatusEmail#

#systemURL#/lot.cfm?lotID=#lotID#">
			<CFIF getWatch.CurrentRow NEQ getWatch.RecordCount AND getWatch.CurrentRow NEQ lastOpenLotWatch>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#

#newLotSeparator#">
			</CFIF>
		</CFLOOP>
	</CFIF>


	<CFIF subscribedCategory EQ 2>
		<CFQUERY NAME=getSubscribed DATASOURCE="#EAdatasource#">
			SELECT Lot.lotID, Lot.lotOpeningBid, Lot.lotName, Lot.lotQuantity, Lot.lotCloseQueue,
				Lot.lotOpenDateTime, Lot.lotCloseDateTime, Lot.lotHighBid, Lot.nextBidMinimum,
				CategorySubscribe.categoryID, Category.categoryName
			FROM (CategorySubscribe INNER JOIN Lot ON CategorySubscribe.categoryID = Lot.categoryID)
				INNER JOIN Category ON CategorySubscribe.categoryID = Category.categoryID
			WHERE CategorySubscribe.userID = #bidderUserID#
				AND Lot.lotCloseQueue = 1
				AND Lot.lotDateTimeCreated >= #dailyStatusLastSent#
			<CFIF IsDefined("getBids")><CFLOOP QUERY=getBids>AND lotID <> #getBids.lotID# </CFLOOP></CFIF>
			<CFIF IsDefined("getWatch")><CFLOOP QUERY=getWatch>AND lotID <> #getWatch.lotID# </CFLOOP></CFIF>
		</CFQUERY>

		<CFIF getSubscribed.RecordCount NEQ 0>
			<CFSET dailyStatusEmail = "#dailyStatusEmail#

#newLotSeparator#
#subscribedCategoryHeading#
#newLotSeparator#">
		</CFIF>

		<CFSET previousCategoryID = 0>
		<CFLOOP QUERY=getSubscribed>
			<CFIF categoryID NEQ previousCategoryID>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#

#categoryNameHeading# #categoryName#
#systemURL#/category.cfm?categoryID=#categoryID#">
			</CFIF>

			<CFSET dailyStatusEmail = "#dailyStatusEmail#

#lotIDHeading# #lotID#
#lotNameHeading# #lotName#
#lotQuantityHeading# #lotQuantity#
#lotOpenDateTimeHeading# #LSDateFormat(lotOpenDateTime,dateFormatDisplay)# #LSTimeFormat(lotOpenDateTime,timeFormatDisplay)#
#lotCloseDateTimeHeading# #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)#
#lotOpeningBidHeading# #LSCurrencyFormat(lotOpeningBid,'local')#">

			<CFIF lotCloseQueue EQ 1>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#
#lotHighBidHeading# #LSCurrencyFormat(lotHighBid,'local')#
#nextBidMinimumHeading# #LSCurrencyFormat(nextBidMinimum,'local')#">
			</CFIF>

			<CFSET dailyStatusEmail = "#dailyStatusEmail#

#systemURL#/lot.cfm?lotID=#lotID#">
			<CFIF getSubscribed.CurrentRow NEQ getSubscribed.RecordCount>
				<CFSET dailyStatusEmail = "#dailyStatusEmail#

#newLotSeparator#">
			</CFIF>
			<CFSET previousCategoryID = categoryID>
		</CFLOOP>
	</CFIF>

	<CFIF dailyStatusEmail NEQ " ">
		<CFINCLUDE TEMPLATE="../email/emailDailyStatus.cfm">
	</CFIF>
</CFLOOP>

<CFFILE ACTION=Write FILE="#systemPath#\system\dailyStatusLastSent.cfm"
	OUTPUT="<CFSET dailyStatusLastSent = ""#CreateODBCDateTime(Now())#"">">
