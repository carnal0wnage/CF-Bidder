<!--- Emaze Auction version 2.1, 1.05 / Sunday, August 22, 1999 --->
<CFSETTING ENABLECFOUTPUTONLY="Yes">
<CFINCLUDE TEMPLATE="../system/bidReverse.cfm">

<CFINCLUDE TEMPLATE="../lot/#Form.lotID#LotInfo.cfm">
<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
	SELECT nextBidMinimum, nextNextBidMinimum, lotReservePriceMet, lotBidsExist, lastBidDateTime
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, lotProcureLowBidAutoWins, lotProcureBidAboveOpeningBid, lotProcureBidDescription</CFIF>
	FROM Lot
	WHERE lotID = #lotID#
</CFQUERY>
<CFINCLUDE TEMPLATE="../system/bidOptions.cfm">
<CFINCLUDE TEMPLATE="../system/bidErrors.cfm">

<CFIF ListFindNoCase(getLot.ColumnList,"lotProcureBidDescription")>
	<CFSET reverseLowBidAutoWins = getLot.lotProcureLowBidAutoWins>
	<CFSET reverseBidAboveOpeningBid = getLot.lotProcureBidAboveOpeningBid>
	<CFSET reverseBidDescription = getLot.lotProcureBidDescription>
</CFIF>

<CFIF Form.bidButton EQ bidButtonReject>
	<CFSETTING ENABLECFOUTPUTONLY="No">
	<CFLOCATION URL="#systemURL#/lot.cfm?lotID=#Form.lotID#">
</CFIF>

<CFIF DateCompare(lotCloseDateTime,Now()) NEQ 1 AND NOT IsDefined("IamOfflineBidder")>
	<CFIF lotCloseBasis EQ "time" OR (lotCloseBasis EQ "timeInactivity"
			AND DateDiff("n",getLot.lastBidDateTime,Now()) GTE lotCloseInactivity)>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<HTML><HEAD><TITLE><CFOUTPUT>#indexTitle# - #lotClosedTitle#</CFOUTPUT></TITLE></HEAD>
		<CFINCLUDE TEMPLATE="../system/bodytag.cfm">
		<CFOUTPUT>#lotClosedBody#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML>
		<CFINCLUDE TEMPLATE="closeCheck.cfm">
		<CFABORT>
	</CFIF>
</CFIF>

<CFSET badBid = 0>
<CFIF IsDefined("Form.useCookie") AND IsDefined("Cookie.EmazeAuction_user")>
	<!--- Check userID/username combo --->
	<CFQUERY NAME="checkUser" DATASOURCE="#EAdatasource#">
		SELECT userID, email, userStatus, userVerifyCode
		FROM Member
		WHERE username = '#ListGetAt(Cookie.EmazeAuction_user,2)#'
			AND userID = #ListGetAt(Cookie.EmazeAuction_user,1)#
	</CFQUERY>
	<CFIF checkUser.RecordCount NEQ 1><!--- user does not exist --->
		<CFSET badBid = ListAppend(badBid,"badCookie")>
		<CFCOOKIE NAME="EmazeAuction_user" VALUE="none" EXPIRES=Now>
	<CFELSEIF checkUser.userID EQ userID AND userID NEQ 1>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFSET title = noBidOnOwnItemTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<P><CFOUTPUT>#noBidOnOwnItemBody#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	<CFELSE>
		<CFSET bidderUserID = ListGetAt(Cookie.EmazeAuction_user,1)>
	</CFIF>
<CFELSEIF Form.username NEQ "" AND Form.password NEQ "">
	<!--- Ensure username/password combo is correct. --->
	<CFQUERY NAME="checkUser" DATASOURCE="#EAdatasource#">
		SELECT userID, useCookie, email, userStatus, userVerifyCode, password
		FROM Member
		WHERE username = '#Form.username#'
	</CFQUERY>
	<CFIF checkUser.RecordCount NEQ 1>
		<CFSET badBid = ListAppend(badBid,"badLogin")>
	<CFELSEIF NOT IsDefined("Form.IamOfflineBidder") AND Form.password NEQ Decrypt(checkUser.password,encryptionCode)>
		<CFSET badBid = ListAppend(badBid,"badLogin")>
	<CFELSEIF checkUser.userID EQ userID AND userID NEQ 1>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFSET title = noBidOnOwnItemTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<P><CFOUTPUT>#noBidOnOwnItemBody#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	<CFELSE>
		<CFSET bidderUserID = checkUser.userID>
		<CFINCLUDE TEMPLATE="../system/useCookies.cfm">
		<CFIF checkUser.useCookie EQ 1 AND allowCookieLogin EQ 1>
			<CFIF NOT IsDefined("Cookie.EmazeAuction_user")><CFSET metaredirect = 1></CFIF>
			<CFCOOKIE NAME="EmazeAuction_user" VALUE="#bidderUserID#,#Form.username#" EXPIRES="Never">
		<CFELSEIF checkUser.useCookie EQ 1 AND allowCookieBid EQ 1>
			<CFIF NOT IsDefined("Cookie.EmazeAuction_user")><CFSET metaredirect = 1></CFIF>
			<CFCOOKIE NAME="EmazeAuction_user" VALUE="#bidderUserID#,#Form.username#">
		</CFIF>
	</CFIF>
