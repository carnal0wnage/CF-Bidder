<!--- Emaze Auction version 2.1 / Sunday, July 16, 1999 --->
<CFSETTING ENABLECFOUTPUTONLY="Yes">

<CFINCLUDE TEMPLATE="../lot/#Form.lotID#LotInfo.cfm">
<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
	SELECT lotBidsExist, lastBidDateTime, lotQuantityTaken, lotSellPrice
	FROM Lot
	WHERE lotID = #lotID#
</CFQUERY>
<CFINCLUDE TEMPLATE="../systemMarket/marketBuyOptions.cfm">
<CFINCLUDE TEMPLATE="../systemMarket/marketBuyErrors.cfm">
<CFINCLUDE TEMPLATE="../systemMarket/marketBuyOptionsVerify.cfm">

<CFIF Form.buyButton EQ buyButtonReject>
	<CFSETTING ENABLECFOUTPUTONLY="No">
	<CFLOCATION URL="#systemURL#/lot.cfm?lotID=#Form.lotID#">
</CFIF>

<!--- If buy date/time > auction closing time OR full quantity is taken, purchase is not allowed --->
<CFIF (DateCompare(lotCloseDateTime,Now()) NEQ 1 AND NOT IsDefined("IamOfflineBuyer"))
		OR getLot.lotQuantityTaken GTE lotQuantity>
	<CFSETTING ENABLECFOUTPUTONLY="No">
	<CFSET title = lotClosedTitle>
	<CFINCLUDE TEMPLATE="../system/navigate.cfm">
	<CFIF getLot.lotQuantityTaken GTE lotQuantity>
		<CFOUTPUT>#lotClosedBody#</CFOUTPUT>
	<CFELSE>
		<CFOUTPUT>#lotClosedBody#</CFOUTPUT>
	</CFIF>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML>
	<CFINCLUDE TEMPLATE="closeCheck.cfm">
	<CFABORT>
</CFIF>

<CFSET badBuy = 0>
<CFIF IsDefined("Form.useCookie") AND IsDefined("Cookie.EmazeAuction_user")>
	<!--- Check userID/username combo --->
	<CFQUERY NAME="checkUser" DATASOURCE="#EAdatasource#">
		SELECT userID, email, userStatus, userVerifyCode, firstName, lastName, phone
		FROM Member
		WHERE username = '#ListGetAt(Cookie.EmazeAuction_user,2)#'
			AND userID = #ListGetAt(Cookie.EmazeAuction_user,1)#
	</CFQUERY>
	<CFIF checkUser.RecordCount NEQ 1><!--- user does not exist --->
		<CFSET badBuy = ListAppend(badBuy,"badCookie")>
		<CFCOOKIE NAME="EmazeAuction_user" VALUE="none" EXPIRES=Now>
	<CFELSEIF checkUser.userID EQ userID AND userID NEQ 1>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFSET title = noBuyOwnItemTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<P><CFOUTPUT>#noBuyOwnItemBody#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	<CFELSE>
		<CFSET buyerUserID = ListGetAt(Cookie.EmazeAuction_user,1)>
	</CFIF>
<CFELSEIF Form.username NEQ "" AND Form.password NEQ "">
	<!--- Ensure username/password combo is correct. --->
	<CFQUERY NAME="checkUser" DATASOURCE="#EAdatasource#">
		SELECT userID, useCookie, email, userStatus, userVerifyCode, password, firstName, lastName, phone
		FROM Member
		WHERE username = '#Form.username#'
	</CFQUERY>
	<CFIF checkUser.RecordCount NEQ 1>
		<CFSET badBuy = ListAppend(badBuy,"badLogin")>
	<CFELSEIF NOT IsDefined("Form.IamOfflineBuyer") AND Form.password NEQ Decrypt(checkUser.password,encryptionCode)>
		<CFSET badBuy = ListAppend(badBuy,"badLogin")>
	<CFELSEIF checkUser.userID EQ userID AND userID NEQ 1>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFSET title = noBuyOwnItemTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<P><CFOUTPUT>#noBuyOwnItemBody#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	<CFELSE>
		<CFSET buyerUserID = checkUser.userID>
		<CFINCLUDE TEMPLATE="../system/useCookies.cfm">
		<CFIF checkUser.useCookie EQ 1 AND allowCookieLogin EQ 1>
			<CFIF NOT IsDefined("Cookie.EmazeAuction_user")><CFSET metaredirect = 1></CFIF>
			<CFCOOKIE NAME="EmazeAuction_user" VALUE="#buyerUserID#,#Form.username#" EXPIRES="Never">
		<CFELSEIF checkUser.useCookie EQ 1 AND allowCookieBid EQ 1>
			<CFIF NOT IsDefined("Cookie.EmazeAuction_user")><CFSET metaredirect = 1></CFIF>
			<CFCOOKIE NAME="EmazeAuction_user" VALUE="#buyerUserID#,#Form.username#">
		</CFIF>
	</CFIF>
