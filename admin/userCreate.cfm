<!--- Emaze Auction version 2.1, 1.03 / Wednesday, June 23, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF IsDefined("userID")>
	<CFSET title = "Edit User">
<CFELSE>
	<CFSET title = "Register">
</CFIF>

<HTML>
<HEAD><TITLE>Emaze Auction: Create/Edit User</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("edit")>
	<!--- <I>This window is where you edit the user information.</I> --->
	<HR NOSHADE COLOR=purple SIZE=3>
	To edit a user(s), you must first choose which user(s) to edit. You can select the user(s) by user ID, username, and/or name. Don't worry about choosing the same user more than once since the system will simply filter them out.
	<P>
	After choosing the user(s) you want to edit, choose the order in which you want those users listed. The list will be displayed in the same middle frame. You can then click on the user to edit their info, which will be done in this window.
	<P>
	You may also search for the user(s) by entering their last name, first name, username, email address, or organization. This can be the full or partial value.
	<P>
	Finally, the resulting list of users will also allow you to delete the users from the user database. Simply check the checkbox next to the users you want to delete, and then click on the &quot;Delete Users&quot; button which will be at the bottom of the list. Be sure to check the checkbox following the Delete button.
	</BODY></HTML><CFABORT>
</CFIF>

<!--- 
1. username is unique
	If edit, if not different
2. password is verified properly
	If edit, if not blank
3. email is valid, verified properly
4. required fields are completed
5. unique fields are unique
6. credit card is valid and an accepted type
7. credit card expiration is mm/yy
--->

<CFINCLUDE TEMPLATE="../system/userList.cfm">
<CFINCLUDE TEMPLATE="../system/userFormText.cfm">
<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
<!--- <CFINCLUDE TEMPLATE="../system/userFormText2.cfm"> --->
<CFINCLUDE TEMPLATE="../system/useCookies.cfm">

