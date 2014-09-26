<!--- Emaze Auction version 2.1, 1.03 / Tuesday, June 15, 1999 --->
<CFSETTING ENABLECFOUTPUTONLY="Yes">

<!---
BIDDING ACTIONS:
If cookie, check that userID/username exists.
	If exists, set userID
	If userID/username does not exist, (re)ask for username/password
Else check that username/password exists
	If exists, set userID
	If not exist, re-ask for username/password
If userID exists,
	If bid not is at least minimum necessary bid, re-enter.
	??? If bid is not proper increment, reduce to next appropriate increment.
	If chose auto-bid, make sure maximum bid is greater than or equal to bid
	Check whether user has an existing bid for this lot
	Insert bid in database

UPDATE LOT INFORMATION:
If other bids use the auto-bid feature for this lot
	Auto-increment bid in order of earliest user (to maximum bid)
	If supposed to send email notification, do so
Update current highest bid, quantity in database
Update minimum bid necessary for quantity of at least 1

Determine who has winning bids now based on the following rules:
1. An earlier user wins over a later user of the same bid price, including all quantity for which that user bid.
2. Time of auto-bid and edited bids does not change original bid time, i.e., not a new bid

COMPLEXITY:
A. BID PRICE OF EACH BID
B. LOT QUANTITY AVAILABLE
C. QUANTITY EACH USER BID FOR
D. ACCEPT ENTIRE QUANTITY ONLY
E. AUTO-BID

TO DETERMINE WHO HAS WINNING BIDS:
1. Get all bids in order of date, then bid price
2. Loop through bids
3. Beginning with first bid, you win at price plus quantity
4. If auto bid, include in auto-bid list to go back to later if no longer win
5. For each successive bid, determine whether next user and previous user still win, and for what quantity
6. If not win whole quantity, check acceptPartialQuantity status. If not accept partial quality, out of bidding. Otherwise, wins partial quantity.
7. If now losing bid, email if requested
8. If auto-bid, email if requested
9. Continue through loop until end of bids or quantity is full

Initially, just list all winning bids.
Will simply determine minimum necessary bid to win quantity 1.
If total number of quantity bids is less than quantity available, minimum bid equals opening bid.
If total number of quantity bids is greater than quantity available, get 2nd lowest winning bid

Reload lot page
--->

<CFINCLUDE TEMPLATE="../lot/#Form.lotID#LotInfo.cfm">
<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
	SELECT nextBidMinimum, nextNextBidMinimum, lotReservePriceMet, lotBidsExist, lastBidDateTime
	FROM Lot
	WHERE lotID = #lotID#
</CFQUERY>
<CFINCLUDE TEMPLATE="../system/bidOptions.cfm">
<CFINCLUDE TEMPLATE="../system/bidErrors.cfm">

<CFIF Form.bidButton EQ bidButtonReject>
	<CFSETTING ENABLECFOUTPUTONLY="No">
	<CFLOCATION URL="#systemURL#/lot.cfm?lotID=#Form.lotID#">
</CFIF>

<!--- CHECK THAT BID IS ALLOWED
If bid date/time > auction closing time:
	If lotCloseBasis = time
		OR lotCloseBasis = timeInactivity and Now - LastBid GTE Inactivity
	  bid is not allowed
--->

<CFIF DateCompare(lotCloseDateTime,Now()) NEQ 1 AND NOT IsDefined("IamOfflineBidder")>
	<CFIF lotCloseBasis EQ "time" OR (lotCloseBasis EQ "timeInactivity"
			AND DateDiff("n",getLot.lastBidDateTime,Now()) GTE lotCloseInactivity)>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFSET title = lotClosedTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
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
		SELECT userID, email, userStatus, userVerifyCode, useCookie
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
<CFIF IsDefined("Form.IamOfflineBidder")>
	<CFQUERY NAME=checkBidEdit DATASOURCE="#EAdatasource#">
		SELECT bidID, bidPriceMaximum, bidWin
		FROM Bid
		WHERE userID = #bidderUserID#
			AND lotID = #Form.lotID#
	</CFQUERY>