<CFELSE><!--- Form.username EQ "" OR Form.password EQ "" --->
	<CFSET badBuy = ListAppend(badBuy,"badLogin")>
</CFIF>

<!---
1. Get user status, email address
2. If user exists
	If user status is not approved and must be before bidding:
		a. Output message saying they verify their email address
		b. Ask if they received email. If yes, click URL or copy to browser.
			If no, click to receive another one. 
--->

<CFIF badBuy EQ 0 AND NOT IsDefined("IamOfflineBuyer")>
	<CFIF checkUser.userStatus EQ -1>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFSET title = buyerBanishedTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<P>
		<CFOUTPUT>#buyerBanishedBody#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	<CFELSEIF checkUser.userStatus EQ "">
		<CFINCLUDE TEMPLATE="../system/userEmailVerify.cfm">
		<CFIF userEmailVerify EQ 1>
			<CFSETTING ENABLECFOUTPUTONLY="No">
			<CFSET title = badBuyTitle>
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

<!--- Check buy if not admin buyer --->
<CFIF NOT IsDefined("Form.IamOfflineBuyer")>
	<!--- Check buy quantity is valid --->
	<CFIF lotQuantityMaximum EQ 0 OR lotQuantityMaximum GTE lotQuantity>
		<CFSET maxQuantityAvailable = lotQuantity - getLot.lotQuantityTaken>
	<CFELSE>
		<CFSET maxQuantityAvailable = Min(lotQuantity - getLot.lotQuantityTaken,lotQuantityMaximum)>
	</CFIF>

	<CFIF Form.buyQuantity EQ "">
		<CFSET badBuy = ListAppend(badBuy,"badBuyQuantityEmpty")>
	<CFELSEIF Form.buyQuantity EQ 0>
		<CFSET badBuy = ListAppend(badBuy,"badBuyQuantityZero")>
	<CFELSEIF Form.buyQuantity GT lotQuantity>
		<CFSET badBuy = ListAppend(badBuy,"badBuyQuantityGreater")>
	<CFELSEIF lotQuantityMaximum LT lotQuantity AND lotQuantityMaximum NEQ 0 AND Form.buyQuantity GT lotQuantityMaximum>
		<CFSET badBuy = ListAppend(badBuy,"badBuyQuantityMaximum")>
	<CFELSEIF Form.buyQuantity GT maxQuantityAvailable>
		<CFSET badBuy = ListAppend(badBuy,"badBuyQuantityAvailable")>
	</CFIF>

	<CFIF badBuy EQ 0 AND lotQuantityMaximum LT lotQuantity AND lotQuantityMaximum NEQ 0>
		<CFQUERY NAME=checkNewBuyer DATASOURCE="#EAdatasource#">
			SELECT buyID, buyQuantity, buyDateTime
			FROM Buy
			WHERE userID = #buyerUserID#
				AND lotID = #Form.lotID#
		</CFQUERY>
		<CFIF checkNewBuyer.RecordCount EQ 1>
			<CFIF (checkNewBuyer.buyQuantity + Form.buyQuantity) GT lotQuantityMaximum>
				<CFSET badBuy = ListAppend(badBuy,"badBuyQuantityMultipleOrder")>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF badBuy NEQ 0>
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFSET title = badBuyTitle>
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<P><CFOUTPUT>#badBuyBody#</CFOUTPUT><P>
		<UL>
		<CFLOOP INDEX=errorList FROM=2 TO=#ListLen(badBuy)#>
			<LI><CFOUTPUT>#Evaluate(ListGetAt(badBuy,errorList))#</CFOUTPUT>
		</CFLOOP>
		</UL>
		<P><CFOUTPUT>#badBuyFooter#</CFOUTPUT><P>
		<P><CFOUTPUT>#badBuyLoginRegisterText#</CFOUTPUT><P>

		<CFINCLUDE TEMPLATE="buyForm.cfm"><P>
		<CFINCLUDE TEMPLATE="copyright.cfm"><P>
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
		</BODY></HTML><CFABORT>
	</CFIF>
</CFIF>

<CFIF Form.buyButton EQ buyButtonPreview>
	<CFSETTING ENABLECFOUTPUTONLY="No">
	<CFINCLUDE TEMPLATE="buyVerify.cfm">
	<CFABORT>
</CFIF>

<CFIF NOT IsDefined("IamOfflineBuyer")>
	<CFSET buyDateTime = CreateODBCDateTime(Now())>
<CFELSE>
	<CFIF Form.buyTimeAMPM EQ "AM" AND Form.buyTimeHH NEQ 12>
		<CFSET buyHour = Form.buyTimeHH>
	<CFELSEIF Form.buyTimeAMPM EQ "PM" AND Form.buyTimeHH NEQ 12>
		<CFSET buyHour = Form.buyTimeHH + 12>
	<CFELSEIF Form.buyTimeAMPM EQ "AM" AND Form.buyTimeHH EQ 12>
		<CFSET buyHour = 0>
	<CFELSE><!--- Form.buyTimeAMPM EQ "PM" AND Form.buyTimeHH EQ 12 --->
		<CFSET buyHour = 12>
	</CFIF>
	<CFSET buyDateTime = CreateODBCDateTime(CreateDateTime(Form.buyDateYYYY, Form.buyDateMM, Form.buyDateDD, buyHour, Form.buyTimeMM, 00))>
