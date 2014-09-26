<!--- Emaze Auction version 2.1 / Monday, September 7, 1999 --->
<CFIF NOT IsDefined("lotID")>
	<HTML><BODY>
	<H2>This is not your beautiful house.</H2>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	</BODY></HTML><CFABORT>
</CFIF>
<!---
When closing an auction, need to do the following:
If contact person should be emailed to notify that lot has closed:
	If include list of winning bidders in email
		Get winning bidders and info
		Send email
	Else send email
If winning bidders should be emailed automatically:
	Get all winning bidders who want to be emailed.
	Email them.
If losing bidders should be emailed automatically:
	Get all losing bidders who want to be emailed.
	Email them.
--->

<CFQUERY NAME=getLotInfo DATASOURCE="#EAdatasource#">
	SELECT lotContactName, lotContactEmail, lotName, nextBidMinimum, lotBidIncrement, categoryID, userID,
		lotReservePrice, lotReservePriceMet, lotBidsExist, lotCloseQueue,
		lotNoBidsStayOpenTimes, lotReserveStayOpenTimes, lotType,
		lotProcureBidDescription, lotProcureLowBidAutoWins
	FROM Lot
	WHERE lotID = #lotID#
</CFQUERY>

<CFIF getLotInfo.RecordCount EQ 1><CFIF getLotInfo.lotCloseQueue EQ 2 AND getLotInfo.lotType EQ -1>
	<!---
	If low bid automatically wins, run thru
	Elseif no bids or reserve not met or seller has made decision now, run thru
	Elseif waiting for seller to make decision
		- Email seller with bids and request to choose
		- Email bidders telling bidding has closed, waiting for seller to choose winner
	 --->

<CFIF getLotInfo.userID NEQ "" AND getLotInfo.userID NEQ " " AND getLotInfo.userID GT 1
		AND (IsDefined("procureBidCloseManual") OR getLotInfo.lotProcureLowBidAutoWins EQ 1)>
	<CFIF getLotInfo.lotReservePriceMet EQ 0>
		<CFQUERY NAME=updateFee DATASOURCE="#EAdatasource#">
			UPDATE Fee
			SET commissionFee = 0,
				commissionFeeFinal = 1
			WHERE lotID = #lotID#
		</CFQUERY>
	<CFELSE>
		<CFQUERY NAME=getSellerLots DATASOURCE="#EAdatasource#">
			SELECT Fee.lotID, Fee.commissionFee, Bid.bidPrice, Bid.bidQuantityWin, Lot.lotCloseQueue,
				Fee.insertionFee, Fee.boldFee, Fee.featuredCategoryFee, Fee.featuredHomepageFee
			FROM (Bid INNER JOIN Lot ON Bid.lotID = Lot.lotID) INNER JOIN Fee ON Bid.lotID = Fee.lotID
			WHERE Fee.lotID = #lotID# AND Bid.bidWin = 1
		</CFQUERY>
		<CFINCLUDE TEMPLATE="../admin/procureCommissionFeeLoop.cfm">
	</CFIF>

	<CFINCLUDE TEMPLATE="../systemProcure/procureFeeBidderBid.cfm">
	<CFINCLUDE TEMPLATE="../systemProcure/procureFeeBidderWin.cfm">
	<CFSET sellerID = getLotInfo.userID>

	<!--- Charge for bid views : All or by unique IP address only --->
	<CFIF getLotInfo.lotProcureBidDescription EQ 1 AND procureFeeBidView GT 0>
		<CFIF procureFeeBidViewUnique EQ 0>
			<CFQUERY NAME=getBidViews DATASOURCE="#EAdatasource#">
				SELECT Distinct(userID), Count(userID) AS bidCount, bidID
				FROM BidDescriptionView
				WHERE lotID = #lotID#
				GROUP BY userID
				ORDER BY userID
			</CFQUERY>
		<CFELSE>
			<CFQUERY NAME=getBidViews DATASOURCE="#EAdatasource#">
				SELECT userID, bidID, IPaddress
				FROM BidDescriptionView
				WHERE lotID = #lotID#
				ORDER BY userID, IPaddress
			</CFQUERY>
		</CFIF>
		<CFINCLUDE TEMPLATE="../admin/procureBidViewFee.cfm">
	</CFIF>

	<!--- Charge for bidding or being a winning bidder --->
	<CFIF getLotInfo.lotReservePriceMet NEQ 0 AND (procureFeeBidInsertion GT 0 OR procureFeeBidInsertionVary EQ 1
			OR procureFeeBidCommissionPercent GT 0 OR procureFeeBidCommissionMinimum GT 0 OR procureFeeBidCommissionVary EQ 1)>
		<CFQUERY NAME=getFeeBids DATASOURCE="#EAdatasource#">
			SELECT bidID, bidWin, bidQuantity, bidQuantityWin, bidPrice, bidPriceInitial, bidPriceMaximum, userID
			FROM Bid
			WHERE lotID = #lotID#
			<CFIF procureFeeBidInsertion EQ 0 AND procureFeeBidInsertionVary EQ 0> AND bidWin = 1</CFIF>
		</CFQUERY>
		<CFINCLUDE TEMPLATE="../admin/procureBidderFeeLoop.cfm">
	<CFELSE>
		<CFQUERY NAME=closeBidFee DATASOURCE="#EAdatasource#">
			UPDATE FeeBid
			SET bidFeeFinal = 1
			WHERE lotID = #lotID#
		</CFQUERY>
	</CFIF>