<CFELSE>
	<!--- Check bid amount is valid, including amount and increment --->
	<CFIF Form.bidPrice EQ "">
		<CFSET badBid = ListAppend(badBid,"badBidPriceEmpty")>
	<CFELSEIF bidLogicOrder EQ "Bid.bidPriceMaximum DESC, Bid.bidQuantity DESC, Bid.bidEditDateTime">
		<CFIF Form.bidPrice LT lotOpeningBid>
			<CFSET badBid = ListAppend(badBid,"badBidPriceLow")>
		<CFELSEIF bidIncrementStrict EQ 1 AND lotBidIncrement NEQ 0 AND Form.bidPrice GT getLot.nextBidMinimum>
			<CFSET bidToDivide = (Form.bidPrice - getLot.nextBidMinimum) / lotBidIncrement>
			<CFIF Right(DecimalFormat(bidToDivide),2) NEQ 0>
				<CFSET badBid = ListAppend(badBid,"badBidPriceIncrement")>
			<CFELSEIF (Form.bidPrice - getLot.nextBidMinimum) LT lotBidIncrement>
				<CFSET badBid = ListAppend(badBid,"badBidPriceIncrement")>
			</CFIF>
		</CFIF>
	<CFELSEIF Form.bidPrice LT getLot.nextBidMinimum>
		<CFSET badBid = ListAppend(badBid,"badBidPriceLow")>
	<CFELSEIF bidIncrementStrict EQ 1 AND lotBidIncrement NEQ 0 AND Form.bidPrice GT getLot.nextBidMinimum>
		<CFSET bidToDivide = (Form.bidPrice - getLot.nextBidMinimum) / lotBidIncrement>
		<CFIF Right(DecimalFormat(bidToDivide),2) NEQ 0>
			<CFSET badBid = ListAppend(badBid,"badBidPriceIncrement")>
		<CFELSEIF (Form.bidPrice - getLot.nextBidMinimum) LT lotBidIncrement>
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

		<CFIF Form.bidPriceMaximum EQ "">
			<CFIF Form.bidAuto EQ 1>
				<CFSET badBid = ListAppend(badBid,"badBidPriceMaximumEmpty")>
			</CFIF>
		<CFELSEIF Form.bidPriceMaximum LT minimumBidPriceMaximum>
			<CFSET badBid = ListAppend(badBid,"badBidPriceMaximumLow")>
		<CFELSEIF bidIncrementStrict EQ 1>
			<CFSET bidToDivide = (Form.bidPriceMaximum - minimumBidPriceMaximum) / lotBidIncrement>
			<CFIF Right(DecimalFormat(bidToDivide),2) NEQ 0>
				<CFSET badBid = ListAppend(badBid,"badBidPriceMaximumIncrement")>
			<CFELSEIF (Form.bidPriceMaximum - minimumBidPriceMaximum) LT lotBidIncrement AND Form.bidPriceMaximum NEQ minimumBidPriceMaximum>
				<CFSET badBid = ListAppend(badBid,"badBidPriceMaximumIncrement")>
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
				<CFIF Form.bidPrice LT checkBidEdit.bidPriceMaximum>
					<CFSET badBid = ListAppend(badBid,"badUpdateBidPriceLess")>
				</CFIF>
			<CFELSEIF Form.bidPriceMaximum NEQ "">
				<CFIF Form.bidPriceMaximum LT checkBidEdit.bidPriceMaximum>
					<CFSET badBid = ListAppend(badBid,"badUpdateBidPriceMaximumLess")>
				</CFIF>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF badBid NEQ 0>
		<CFSETTING ENABLECFOUTPUTONLY="No">
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

		<CFINCLUDE TEMPLATE="bidForm.cfm"><P>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	</CFIF>
</CFIF>

<CFIF Form.bidButton EQ bidButtonPreview>
	<CFSETTING ENABLECFOUTPUTONLY="No">
	<CFINCLUDE TEMPLATE="bidVerify.cfm">
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
	<CFIF Form.bidPrice GTE lotReservePrice>
		<CFSET lotReservePriceMet = 1>
	<CFELSEIF IsDefined("Form.bidAuto")>
		<CFIF bidPriceMaximum GTE lotReservePrice>
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
			bidAuto, bidPriceMaximum, bidPriceInitial, bidQuantityWin, bidUpdateDateTime)
		VALUES (#bidderUserID#, #Form.lotID#, #bidPrice#, 1,
			#bidQuantity#, #bidFullQuantityOnly#, #bidDateTime#, #bidDateTime#,
			#bidAuto#, #bidPriceMaximum#, #Form.bidPrice#, #bidQuantity#, #bidDateTime#)
	</CFQUERY>
</CFIF>

<!--- Update list of winning users --->
<!---
1. Loop thru bidPriceMaximum to determine who has winning bids
2. Determine minimum bid to win quantity 1
3. Update bidPrice for auto-bids
4. Send email notifications for auto-bids
--->

<!---
Set initial values for quantity taken, auto-bid list, and losers list.
LOOP thru potential winning bids in descending order of bid and
	then ascending of date, or bidID.
  If bidder can win full quantity requested:
	Increment quantity taken by quantity requested by bidder
	If quantity taken now equals quantity available:
		Increase minimum bid to win at least one unit by current price + bid increment
	If auto-bid:
		Add bidID to auto-bidders list
  Elseif bidder can win only partial quantity and willing to accept partial quantity:
	Bidders wins remaining quantity
	Update quantity for bidder
	Quantity taken = quantity available
	Increase minimum bid to win at least one unit by current price + bid increment	
	If chose to be notified of losing bid before closing:
		Send partial quantity email
  Else
	Add bidID to list of losers
	If this is the first bid for which no more quantity is available and there is at least one auto-bidder:
		Determine minimum price for auto-bidders
	If chose to be notified of losing bid before closing:
		Send lot closing email
/LOOP

If there are losers, update database to reflect they won nothing
Update lotBid file with new last bid times and minimum bid to win one unit
If there are autobidders:
  If auto-bidder's current bid is LT minimum price
	Update current bid and send auto-bid email if requested
Reload lot page
--->

<CFINCLUDE TEMPLATE="bidLogic.cfm">

<CFSETTING ENABLECFOUTPUTONLY="No">
<CFIF displayBidResultAfterBid EQ 1>
	<CFINCLUDE TEMPLATE="bidResult.cfm">
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
