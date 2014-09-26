<!--- Emaze Auction version 2.1, 1.02 / Tuesday, July 13, 1999 --->
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
		lotNoBidsStayOpenTimes, lotReserveStayOpenTimes, lotType
	FROM Lot
	WHERE lotID = #lotID#
</CFQUERY>

<CFIF getLotInfo.RecordCount EQ 1><CFIF getLotInfo.lotCloseQueue EQ 2 AND getLotInfo.lotType NEQ 0>

<CFIF getLotInfo.userID NEQ "" AND getLotInfo.userID NEQ " " AND getLotInfo.userID GT 1>
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
		<CFINCLUDE TEMPLATE="../admin/sellerCommissionFeeLoop.cfm">
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
<CFELSEIF ListFind(closeLotEmailList,"adminEmail")>
	<CFIF ListFind(closeLotEmailList,"adminWin")>
		<CFINCLUDE TEMPLATE="../email/emailCloseAdminWinners.cfm">
	<CFELSE>
		<CFINCLUDE TEMPLATE="../email/emailCloseAdmin.cfm">
	</CFIF>
</CFIF>

<CFIF getLotInfo.lotReservePriceMet EQ 0 AND getLotInfo.lotBidsExist EQ 1>
	<CFIF reserveCloseWinnerEmail EQ "reserve">
		<CFINCLUDE TEMPLATE="../email/emailCloseReserveNotMetWin.cfm">
	<CFELSEIF reserveCloseWinnerEmail EQ "normal">
		<CFIF reserveCloseLoserEmail EQ "normal"><CFSET emailAllLosers = 1></CFIF>
		<CFINCLUDE TEMPLATE="../email/emailCloseLoser.cfm">
	</CFIF>
<CFELSEIF getLotInfo.lotBidsExist EQ 1 AND ListFind(closeLotEmailList,"winner")>
	<CFINCLUDE TEMPLATE="../email/emailCloseWinner.cfm">
</CFIF>

<CFIF getLotInfo.lotReservePriceMet EQ 0 AND getLotInfo.lotBidsExist EQ 1 AND reserveCloseLoserEmail EQ "reserve">
	<CFINCLUDE TEMPLATE="../email/emailCloseReserveLoser.cfm">
<CFELSEIF getLotInfo.lotBidsExist EQ 1 AND ListFind(closeLotEmailList,"loser") AND NOT IsDefined("emailAllLosers")>
	<CFINCLUDE TEMPLATE="../email/emailCloseLoser.cfm">
</CFIF>

<CFQUERY NAME=updateCloseLotQueue DATASOURCE="#EAdatasource#">
	UPDATE Lot
	SET lotCloseQueue = <CFIF NOT IsDefined("IamTheAdmin")>3<CFELSE>4</CFIF>
	WHERE lotID = #lotID#
</CFQUERY>

<CFQUERY NAME=updateCatCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categoryLotCount = categoryLotCount - 1
	WHERE categoryID = #getLotInfo.categoryID#
</CFQUERY>
<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
	SELECT categoryID1, categoryID2, categoryID3, categoryID4
	FROM Category
	WHERE categoryID = #getLotInfo.categoryID#
</CFQUERY>
<CFQUERY NAME=incrCatSubCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categorySubLotCount = categorySubLotCount - 1
	WHERE categoryID = #getCatID.categoryID1#
		OR categoryID = #getCatID.categoryID2#
		OR categoryID = #getCatID.categoryID3#
		OR categoryID = #getCatID.categoryID4#
</CFQUERY>	

</CFIF></CFIF><!--- end of if statement for whether lot exists, lotCloseQueue = 2 --->