<CFELSE><!--- Form.username EQ "" OR Form.password EQ "" --->
	<CFSET badBid = ListAppend(badBid,"badLogin")>
</CFIF>

<!---
1. Get user status, email address
2. If user exists
	If user status is not approved and must be before bidding:
		a. Output message saying they verify their email address
		b. Ask if they received email. If yes, click URL or copy to browser.
			If no, click to receive another one. 
--->

<CFSETTING ENABLECFOUTPUTONLY="No">
<CFIF badBid EQ 0 AND NOT IsDefined("IamOfflineBidder")>
	<CFIF checkUser.userStatus EQ -1>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFSET title = bidderBanishedTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<P>
		<CFOUTPUT>#bidderBanishedBody#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	<CFELSEIF checkUser.userStatus EQ "">
		<CFINCLUDE TEMPLATE="../system/userEmailVerify.cfm">
		<CFIF userEmailVerify EQ 1>
			<CFSETTING ENABLECFOUTPUTONLY="No">
			<HTML><HEAD><TITLE><CFOUTPUT>#indexTitle# - #emailNotVerifiedTitle#</CFOUTPUT></TITLE></HEAD>
			<CFINCLUDE TEMPLATE="../system/bodytag.cfm">
			<CFSET title = badBidTitle>
			<CFINCLUDE TEMPLATE="../system/navigate.cfm">
			<CFOUTPUT>#emailNotVerifiedBody#</CFOUTPUT>

			<CFSET email = checkUser.email>
			<CFSET userVerifyCode = checkUser.userVerifyCode>
			<CFINCLUDE TEMPLATE="../email/emailVerifyEmail.cfm">
			<CFINCLUDE TEMPLATE="copyright.cfm">
			<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
			</BODY></HTML><CFABORT>
		</CFIF>
	</CFIF>
</CFIF>

