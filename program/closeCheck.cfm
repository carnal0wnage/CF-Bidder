<!--- Emaze Auction version 2.1, 1.03 / Saturday, July 31, 1999 --->
<!---
Close bidding when after closing time if greater than required inactivity:
1. After closing time with no inactivity setting
2. After closing time when no bid within activity setting
--->

<CFINCLUDE TEMPLATE="../system/noBids.cfm">
<CFINCLUDE TEMPLATE="../system/reserve.cfm">
<CFINCLUDE TEMPLATE="../system/userList.cfm">

<CFIF IsDefined("IamTheScheduler") OR IsDefined("IamTheAdmin") OR IsDefined("IamTheMainAdmin")>
	<CFQUERY NAME=getCheckList DATASOURCE="#EAdatasource#">
		SELECT lotID, lotName, lotCloseDateTime, lotCloseInactivity, lotContactName, lotContactEmail,
			lastBidDateTime, nextBidMinimum, nextNextBidMinimum, secondLastBidDateTime
		<CFIF noBidsEmail EQ 1 OR noBidsStayOpen EQ 1 OR reserveNotMetEmail EQ 1 OR reserveStayOpen EQ 1>
			, lotType, lotReservePrice, lotReservePriceMet, lotReserveStayOpenTimes, lotBidsExist, lotNoBidsStayOpenTimes
		</CFIF>
		FROM Lot
		WHERE lotCloseQueue = 1 AND lotCloseDateTime <= #CreateODBCDateTime(Now())#
	</CFQUERY>
<CFELSEIF IsDefined("lotID") AND NOT IsDefined("lotID2")>
	<CFQUERY NAME=getCheckList DATASOURCE="#EAdatasource#">
		SELECT lotID, lotName, lotCloseDateTime, lotCloseInactivity, lotContactName, lotContactEmail,
			lastBidDateTime, nextBidMinimum, nextNextBidMinimum, secondLastBidDateTime
		<CFIF noBidsEmail EQ 1 OR noBidsStayOpen EQ 1 OR reserveNotMetEmail EQ 1 OR reserveStayOpen EQ 1>
			, lotType, lotReservePrice, lotReservePriceMet, lotReserveStayOpenTimes, lotBidsExist, lotNoBidsStayOpenTimes
		</CFIF>
		FROM Lot
		WHERE lotCloseQueue = 1 AND lotCloseDateTime <= #CreateODBCDateTime(Now())#
			AND lotID = #lotID#
	</CFQUERY>
<CFELSE>
	<CFQUERY NAME=getCheckList MAXROWS=5 DATASOURCE="#EAdatasource#">
		SELECT lotID, lotName, lotCloseDateTime, lotCloseInactivity, lotContactName, lotContactEmail,
			lastBidDateTime, nextBidMinimum, nextNextBidMinimum, secondLastBidDateTime
		<CFIF noBidsEmail EQ 1 OR noBidsStayOpen EQ 1 OR reserveNotMetEmail EQ 1 OR reserveStayOpen EQ 1>
			, lotType, lotReservePrice, lotReservePriceMet, lotReserveStayOpenTimes, lotBidsExist, lotNoBidsStayOpenTimes
		</CFIF>
		FROM Lot
		WHERE lotCloseQueue = 1 AND lotCloseDateTime <= #CreateODBCDateTime(Now())#
	</CFQUERY>
</CFIF>

<CFSET lotCloseUpdateList = 0>
<CFIF noBidsEmail NEQ 1 AND noBidsStayOpen NEQ 1 AND reserveNotMetEmail NEQ 1 AND reserveStayOpen NEQ 1>
	<CFLOOP QUERY="getCheckList">
		<CFIF getCheckList.lotCloseInactivity EQ 0 OR DateDiff("n",getCheckList.lastBidDateTime,Now()) GTE getCheckList.lotCloseInactivity>
			<CFFILE ACTION=Append FILE="#systemPath#\lot\#getCheckList.lotID#LotInfo.cfm" OUTPUT="<CFSET lotStatus = ""Closed"">">
			<CFSET lotCloseUpdateList = ListAppend(lotCloseUpdateList,getCheckList.lotID)>
		</CFIF>
	</CFLOOP>
