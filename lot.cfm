<!--- Emaze Auction version 2.1, 1.04 / Tuesday, August 17, 1999 --->
<!---
If inactive and admin -- view lot as preview
Elseif inactive -- go away
Elseif form.username -- check for permission. if bad, go away
Elseif lot private
	If cookie exists, check for permission. if bad, go away
	If cookie does not exist, present form

If closed -- closed
Elseif now is before open time -- preview
Elseif now equals open time or now is before closing time -- open
ElseIf closed based on time and inactivity
	and previous bid minus next previous bid less than inactivity -- open
Else closed.
--->

<CFIF NOT IsDefined("lotID")>
	<CFSET title = "titleLotBad">
	<CFINCLUDE TEMPLATE="system/navigate.cfm">
	<H2>No lot has been specified.</H2>
	<CFINCLUDE TEMPLATE="program/copyright.cfm">
	<CFSET lotID2 = 1>
	<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF FileExists("#systemPath#\lot\#lotID#LotInfo.cfm") EQ "NO">
	<CFSET title = "titleLotBad">
	<CFINCLUDE TEMPLATE="system/navigate.cfm">
	<H2>This lot does not exist.</H2>
	<CFINCLUDE TEMPLATE="program/copyright.cfm">
	<CFSET lotID2 = 1>
	<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFINCLUDE TEMPLATE="lot/#lotID#LotInfo.cfm">

<CFIF lotStatus EQ "Inactive" AND IsDefined("Cookie.EmazeAuction_master")>
	<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
		SELECT nextBidMinimum, nextNextBidMinimum, lotReservePriceMet, lastBidDateTime, lotBidCount, lotQuantityTaken
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, lotProcureLowBidAutoWins, lotProcureBidAboveOpeningBid, lotProcureBidDescription</CFIF>
		FROM Lot
		WHERE lotID = #lotID#
	</CFQUERY>
	<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
	<CFINCLUDE TEMPLATE="template/#templateFile#">
	<CFABORT>
<CFELSEIF lotStatus EQ "Inactive">
	<CFSET title = "titleLotBad">
	<CFINCLUDE TEMPLATE="system/navigate.cfm">
	<H2>This lot does not exist.</H2>
	<CFINCLUDE TEMPLATE="program/copyright.cfm">
	<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF IsDefined("Form.username")>
	<CFQUERY NAME=checkUserCookie DATASOURCE="#EAdatasource#">
		SELECT PrivateLotUser.lotID, Member.userID, Member.useCookie, Member.password
		FROM PrivateLotUser INNER JOIN Member ON PrivateLotUser.userID = Member.userID
		WHERE Member.username = '#Form.username#'
			AND PrivateLotUser.lotID = #Form.lotID#
	</CFQUERY>
	<CFIF checkUserCookie.RecordCount EQ 0>
		<CFSET title = "titleLotPrivate">
		<CFINCLUDE TEMPLATE="system/navigate.cfm">
		You do not have permission to access this private lot. If you believe you simply entered the incorrect username and/or password, please back up and try again.
		<CFINCLUDE TEMPLATE="program/copyright.cfm">
		</BODY></HTML><CFABORT>
	<CFELSEIF Form.password NEQ Decrypt(checkUserCookie.password,encryptionCode)>
		<CFSET title = "titleLotPrivate">
		<CFINCLUDE TEMPLATE="system/navigate.cfm">
		You do not have permission to access this private lot. If you believe you simply entered the incorrect username and/or password, please back up and try again.
		<CFINCLUDE TEMPLATE="program/copyright.cfm">
		</BODY></HTML><CFABORT>
	<CFELSEIF checkUserCookie.useCookie EQ 1>
		<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUserCookie.userID#,#Form.username#">
	</CFIF>
<CFELSEIF lotPublic EQ 0>
	<CFINCLUDE TEMPLATE="system/useCookies.cfm">
	<CFIF allowCookieLogin EQ 1 AND IsDefined("Cookie.EmazeAuction_user")>
		<CFQUERY NAME=checkUserCookie DATASOURCE="#EAdatasource#">
			SELECT PrivateLotUser.useriD
			FROM PrivateLotUser INNER JOIN Member ON PrivateLotUser.userID = Member.userID
			WHERE PrivateLotUser.lotID = #lotID#
				AND Member.username = '#ListGetAt("#Cookie.EmazeAuction_user#",2)#'
				AND PrivateLotUser.userID = #ListGetAt("#Cookie.EmazeAuction_user#",1)#
		</CFQUERY>
		<CFIF checkUserCookie.RecordCount EQ 0><CFSET displayForm = 1></CFIF>
	<CFELSE>
		<CFSET displayForm = 1>
	</CFIF>
	<CFIF IsDefined("displayForm")>
		<CFSET title = "titleLotPrivate">
		<CFINCLUDE TEMPLATE="system/navigate.cfm">
		<CFINCLUDE TEMPLATE="system/loginHeader.cfm"><P>
		<CFFORM NAME=privateLot ACTION=lot.cfm>
		<CFOUTPUT><INPUT TYPE=hidden NAME=lotID VALUE=#lotID#></CFOUTPUT>
		<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
		<TR><TD ALIGN=right>Username: </TD>
		<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED="Yes" MESSAGE="Username cannot be blank."></TD></TR>
		<TR><TD ALIGN=right>Password: </TD>
		<TD><CFINPUT TYPE=password NAME=password SIZE=20 REQUIRED="Yes" MESSAGE="Password cannot be blank."></TD></TR>
		<TR><TD></TD><TD><INPUT TYPE=submit VALUE="Log In"></TD>
		</TABLE>
		</CFFORM>
		<P><CFINCLUDE TEMPLATE="system/loginFooter.cfm"><P>
		<CFINCLUDE TEMPLATE="program/copyright.cfm">
		</BODY></HTML><CFABORT>
	</CFIF>
</CFIF>

<!--- Check the status of this lot --->
<CFSET lot = lotID>
<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
<CFSET lotID = lot>

<CFIF NOT IsDefined("Cookie.EmazeAuction_master")>
	<CFQUERY NAME=updateLotViewCount DATASOURCE="#EAdatasource#">
		UPDATE Lot
		SET lotViewCount = lotViewCount + 1
		WHERE lotID = #lotID#
	</CFQUERY>
</CFIF>

<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
	SELECT nextBidMinimum, nextNextBidMinimum, lotReservePriceMet, lastBidDateTime, lotBidCount, lotQuantityTaken
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, lotProcureLowBidAutoWins, lotProcureBidAboveOpeningBid, lotProcureBidDescription</CFIF>
	FROM Lot
	WHERE lotID = #lotID#
</CFQUERY>

<CFINCLUDE TEMPLATE="lot/#lotID#LotInfo.cfm">
<CFINCLUDE TEMPLATE="template/#templateFile#">

<CFINCLUDE TEMPLATE="program/copyright.cfm">
<!--- Check the status of 5 other lots --->
<CFSET lotID2 = 1>
<CFINCLUDE TEMPLATE="program/closeCheck.cfm">