<!--- Check bid if not admin bidder --->
<CFIF NOT IsDefined("Form.IamOfflineBidder")>
	<!--- Check bid amount is valid, including amount and increment --->
	<CFIF Form.bidPrice EQ "" OR Form.bidPrice LT 0>
		<CFSET badBid = ListAppend(badBid,"badBidPriceEmpty")>
	<CFELSEIF reverseBidLogicOrder EQ "Bid.bidPriceMaximum ASC, Bid.bidQuantity DESC, Bid.bidEditDateTime">
		<CFIF Form.bidPrice GT lotOpeningBid AND reverseBidAboveOpeningBid EQ 0>
			<CFSET badBid = ListAppend(badBid,"reverseBadBidPriceHigh")>
		<CFELSEIF bidIncrementStrict EQ 1 AND lotBidIncrement NEQ 0 AND Form.bidPrice NEQ getLot.nextBidMinimum>
			<CFSET bidToDivide = (getLot.nextBidMinimum - Form.bidPrice) / lotBidIncrement>
			<CFIF Right(DecimalFormat(bidToDivide),2) NEQ 0>
				<CFSET badBid = ListAppend(badBid,"badBidPriceIncrement")>
			<CFELSEIF Abs(getLot.nextBidMinimum - Form.bidPrice) LT lotBidIncrement>
				<CFSET badBid = ListAppend(badBid,"badBidPriceIncrement")>
			</CFIF>
		</CFIF>
	<CFELSEIF Form.bidPrice GT getLot.nextBidMinimum AND reverseBidAboveOpeningBid EQ 0>
		<CFSET badBid = ListAppend(badBid,"reversebadBidPriceHigh")>
	<CFELSEIF bidIncrementStrict EQ 1 AND lotBidIncrement NEQ 0 AND Form.bidPrice NEQ getLot.nextBidMinimum>
		<CFSET bidToDivide = (getLot.nextBidMinimum - Form.bidPrice) / lotBidIncrement>
		<CFIF Right(DecimalFormat(bidToDivide),2) NEQ 0>
			<CFSET badBid = ListAppend(badBid,"badBidPriceIncrement")>
		<CFELSEIF Abs(getLot.nextBidMinimum - Form.bidPrice) LT lotBidIncrement>
			<CFSET badBid = ListAppend(badBid,"badBidPriceIncrement")>
		</CFIF>
	</CFIF>

	<!--- Check bid quantity is valid --->
	<CFIF Form.bidQuantity EQ "">
		<CFSET badBid = ListAppend(badBid,"badBidQuantityEmpty")>
	<CFELSEIF Form.bidQuantity EQ 0>
		<CFSET badBid = ListAppend(badBid,"badBidQuantityZero")>
	<CFELSEIF Form.bidQuantity GT lotQuantity>
		<CFSET badBid = ListAppend(badBid,"badBidQuantityGreater")>
	<CFELSEIF lotQuantityMaximum LT lotQuantity AND lotQuantityMaximum NEQ 0>
		<CFIF Form.bidQuantity GT lotQuantityMaximum>
			<CFSET badBid = ListAppend(badBid,"badBidQuantityMaximum")>
		</CFIF>
	</CFIF>

	<!--- Check maximum bid amount is valid, including amount and increment --->
	<CFIF IsDefined("Form.bidAuto")>
		<CFIF allowAutoBid EQ 3>
			<CFSET minimumBidPriceMaximum = getLot.nextBidMinimum>
		<CFELSE>
			<CFSET minimumBidPriceMaximum = getLot.nextNextBidMinimum>
		</CFIF>

		<CFIF Form.bidPriceMaximum EQ "" OR Form.bidPriceMaximum LT 0>
			<CFIF Form.bidAuto EQ 1>
				<CFSET badBid = ListAppend(badBid,"reverseBadBidPriceMaximumEmpty")>
			</CFIF>
		<CFELSEIF Form.bidPriceMaximum GT minimumBidPriceMaximum AND reverseLowBidAutoWins EQ 1>
			<CFSET badBid = ListAppend(badBid,"reverseBadBidPriceMaximumHigh")>
		<CFELSEIF bidIncrementStrict EQ 1>
			<CFSET bidToDivide = (Form.bidPriceMaximum - minimumBidPriceMaximum) / lotBidIncrement>
			<CFIF Right(DecimalFormat(bidToDivide),2) NEQ 0>
				<CFSET badBid = ListAppend(badBid,"reverseBadBidPriceMaximumIncrement")>
			<CFELSEIF Abs(Form.bidPriceMaximum - minimumBidPriceMaximum) LT lotBidIncrement AND Form.bidPriceMaximum NEQ minimumBidPriceMaximum>
				<CFSET badBid = ListAppend(badBid,"reverseBadBidPriceMaximumIncrement")>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF badBid EQ 0>
		<CFQUERY NAME=checkBidEdit DATASOURCE="#EAdatasource#">
			SELECT bidID, bidPriceMaximum, bidWin
			FROM Bid
			WHERE userID = #bidderUserID#
				AND lotID = #Form.lotID#
		</CFQUERY>
		<CFIF checkBidEdit.RecordCount EQ 1>
			<CFIF NOT IsDefined("Form.bidAuto")>
				<CFIF Form.bidPrice GT checkBidEdit.bidPriceMaximum>
					<CFSET badBid = ListAppend(badBid,"reverseBadUpdateBidPriceMore")>
				</CFIF>
			<CFELSEIF Form.bidPriceMaximum NEQ "">
				<CFIF Form.bidPriceMaximum GT checkBidEdit.bidPriceMaximum>
					<CFSET badBid = ListAppend(badBid,"reverseBadUpdateBidPriceMaximumMore")>
				</CFIF>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF badBid NEQ 0>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<HTML><HEAD><TITLE><CFOUTPUT>#indexTitle# - #badBidTitle#</CFOUTPUT></TITLE></HEAD>
		<CFINCLUDE TEMPLATE="../system/bodytag.cfm">

		<CFSET title = badBidTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<P><CFOUTPUT>#badBidBody#</CFOUTPUT><P>
		<UL>
		<CFLOOP INDEX=errorList FROM=2 TO=#ListLen(badBid)#>
			<LI><CFOUTPUT>#Evaluate(ListGetAt(badBid,errorList))#</CFOUTPUT>
		</CFLOOP>
		</UL>
		<P><CFOUTPUT>#badBidFooter#</CFOUTPUT><P>
		<CFIF (ListFind(badBid,"badLogin") OR ListFind(badBid,"badCookie")) AND badBidLoginRegisterLink EQ 1>
			<CFSET bidURL = "#systemURL#/program/user.cfm?bidURL=1&lotID=#lotID#&bidPrice=#URLEncodedFormat(bidPrice)#">
			<CFIF IsDefined("Form.bidAuto")><CFSET bidURL = "#bidURL#&bidAuto=#bidAuto#"></CFIF>
			<CFIF IsDefined("Form.bidPriceMaximum")><CFSET bidURL = "#bidURL#&bidPriceMaximum=#URLEncodedFormat(bidPriceMaximum)#"></CFIF>
			<CFIF IsDefined("Form.bidQuantity")><CFSET bidURL = "#bidURL#&bidQuantity=#bidQuantity#"></CFIF>
			<CFIF IsDefined("Form.bidFullQuantityOnly")><CFSET bidURL = "#bidURL#&bidFullQuantityOnly=#bidFullQuantityOnly#"></CFIF>
			<CFSET badBidLoginRegisterText = ReplaceNoCase(badBidLoginRegisterText, "LINK", """#bidURL#""", "ALL")>
			<P><CFOUTPUT>#badBidLoginRegisterText#</CFOUTPUT><P>
		</CFIF>

		<CFINCLUDE TEMPLATE="reverseBidForm.cfm"><P>
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
		<CFINCLUDE TEMPLATE="copyright.cfm"><P>
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	</CFIF>
</CFIF>