<CFIF IsDefined("Form.first")>
	<CFSETTING ENABLECFOUTPUTONLY="Yes">

	<CFIF IsDefined("Form.userID")>
		<CFSET userID = Replace(Form.userID, "emaze666", "
", "ALL")>
		<CFSET userID = Replace(userID, "&quot;", """", "ALL")>
		<CFSET userID = Replace(userID, "&gt;", ">", "ALL")>
		<CFSET userID = Replace(userID, "&lt;", "<", "ALL")>
		<CFSET userID = Replace(Decrypt(userID,encryptionCode), "user", "", "ALL")>

		<CFSET oldUsername = Replace(Form.oldUsername, "&quot;", """", "ALL")>
		<CFSET oldUsername = Replace(oldUsername, "&gt;", ">", "ALL")>
		<CFSET oldUsername = Replace(oldUsername, "&lt;", "<", "ALL")>
		<CFSET oldUsername = Replace(oldUsername, "emaze666", "
", "ALL")>
		<CFSET oldUsername = Decrypt(oldUsername,encryptionCode)>

		<CFSET oldEmail = Replace(Form.oldEmail, "&quot;", """", "ALL")>
		<CFSET oldEmail = Replace(oldEmail, "&gt;", ">", "ALL")>
		<CFSET oldEmail = Replace(oldEmail, "&lt;", "<", "ALL")>
		<CFSET oldEmail = Replace(oldEmail, "emaze666", "
", "ALL")>
		<CFSET oldEmail = Decrypt(oldEmail,encryptionCode)>
	</CFIF>

	<CFSET badRegistration = 0>
	<CFIF NOT IsDefined("Form.userID")>
		<!--- Ensure username is not blank. --->
		<CFIF Form.username EQ "">
			<CFSET badRegistration = ListAppend(badRegistration,"usernameBlank")>
		<CFELSE><!--- Ensure username is not already taken. --->
			<CFQUERY NAME=checkUser DATASOURCE="#EAdatasource#">
				SELECT userID, userStatus, userVerifyCode, email
				FROM Member
				WHERE username = '#Form.username#'
			</CFQUERY>
			<CFIF checkUser.RecordCount GT 0>
				<CFSET badRegistration = ListAppend(badRegistration,"usernameTaken")>
			</CFIF>
		</CFIF>
	<CFELSEIF IsDefined("Form.username")>
		<CFIF Form.username EQ "">
			<CFSET badRegistration = ListAppend(badRegistration,"usernameBlankEdit")>
		<CFELSEIF Form.username NEQ oldUsername>
			<CFQUERY NAME=checkUser DATASOURCE="#EAdatasource#">
				SELECT userID, userStatus, userVerifyCode, email
				FROM Member
				WHERE username = '#Form.username#'
					AND userID <> #userID#
			</CFQUERY>
			<CFIF checkUser.RecordCount EQ 0>
				<CFSET updateUsername = 1>
			<CFELSE>
				<CFSET badRegistration = ListAppend(badRegistration,"usernameTakenEdit")>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF NOT IsDefined("Form.userID")>
		<CFIF Form.password EQ "" OR Form.password EQ " "><!--- Ensure password is not blank --->
			<CFSET badRegistration = ListAppend(badRegistration,"passwordEmpty")>
		<CFELSEIF Form.password NEQ Form.passwordVerify><!--- Ensure password is verified correctly --->
			<CFSET badRegistration = ListAppend(badRegistration,"passwordVerifyNew")>
		<CFELSE>
			<CFSET password = Encrypt(Form.password,encryptionCode)>
		</CFIF>
	<CFELSEIF IsDefined("Form.password")>
		<CFIF Form.password NEQ "" AND Form.password NEQ " ">
			<CFIF Form.password EQ " "><!--- Ensure password is not blank --->
				<CFSET badRegistration = ListAppend(badRegistration,"passwordEmpty")>
			<CFELSEIF Form.password EQ Form.passwordVerify>
				<CFSET updatePassword = 1>
				<CFSET password = Encrypt(Form.password,encryptionCode)>
			<CFELSE>
				<CFSET badRegistration = ListAppend(badRegistration,"passwordVerifyEdit")>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF IsDefined("Form.email")>
		<CFIF Find(".",Form.email) EQ 0 OR Find("@",Form.email) EQ 0>
			<CFIF IsDefined("Form.userID")><CFSET badRegistration = ListAppend(badRegistration,"emailValidNew")>
			<CFELSE><CFSET badRegistration = ListAppend(badRegistration,"emailValidEdit")></CFIF>
		</CFIF>
		<CFIF emailVerifyTwice EQ 1 AND IsDefined("Form.emailVerify")>
			<CFIF Form.email NEQ Form.emailVerify>
				<CFIF IsDefined("Form.userID")><CFSET badRegistration = ListAppend(badRegistration,"emailVerifyNew")>
				<CFELSE><CFSET badRegistration = ListAppend(badRegistration,"emailVerifyEdit")></CFIF>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF stateSelect NEQ 0>
		<CFIF IsDefined("Form.stateSelectList")>
			<CFIF stateSelect EQ 1>
				<CFSET state = Form.stateSelectList>
			<CFELSEIF Form.stateSelectList NEQ "" AND Form.stateSelectList NEQ " ">
				<CFSET state = Form.stateSelectList>
			<CFELSEIF Form.stateText NEQ "" AND Form.stateText NEQ " ">
				<CFSET state = Form.stateText>
			<CFELSE>
				<CFSET state = " ">
			</CFIF>
		</CFIF>

		<CFIF IsDefined("Form.billingStateSelectList")>
			<CFIF stateSelect EQ 1>
				<CFSET billingState = Form.billingStateSelectList>
			<CFELSEIF Form.billingStateSelectList NEQ "" AND Form.billingStateSelectList NEQ " ">
				<CFSET billingState = Form.billingStateSelectList>
			<CFELSEIF Form.billingStateText NEQ "" AND Form.billingStateText NEQ " ">
				<CFSET billingState = Form.billingStateText>
			<CFELSE>
				<CFSET billingState = " ">
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF countrySelect NEQ 0>
		<CFIF IsDefined("Form.countrySelectList")>
			<CFIF countrySelect EQ 1>
				<CFSET country = Form.countrySelectList>
			<CFELSEIF Form.countrySelectList NEQ "" AND Form.countrySelectList NEQ " ">
				<CFSET country = Form.countrySelectList>
			<CFELSEIF Form.countryText NEQ "" AND Form.countryText NEQ " ">
				<CFSET country = Form.countryText>
			<CFELSE>
				<CFSET country = " ">
			</CFIF>
		</CFIF>

		<CFIF IsDefined("Form.billingCountrySelectList")>
			<CFIF billingCountrySelect EQ 1>
				<CFSET billingCountry = Form.billingCountrySelectList>
			<CFELSEIF Form.billingCountrySelectList NEQ "" AND Form.billingCountrySelectList NEQ " ">
				<CFSET billingCountry = Form.billingCountrySelectList>
			<CFELSEIF Form.billingCountryText NEQ "" AND Form.billingCountryText NEQ " ">
				<CFSET billingCountry = Form.billingCountryText>
			<CFELSE>
				<CFSET billingCountry = " ">
			</CFIF>
		</CFIF>
	</CFIF>

	<!--- 
	if select and fields exist
		If create user or (edit user and not blank):
	elseif text fields exist
		If create user or (edit user and not blank):
	--->

	<CFIF IsDefined("Form.creditCardExpiration")>
		<CFIF Form.creditCardExpiration NEQ "">
			<CFIF Len(Form.creditCardExpiration) NEQ 5 OR FindNoCase("/",Form.creditCardExpiration) NEQ 3>
				<CFSET badRegistration = ListAppend(badRegistration,"creditCardExpirationText")>
			<CFELSE>
				<CFSET ccMonth = Left(Form.creditCardExpiration,2)>
				<CFSET ccYear = Right(Form.creditCardExpiration,2)>
				<CFIF NOT IsNumeric(ccMonth) OR NOT IsNumeric(ccYear)>
					<CFSET badRegistration = ListAppend(badRegistration,"creditCardExpirationText")>
				<CFELSE>
					<CFIF ccYear LT 90><CFSET ccYear = 2000 + ccYear>
						<CFELSE><CFSET ccYear = 1900 + ccYear></CFIF>
					<CFIF ccYear LT Year(Now()) OR (ccYear EQ Year(Now()) AND ccMonth LT Month(Now()))>
						<CFSET badRegistration = ListAppend(badRegistration,"creditCardExpirationExpired")>
					<CFELSE>
						<CFSET creditCardExpiration = Encrypt(Form.creditCardExpiration,encryptionCode)>
					</CFIF>
				</CFIF>
			</CFIF>
		</CFIF>
	<CFELSEIF IsDefined("Form.creditCardExpirationMM")>
		<CFIF Form.creditCardExpirationMM NEQ "" OR Form.creditCardExpirationYY NEQ "">
			<CFIF Form.creditCardExpirationMM LT 90><CFSET ccYear = 2000 + Form.creditCardExpirationYY>
				<CFELSE><CFSET ccYear = 1900 + Form.creditCardExpirationYY></CFIF>
			<CFIF ccYear LT Year(Now()) OR (ccYear EQ Year(Now()) AND Form.creditCardExpirationMM LT Month(Now()))>
				<CFSET badRegistration = ListAppend(badRegistration,"creditCardExpirationExpired")>
			<CFELSE>
				<CFSET creditCardExpiration = Encrypt("#Form.creditCardExpirationMM#/#Form.creditCardExpirationYY#",encryptionCode)>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF IsDefined("Form.creditCardNumber")>
		<CFIF Form.creditCardNumber NEQ "">
			<CFSET checkMod10 = 0>
			<CFIF Len(Form.creditCardNumber) LT 13 OR Len(Form.creditCardNumber) GT 16>
				<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberLength")>
			<CFELSEIF IsNumeric(Form.creditCardNumber) EQ "False">
				<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberText")>
			<CFELSE>
				<!--- check that credit card is an allowed type, matches credit card type, and is valid number --->
				<CFIF Left(Form.creditCardNumber,1) EQ 4><!--- Visa --->
					<CFSET checkMod10 = 1>
					<CFIF ListFind(creditCardTypeList,"Visa") EQ 0>
						<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberType")>
					</CFIF>
					<CFIF Len(Form.creditCardNumber) NEQ 13 AND Len(Form.creditCardNumber) NEQ 16>
						<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberLength")>
					</CFIF>
					<CFIF IsDefined("Form.creditCardType")><CFIF Form.creditCardType NEQ "Visa">
						<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberTypeMismatch")>
					</CFIF></CFIF>
				<CFELSEIF Left(Form.creditCardNumber,2) GTE 51 AND Left(Form.creditCardNumber,2) LTE 55><!--- MasterCard --->
					<CFSET ccType = "MasterCard"><CFSET ccLength = 16>
				<CFELSEIF Left(Form.creditCardNumber,2) EQ 34 OR Left(Form.creditCardNumber,2) EQ 37><!--- Amex --->
					<CFSET ccType = "American Express"><CFSET ccLength = 15>
				<CFELSEIF (Left(Form.creditCardNumber,3) GTE 300 AND Left(Form.creditCardNumber,3) LTE 305)
						OR Left(Form.creditCardNumber,2) EQ 36 OR Left(Form.creditCardNumber,2) EQ 38><!--- Diners Club / CB --->
					<CFSET ccType = "Diners Club/Carte Blanche"><CFSET ccLength = 14>
				<CFELSEIF Left(Form.creditCardNumber,4) EQ 6011><!--- Discover --->
					<CFSET ccType = "Discover"><CFSET ccLength = 16>
				<CFELSEIF Left(Form.creditCardNumber,4) EQ 2014 OR Left(Form.creditCardNumber,4) EQ 2019><!--- enRoute --->
					<CFSET ccType = "enRoute"><CFSET ccLength = 15>
				<CFELSEIF Left(Form.creditCardNumber,1) EQ 3><!--- JCB --->
					<CFSET ccType = "JCB"><CFSET ccLength = 16>
				<CFELSEIF Left(Form.creditCardNumber,4) EQ 2131 OR Left(Form.creditCardNumber,4) EQ 1800><!--- JCB --->
					<CFSET ccType = "JCB"><CFSET ccLength = 15>
				<CFELSE>
					<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberValid")>
				</CFIF>

				<CFIF IsDefined("ccLength") AND IsDefined("ccType")>
					<CFSET checkMod10 = 1>
					<CFIF ListFind(creditCardTypeList,ccType) EQ 0>
						<CFSET checkMod10 = 0>
						<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberType")>
					</CFIF>
					<CFIF Len(Form.creditCardNumber) NEQ ccLength>
						<CFSET checkMod10 = 0>
						<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberLength")>
					</CFIF>
					<CFIF IsDefined("Form.creditCardType")><CFIF Form.creditCardType NEQ ccType>
						<CFSET checkMod10 = 0>
						<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberTypeMismatch")>
					</CFIF></CFIF>

					<CFIF ccType EQ "enRoute" AND checkMod10 EQ 1>
						<CFSET checkMod10 = 0>
						<CFSET creditCardNumber = Encrypt(Form.creditCardNumber,encryptionCode)>
					</CFIF>
				</CFIF>
				<CFIF checkMod10 EQ 1>
					<CFSET modSum = 0>
					<CFLOOP INDEX=modCounter FROM=#Len(Form.creditCardNumber)# TO=1 STEP=-1>
						<CFSET modCount = Len(Form.creditCardNumber) - modCounter + 1>
						<CFSET currentNumber = Mid(Form.creditCardNumber,modCounter,1)>
						<CFIF (modCount MOD 2) NEQ 0>
							<CFSET modSum = modSum + currentNumber>
						<CFELSEIF currentNumber LTE 4>
							<CFSET modSum = modSum + (2 * currentNumber)>
						<CFELSEIF currentNumber EQ 5>
							<CFSET modSum = modSum + 1 + 0>
						<CFELSEIF currentNumber EQ 6>
							<CFSET modSum = modSum + 1 + 2>
						<CFELSEIF currentNumber EQ 7>
							<CFSET modSum = modSum + 1 + 4>
						<CFELSEIF currentNumber EQ 8>
							<CFSET modSum = modSum + 1 + 6>
						<CFELSEIF currentNumber EQ 9>
							<CFSET modSum = modSum + 1 + 8>
						</CFIF>
					</CFLOOP>
					<CFIF (modSum MOD 10) NEQ 0 OR modSum EQ 0>
						<CFSET badRegistration = ListAppend(badRegistration,"creditCardNumberValid")>
					<CFELSE>
						<CFSET creditCardNumber = Encrypt(Form.creditCardNumber,encryptionCode)>
					</CFIF>
				</CFIF>
			</CFIF>
		</CFIF>
	</CFIF>

	<!--- If bad registration, redisplay user form with proper field values.--->
	<CFIF badRegistration NEQ 0>
		<CFINCLUDE TEMPLATE="../system/userFormText2.cfm">
		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFOUTPUT>#messageBadRegistration#</CFOUTPUT><P>
		<UL>
		<CFSET errorListProcessed = "0">
		<CFLOOP INDEX=errorList LIST="#badRegistration#">
			<CFIF ListFind(errorListProcessed,errorList) EQ 0>
				<LI><CFOUTPUT>#Evaluate(errorList)#</CFOUTPUT>
				<CFSET errorListProcessed = ListAppend(errorListProcessed,errorList)>
			</CFIF>
		</CFLOOP>
		</UL>
		<P><CFOUTPUT>#messageBadRegistration2#</CFOUTPUT>
		<CFSETTING ENABLECFOUTPUTONLY="Yes">
	<CFELSEIF NOT IsDefined("userID")>
		<CFSET userVerifyCode = "#LSDateFormat(Now(),'dd')#m#LSTimeFormat(Now(),'sshh')#z#LSDateFormat(Now(),'mm')#">
		<CFSET userStatus = 1>

		<CFSET nowDateTime = CreateODBCDateTime(Now())>
		<CFQUERY NAME=createUser DATASOURCE="#EAdatasource#">
			INSERT INTO Member (username, password, firstName, lastName, email, mothersMaidenName,
				phone, phoneExtension, phone2, phone2Extension, organization, userEmailEvents,
				creditCardType, creditCardNumber, creditCardExpiration, creditCardName,
				address, address2, city, state, zipCode, country,
				billingSameAsShipping, billingAddress, billingAddress2, billingCity, billingState, billingZipCode, billingCountry,
				useCookie, userVerifyCode, userStatus, userCreatedDateTime, userEditedDateTime,
				feedbackRating, feedbackCountPositive, feedbackCountNegative, feedbackCountNeutral, feedbackCountTotal,
				numberOfBids, numberOfWins, amountOfAuctionPurchases, accountBalance, accountBalanceAsOfDateTime)
			VALUES ('#Form.username#', '#password#', 
				<CFIF NOT IsDefined("Form.firstName")>NULL, <CFELSEIF Form.firstName EQ "">NULL, <CFELSE>'#Form.firstName#', </CFIF>
				<CFIF NOT IsDefined("Form.lastName")>NULL, <CFELSEIF Form.lastName EQ "">NULL, <CFELSE>'#Form.lastName#', </CFIF>
				<CFIF NOT IsDefined("Form.email")>NULL, <CFELSEIF Form.email EQ "">NULL, <CFELSE>'#Form.email#', </CFIF>
				<CFIF NOT IsDefined("Form.mothersMaidenName")>NULL, <CFELSEIF Form.mothersMaidenName EQ "">NULL, <CFELSE>'#Form.mothersMaidenName#', </CFIF>
				<CFIF NOT IsDefined("Form.phone")>NULL, <CFELSEIF Form.phone EQ "">NULL, <CFELSE>'#Form.phone#', </CFIF>
				<CFIF NOT IsDefined("Form.phoneExtension")>NULL, <CFELSEIF Form.phoneExtension EQ "">NULL, <CFELSE>'#Form.phoneExtension#', </CFIF>
				<CFIF NOT IsDefined("Form.phone2")>NULL, <CFELSEIF Form.phone2 EQ "">NULL, <CFELSE>'#Form.phone2#', </CFIF>
				<CFIF NOT IsDefined("Form.phone2Extension")>NULL, <CFELSEIF Form.phone2Extension EQ "">NULL, <CFELSE>'#Form.phone2Extension#', </CFIF>
				<CFIF NOT IsDefined("Form.organization")>NULL, <CFELSEIF Form.organization EQ "">NULL, <CFELSE>'#Form.organization#', </CFIF>
				<CFIF NOT IsDefined("Form.userEmailEvents")>NULL, <CFELSEIF Form.userEmailEvents EQ "">NULL, <CFELSE>'#Form.userEmailEvents#', </CFIF>
				<CFIF NOT IsDefined("Form.creditCardType")>NULL, <CFELSEIF Form.creditCardType EQ "">NULL, <CFELSE>'#Form.creditCardType#', </CFIF>
				<CFIF NOT IsDefined("Form.creditCardNumber")>NULL, <CFELSEIF Form.creditCardNumber EQ "">NULL, <CFELSE>'#creditCardNumber#', </CFIF>
				<CFIF NOT IsDefined("creditCardExpiration")>NULL, <CFELSEIF creditCardExpiration EQ "">NULL, <CFELSE>'#creditCardExpiration#', </CFIF>
				<CFIF NOT IsDefined("Form.creditCardName")>NULL, <CFELSEIF Form.creditCardName EQ "">NULL, <CFELSE>'#Form.creditCardName#', </CFIF>
				<CFIF NOT IsDefined("Form.address")>NULL, <CFELSEIF Form.address EQ "">NULL, <CFELSE>'#Form.address#', </CFIF>
				<CFIF NOT IsDefined("Form.address2")>NULL, <CFELSEIF Form.address2 EQ "">NULL, <CFELSE>'#Form.address2#', </CFIF>
				<CFIF NOT IsDefined("Form.city")>NULL, <CFELSEIF Form.city EQ "">NULL, <CFELSE>'#Form.city#', </CFIF>
				<CFIF NOT IsDefined("state")>NULL, <CFELSEIF state EQ "">NULL, <CFELSE>'#state#', </CFIF>
				<CFIF NOT IsDefined("Form.zipCode")>NULL, <CFELSEIF Form.zipCode EQ "">NULL, <CFELSE>'#Form.zipCode#', </CFIF>
				<CFIF NOT IsDefined("country")>NULL, <CFELSEIF country EQ "">NULL, <CFELSE>'#country#', </CFIF>
				<CFIF NOT IsDefined("Form.billingSameAsShipping")>0, 
					<CFIF NOT IsDefined("Form.billingAddress")>NULL, <CFELSEIF Form.billingAddress EQ "">NULL, <CFELSE>'#Form.billingAddress#', </CFIF>
					<CFIF NOT IsDefined("Form.billingAddress2")>NULL, <CFELSEIF Form.billingAddress2 EQ "">NULL, <CFELSE>'#Form.billingAddress2#', </CFIF>
					<CFIF NOT IsDefined("Form.billingCity")>NULL, <CFELSEIF Form.billingCity EQ "">NULL, <CFELSE>'#Form.billingCity#', </CFIF>
					<CFIF NOT IsDefined("billingState")>NULL, <CFELSEIF billingState EQ "">NULL, <CFELSE>'#billingState#', </CFIF>
					<CFIF NOT IsDefined("Form.billingZipCode")>NULL, <CFELSEIF Form.billingZipCode EQ "">NULL, <CFELSE>'#Form.billingZipCode#', </CFIF>
					<CFIF NOT IsDefined("billingCountry")>NULL, <CFELSEIF billingCountry EQ "">NULL, <CFELSE>'#billingCountry#', </CFIF>
				<CFELSE>1, 
					<CFIF NOT IsDefined("Form.address")>NULL, <CFELSEIF Form.address EQ "">NULL, <CFELSE>'#Form.address#', </CFIF>
					<CFIF NOT IsDefined("Form.address2")>NULL, <CFELSEIF Form.address2 EQ "">NULL, <CFELSE>'#Form.address2#', </CFIF>
					<CFIF NOT IsDefined("Form.city")>NULL, <CFELSEIF Form.city EQ "">NULL, <CFELSE>'#Form.city#', </CFIF>
					<CFIF NOT IsDefined("state")>NULL, <CFELSEIF state EQ "">NULL, <CFELSE>'#state#', </CFIF>
					<CFIF NOT IsDefined("Form.zipCode")>NULL, <CFELSEIF Form.zipCode EQ "">NULL, <CFELSE>'#Form.zipCode#', </CFIF>
					<CFIF NOT IsDefined("country")>NULL, <CFELSEIF country EQ "">NULL, <CFELSE>'#country#', </CFIF>
				</CFIF>
				<CFIF NOT IsDefined("Form.useCookie")>0, <CFELSE>1, </CFIF>
				'#userVerifyCode#', #userStatus#, #nowDateTime#, #nowDateTime#,
				0, 0, 0, 0, 0,
				0, 0, 0, 0, #nowDateTime#)
		</CFQUERY>

		<CFSETTING ENABLECFOUTPUTONLY="No">

		<CFINCLUDE TEMPLATE="../system/addUserSuccess.cfm">
		<CFINCLUDE TEMPLATE="../system/addUserSuccess2.cfm">
		</BODY></HTML><CFABORT>
		<CFSETTING ENABLECFOUTPUTONLY="Yes">

	<CFELSE>
		<!--- Update user information --->
		<CFSET nowDateTime = CreateODBCDateTime(Now())>
		<CFQUERY NAME=updateUser DATASOURCE="#EAdatasource#">
			UPDATE Member
			SET useCookie = <CFIF IsDefined("useCookie")>1,<CFELSE>0,</CFIF>
				<CFIF IsDefined("updateUsername")>username = '#Form.username#', </CFIF>
				<CFIF IsDefined("updatePassword")>password = '#password#', </CFIF>
				<CFIF IsDefined("Form.firstName")>firstName = <CFIF Form.firstName EQ "">NULL,<CFELSE>'#Form.firstName#',</CFIF></CFIF>
				<CFIF IsDefined("Form.lastName")>lastName = <CFIF Form.lastName EQ "">NULL,<CFELSE>'#Form.lastName#',</CFIF></CFIF>
				<CFIF IsDefined("Form.email")>email = <CFIF Form.email EQ "">NULL,<CFELSE>'#Form.email#',</CFIF></CFIF>
				<CFIF IsDefined("Form.mothersMaidenName")>mothersMaidenName = <CFIF Form.mothersMaidenName EQ "">NULL,<CFELSE>'#Form.mothersMaidenName#',</CFIF></CFIF>
				<CFIF IsDefined("Form.phone")>phone = <CFIF Form.phone EQ "">NULL,<CFELSE>'#Form.phone#',</CFIF></CFIF>
				<CFIF IsDefined("Form.phoneExtension")>phoneExtension = <CFIF Form.phoneExtension EQ "">NULL,<CFELSE>'#Form.phoneExtension#',</CFIF></CFIF>
				<CFIF IsDefined("Form.phone2")>phone2 = <CFIF Form.phone2 EQ "">NULL,<CFELSE>'#Form.phone2#',</CFIF></CFIF>
				<CFIF IsDefined("Form.phone2Extension")>phone2Extension = <CFIF Form.phone2Extension EQ "">NULL,<CFELSE>'#Form.phone2Extension#',</CFIF></CFIF>
				<CFIF IsDefined("Form.organization")>organization = <CFIF Form.organization EQ "">NULL,<CFELSE>'#Form.organization#',</CFIF></CFIF>
				<CFIF IsDefined("Form.userEmailEvents")>userEmailEvents = <CFIF Form.userEmailEvents EQ "">NULL,<CFELSE>'#Form.userEmailEvents#',</CFIF></CFIF>
				<CFIF IsDefined("Form.creditCardType")><CFIF Form.creditCardType NEQ "">creditCardType = '#Form.creditCardType#',</CFIF></CFIF>
				<CFIF IsDefined("Form.creditCardNumber")><CFIF Form.creditCardNumber NEQ "">creditCardNumber = '#creditCardNumber#',</CFIF></CFIF>
				<CFIF IsDefined("creditCardExpiration")><CFIF creditCardExpiration NEQ "">creditCardExpiration = '#creditCardExpiration#',</CFIF></CFIF>
				<CFIF IsDefined("Form.creditCardName")><CFIF Form.creditCardName NEQ "">creditCardName = '#Form.creditCardName#',</CFIF></CFIF>
				<CFIF IsDefined("Form.address")>address = <CFIF Form.address EQ "">NULL,<CFELSE>'#Form.address#',</CFIF></CFIF>
				<CFIF IsDefined("Form.address2")>address2 = <CFIF Form.address2 EQ "">NULL,<CFELSE>'#Form.address2#',</CFIF></CFIF>
				<CFIF IsDefined("Form.city")>city = <CFIF Form.city EQ "">NULL,<CFELSE>'#Form.city#',</CFIF></CFIF>
				<CFIF IsDefined("state")>state = <CFIF state EQ "">NULL,<CFELSE>'#state#',</CFIF></CFIF>
				<CFIF IsDefined("Form.zipCode")>zipCode = <CFIF Form.zipCode EQ "">NULL,<CFELSE>'#Form.zipCode#',</CFIF></CFIF>
				<CFIF IsDefined("country")>country = <CFIF country EQ "">NULL,<CFELSE>'#country#',</CFIF></CFIF>
				<CFIF IsDefined("billingSameAsShipping")>
					billingSameAsShipping = 1,
					<CFIF IsDefined("Form.address")>billingAddress = <CFIF Form.address EQ "">NULL,<CFELSE>'#Form.address#',</CFIF></CFIF>
					<CFIF IsDefined("Form.address2")>billingAddress2 = <CFIF Form.address2 EQ "">NULL,<CFELSE>'#Form.address2#',</CFIF></CFIF>
					<CFIF IsDefined("Form.city")>billingCity = <CFIF Form.city EQ "">NULL,<CFELSE>'#Form.city#',</CFIF></CFIF>
					<CFIF IsDefined("state")>billingState = <CFIF state EQ "">NULL,<CFELSE>'#state#',</CFIF></CFIF>
					<CFIF IsDefined("Form.zipCode")>billingZipCode = <CFIF Form.zipCode EQ "">NULL,<CFELSE>'#Form.zipCode#',</CFIF></CFIF>
					<CFIF IsDefined("country")>billingCountry = <CFIF country EQ "">NULL,<CFELSE>'#country#',</CFIF></CFIF>
				<CFELSE>
					billingSameAsShipping = 0,
					<CFIF IsDefined("Form.billingAddress")>billingAddress = <CFIF Form.billingAddress EQ "">NULL,<CFELSE>'#Form.billingAddress#',</CFIF></CFIF>
					<CFIF IsDefined("Form.billingAddress2")>billingAddress2 = <CFIF Form.billingAddress2 EQ "">NULL,<CFELSE>'#Form.billingAddress2#',</CFIF></CFIF>
					<CFIF IsDefined("Form.billingCity")>billingCity = <CFIF Form.billingCity EQ "">NULL,<CFELSE>'#Form.billingCity#',</CFIF></CFIF>
					<CFIF IsDefined("billingState")>billingState = <CFIF billingState EQ "">NULL,<CFELSE>'#billingState#',</CFIF></CFIF>
					<CFIF IsDefined("Form.billingZipCode")>billingZipCode = <CFIF Form.billingZipCode EQ "">NULL,<CFELSE>'#Form.billingZipCode#',</CFIF></CFIF>
					<CFIF IsDefined("billingCountry")>billingCountry = <CFIF billingCountry EQ "">NULL,<CFELSE>'#billingCountry#',</CFIF></CFIF>
				</CFIF>
				userEditedDateTime = #nowDateTime#
			WHERE userID = #userID#
		</CFQUERY>

		<CFSETTING ENABLECFOUTPUTONLY="No">
		<CFINCLUDE TEMPLATE="../system/editUserSuccess.cfm">
		<CFINCLUDE TEMPLATE="../system/editUserSuccess2.cfm">
		</BODY></HTML><CFABORT>
		<CFSETTING ENABLECFOUTPUTONLY="Yes">
	</CFIF>
</CFIF>

<CFSETTING ENABLECFOUTPUTONLY="No">
<CFIF NOT IsDefined("badRegistration")>
	<CFSET badRegistration = 0>
</CFIF>

<CFSET action = "#secureSystemURL#/admin/userCreate.cfm">
<CFFORM NAME=createUser ACTION=#action#>
<INPUT TYPE=hidden NAME=first VALUE=1>

<CFIF NOT IsDefined("userID")>
	<CFINCLUDE TEMPLATE="../system/adduserHeader.cfm">
<CFELSEIF NOT IsDefined("Form.first")>
	<CFIF IsDefined("Form.userID")>
		<CFSET userID = Replace(Form.userID, "emaze666", "
", "ALL")>
		<CFSET userID = Replace(userID, "&quot;", """", "ALL")>
		<CFSET userID = Replace(userID, "&gt;", ">", "ALL")>
		<CFSET userID = Replace(userID, "&lt;", "<", "ALL")>
		<CFSET userID = Decrypt(userID,encryptionCode)>
	</CFIF>

	<CFQUERY NAME=getUser DATASOURCE="#EAdatasource#">
		SELECT * FROM Member WHERE userID = #userID#
	</CFQUERY>
	<CFSET userIDcrypt = Encrypt("user#userID#",encryptionCode)>
	<CFSET userIDcrypt = Replace(userIDcrypt, """", "&quot;", "ALL")>
	<CFSET userIDcrypt = Replace(userIDcrypt, "
", "emaze666", "ALL")>
	<CFSET userIDcrypt = Replace(userIDcrypt, ">", "&gt;", "ALL")>
	<CFSET userIDcrypt = Replace(userIDcrypt, "<", "&lt;", "ALL")>

	<CFOUTPUT><INPUT TYPE=hidden NAME=userID VALUE="#userIDcrypt#"></CFOUTPUT>

	<CFSET oldUsername = Encrypt(getUser.username,encryptionCode)>
	<CFSET oldUsername = Replace(oldUsername, """", "&quot;", "ALL")>
	<CFSET oldUsername = Replace(oldUsername, ">", "&gt;", "ALL")>
	<CFSET oldUsername = Replace(oldUsername, "<", "&lt;", "ALL")>
	<CFSET oldUsername = Replace(oldUsername, "
", "emaze666", "ALL")>
	<CFOUTPUT><INPUT TYPE=hidden NAME=oldUsername VALUE="#oldUsername#"></CFOUTPUT>

	<CFIF getUser.email EQ ""><CFSET oldEmail = " "><CFELSE><CFSET oldEmail = getUser.email></CFIF>
	<CFSET oldEmail = Encrypt(oldEmail,encryptionCode)>
	<CFSET oldEmail = Replace(oldEmail, """", "&quot;", "ALL")>
	<CFSET oldEmail = Replace(oldEmail, ">", "&gt;", "ALL")>
	<CFSET oldEmail = Replace(oldEmail, "<", "&lt;", "ALL")>
	<CFSET oldEmail = Replace(oldEmail, "
", "emaze666", "ALL")>
	<CFOUTPUT><INPUT TYPE=hidden NAME=oldEmail VALUE="#oldEmail#"></CFOUTPUT>
	<CFINCLUDE TEMPLATE="../system/edituserHeader.cfm">
<CFELSE>
	<CFSET userIDcrypt = Encrypt("user#userID#",encryptionCode)>
	<CFSET userIDcrypt = Replace(userIDcrypt, """", "&quot;", "ALL")>
	<CFSET userIDcrypt = Replace(userIDcrypt, ">", "&gt;", "ALL")>
	<CFSET userIDcrypt = Replace(userIDcrypt, "<", "&lt;", "ALL")>
	<CFSET userIDcrypt = Replace(userIDcrypt, "
", "emaze666", "ALL")>
	<CFOUTPUT><INPUT TYPE=hidden NAME=userID VALUE="#userIDcrypt#"></CFOUTPUT>

	<CFSET oldUsername = Encrypt(oldUsername,encryptionCode)>
	<CFSET oldUsername = Replace(oldUsername, """", "&quot;", "ALL")>
	<CFSET oldUsername = Replace(oldUsername, ">", "&gt;", "ALL")>
	<CFSET oldUsername = Replace(oldUsername, "<", "&lt;", "ALL")>
	<CFSET oldUsername = Replace(oldUsername, "
", "emaze666", "ALL")>
	<CFOUTPUT><INPUT TYPE=hidden NAME=oldUsername VALUE="#oldUsername#"></CFOUTPUT>

	<CFIF NOT IsDefined("email")><CFSET email = " "><CFELSEIF email EQ ""><CFSET email = " "></CFIF>
	<CFSET oldEmail = Encrypt(email,encryptionCode)>
	<CFSET oldEmail = Replace(oldEmail, """", "&quot;", "ALL")>
	<CFSET oldEmail = Replace(oldEmail, ">", "&gt;", "ALL")>
	<CFSET oldEmail = Replace(oldEmail, "<", "&lt;", "ALL")>
	<CFSET oldEmail = Replace(oldEmail, "
", "emaze666", "ALL")>
	<CFOUTPUT><INPUT TYPE=hidden NAME=oldEmail VALUE="#oldEmail#"></CFOUTPUT>
</CFIF>

<CFSET YES = "Yes">
<CFSET NO = "No">

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>

	<CFIF IsDefined("getUser")><CFSET username = getUser.username>
	<CFELSEIF FindNoCase("username",badRegistration) AND IsDefined("Form.oldUsername")><CFSET username = oldUsername>
	<CFELSEIF IsDefined("Form.username")><CFSET username = Form.username>
	<CFELSE><CFSET username = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textUsername#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=25 MAXLENGTH=50 VALUE="#username#" REQUIRED="Yes" MESSAGE="#messageusername#"> <CFOUTPUT>#requiredFieldMarker#</CFOUTPUT></TD></TR>

	<CFIF IsDefined("userID") AND textPasswordEdit NEQ "">
		<TR><TD></TD><TD><CFOUTPUT>#textPasswordEdit#</CFOUTPUT></TD></TR>
	</CFIF>
	<CFIF NOT IsDefined("Form.password") OR NOT IsDefined("Form.first")><CFSET password = "">
	<CFELSEIF FindNoCase("password",badRegistration) EQ 0><CFSET password = Form.password>
	<CFELSE><CFSET password = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textPassword#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=password NAME=password SIZE=25 MAXLENGTH=30 VALUE="#password#" REQUIRED=#Iif(NOT IsDefined("userID"),"Yes","No")# MESSAGE="#messagepassword#"> <CFIF NOT IsDefined("userID")><CFOUTPUT>#requiredFieldMarker#</CFOUTPUT></CFIF></TD></TR>
	<TR><TD ALIGN=right><FONT SIZE=2><CFOUTPUT>#textPasswordVerify#</CFOUTPUT></FONT> </TD>
	<TD><CFINPUT TYPE=password NAME=passwordVerify SIZE=25 MAXLENGTH=30 VALUE="#password#" REQUIRED=#Iif(NOT IsDefined("userID"),"Yes","No")# MESSAGE="#messagepasswordVerify#"> <CFIF NOT IsDefined("userID")><CFOUTPUT>#requiredFieldMarker#</CFOUTPUT></CFIF></TD></TR>

	<CFIF IsDefined("getUser")><CFSET useCookie = getUser.useCookie>
	<CFELSEIF IsDefined("Form.useCookie")><CFSET useCookie = Form.useCookie>
	<CFELSE><CFSET useCookie = 0></CFIF>
	<TR><TD ALIGN=right></TD>
	<TD><INPUT TYPE=checkbox NAME=useCookie VALUE=1<CFIF useCookie EQ 1> CHECKED</CFIF>> <CFOUTPUT>#textUseCookies#</CFOUTPUT></TD></TR>

	<CFIF IsDefined("getUser")><CFSET firstName = getUser.firstName>
	<CFELSEIF NOT IsDefined("firstName")><CFSET firstName = ""></CFIF>
	<TR><TD ALIGN=right HEIGHT=40 VALIGN=bottom><CFOUTPUT>#textFirstName#</CFOUTPUT>: </TD>
	<TD HEIGHT=40 VALIGN=bottom><CFINPUT TYPE=text NAME=firstName SIZE=25 MAXLENGTH=50 VALUE="#firstName#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET lastName = getUser.lastName>
	<CFELSEIF NOT IsDefined("lastName")><CFSET lastName = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textLastName#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=lastName SIZE=25 MAXLENGTH=50 VALUE="#lastName#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET email = getUser.email>
	<CFELSEIF NOT IsDefined("email")><CFSET email = "">
	<CFELSEIF FindNoCase("email",badRegistration) AND IsDefined("oldEmail")>
		<CFIF oldEmail EQ " "><CFSET email = "">
		<CFELSE><CFSET email = oldEmail></CFIF>
	<CFELSE><CFSET email = Form.email></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textEmail#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=email SIZE=25 MAXLENGTH=50 VALUE="#email#"></TD></TR>
	<CFIF emailVerifyTwice EQ 1>
		<TR><TD ALIGN=right><CFOUTPUT>#textEmailVerify#</CFOUTPUT>: </TD>
		<TD><CFINPUT TYPE=text NAME=emailVerify SIZE=25 MAXLENGTH=50 VALUE="#email#"></TD></TR>
	</CFIF>

	<TR><TD ALIGN=right VALIGN=top><CFOUTPUT>#textEmailMeWhen#</CFOUTPUT></TD><TD>
	<CFIF IsDefined("getUser")><CFSET userEmailEvents = getUser.userEmailEvents>
	<CFELSEIF NOT IsDefined("userEmailEvents")><CFSET userEmailEvents = ""></CFIF>
	<INPUT TYPE=checkbox NAME=userEmailEvents VALUE=winner<CFIF ListFind(userEmailEvents,"winner")> CHECKED</CFIF>> <CFOUTPUT>#textEmailWinner#</CFOUTPUT><BR>
	<INPUT TYPE=checkbox NAME=userEmailEvents VALUE=loser<CFIF ListFind(userEmailEvents,"loser")> CHECKED</CFIF>> <CFOUTPUT>#textEmailLoser#</CFOUTPUT><BR>
	<INPUT TYPE=checkbox NAME=userEmailEvents VALUE=outbid<CFIF ListFind(userEmailEvents,"outbid")> CHECKED</CFIF>> <CFOUTPUT>#textEmailOutbid#</CFOUTPUT><BR>
	<INPUT TYPE=checkbox NAME=userEmailEvents VALUE=autobid<CFIF ListFind(userEmailEvents,"autobid")> CHECKED</CFIF>> <CFOUTPUT>#textEmailAutobid#</CFOUTPUT>
	</TD></TR>

	<CFIF IsDefined("getUser")><CFSET organization = getUser.organization>
	<CFELSEIF NOT IsDefined("organization")><CFSET organization = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textOrganization#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=organization SIZE=15 MAXLENGTH=50 VALUE="#organization#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET phone = getUser.phone>
	<CFELSEIF NOT IsDefined("phone")><CFSET phone = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textPhone#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=phone SIZE=15 MAXLENGTH=50 VALUE="#phone#">
		<CFIF IsDefined("getUser")><CFSET phoneExtension = getUser.phoneExtension>
		<CFELSEIF NOT IsDefined("phoneExtension")><CFSET phoneExtension = ""></CFIF>
		<CFOUTPUT>#textPhoneExtension#</CFOUTPUT>: <CFINPUT TYPE=text NAME=phoneExtension SIZE=15 MAXLENGTH=50 VALUE="#phoneExtension#">
	</TD></TR>

	<CFIF IsDefined("getUser")><CFSET phone2 = getUser.phone2>
	<CFELSEIF NOT IsDefined("phone2")><CFSET phone2 = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textPhone2#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=phone2 SIZE=15 MAXLENGTH=50 VALUE="#phone2#">
		<CFIF IsDefined("getUser")><CFSET phone2Extension = getUser.phone2Extension>
		<CFELSEIF NOT IsDefined("phone2Extension")><CFSET phone2Extension = ""></CFIF>
		<CFOUTPUT>#textPhone2Extension#</CFOUTPUT>: <CFINPUT TYPE=text NAME=phone2Extension SIZE=15 MAXLENGTH=50 VALUE="#phone2Extension#">
	</TD></TR>

<CFIF textShippingInformation NEQ "">
	<TR><TD COLSPAN=2 HEIGHT=40 VALIGN=bottom><CFOUTPUT>#textShippingInformation#</CFOUTPUT></TD></TR>
</CFIF>

	<CFIF IsDefined("getUser")><CFSET address = getUser.address>
	<CFELSEIF NOT IsDefined("address")><CFSET address = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textAddress#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=address SIZE=25 MAXLENGTH=50 VALUE="#address#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET address2 = getUser.address2>
	<CFELSEIF NOT IsDefined("address2")><CFSET address2 = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textAddress2#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME=address2 SIZE=25 MAXLENGTH=50 VALUE="#address2#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET city = getUser.city>
	<CFELSEIF NOT IsDefined("city")><CFSET city = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textCity#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=city SIZE=20 MAXLENGTH=50 VALUE="#city#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET state = getUser.state>
	<CFELSEIF NOT IsDefined("state")><CFSET state = ""></CFIF>
	<TR><TD ALIGN=right VALIGN=top><CFOUTPUT>#textState#</CFOUTPUT>: </TD><TD>
	<CFIF stateSelect EQ 0>
		<CFINPUT TYPE=text NAME=state SIZE=20 MAXLENGTH=50 VALUE="#state#">
	<CFELSE>
		<CFSET stateSelected = state>
		<SELECT NAME=stateSelectList SIZE=1><CFINCLUDE TEMPLATE="../system/userState.cfm"></SELECT>
		<CFIF stateSelect EQ 2>
			<BR><CFOUTPUT>#textStateOther#</CFOUTPUT>
			<CFIF ListFind(stateList,state) OR state EQ " "><CFSET state = ""></CFIF>
			<CFINPUT TYPE=text NAME=stateText SIZE=20 MAXLENGTH=50 VALUE="#state#">
		</CFIF>
	</CFIF>
	</TD></TR>

	<CFIF IsDefined("getUser")><CFSET zipCode = getUser.zipCode>
	<CFELSEIF NOT IsDefined("zipCode")><CFSET zipCode = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textZipCode#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=zipCode SIZE=10 MAXLENGTH=50 VALUE="#zipCode#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET country = getUser.country>
	<CFELSEIF NOT IsDefined("country")><CFSET country = ""></CFIF>
	<TR><TD ALIGN=right VALIGN=top><CFOUTPUT>#textCountry#</CFOUTPUT>: </TD><TD>
	<CFIF countrySelect EQ 0>
		<CFINPUT TYPE=text NAME=country SIZE=25 MAXLENGTH=50 VALUE="#country#">
	<CFELSE>
		<CFSET countrySelected = country>
		<SELECT NAME=countrySelectList SIZE=1><CFINCLUDE TEMPLATE="../system/userCountry.cfm"></SELECT> 
		<CFIF countrySelect EQ 2>
			<BR><CFOUTPUT>#textCountryOther#</CFOUTPUT>
			<CFIF ListFind(countryList,country) OR country EQ " "><CFSET country = ""></CFIF>
			<CFINPUT TYPE=text NAME=countryText SIZE=25 MAXLENGTH=50 VALUE="#country#">
		</CFIF>
	</CFIF>
	</TD></TR>

<TR><TD>&nbsp;</TD></TR>

<CFIF textBillingInformation NEQ "">
	<TR><TD COLSPAN=2 VALIGN=bottom><CFOUTPUT>#textBillingInformation#</CFOUTPUT></TD></TR>
</CFIF>

	<CFIF IsDefined("Form.creditCardType")><CFSET creditCardType = Form.creditCardType>
	<CFELSEIF IsDefined("getUser")><CFSET creditCardType = getUser.creditCardType>
	<CFELSE><CFSET creditCardType = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textCreditCardType#</CFOUTPUT>: </TD>
	<TD><SELECT NAME=creditCardType SIZE=1>
	<CFINCLUDE TEMPLATE="../system/userCreditCardType.cfm">
	</SELECT>
	</TD></TR>

	<CFIF IsDefined("userID") AND textPasswordEdit NEQ "">
		<TR><TD></TD><TD><CFOUTPUT>#textCreditCardEdit#</CFOUTPUT></TD></TR>
	</CFIF>
	<CFIF IsDefined("Form.creditCardNumber")><CFSET creditCardNumber = Form.creditCardNumber>
	<CFELSEIF IsDefined("getUser")>
		<CFIF getUser.creditCardNumber EQ "" OR getUser.creditCardNumber EQ " "><CFSET creditCardNumber = "">
		<CFELSE><CFSET creditCardNumber = Decrypt(getUser.creditCardNumber,encryptionCode)></CFIF>
	<CFELSE><CFSET creditCardNumber = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textCreditCardNumber#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=creditCardNumber SIZE=16 MAXLENGTH=16 VALUE="#creditCardNumber#" VALIDATE=creditcard>
	<CFOUTPUT>#textCreditCardNumberFormat#</CFOUTPUT></TD></TR>

	<TR><TD ALIGN=right><CFOUTPUT>#textCreditCardExpiration#</CFOUTPUT>: </TD><TD>
	<CFIF creditCardExpirationSelect EQ 0>
		<CFIF IsDefined("Form.creditCardExpiration")><CFSET creditCardExpiration = Form.creditCardExpiration>
		<CFELSEIF IsDefined("getUser")>
			<CFIF getUser.creditCardExpiration EQ "" OR getUser.creditCardExpiration EQ " "><CFSET creditCardExpiration = "">
			<CFELSE><CFSET creditCardExpiration = Decrypt(getUser.creditCardExpiration,encryptionCode)></CFIF>
		<CFELSE><CFSET creditCardExpiration = ""></CFIF>
		<CFINPUT TYPE=text NAME=creditCardExpiration SIZE=7 MAXLENGTH=5 VALUE="#creditCardExpiration#">
	<CFELSE>
		<CFIF IsDefined("Form.creditCardExpirationMM")>
			<CFSET creditCardExpirationMM = Form.creditCardExpirationMM>
			<CFSET creditCardExpirationYY = Form.creditCardExpirationYY>
		<CFELSEIF IsDefined("getUser")>
			<CFIF getUser.creditCardExpiration EQ "" OR getUser.creditCardExpiration EQ " "><CFSET creditCardExpiration = "">
			<CFELSE><CFSET creditCardExpiration = Decrypt(getUser.creditCardExpiration,encryptionCode)></CFIF>
			<CFSET creditCardExpirationMM = Left(creditCardExpiration,2)>
			<CFSET creditCardExpirationYY = Right(creditCardExpiration,2)>
		<CFELSE><CFSET creditCardExpirationMM = ""><CFSET creditCardExpirationYY = ""></CFIF>
		<SELECT NAME=creditCardExpirationMM SIZE=1>
		<OPTION VALUE=""<CFIF creditCardExpirationMM EQ ""> SELECTED</CFIF>> MM
		<OPTION VALUE=01<CFIF creditCardExpirationMM EQ 01> SELECTED</CFIF>> 01
		<OPTION VALUE=02<CFIF creditCardExpirationMM EQ 02> SELECTED</CFIF>> 02
		<OPTION VALUE=03<CFIF creditCardExpirationMM EQ 03> SELECTED</CFIF>> 03
		<OPTION VALUE=04<CFIF creditCardExpirationMM EQ 04> SELECTED</CFIF>> 04
		<OPTION VALUE=05<CFIF creditCardExpirationMM EQ 05> SELECTED</CFIF>> 05
		<OPTION VALUE=06<CFIF creditCardExpirationMM EQ 06> SELECTED</CFIF>> 06
		<OPTION VALUE=07<CFIF creditCardExpirationMM EQ 07> SELECTED</CFIF>> 07
		<OPTION VALUE=08<CFIF creditCardExpirationMM EQ 08> SELECTED</CFIF>> 08
		<OPTION VALUE=09<CFIF creditCardExpirationMM EQ 09> SELECTED</CFIF>> 09
		<OPTION VALUE=10<CFIF creditCardExpirationMM EQ 10> SELECTED</CFIF>> 10
		<OPTION VALUE=11<CFIF creditCardExpirationMM EQ 11> SELECTED</CFIF>> 11
		<OPTION VALUE=12<CFIF creditCardExpirationMM EQ 12> SELECTED</CFIF>> 12
		</SELECT>/<SELECT NAME=creditCardExpirationYY SIZE=1>
		<OPTION VALUE=""<CFIF creditCardExpirationMM EQ ""> SELECTED</CFIF>> YY
		<OPTION VALUE=99<CFIF creditCardExpirationYY EQ 99> SELECTED</CFIF>> 1999
		<OPTION VALUE=00<CFIF creditCardExpirationYY EQ 00> SELECTED</CFIF>> 2000
		<OPTION VALUE=01<CFIF creditCardExpirationYY EQ 01> SELECTED</CFIF>> 2001
		<OPTION VALUE=02<CFIF creditCardExpirationYY EQ 02> SELECTED</CFIF>> 2002
		<OPTION VALUE=03<CFIF creditCardExpirationYY EQ 03> SELECTED</CFIF>> 2003
		<OPTION VALUE=04<CFIF creditCardExpirationYY EQ 04> SELECTED</CFIF>> 2004
		<OPTION VALUE=05<CFIF creditCardExpirationYY EQ 05> SELECTED</CFIF>> 2005
		<OPTION VALUE=06<CFIF creditCardExpirationYY EQ 06> SELECTED</CFIF>> 2006
		<OPTION VALUE=07<CFIF creditCardExpirationYY EQ 07> SELECTED</CFIF>> 2007
		</SELECT>
	</CFIF>
	 <CFOUTPUT>#textCreditCardExpirationFormat#</CFOUTPUT></TD></TR>

	<CFIF IsDefined("Form.creditCardName")><CFSET creditCardName = Form.creditCardName>
	<CFELSEIF IsDefined("getUser")><CFSET creditCardName = getUser.creditCardName>
	<CFELSE><CFSET creditCardName = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textCreditCardName#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=creditCardName SIZE=25 MAXLENGTH=50 VALUE="#creditCardName#"></TD></TR>

<TR><TD>&nbsp;</TD></TR>

	<CFIF IsDefined("getUser")><CFSET billingSameAsShipping = getUser.billingSameAsShipping>
	<CFELSEIF NOT IsDefined("billingSameAsShipping")><CFSET billingSameAsShipping = 0></CFIF>
	<TR><TD ALIGN=right VALIGN=top><INPUT TYPE=checkbox NAME=billingSameAsShipping VALUE=1<CFIF billingSameAsShipping EQ 1> CHECKED</CFIF>> </TD>
	<TD><CFOUTPUT>#textBillingSameAsShipping#</CFOUTPUT></TD></TR>

	<CFIF IsDefined("getUser")><CFSET billingAddress = getUser.billingAddress>
	<CFELSEIF NOT IsDefined("billingAddress")><CFSET billingAddress = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textBillingAddress#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=billingAddress SIZE=25 MAXLENGTH=50 VALUE="#billingAddress#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET billingAddress2 = getUser.billingAddress2>
	<CFELSEIF NOT IsDefined("billingAddress2")><CFSET billingAddress2 = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textBillingAddress2#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME=billingAddress2 SIZE=25 MAXLENGTH=50 VALUE="#billingAddress2#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET billingCity = getUser.billingCity>
	<CFELSEIF NOT IsDefined("billingCity")><CFSET billingCity = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textBillingCity#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=billingCity SIZE=20 MAXLENGTH=50 VALUE="#billingCity#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET billingState = getUser.billingState>
	<CFELSEIF NOT IsDefined("billingState")><CFSET billingState = ""></CFIF>
	<TR><TD ALIGN=right VALIGN=top><CFOUTPUT>#textBillingState#</CFOUTPUT>: </TD><TD>
	<CFIF stateSelect EQ 0>
		<CFINPUT TYPE=text NAME=billingState SIZE=20 MAXLENGTH=50 VALUE="#billingState#">
	<CFELSE>
		<CFSET stateSelected = billingState>
		<SELECT NAME=billingStateSelectList SIZE=1><CFINCLUDE TEMPLATE="../system/userState.cfm"></SELECT>
		<CFIF stateSelect EQ 2>
			<BR><CFOUTPUT>#textStateOther#</CFOUTPUT>
			<CFIF ListFind(stateList,billingState) OR billingState EQ " "><CFSET billingState = ""></CFIF>
			<CFINPUT TYPE=text NAME=billingStateText SIZE=20 MAXLENGTH=50 VALUE="#billingState#">
		</CFIF>
	</CFIF>
	</TD></TR>

	<CFIF IsDefined("getUser")><CFSET billingZipCode = getUser.billingZipCode>
	<CFELSEIF NOT IsDefined("billingZipCode")><CFSET billingZipCode = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textBillingZipCode#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=billingZipCode SIZE=10 MAXLENGTH=50 VALUE="#billingZipCode#"></TD></TR>

	<CFIF IsDefined("getUser")><CFSET billingCountry = getUser.billingCountry>
	<CFELSEIF NOT IsDefined("billingCountry")><CFSET billingCountry = ""></CFIF>
	<TR><TD ALIGN=right VALIGN=top><CFOUTPUT>#textBillingCountry#</CFOUTPUT>: </TD><TD>
	<CFIF countrySelect EQ 0>
		<CFINPUT TYPE=text NAME=billingCountry SIZE=25 MAXLENGTH=50 VALUE="#billingCountry#">
	<CFELSE>
		<CFSET countrySelected = billingCountry>
		<SELECT NAME=countrySelectList SIZE=1><CFINCLUDE TEMPLATE="../system/userCountry.cfm"></SELECT>
		<CFIF countrySelect EQ 2>
			<BR><CFOUTPUT>#textCountryOther#</CFOUTPUT>
			<CFIF ListFind(countryList,billingCountry) OR billingCountry EQ " "><CFSET billingCountry = ""></CFIF>
			<CFINPUT TYPE=text NAME=billingCountryText SIZE=25 MAXLENGTH=50 VALUE="#billingCountry#">
		</CFIF>
	</CFIF>
	</TD></TR>

	<CFIF IsDefined("getUser")><CFSET mothersMaidenName = getUser.mothersMaidenName>
	<CFELSEIF NOT IsDefined("mothersMaidenName")><CFSET mothersMaidenName = ""></CFIF>
	<TR><TD ALIGN=right><CFOUTPUT>#textMothersMaidenName#</CFOUTPUT>: </TD>
	<TD><CFINPUT TYPE=text NAME=mothersMaidenName SIZE=15 MAXLENGTH=50 VALUE="#mothersMaidenName#"></TD></TR>

<CFOUTPUT><TR><TD ALIGN=center COLSPAN=2 HEIGHT=40><INPUT TYPE=reset VALUE="#buttonReset#"> 
<CFIF IsDefined("userID") AND NOT IsDefined("Form.first")>
	<INPUT TYPE=submit VALUE="#buttonEdit#">
<CFELSEIF NOT IsDefined("Form.userID")><INPUT TYPE=submit VALUE="#buttonCreate#">
<CFELSE><INPUT TYPE=submit VALUE="#buttonEdit#">
</CFIF>
</CFOUTPUT>

</TD></TR>
</TABLE>
</CFFORM>

<P>
</BODY>
</HTML>