</CFIF>

<!--- Determine email server, and who the email is from --->
<CFINCLUDE TEMPLATE="../system/closeLotEmailList.cfm">
<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
<CFINCLUDE TEMPLATE="../system/reserve.cfm">
<CFINCLUDE TEMPLATE="../system/emailClose.cfm">
<CFIF e_fromnameClose NEQ "" AND e_fromnameClose NEQ " ">
	<CFSET e_fromemailClose = "#e_fromemailClose# (#e_fromnameClose#)">
</CFIF>

<!--- If low bid automatically wins, send normal email. If buyer chooses, send 2 --->
<CFIF getLotInfo.lotProcureLowBidAutoWins EQ 1><CFSET emailNumber = "">
<CFELSEIF NOT IsDefined("procureBidCloseManual")><CFSET emailNumber = 2>
<CFELSE><CFSET emailNumber = 3></CFIF>

<CFIF getLotInfo.lotBidsExist EQ 0 AND ListFind(closeLotEmailList,"adminEmail")>
	<CFINCLUDE TEMPLATE="../system/noBids.cfm">
	<CFIF noBidsStayOpen EQ 1 AND getLotInfo.lotNoBidsStayOpenTimes GTE noBidsStayOpenTimes>
		<CFINCLUDE TEMPLATE="../email/emailCloseNoBidsExtendedMax.cfm">
	<CFELSE>
		<CFINCLUDE TEMPLATE="../email/emailCloseNoBids.cfm">
	</CFIF>
<CFELSEIF getLotInfo.lotReservePriceMet EQ 0 AND ListFind(closeLotEmailList,"adminEmail")>
	<CFINCLUDE TEMPLATE="../system/reserve.cfm">
	<CFIF reserveStayOpen EQ 1 AND getLotInfo.lotReserveStayOpenTimes GTE reserveStayOpenTimes>
		<CFINCLUDE TEMPLATE="../email/emailCloseReserveNotMetExtMax.cfm">
	<CFELSE>
		<CFINCLUDE TEMPLATE="../email/emailCloseReserveNotMet.cfm">
	</CFIF>
<CFELSE>
	<CFINCLUDE TEMPLATE="../email/emailProcureCloseSeller#emailNumber#.cfm">
</CFIF>

<CFIF getLotInfo.lotReservePriceMet EQ 0 AND getLotInfo.lotBidsExist EQ 1>
	<CFIF reserveCloseWinnerEmail EQ "reserve">
		<CFINCLUDE TEMPLATE="../email/emailCloseReserveNotMetWin.cfm">
	<CFELSEIF reserveCloseWinnerEmail EQ "normal">
		<CFIF reserveCloseLoserEmail EQ "normal"><CFSET emailAllLosers = 1></CFIF>
		<CFINCLUDE TEMPLATE="../email/emailProcureCloseLoser#emailNumber#.cfm">
	</CFIF>
<CFELSEIF getLotInfo.lotBidsExist EQ 1 AND ListFind(closeLotEmailList,"winner")>
	<CFINCLUDE TEMPLATE="../email/emailProcureCloseWinner#emailNumber#.cfm">
</CFIF>

<CFIF getLotInfo.lotReservePriceMet EQ 0 AND getLotInfo.lotBidsExist EQ 1 AND reserveCloseLoserEmail EQ "reserve">
	<CFINCLUDE TEMPLATE="../email/emailCloseReserveLoser.cfm">
<CFELSEIF getLotInfo.lotBidsExist EQ 1 AND ListFind(closeLotEmailList,"loser") AND NOT IsDefined("emailAllLosers")>
	<CFINCLUDE TEMPLATE="../email/emailProcureCloseLoser#emailNumber#.cfm">
</CFIF>

<CFQUERY NAME=updateCloseLotQueue DATASOURCE="#EAdatasource#">
	UPDATE Lot
	SET lotCloseQueue = 
	<CFIF IsDefined("procureBidCloseManual")>3
	<CFELSEIF getLotInfo.lotProcureLowBidAutoWins EQ 0 AND getLotInfo.lotReservePriceMet NEQ 0>5
	<CFELSEIF NOT IsDefined("IamTheAdmin")>3
	<CFELSE>4</CFIF>
	WHERE lotID = #lotID#
</CFQUERY>

<CFQUERY NAME=updateCatCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categoryProcureCount = categoryProcureCount - 1
	WHERE categoryID = #getLotInfo.categoryID#
</CFQUERY>
<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
	SELECT categoryID1, categoryID2, categoryID3, categoryID4
	FROM Category
	WHERE categoryID = #getLotInfo.categoryID#
</CFQUERY>
<CFQUERY NAME=incrCatSubCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categorySubProcureCount = categorySubProcureCount - 1
	WHERE categoryID = #getCatID.categoryID1#
		OR categoryID = #getCatID.categoryID2#
		OR categoryID = #getCatID.categoryID3#
		OR categoryID = #getCatID.categoryID4#
</CFQUERY>	

</CFIF></CFIF><!--- end of if statement for whether lot exists, lotCloseQueue = 2 --->