<CFIF Form.bidButton EQ bidButtonPreview>
	<CFSETTING ENABLECFOUTPUTONLY="No">
	<CFINCLUDE TEMPLATE="reverseBidVerify.cfm">
	<CFABORT>
</CFIF>

<CFIF NOT IsDefined("IamOfflineBidder")>
	<CFSET bidDateTime = CreateODBCDateTime(Now())>
<CFELSE>
	<CFIF Form.bidTimeAMPM EQ "AM" AND Form.bidTimeHH NEQ 12>
		<CFSET bidHour = Form.bidTimeHH>
	<CFELSEIF Form.bidTimeAMPM EQ "PM" AND Form.bidTimeHH NEQ 12>
		<CFSET bidHour = Form.bidTimeHH + 12>
	<CFELSEIF Form.bidTimeAMPM EQ "AM" AND Form.bidTimeHH EQ 12>
		<CFSET bidHour = 0>
	<CFELSE><!--- Form.bidTimeAMPM EQ "PM" AND Form.bidTimeHH EQ 12 --->
		<CFSET bidHour = 12>
	</CFIF>
	<CFSET bidDateTime = CreateODBCDateTime(CreateDateTime(Form.bidDateYYYY, Form.bidDateMM, Form.bidDateDD, bidHour, Form.bidTimeMM, 0))>
</CFIF>

<CFIF NOT IsDefined("Form.bidFullQuantityOnly")>
	<CFSET bidFullQuantityOnly = 0>
</CFIF>
<CFIF NOT IsDefined("Form.bidAuto")>
	<CFSET bidAuto = 0>
	<CFSET bidPriceMaximum = Form.bidPrice>
<CFELSEIF Form.bidAuto EQ 1 OR (Form.bidAuto EQ 2 AND Form.bidPriceMaximum NEQ "")>
	<CFSET bidAuto = 1>
	<CFSET bidPriceMaximum = Form.bidPriceMaximum>
<CFELSE>
	<CFSET bidAuto = 0>
	<CFSET bidPriceMaximum = Form.bidPrice>
</CFIF>

<!---
If reserve price exists, determine whether it has been met.
	If not, if the current nextBidMinimum GTE reserve price:
		Send email. Update lotReservePriceMet.
	Elseif autobid with maximum bid GTE reserve price:
		Set current bid equal to reserve price.
		Send email. Update lotReservePriceMet.
--->

<CFIF getLot.lotReservePriceMet EQ 0>
	<CFIF Form.bidPrice LTE lotReservePrice>
		<CFSET lotReservePriceMet = 1>
	<CFELSEIF IsDefined("Form.bidAuto")>
		<CFIF bidPriceMaximum LTE lotReservePrice>
			<CFSET lotReservePriceMet = 1>
			<CFSET bidPrice = lotReservePrice>
		<CFELSE>
			<CFSET bidPrice = bidPriceMaximum>
		</CFIF>
	</CFIF>
	<CFIF IsDefined("lotReservePriceMet")>
		<CFINCLUDE TEMPLATE="../system/reserve.cfm">
		<CFIF reserveMetEmail EQ 1>
			<CFINCLUDE TEMPLATE="../email/emailBidReserveMet.cfm">
		</CFIF>
		<CFIF reserveMetLoserEmail EQ 1>
			<CFINCLUDE TEMPLATE="../email/emailBidReserveMetLoser.cfm">
		</CFIF>
	</CFIF>
