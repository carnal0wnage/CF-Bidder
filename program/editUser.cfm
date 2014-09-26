<!--- Emaze Auction version 2.1, 1.03 / Thursday, June 24, 1999 --->
<CFINCLUDE TEMPLATE="../system/editUserLogin.cfm">
<CFIF IsDefined("Form.userSubmit")>
	<CFIF Form.userSubmit EQ editUserLoginButtonBidStatus>
		<CFSET bidStatus = 1>
	<CFELSEIF Form.userSubmit EQ editUserLoginButtonSellerHome>
		<CFSET sellerIndex = 1>
	<CFELSEIF Form.userSubmit EQ editUserLoginButtonSubscribe>
		<CFSET subscribe = 1>
	</CFIF>
<CFELSEIF IsDefined("Form.bidStatus.x")>
	<CFSET bidStatus = 1>
<CFELSEIF IsDefined("Form.sellerHome.x")>
	<CFSET sellerIndex = 1>
<CFELSEIF IsDefined("Form.subscribe.x")>
	<CFSET subscribe = 1>
</CFIF>

<CFIF IsDefined("Cookie.EmazeAuction_user") AND (IsDefined("Form.useCookie") OR IsDefined("subscribe") OR IsDefined("watch") OR IsDefined("seller"))>
	<!--- Check userID/username combo --->
	<CFQUERY NAME="checkCookie" DATASOURCE="#EAdatasource#">
		SELECT userID, useCookie
		FROM Member
		WHERE username = '#ListGetAt(Cookie.EmazeAuction_user,2)#'
			AND userID = #ListGetAt(Cookie.EmazeAuction_user,1)#
	</CFQUERY>
	<CFIF checkCookie.RecordCount NEQ 1><!--- user does not exist --->
		<CFCOOKIE NAME="EmazeAuction_user" VALUE="none" EXPIRES=Now>
		<CFSET displayForm = 1>
	<CFELSEIF IsDefined("sellerIndex")>
		<CFIF checkCookie.useCookie EQ 1>
			<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
		</CFIF>
		<CFLOCATION URL="#systemURL#/seller/sellerIndex.cfm">
	<CFELSEIF IsDefined("seller")>
		<CFIF checkCookie.useCookie EQ 1>
			<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
		</CFIF>
		<CFSET userID = ListFirst(Cookie.EmazeAuction_user)>
		<CFINCLUDE TEMPLATE="../seller/sellerUser.cfm">
		<CFABORT>
	<CFELSEIF IsDefined("watch")>
		<CFIF checkCookie.useCookie EQ 1>
			<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
		</CFIF>
		<CFQUERY NAME=checkBid DATASOURCE="#EAdatasource#">
			SELECT bidID
			FROM Bid
			WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
				AND lotID = #lotID#
		</CFQUERY>

		<CFIF checkBid.RecordCount NEQ 1>
			<CFQUERY NAME=checkWatch DATASOURCE="#EAdatasource#">
				DELETE FROM LotWatch
				WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
					AND lotID = #lotID#
			</CFQUERY>
			<CFQUERY NAME=checkWatch DATASOURCE="#EAdatasource#">
				INSERT INTO LotWatch (lotID, userID)
				VALUES (#lotID#, #ListFirst(Cookie.EmazeAuction_user)#)
			</CFQUERY>
		</CFIF>

		<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">
		<CFSET title = "titleLotWatch">
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<CFINCLUDE TEMPLATE="../system/lotWatch.cfm">
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML>
		<CFINCLUDE TEMPLATE="closeCheck.cfm">
		<CFABORT>
	<CFELSEIF IsDefined("subscribe")>
		<CFIF checkCookie.useCookie EQ 1>
			<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
		</CFIF>
		<CFIF NOT IsDefined("Form.subcategorySubscribe")>
			<CFSET subcategorySubscribe = 0>
			<CFQUERY NAME=checkStatus DATASOURCE="#EAdatasource#">
				DELETE FROM CategorySubscribe
				WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
					AND categoryID = #Form.categoryID#
			</CFQUERY>
		<CFELSE>
			<CFQUERY NAME=checkStatus DATASOURCE="#EAdatasource#">
				SELECT CategorySubscribe.categoryID
				FROM CategorySubscribe INNER JOIN Category ON CategorySubscribe.categoryID = Category.categoryID
				WHERE CategorySubscribe.userID = #ListFirst(Cookie.EmazeAuction_user)#
					AND (CategorySubscribe.categoryID = #Form.categoryID#
					OR Category.categoryID1 = #Form.categoryID#
					OR Category.categoryID2 = #Form.categoryID#
					OR Category.categoryID3 = #Form.categoryID#)
			</CFQUERY>
			<CFIF checkStatus.RecordCount NEQ 0>
				<CFQUERY NAME=deleteSubscribe DATASOURCE="#EAdatasource#">
					DELETE FROM CategorySubscribe
					WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
						AND categoryID IN (#ValueList(checkStatus.categoryID)#)
				</CFQUERY>
			</CFIF>
		</CFIF>

		<CFQUERY NAME=checkStatus DATASOURCE="#EAdatasource#">
			INSERT INTO CategorySubscribe (categoryID, userID, subcategorySubscribe)
			VALUES (#Form.categoryID#, #ListFirst(Cookie.EmazeAuction_user)#, #subcategorySubscribe#)
		</CFQUERY>

		<CFINCLUDE TEMPLATE="../category/#Form.categoryID#CategoryInfo.cfm">
		<CFSET title = "titleCategorySubscribe">
		<CFINCLUDE TEMPLATE="../system/navigate.cfm">
		<CFINCLUDE TEMPLATE="../system/categorySubscribe.cfm">
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML>
		<CFINCLUDE TEMPLATE="closeCheck.cfm">
		<CFABORT>
	<CFELSE>
		<CFSET userID = ListGetAt(Cookie.EmazeAuction_user,1)>
		<CFIF IsDefined("bidStatus")><CFINCLUDE TEMPLATE="status.cfm">
			<CFELSE><CFINCLUDE TEMPLATE="user.cfm"></CFIF>
		<CFABORT>
	</CFIF>
<CFELSE>
	<CFSET displayForm = 1>
</CFIF>

<CFIF IsDefined("Form.username")>
	<CFIF Form.username EQ "" OR Form.password EQ "">
		<CFSET displayForm = "badLogin">
	<CFELSE>
		<CFSET password = Encrypt(Form.password,encryptionCode)>
		<CFQUERY NAME="checkUser" DATASOURCE="#EAdatasource#">
			SELECT userID, password, useCookie
			FROM Member
			WHERE username = '#Form.username#'
		</CFQUERY>
		<CFIF checkUser.RecordCount NEQ 1>
			<CFSET displayForm = "badLogin">
		<CFELSEIF Form.password NEQ Decrypt(checkUser.password,encryptionCode)>
			<CFSET displayForm = "badLogin">
		<CFELSEIF IsDefined("sellerIndex")>
			<CFIF checkUser.useCookie EQ 1>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
			<CFELSE>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#">
			</CFIF>
			<CFINCLUDE TEMPLATE="../seller/sellerIndex.cfm">
			<CFABORT>
		<CFELSEIF IsDefined("seller")>
			<CFIF checkUser.useCookie EQ 1>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
			<CFELSE>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#">
			</CFIF>
			<CFSET userID = checkUser.userID>
			<CFINCLUDE TEMPLATE="../seller/sellerUser.cfm">
			<CFABORT>
		<CFELSEIF IsDefined("watch")>
			<CFIF checkUser.useCookie EQ 1>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
			<CFELSE>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#">
			</CFIF>
			<CFQUERY NAME=checkBid DATASOURCE="#EAdatasource#">
				SELECT bidID
				FROM Bid
				WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
					AND lotID = #lotID#
			</CFQUERY>
	
			<CFIF checkBid.RecordCount NEQ 1>
				<CFQUERY NAME=checkWatch DATASOURCE="#EAdatasource#">
					DELETE FROM LotWatch
					WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
						AND lotID = #lotID#
				</CFQUERY>
				<CFQUERY NAME=checkWatch DATASOURCE="#EAdatasource#">
					INSERT INTO LotWatch (lotID, userID)
					VALUES (#lotID#, #ListFirst(Cookie.EmazeAuction_user)#)
				</CFQUERY>
			</CFIF>

			<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">
			<CFSET title = "titleLotWatch">
			<CFINCLUDE TEMPLATE="../system/navigate.cfm">
			<CFINCLUDE TEMPLATE="../system/lotWatch.cfm">
			<CFINCLUDE TEMPLATE="copyright.cfm">
			<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
			</BODY></HTML>
			<CFINCLUDE TEMPLATE="closeCheck.cfm">
			<CFABORT>
		<CFELSEIF IsDefined("subscribe")>
			<CFIF checkUser.useCookie EQ 1>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
			<CFELSE>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#">
			</CFIF>
			<CFIF NOT IsDefined("Form.subcategorySubscribe")>
				<CFSET subcategorySubscribe = 0>
				<CFQUERY NAME=checkStatus DATASOURCE="#EAdatasource#">
					DELETE FROM CategorySubscribe
					WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
						AND categoryID = #Form.categoryID#
				</CFQUERY>
			<CFELSE>
				<CFQUERY NAME=checkStatus DATASOURCE="#EAdatasource#">
					SELECT CategorySubscribe.categoryID
					FROM CategorySubscribe INNER JOIN Category ON CategorySubscribe.categoryID = Category.categoryID
					WHERE CategorySubscribe.userID = #ListFirst(Cookie.EmazeAuction_user)#
						AND (CategorySubscribe.categoryID = #Form.categoryID#
						OR Category.categoryID1 = #Form.categoryID#
						OR Category.categoryID2 = #Form.categoryID#
						OR Category.categoryID3 = #Form.categoryID#)
				</CFQUERY>
				<CFIF checkStatus.RecordCount NEQ 0>
					<CFQUERY NAME=deleteSubscribe DATASOURCE="#EAdatasource#">
						DELETE FROM CategorySubscribe
						WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
							AND categoryID IN (#ValueList(checkStatus.categoryID)#)
					</CFQUERY>
				</CFIF>
			</CFIF>

			<CFQUERY NAME=checkStatus DATASOURCE="#EAdatasource#">
				INSERT INTO CategorySubscribe (categoryID, userID, subcategorySubscribe)
				VALUES (#Form.categoryID#, #ListFirst(Cookie.EmazeAuction_user)#, #subcategorySubscribe#)
			</CFQUERY>

			<CFINCLUDE TEMPLATE="../category/#Form.categoryID#CategoryInfo.cfm">
			<CFSET title = "titleCategorySubscribe">
			<CFINCLUDE TEMPLATE="../system/navigate.cfm">
			<CFINCLUDE TEMPLATE="../system/categorySubscribe.cfm">
			<CFINCLUDE TEMPLATE="copyright.cfm">
			<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
			</BODY></HTML>
			<CFINCLUDE TEMPLATE="closeCheck.cfm">
			<CFABORT>
		<CFELSE>
			<CFIF checkUser.useCookie EQ 1>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#" EXPIRES="Never">
			<CFELSE>
				<CFCOOKIE NAME="EmazeAuction_user" VALUE="#checkUser.userID#,#Form.username#">
			</CFIF>
			<CFSET userID = checkUser.userID>
			<CFIF IsDefined("bidStatus")><CFINCLUDE TEMPLATE="status.cfm">
				<CFELSE><CFINCLUDE TEMPLATE="user.cfm"></CFIF>
			<CFABORT>
		</CFIF>
	</CFIF>
</CFIF>

<CFIF IsDefined("displayForm")>
	<CFIF IsDefined("bidStatus")><CFSET title = "titleBidStatus">
	<CFELSEIF IsDefined("subscribe")><CFSET title = "titleCategorySubscribe">
	<CFELSE><CFSET title = "titleUserEdit"></CFIF>

	<CFINCLUDE TEMPLATE="../system/navigate.cfm">
	<P>
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH=600><TR><TD>	
	<CFIF displayForm EQ "badLogin">
		<CFOUTPUT>#editUserLoginBad#</CFOUTPUT>
	<CFELSEIF IsDefined("bidStatus")>
		<CFOUTPUT>#editUserLoginBidStatus#</CFOUTPUT>
	<CFELSEIF IsDefined("subscribe")>
		<CFOUTPUT>#editUserLoginSubscribe#</CFOUTPUT>
	<CFELSEIF IsDefined("watch")>
		<CFOUTPUT>#editUserLoginEdit#</CFOUTPUT>
	<CFELSE>
		<CFOUTPUT>#editUserLoginEdit#</CFOUTPUT>
	</CFIF>
	</TD></TR></TABLE>

	<CFIF IsDefined("sellerIndex")>
		<CFSET formAction = "#systemURL#/seller/sellerIndex.cfm">
	<CFELSEIF IsDefined("bidStatus") OR IsDefined("subscribe")>
		<CFSET formAction = "#systemURL#/program/editUser.cfm">
	<CFELSE>
		<CFSET formAction = "#secureSystemURL#/program/editUser.cfm">
	</CFIF>
	<CFFORM NAME=editUser ACTION="#formAction#">

	<CFIF IsDefined("bidStatus")><INPUT TYPE=hidden NAME=bidStatus VALUE=1>
	<CFELSEIF IsDefined("seller")><INPUT TYPE=hidden NAME=seller VALUE=1>
	<CFELSEIF IsDefined("lotID") AND IsDefined("watch")>
		<INPUT TYPE=hidden NAME=watch VALUE=1>
		<CFOUTPUT><INPUT TYPE=hidden NAME=lotID VALUE=#lotID#></CFOUTPUT>
	<CFELSEIF IsDefined("categoryID") AND IsDefined("subscribe")>
		<INPUT TYPE=hidden NAME=subscribe VALUE=1>
		<CFOUTPUT><INPUT TYPE=hidden NAME=categoryID VALUE=#categoryID#></CFOUTPUT>
		<CFIF IsDefined("Form.subcategorySubscribe")><INPUT TYPE=hidden NAME=subcategorySubscribe VALUE=1></CFIF>
	</CFIF>

	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
	<TR><TD ALIGN=right><CFOUTPUT>#editUserLoginUsernameText#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED="Yes" MESSAGE="#editUserLoginUsernameError#"></TD></TR>
	<TR><TD ALIGN=right><CFOUTPUT>#editUserLoginPasswordText#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=password NAME=password SIZE=20 REQUIRED="Yes" MESSAGE="#editUserLoginPasswordError#"></TD></TR>
	<TR><TD></TD><TD HEIGHT=40><CFOUTPUT><INPUT TYPE=submit VALUE="#editUserLoginButtonSubmit#"></CFOUTPUT></TD></TR>
	</TABLE>
	</CFFORM>
	<P>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML>
	<CFINCLUDE TEMPLATE="closeCheck.cfm">
</CFIF>