<CFELSE><!--- Possibly extending closing time or sending emails because of no bids or not meeting reserve price --->
	<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
	<CFINCLUDE TEMPLATE="../system/emailClose.cfm">
	<CFIF e_fromnameClose NEQ "" AND e_fromnameClose NEQ " ">
		<CFSET e_fromemailClose = "#e_fromemailClose# (#e_fromnameClose#)">
	</CFIF>

	<CFLOOP QUERY="getCheckList">
		<CFSET closingTimeExtended = 0>
		<CFIF getCheckList.lotType NEQ 0 AND getCheckList.lotBidsExist EQ 0>
			<CFIF noBidsStayOpen EQ 1 AND getCheckList.lotNoBidsStayOpenTimes LT noBidsStayOpenTimes>
				<CFSET closingTimeExtended = 1>
				<CFSET newLotCloseDateTime = CreateODBCDateTime(DateAdd(noBidsStayOpenUnit,noBidsStayOpenNumber,getCheckList.lotCloseDateTime))>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#getCheckList.lotID#LotInfo.cfm"
					OUTPUT="<CFSET lotCloseDateTime = ""#newLotCloseDateTime#"">">
				<CFQUERY NAME=updateCloseTime DATASOURCE="#EAdatasource#">
					UPDATE Lot
					SET lotCloseDateTime = #newLotCloseDateTime#,
						lotNoBidsStayOpenTimes = lotNoBidsStayOpenTimes + 1
					WHERE lotID = #getCheckList.lotID#
				</CFQUERY>
				<CFIF noBidsEmail EQ 1><CFINCLUDE TEMPLATE="../email/emailCheckNoBidsExtended.cfm"></CFIF>
			</CFIF>

		<CFELSEIF getCheckList.lotType NEQ 0 AND getCheckList.lotReservePriceMet EQ 0>
			<CFIF reserveStayOpen EQ 1 AND getCheckList.lotReserveStayOpenTimes LT reserveStayOpenTimes>
				<CFSET closingTimeExtended = 1>
				<CFSET newLotCloseDateTime = CreateODBCDateTime(DateAdd(reserveStayOpenUnit,reserveStayOpenNumber,getCheckList.lotCloseDateTime))>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#getCheckList.lotID#LotInfo.cfm"
					OUTPUT="<CFSET lotCloseDateTime = ""#newLotCloseDateTime#"">">
				<CFQUERY NAME=updateCloseTime DATASOURCE="#EAdatasource#">
					UPDATE Lot
					SET lotCloseDateTime = #newLotCloseDateTime#,
						lotReserveStayOpenTimes = lotReserveStayOpenTimes + 1
					WHERE lotID = #getCheckList.lotID#
				</CFQUERY>

				<CFIF reserveNotMetEmail EQ 1><CFINCLUDE TEMPLATE="../email/emailCheckReserveExt.cfm"></CFIF>
				<CFIF reserveExtendedEmailWinners EQ 1 OR reserveExtendedEmailLosers EQ 1>
					<CFIF NOT IsDefined("IamTheScheduler") AND NOT IsDefined("IamTheAdmin") AND NOT IsDefined("IamTheMainAdmin")>
						<CFSET breakAfterLot = 1>
					</CFIF>
					<CFIF reserveExtendedEmailWinners EQ 1><CFINCLUDE TEMPLATE="../email/emailCheckReserveExtWin.cfm"></CFIF>
					<CFIF reserveExtendedEmailLosers EQ 1><CFINCLUDE TEMPLATE="../email/emailCheckReserveExtLoser.cfm"></CFIF>
				</CFIF>
			</CFIF>
			<CFIF IsDefined("breakAfterLot")><CFBREAK></CFIF>
		</CFIF>

		<!--- If sent reserve emails and not admin or scheduler, stop after this lot. --->
		<!--- If lot not extended, check whether to close. First if no inactivity setting. --->

		<CFIF closingTimeExtended EQ 0>
			<CFIF getCheckList.lotCloseInactivity EQ 0 OR DateDiff("n",getCheckList.lastBidDateTime,Now()) GTE getCheckList.lotCloseInactivity>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#getCheckList.lotID#LotInfo.cfm" OUTPUT="<CFSET lotStatus = ""Closed"">">
				<CFSET lotCloseUpdateList = ListAppend(lotCloseUpdateList,getCheckList.lotID)>
			</CFIF>
		</CFIF>
	</CFLOOP>
</CFIF>

<CFIF lotCloseUpdateList NEQ 0>
	<CFQUERY NAME=updateLotStatus DATASOURCE="#EAdatasource#">
		UPDATE Lot
		SET lotStatus = 'Closed',
			lotCloseQueue = 2
		WHERE lotID IN (#ListRest(lotCloseUpdateList)#)
	</CFQUERY>
<CFELSEIF NOT IsDefined("IamTheScheduler") AND NOT IsDefined("IamTheAdmin") AND NOT IsDefined("IamTheMainAdmin")>
	<CFINCLUDE TEMPLATE="../system/useScheduler.cfm">
	<CFIF useScheduler EQ 0>
		<CFQUERY NAME=getLotClose MAXROWS=1 DATASOURCE="#EAdatasource#">
			SELECT lotID, lotType
			FROM Lot
			WHERE lotCloseQueue = 2
			ORDER BY lotCloseDateTime
		</CFQUERY>
		<CFIF getLotClose.RecordCount EQ 1>
			<CFSET lotID = getLotClose.lotID>
			<CFIF getLotClose.lotType EQ 1>
				<CFINCLUDE TEMPLATE="closeLot.cfm">
			<CFELSEIF getLotClose.lotType EQ 0 AND FileExists("#systemPath#\program\closeMarket.cfm")>
				<CFINCLUDE TEMPLATE="closeMarket.cfm">
			<CFELSEIF getLotClose.lotType EQ -1 AND FileExists("#systemPath#\program\closeReverse.cfm")>
				<CFINCLUDE TEMPLATE="closeReverse.cfm">
			<CFELSE>
				<CFINCLUDE TEMPLATE="closeLot.cfm">
			</CFIF>
		</CFIF>
	</CFIF>
</CFIF>