</CFIF>

<!--- Either update or insert bid in database --->
<CFIF checkBidEdit.RecordCount EQ 1>
	<!--- Update bid in database --->
	<CFQUERY NAME=updateBid DATASOURCE="#EAdatasource#">
		UPDATE Bid
		SET <CFIF checkBidEdit.bidWin EQ 0 OR bidAuto EQ 0 OR IsDefined("lotReservePriceMet")>
				bidPrice = #bidPrice#,
			</CFIF>
			bidWin = 1,
			bidQuantity = #bidQuantity#,
			bidQuantityWin = #bidQuantity#,
			bidFullQuantityOnly = #bidFullQuantityOnly#,
			bidEditDateTime = #bidDateTime#,
			bidAuto = #bidAuto#,
			bidPriceMaximum = #bidPriceMaximum#,
			bidUpdateDateTime = #bidDateTime#
			<CFIF IsDefined("Form.bidDescription") AND NOT IsDefined("Form.bidDescriptionSame")>
				, bidDescription = <CFIF Form.bidDescription EQ "">NULL<CFELSE>'#Form.bidDescription#'</CFIF>
			</CFIF>
		WHERE bidID = #checkBidEdit.bidID#
	</CFQUERY>
	<CFSET bidID = checkBidEdit.bidID>
<CFELSE>
	<CFQUERY NAME=deleteWatch DATASOURCE="#EAdatasource#">
		DELETE FROM LotWatch
		WHERE lotID = #lotID# AND userID = #bidderUserID#
	</CFQUERY>
	<CFQUERY NAME=insertBid DATASOURCE="#EAdatasource#">
		INSERT INTO Bid (userID, lotID, bidPrice, bidWin, 
			bidQuantity, bidFullQuantityOnly, bidDateTime, bidEditDateTime,
			bidAuto, bidPriceMaximum, bidPriceInitial, bidQuantityWin, bidUpdateDateTime,
			bidDescription)
		VALUES (#bidderUserID#, #lotID#, #bidPrice#, 1,
			#bidQuantity#, #bidFullQuantityOnly#, #bidDateTime#, #bidDateTime#,
			#bidAuto#, #bidPriceMaximum#, #Form.bidPrice#, #bidQuantity#, #bidDateTime#, 
			<CFIF NOT IsDefined("Form.bidDescription")>NULL<CFELSEIF Form.bidDescription EQ "">NULL<CFELSE>'#Form.bidDescription#'</CFIF>)
	</CFQUERY>

	<CFQUERY NAME=getBidID DATASOURCE="#EAdatasource#">
		SELECT bidID
		FROM Bid
		WHERE userID = #bidderUserID# AND lotID = #lotID#
	</CFQUERY>
	<CFQUERY NAME=insertBidViewFee DATASOURCE="#EAdatasource#">
		INSERT INTO FeeBid (userID, lotID, lotName, bidFee, bidWinFee, bidFeeFinal, bidViewFee, sellerID, bidID)
		VALUES (#bidderUserID#, #lotID#, '#lotName#', 0, 0, 0, 0, #userID#, #getBidID.bidID#)
	</CFQUERY>
</CFIF>

<CFINCLUDE TEMPLATE="reverseBidLogic.cfm">

<CFSETTING ENABLECFOUTPUTONLY="No">
<CFIF displayBidResultAfterBid EQ 1>
	<CFINCLUDE TEMPLATE="reverseBidResult.cfm">
<CFELSEIF IsDefined("metaredirect")>
	<HTML>
	<CFOUTPUT><META HTTP-EQUIV="Refresh" CONTENT="0; URL=#systemURL#/lot.cfm?lotID=#Form.lotID#"></CFOUTPUT>
	<CFINCLUDE TEMPLATE="../system/bodytag.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF NOT IsDefined("IamOfflineBidder")>
	<CFLOCATION URL="#systemURL#/lot.cfm?lotID=#Form.lotID#">
<CFELSE>
	<CFLOCATION URL="#systemURL#/admin/lotBidOffline?lotID=#Form.lotID#&manualBid=1">
</CFIF>