</CFIF>

<!--- Insert purchase in database --->
<CFQUERY NAME=deleteWatch DATASOURCE="#EAdatasource#">
	DELETE FROM LotWatch
	WHERE lotID = #lotID# AND userID = #buyerUserID#
</CFQUERY>
<CFQUERY NAME=insertBuy DATASOURCE="#EAdatasource#">
	INSERT INTO Buy (userID, lotID, buyPrice, buyQuantity, buyDateTime)
	VALUES (#buyerUserID#, #Form.lotID#, #getLot.lotSellPrice#, #buyQuantity#, #buyDateTime#)
</CFQUERY>
<CFQUERY NAME=updateLot DATASOURCE="#EAdatasource#">
	UPDATE Lot
	SET lotBidsExist = 1,
		lotBidCount = lotBidCount + 1,
		lotQuantityTaken = lotQuantityTaken + #Form.buyQuantity#
	WHERE lotID = #lotID#
</CFQUERY>

<CFQUERY NAME="getSeller" DATASOURCE="#EAdatasource#">
	SELECT username, phone, firstName, lastName
	FROM Member
	WHERE userID = #userID#
</CFQUERY>

<CFSETTING ENABLECFOUTPUTONLY="No">
<CFIF NOT IsDefined("IamOfflineBuyer")>
	<CFSET title = "Purchase Result">
	<CFINCLUDE TEMPLATE="../system/navigate.cfm">
	<P><CFINCLUDE TEMPLATE="../systemMarket/marketBuyResult.cfm">
	<P><CFINCLUDE TEMPLATE="copyright.cfm">
	<P><CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML>
</CFIF>

<CFINCLUDE TEMPLATE="../systemMarket/marketEmailOptions.cfm">
<CFINCLUDE TEMPLATE="../systemMarket/marketEmailSubject.cfm">
<CFINCLUDE TEMPLATE="../systemMarket/marketAdminEmail.cfm">
<CFIF marketAdminName NEQ "" AND marketAdminName NEQ " ">
	<CFSET marketAdminEmail = "#marketAdminEmail# (#marketAdminName#)">
</CFIF>

<!--- Send email to buyer? --->
<CFIF marketBuyEmailBuyer EQ 1>
	<CFIF marketBuyEmailBuyerCCseller EQ 0 AND marketBuyEmailBuyerCCadmin EQ 0><!--- buyer only --->
		<CFSET marketBuyBuyerTo = checkUser.email>
	<CFELSEIF marketBuyEmailBuyerCCseller EQ 1 AND marketBuyEmailBuyerCCadmin EQ 0><!--- cc seller --->
		<CFSET marketBuyBuyerTo = "#checkUser.email#,#lotContactEmail#">
	<CFELSEIF marketBuyEmailBuyerCCseller EQ 0 AND marketBuyEmailBuyerCCadmin EQ 1><!--- cc admin --->
		<CFSET marketBuyBuyerTo = "#checkUser.email#,#marketAdminEmail#">
	<CFELSE><!--- cc seller and admin --->
		<CFSET marketBuyBuyerTo = "#checkUser.email#,#lotContactEmail#,#marketAdminEmail#">
	</CFIF>
	<CFINCLUDE TEMPLATE="../email/emailMarketBuyBuyer.cfm">
</CFIF>

<!--- Send email to seller? --->
<CFIF marketBuyEmailSeller EQ 1>
	<CFIF marketBuyEmailSellerCCadmin EQ 1>
		<CFSET marketBuySellerTo = "#lotContactName#,#marketAdminEmail#">
	<CFELSE>
		<CFSET marketBuySellerTo = lotContactEmail>
	</CFIF>
	<CFINCLUDE TEMPLATE="../email/emailMarketBuySeller.cfm">
</CFIF>

<!--- If full quantity is taken, close lot. --->
<CFIF (getLot.lotQuantityTaken + Form.buyQuantity) GTE lotQuantity>
	<CFQUERY NAME=updateCloseLotQueue DATASOURCE="#EAdatasource#">
		UPDATE Lot
		SET lotCloseQueue = 2,
			lotStatus = 'Closed',
			lotCloseDateTime = #CreateODBCDateTime(Now())#
		WHERE lotID = #lotID#
	</CFQUERY>
	<CFFILE ACTION=Append FILE="#systemPath#\lot\#Form.lotID#LotInfo.cfm"
		OUTPUT="<CFSET lotStatus = ""Closed"">">
	<CFINCLUDE TEMPLATE="closeMarket.cfm">
</CFIF>

<CFIF IsDefined("IamOfflineBuyer")>
	<CFLOCATION URL="#systemURL#/admin/lotBuyOffline?lotID=#Form.lotID#&manualBid=1">
</CFIF>
