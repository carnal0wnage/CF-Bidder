<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>User Fields</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFSETTING ENABLECFOUTPUTONLY="Yes">

	<CFIF NOT IsDefined("Form.emailEventsList")><CFSET emailEventsList = " "></CFIF>
	<CFIF NOT IsDefined("Form.forcedEmailEventsList")><CFSET forcedEmailEventsList = " "></CFIF>
	<CFFILE ACTION=Write FILE="#systemPath#\system\emailEventsList.cfm"
		OUTPUT="<CFSET emailEventsList = ""#emailEventsList#"">
<CFSET forcedEmailEventsList = ""#forcedEmailEventsList#"">">

	<CFSET basicUserList = "firstName,lastName,email,organization,phone,phoneExtension,phone2,phone2Extension,creditCardNumber,creditCardExpiration,creditCardName,creditCardType,address,billingAddress,address2,billingAddress2,city,billingCity,state,billingState,zipCode,billingZipCode,country,billingCountry,mothersMaidenName">
	<CFSET userList = "username,password">
	<CFIF IsDefined("Form.billingSameAsShipping")><CFSET userList = ListAppend(userList,"billingSameAsShipping")></CFIF>
	<CFSET userListRequired = "username,password">
	<CFLOOP INDEX=field LIST="#basicUserList#">
		<CFSET tempField = "Form.#field#">
		<CFIF Evaluate(tempField) EQ 1>
			<CFSET userList = ListAppend(userList,field)>
		<CFELSEIF Evaluate(tempField) EQ 2>
			<CFSET userList = ListAppend(userList,field)>
			<CFSET userListRequired = ListAppend(userListRequired,field)>
		</CFIF>
	</CFLOOP>

	<CFIF NOT IsDefined("Form.userListUnique")><CFSET userListUnique = ""></CFIF>
	<CFIF NOT IsDefined("Form.creditCardTypeList")><CFSET creditCardTypeList = " "></CFIF>
	<CFIF NOT IsDefined("Form.emailVerifyTwice")><CFSET emailVerifyTwice = 0></CFIF>
	<CFIF NOT IsDefined("Form.emailUsernamePassword")><CFSET emailUsernamePassword = 0></CFIF>
	<CFIF NOT IsDefined("Form.emailUserAgreement")><CFSET emailUserAgreement = 0></CFIF>
	<CFIF NOT IsDefined("Form.userListEdit")><CFSET userListEdit = ""></CFIF>
	<CFFILE ACTION=Write FILE="#systemPath#\system\userList.cfm"
		OUTPUT="<CFSET userList = ""#userList#"">
<CFSET userListEdit = ""#userListEdit#"">
<CFSET userListRequired = ""#userListRequired#"">
<CFSET userListUnique = ""#userListUnique#"">
<CFSET emailVerifyTwice = #emailVerifyTwice#>
<CFSET creditCardTypeList = ""#creditCardTypeList#"">
<CFSET creditCardExpirationSelect = #Form.creditCardExpirationSelect#>
<CFSET stateSelect = #Form.stateSelect#>
<CFSET countrySelect = #Form.countrySelect#>
<CFSET userAgreement = #Form.userAgreement#>
<CFSET emailUsernamePassword = #emailUsernamePassword#>
<CFSET emailUserAgreement = #emailUserAgreement#>">

	<CFIF IsDefined("Form.userEmailVerify")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\userEmailVerify.cfm" OUTPUT="<CFSET userEmailVerify = 1>">
	<CFELSE>
		<CFFILE ACTION=Write FILE="#systemPath#\system\userEmailVerify.cfm" OUTPUT="<CFSET userEmailVerify = 0>">
	</CFIF>

	<CFIF NOT IsDefined("Form.allowCookieLogin")><CFSET allowCookieLogin = 0></CFIF>
	<CFIF Form.oldAllowCookieLogin NEQ allowCookieLogin><B>Cookie login option updated.</B><BR></CFIF>
	<CFIF NOT IsDefined("Form.allowCookieBid")><CFSET allowCookieBid = 0></CFIF>
	<CFIF Form.oldCookieBid NEQ allowCookieBid><B>Cookie bid option updated.</B><BR></CFIF>
	<CFFILE ACTION=Write FILE="#systemPath#\system\useCookies.cfm"
		OUTPUT="<CFSET allowCookieLogin = #allowCookieLogin#>
<CFSET allowCookieBid = #allowCookieBid#>">

	<CFSET requiredFieldMarker = Replace(Form.requiredFieldMarker, """", "&quot;", "ALL")>
	<CFSET textPassword = Replace(Form.textPassword, """", "&quot;", "ALL")>
	<CFSET textPasswordVerify = Replace(Form.textPasswordVerify, """", "&quot;", "ALL")>
	<CFSET textPasswordEdit = Replace(Form.textPasswordEdit, """", "&quot;", "ALL")>
	<CFSET textUseCookies = Replace(Form.textUseCookies, """", "&quot;", "ALL")>
	<CFSET textFirstName = Replace(Form.textFirstName, """", "&quot;", "ALL")>
	<CFSET textLastName = Replace(Form.textLastName, """", "&quot;", "ALL")>
	<CFSET textEmail = Replace(Form.textEmail, """", "&quot;", "ALL")>
	<CFSET textEmailVerify = Replace(Form.textEmailVerify, """", "&quot;", "ALL")>
	<CFSET textOrganization = Replace(Form.textOrganization, """", "&quot;", "ALL")>
	<CFSET textPhone = Replace(Form.textPhone, """", "&quot;", "ALL")>
	<CFSET textPhoneExtension = Replace(Form.textPhoneExtension, """", "&quot;", "ALL")>
	<CFSET textPhone2 = Replace(Form.textPhone2, """", "&quot;", "ALL")>
	<CFSET textPhone2Extension = Replace(Form.textPhone2Extension, """", "&quot;", "ALL")>
	<CFSET textAddress = Replace(Form.textAddress, """", "&quot;", "ALL")>
	<CFSET textAddress2 = Replace(Form.textAddress2, """", "&quot;", "ALL")>
	<CFSET textCity = Replace(Form.textCity, """", "&quot;", "ALL")>
	<CFSET textState = Replace(Form.textState, """", "&quot;", "ALL")>
	<CFSET textStateOther = Replace(Form.textStateOther, """", "&quot;", "ALL")>
	<CFSET textZipCode = Replace(Form.textZipCode, """", "&quot;", "ALL")>
	<CFSET textCountry = Replace(Form.textCountry, """", "&quot;", "ALL")>
	<CFSET textCountryOther = Replace(Form.textCountryOther, """", "&quot;", "ALL")>
	<CFSET textBillingSameAsShipping = Replace(Form.textBillingSameAsShipping, """", "&quot;", "ALL")>
	<CFSET textBillingAddress = Replace(Form.textBillingAddress, """", "&quot;", "ALL")>
	<CFSET textBillingAddress2 = Replace(Form.textBillingAddress2, """", "&quot;", "ALL")>
	<CFSET textBillingCity = Replace(Form.textBillingCity, """", "&quot;", "ALL")>
	<CFSET textBillingState = Replace(Form.textBillingState, """", "&quot;", "ALL")>
	<CFSET textBillingZipCode = Replace(Form.textBillingZipCode, """", "&quot;", "ALL")>
	<CFSET textBillingCountry = Replace(Form.textBillingCountry, """", "&quot;", "ALL")>
	<CFSET textCreditCardNumber = Replace(Form.textCreditCardNumber, """", "&quot;", "ALL")>
	<CFSET textCreditCardName = Replace(Form.textCreditCardName, """", "&quot;", "ALL")>
	<CFSET textCreditCardExpiration = Replace(Form.textCreditCardExpiration, """", "&quot;", "ALL")>
	<CFSET textCreditCardType = Replace(Form.textCreditCardType, """", "&quot;", "ALL")>
	<CFSET textCreditCardType = Replace(Form.textCreditCardType, """", "&quot;", "ALL")>
	<CFSET textMothersMaidenName = Replace(Form.textMothersMaidenName, """", "&quot;", "ALL")>

	<CFSET textShippingInformation = Replace(Form.textShippingInformation, """", "&quot;", "ALL")>
	<CFSET textBillingInformation = Replace(Form.textBillingInformation, """", "&quot;", "ALL")>
	<CFSET textCreditCardEdit = Replace(Form.textCreditCardEdit, """", "&quot;", "ALL")>
	<CFSET textCreditCardNumberFormat = Replace(Form.textCreditCardNumberFormat, """", "&quot;", "ALL")>
	<CFSET textCreditCardExpirationFormat = Replace(Form.textCreditCardExpirationFormat, """", "&quot;", "ALL")>
	<CFSET textEmailMeWhen = Replace(Form.textEmailMeWhen, """", "&quot;", "ALL")>
	<CFSET textEmailDailyStatus = Replace(Form.textEmailDailyStatus, """", "&quot;", "ALL")>
	<CFSET textEmailWinner = Replace(Form.textEmailWinner, """", "&quot;", "ALL")>
	<CFSET textEmailLoser = Replace(Form.textEmailLoser, """", "&quot;", "ALL")>
	<CFSET textEmailOutbid = Replace(Form.textEmailOutbid, """", "&quot;", "ALL")>
	<CFSET textEmailAutobid = Replace(Form.textEmailAutobid, """", "&quot;", "ALL")>

	<CFSET buttonReset = Replace(Form.buttonReset, """", "&quot;", "ALL")>
	  <CFSET buttonReset = Replace(buttonReset, "<", "&lt;", "ALL")>
	  <CFSET buttonReset = Replace(buttonReset, ">", "&gt;", "ALL")>
	<CFSET buttonEdit = Replace(Form.buttonEdit, """", "&quot;", "ALL")>
	  <CFSET buttonEdit = Replace(buttonEdit, "<", "&lt;", "ALL")>
	  <CFSET buttonEdit = Replace(buttonEdit, ">", "&gt;", "ALL")>
	<CFSET buttonCreate = Replace(Form.buttonCreate, """", "&quot;", "ALL")>
	  <CFSET buttonCreate = Replace(buttonCreate, "<", "&lt;", "ALL")>
	  <CFSET buttonCreate = Replace(buttonCreate, ">", "&gt;", "ALL")>
	<CFSET buttonUserAgrAccept = Replace(Form.buttonUserAgrAccept, """", "&quot;", "ALL")>
	  <CFSET buttonUserAgrAccept = Replace(buttonUserAgrAccept, "<", "&lt;", "ALL")>
	  <CFSET buttonUserAgrAccept = Replace(buttonUserAgrAccept, ">", "&gt;", "ALL")>
	<CFSET buttonUserAgrReject = Replace(Form.buttonUserAgrReject, """", "&quot;", "ALL")>
	  <CFSET buttonUserAgrReject = Replace(buttonUserAgrReject, "<", "&lt;", "ALL")>
	  <CFSET buttonUserAgrReject = Replace(buttonUserAgrReject, ">", "&gt;", "ALL")>

	<CFSET messageusername = Replace(Form.messageusername, """", "&quot;", "ALL")>
	<CFSET messagepassword = Replace(Form.messagepassword, """", "&quot;", "ALL")>
	<CFSET messagepasswordVerify = Replace(Form.messagepasswordVerify, """", "&quot;", "ALL")>
	<CFSET messagefirstName = Replace(Form.messagefirstName, """", "&quot;", "ALL")>
	<CFSET messagelastName = Replace(Form.messagelastName, """", "&quot;", "ALL")>
	<CFSET messageemail = Replace(Form.messageemail, """", "&quot;", "ALL")>
	<CFSET messageemailVerify = Replace(Form.messageemailVerify, """", "&quot;", "ALL")>
	<CFSET messageorganization = Replace(Form.messageorganization, """", "&quot;", "ALL")>
	<CFSET messagephone = Replace(Form.messagephone, """", "&quot;", "ALL")>
	<CFSET messagephoneExtension = Replace(Form.messagephoneExtension, """", "&quot;", "ALL")>
	<CFSET messagephone2 = Replace(Form.messagephone2, """", "&quot;", "ALL")>
	<CFSET messagephone2Extension = Replace(Form.messagephone2Extension, """", "&quot;", "ALL")>
	<CFSET messageaddress = Replace(Form.messageaddress, """", "&quot;", "ALL")>
	<CFSET messageaddress2 = Replace(Form.messageaddress2, """", "&quot;", "ALL")>
	<CFSET messagecity = Replace(Form.messagecity, """", "&quot;", "ALL")>
	<CFSET messagestate = Replace(Form.messagestate, """", "&quot;", "ALL")>
	<CFSET messagezipCode = Replace(Form.messagezipCode, """", "&quot;", "ALL")>
	<CFSET messagecountry = Replace(Form.messagecountry, """", "&quot;", "ALL")>
	<CFSET messagebillingAddress = Replace(Form.messagebillingAddress, """", "&quot;", "ALL")>
	<CFSET messagebillingAddress2 = Replace(Form.messagebillingAddress2, """", "&quot;", "ALL")>
	<CFSET messagebillingCity = Replace(Form.messagebillingCity, """", "&quot;", "ALL")>
	<CFSET messagebillingState = Replace(Form.messagebillingState, """", "&quot;", "ALL")>
	<CFSET messagebillingZipCode = Replace(Form.messagebillingZipCode, """", "&quot;", "ALL")>
	<CFSET messagebillingCountry = Replace(Form.messagebillingCountry, """", "&quot;", "ALL")>
	<CFSET messagecreditCardNumber = Replace(Form.messagecreditCardNumber, """", "&quot;", "ALL")>
	<CFSET messagecreditCardName = Replace(Form.messagecreditCardName, """", "&quot;", "ALL")>
	<CFSET messagecreditCardExpiration = Replace(Form.messagecreditCardExpiration, """", "&quot;", "ALL")>
	<CFSET messagecreditCardType = Replace(Form.messagecreditCardType, """", "&quot;", "ALL")>
	<CFSET messagemothersMaidenName = Replace(Form.messagemothersMaidenName, """", "&quot;", "ALL")>

	<CFSET requiredFieldMarker = Replace(requiredFieldMarker, "##", "####", "ALL")>
	<CFSET textUsername = Replace(textUsername, "##", "####", "ALL")>
	<CFSET textPassword = Replace(textPassword, "##", "####", "ALL")>
	<CFSET textPasswordVerify = Replace(textPasswordVerify, "##", "####", "ALL")>
	<CFSET textPasswordEdit = Replace(textPasswordEdit, "##", "####", "ALL")>
	<CFSET textUseCookies = Replace(textUseCookies, "##", "####", "ALL")>
	<CFSET textFirstName = Replace(textFirstName, "##", "####", "ALL")>
	<CFSET textLastName = Replace(textLastName, "##", "####", "ALL")>
	<CFSET textEmail = Replace(textEmail, "##", "####", "ALL")>
	<CFSET textEmailVerify = Replace(textEmailVerify, "##", "####", "ALL")>
	<CFSET textOrganization = Replace(textOrganization, "##", "####", "ALL")>
	<CFSET textPhone = Replace(textPhone, "##", "####", "ALL")>
	<CFSET textPhoneExtension = Replace(textPhoneExtension, "##", "####", "ALL")>
	<CFSET textPhone2 = Replace(textPhone2, "##", "####", "ALL")>
	<CFSET textPhone2Extension = Replace(textPhone2Extension, "##", "####", "ALL")>
	<CFSET textAddress = Replace(textAddress, "##", "####", "ALL")>
	<CFSET textAddress2 = Replace(textAddress2, "##", "####", "ALL")>
	<CFSET textCity = Replace(textCity, "##", "####", "ALL")>
	<CFSET textState = Replace(textState, "##", "####", "ALL")>
	<CFSET textStateOther = Replace(textStateOther, "##", "####", "ALL")>
	<CFSET textZipCode = Replace(textZipCode, "##", "####", "ALL")>
	<CFSET textCountry = Replace(textCountry, "##", "####", "ALL")>
	<CFSET textCountryOther = Replace(textCountryOther, "##", "####", "ALL")>
	<CFSET textBillingSameAsShipping = Replace(textBillingSameAsShipping, "##", "####", "ALL")>
	<CFSET textBillingAddress = Replace(textBillingAddress, "##", "####", "ALL")>
	<CFSET textBillingAddress2 = Replace(textBillingAddress2, "##", "####", "ALL")>
	<CFSET textBillingCity = Replace(textBillingCity, "##", "####", "ALL")>
	<CFSET textBillingState = Replace(textBillingState, "##", "####", "ALL")>
	<CFSET textBillingZipCode = Replace(textBillingZipCode, "##", "####", "ALL")>
	<CFSET textBillingCountry = Replace(textBillingCountry, "##", "####", "ALL")>
	<CFSET textCreditCardNumber = Replace(textCreditCardNumber, "##", "####", "ALL")>
	<CFSET textCreditCardName = Replace(textCreditCardName, "##", "####", "ALL")>
	<CFSET textCreditCardExpiration = Replace(textCreditCardExpiration, "##", "####", "ALL")>
	<CFSET textCreditCardType = Replace(textCreditCardType, "##", "####", "ALL")>
	<CFSET textMothersMaidenName = Replace(textMothersMaidenName, "##", "####", "ALL")>

	<CFSET messageusername = Replace(messageusername, "##", "####", "ALL")>
	<CFSET messagepassword = Replace(messagepassword, "##", "####", "ALL")>
	<CFSET messagepasswordVerify = Replace(messagepasswordVerify, "##", "####", "ALL")>
	<CFSET messagefirstName = Replace(messagefirstName, "##", "####", "ALL")>
	<CFSET messagelastName = Replace(messagelastName, "##", "####", "ALL")>
	<CFSET messageemail = Replace(messageemail, "##", "####", "ALL")>
	<CFSET messageemailVerify = Replace(messageemailVerify, "##", "####", "ALL")>
	<CFSET messageorganization = Replace(messageorganization, "##", "####", "ALL")>
	<CFSET messagephone = Replace(messagephone, "##", "####", "ALL")>
	<CFSET messagephoneExtension = Replace(messagephoneExtension, "##", "####", "ALL")>
	<CFSET messagephone2 = Replace(messagephone2, "##", "####", "ALL")>
	<CFSET messagephone2Extension = Replace(messagephone2Extension, "##", "####", "ALL")>
	<CFSET messageaddress = Replace(messageaddress, "##", "####", "ALL")>
	<CFSET messageaddress2 = Replace(messageaddress2, "##", "####", "ALL")>
	<CFSET messagecity = Replace(messagecity, "##", "####", "ALL")>
	<CFSET messagestate = Replace(messagestate, "##", "####", "ALL")>
	<CFSET messagezipCode = Replace(messagezipCode, "##", "####", "ALL")>
	<CFSET messagecountry = Replace(messagecountry, "##", "####", "ALL")>
	<CFSET messagebillingAddress = Replace(messagebillingAddress, "##", "####", "ALL")>
	<CFSET messagebillingAddress2 = Replace(messagebillingAddress2, "##", "####", "ALL")>
	<CFSET messagebillingCity = Replace(messagebillingCity, "##", "####", "ALL")>
	<CFSET messagebillingState = Replace(messagebillingState, "##", "####", "ALL")>
	<CFSET messagebillingZipCode = Replace(messagebillingZipCode, "##", "####", "ALL")>
	<CFSET messagebillingCountry = Replace(messagebillingCountry, "##", "####", "ALL")>
	<CFSET messagecreditCardNumber = Replace(messagecreditCardNumber, "##", "####", "ALL")>
	<CFSET messagecreditCardName = Replace(messagecreditCardName, "##", "####", "ALL")>
	<CFSET messagecreditCardExpiration = Replace(messagecreditCardExpiration, "##", "####", "ALL")>
	<CFSET messagecreditCardType = Replace(messagecreditCardType, "##", "####", "ALL")>
	<CFSET messagemothersMaidenName = Replace(messagemothersMaidenName, "##", "####", "ALL")>

	<CFSET textShippingInformation = Replace(textShippingInformation, "##", "####", "ALL")>
	<CFSET textBillingInformation = Replace(textBillingInformation, "##", "####", "ALL")>
	<CFSET textCreditCardEdit = Replace(textCreditCardEdit, "##", "####", "ALL")>
	<CFSET textCreditCardNumberFormat = Replace(textCreditCardNumberFormat, "##", "####", "ALL")>
	<CFSET textCreditCardExpirationFormat = Replace(textCreditCardExpirationFormat, "##", "####", "ALL")>
	<CFSET textEmailMeWhen = Replace(textEmailMeWhen, "##", "####", "ALL")>
	<CFSET textEmailDailyStatus = Replace(textEmailDailyStatus, "##", "####", "ALL")>
	<CFSET textEmailWinner = Replace(textEmailWinner, "##", "####", "ALL")>
	<CFSET textEmailLoser = Replace(textEmailLoser, "##", "####", "ALL")>
	<CFSET textEmailOutbid = Replace(textEmailOutbid, "##", "####", "ALL")>
	<CFSET textEmailAutobid = Replace(textEmailAutobid, "##", "####", "ALL")>
	<CFSET buttonReset = Replace(buttonReset, "##", "####", "ALL")>
	<CFSET buttonEdit = Replace(buttonEdit, "##", "####", "ALL")>
	<CFSET buttonCreate = Replace(buttonCreate, "##", "####", "ALL")>
	<CFSET buttonUserAgrAccept = Replace(buttonUserAgrAccept, "##", "####", "ALL")>
	<CFSET buttonUserAgrReject = Replace(buttonUserAgrReject, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\userFormText.cfm"
		OUTPUT="<CFSETTING ENABLECFOUTPUTONLY=""Yes"">
<CFSET requiredFieldMarker = ""#requiredFieldMarker#"">
<CFSET textUsername = ""#textUsername#"">
<CFSET textPassword = ""#textPassword#"">
<CFSET textPasswordVerify = ""#textPasswordVerify#"">
<CFSET textPasswordEdit = ""#textPasswordEdit#"">
<CFSET textUseCookies = ""#textUseCookies#"">
<CFSET textFirstName = ""#textFirstName#"">
<CFSET textLastName = ""#textLastName#"">
<CFSET textEmail = ""#textEmail#"">
<CFSET textEmailVerify = ""#textEmailVerify#"">
<CFSET textOrganization = ""#textOrganization#"">
<CFSET textPhone = ""#textPhone#"">
<CFSET textPhoneExtension = ""#textPhoneExtension#"">
<CFSET textPhone2 = ""#textPhone2#"">
<CFSET textPhone2Extension = ""#textPhone2Extension#"">
<CFSET textAddress = ""#textAddress#"">
<CFSET textAddress2 = ""#textAddress2#"">
<CFSET textCity = ""#textCity#"">
<CFSET textState = ""#textState#"">
<CFSET textStateOther = ""#textStateOther#"">
<CFSET textZipCode = ""#textZipCode#"">
<CFSET textCountry = ""#textCountry#"">
<CFSET textCountryOther = ""#textCountryOther#"">
<CFSET textBillingSameAsShipping = ""#textBillingSameAsShipping#"">
<CFSET textBillingAddress = ""#textBillingAddress#"">
<CFSET textBillingAddress2 = ""#textBillingAddress2#"">
<CFSET textBillingCity = ""#textBillingCity#"">
<CFSET textBillingState = ""#textBillingState#"">
<CFSET textBillingZipCode = ""#textBillingZipCode#"">
<CFSET textBillingCountry = ""#textBillingCountry#"">
<CFSET textCreditCardNumber = ""#textCreditCardNumber#"">
<CFSET textCreditCardName = ""#textCreditCardName#"">
<CFSET textCreditCardExpiration = ""#textCreditCardExpiration#"">
<CFSET textCreditCardType = ""#textCreditCardType#"">
<CFSET textMothersMaidenName = ""#textMothersMaidenName#"">

<CFSET messageusername = ""#messageusername#"">
<CFSET messagepassword = ""#messagepassword#"">
<CFSET messagepasswordVerify = ""#messagepasswordVerify#"">
<CFSET messagefirstName = ""#messagefirstName#"">
<CFSET messagelastName = ""#messagelastName#"">
<CFSET messageemail = ""#messageemail#"">
<CFSET messageemailVerify = ""#messageemailVerify#"">
<CFSET messageorganization = ""#messageorganization#"">
<CFSET messagephone = ""#messagephone#"">
<CFSET messagephoneExtension = ""#messagephoneExtension#"">
<CFSET messagephone2 = ""#messagephone2#"">
<CFSET messagephone2Extension = ""#messagephone2Extension#"">
<CFSET messageaddress = ""#messageaddress#"">
<CFSET messageaddress2 = ""#messageaddress2#"">
<CFSET messagecity = ""#messagecity#"">
<CFSET messagestate = ""#messagestate#"">
<CFSET messagezipCode = ""#messagezipCode#"">
<CFSET messagecountry = ""#messagecountry#"">
<CFSET messagebillingAddress = ""#messagebillingAddress#"">
<CFSET messagebillingAddress2 = ""#messagebillingAddress2#"">
<CFSET messagebillingCity = ""#messagebillingCity#"">
<CFSET messagebillingState = ""#messagebillingState#"">
<CFSET messagebillingZipCode = ""#messagebillingZipCode#"">
<CFSET messagebillingCountry = ""#messagebillingCountry#"">
<CFSET messagecreditCardNumber = ""#messagecreditCardNumber#"">
<CFSET messagecreditCardName = ""#messagecreditCardName#"">
<CFSET messagecreditCardExpiration = ""#messagecreditCardExpiration#"">
<CFSET messagecreditCardType = ""#messagecreditCardType#"">
<CFSET messagemothersMaidenName = ""#messagemothersMaidenName#"">

<CFSET textShippingInformation = ""#textShippingInformation#"">
<CFSET textBillingInformation = ""#textBillingInformation#"">
<CFSET textCreditCardEdit = ""#textCreditCardEdit#"">
<CFSET textCreditCardNumberFormat = ""#textCreditCardNumberFormat#"">
<CFSET textCreditCardExpirationFormat = ""#textCreditCardExpirationFormat#"">
<CFSET textEmailMeWhen = ""#textEmailMeWhen#"">
<CFSET textEmailDailyStatus = ""#textEmailDailyStatus#"">
<CFSET textEmailWinner = ""#textEmailWinner#"">
<CFSET textEmailLoser = ""#textEmailLoser#"">
<CFSET textEmailOutbid = ""#textEmailOutbid#"">
<CFSET textEmailAutobid = ""#textEmailAutobid#"">
<CFSET buttonReset = ""#buttonReset#"">
<CFSET buttonEdit = ""#buttonEdit#"">
<CFSET buttonCreate = ""#buttonCreate#"">
<CFSET buttonUserAgrAccept = ""#buttonUserAgrAccept#"">
<CFSET buttonUserAgrReject = ""#buttonUserAgrReject#"">
<CFSETTING ENABLECFOUTPUTONLY=""No"">">

	<CFSETTING ENABLECFOUTPUTONLY="No">
	<H3>User fields updated.</H3>
</CFIF>

<CFINCLUDE TEMPLATE="../system/userList.cfm">
<CFINCLUDE TEMPLATE="../system/useCookies.cfm">
<CFINCLUDE TEMPLATE="../system/userFormText.cfm">
<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
<CFINCLUDE TEMPLATE="../system/userEmailVerify.cfm">

<FONT SIZE=6 COLOR=purple><B>User Fields</B></FONT>

<P>This screen is where you designate which fields users are requested to enter when adding themselves to the user database; whether they are required; whether they must be unique; the text description of each field; and the automated emails they may request. <FONT COLOR=red><I>Use of the credit card fields should be restricted to secure servers.</I></FONT>

<P>

<CFFORM ACTION=userFields.cfm NAME=userFields>
<INPUT TYPE=hidden NAME=first VALUE=0>
<CFOUTPUT>
	<INPUT TYPE=hidden NAME=oldAllowCookieLogin VALUE=#allowCookieLogin#>
	<INPUT TYPE=hidden NAME=oldCookieBid VALUE=#allowCookieBid#>
</CFOUTPUT>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR BGCOLOR=orange><TH>User Agreement</TH></TR>
<TR><TD><INPUT TYPE=radio NAME=userAgreement VALUE=0<CFIF userAgreement EQ 0> CHECKED</CFIF>> No user agreement<BR>
	<INPUT TYPE=radio NAME=userAgreement VALUE=-1<CFIF userAgreement EQ -1> CHECKED</CFIF>> User must agree to user agreement before registering<BR>
	<INPUT TYPE=radio NAME=userAgreement VALUE=1<CFIF userAgreement EQ 1> CHECKED</CFIF>> User must agree to user agreement after registering<BR>
	Button - Accept: <CFINPUT TYPE=text NAME=buttonUserAgrAccept SIZE=30 VALUE="#buttonUserAgrAccept#"><BR>
	Button - Reject: &nbsp;<CFINPUT TYPE=text NAME=buttonUserAgrReject SIZE=30 VALUE="#buttonUserAgrReject#"></TD></TR>
<TR BGCOLOR=orange><TH>Email After Registering</TH></TR>
<TR><TD><INPUT TYPE=checkbox NAME=emailUsernamePassword VALUE=1<CFIF emailUsernamePassword EQ 1> CHECKED</CFIF>> Email username and password to user after registering/verifying<BR>
	<INPUT TYPE=checkbox NAME=emailUserAgreement VALUE=1<CFIF emailUserAgreement EQ 1> CHECKED</CFIF>> Email user agreement to user after registering/verifying</TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR BGCOLOR=orange><TH>Field</TH><TH><FONT SIZE=2>Edit</FONT></TH><TH>Form Text</TH><TH>Error Message</TH></TR>
<TR><TD ALIGN=right>Username</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=username<CFIF ListFind(userListEdit,"username")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textUsername SIZE=16 VALUE="#textUsername#"></TD>
	<TD><CFINPUT TYPE=text NAME=messageusername SIZE=20 VALUE="#messageusername#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Password</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=password<CFIF ListFind(userListEdit,"password")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textPassword SIZE=16 VALUE="#textPassword#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagepassword SIZE=20 VALUE="#messagepassword#"></TD></TR>
<TR><TD ALIGN=right>Password Verify</TD>
	<TD ALIGN=center>-</TD>
	<TD><CFINPUT TYPE=text NAME=textPasswordVerify SIZE=16 VALUE="#textPasswordVerify#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagepasswordVerify SIZE=20 VALUE="#messagepasswordVerify#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Password Edit Notice</TD>
	<TD COLSPAN=3><CFINPUT TYPE=text NAME=textPasswordEdit SIZE=42 VALUE="#textPasswordEdit#"></TD></TR>
<TR><TD ALIGN=right VALIGN=top>Cookie Login</TD>
	<TD COLSPAN=3><FONT SIZE=2><INPUT TYPE=checkbox NAME=allowCookieLogin VALUE=1<CFIF #allowCookieLogin# EQ 1> CHECKED</CFIF>> Allow automatic bidder login via permanent cookie<BR>
	<INPUT TYPE=checkbox NAME=allowCookieBid VALUE=1<CFIF #allowCookieBid# EQ 1> CHECKED</CFIF>> Temporary cookie enables bidders to submit multiple bids<BR>&nbsp; &nbsp; without re-entering username and password after first bid.</FONT><BR>
	<CFINPUT TYPE=text NAME=textUseCookies SIZE=42 VALUE="#textUseCookies#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Required Field Indicator</TD>
	<TD COLSPAN=3><CFINPUT TYPE=text NAME=requiredFieldMarker SIZE=42 VALUE="#requiredFieldMarker#"></TD></TR>
<TR><TD ALIGN=right>Button - Clear</TD>
	<TD COLSPAN=3><CFINPUT TYPE=text NAME=buttonReset SIZE=42 VALUE="#buttonReset#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Button - Create User</TD>
	<TD COLSPAN=3><CFINPUT TYPE=text NAME=buttonCreate SIZE=42 VALUE="#buttonCreate#"></TD></TR>
<TR><TD ALIGN=right>Button - Edit User</TD>
	<TD COLSPAN=3><CFINPUT TYPE=text NAME=buttonEdit SIZE=42 VALUE="#buttonEdit#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR BGCOLOR=orange><TD ROWSPAN=2 VALIGN=bottom>Field</TD>
	<TD COLSPAN=3 ALIGN=center>New User</TD>
	<TD ALIGN=center ROWSPAN=2 VALIGN=bottom><FONT SIZE=2><I>Edit</I></FONT></TD>
	<TD ALIGN=center ROWSPAN=2 VALIGN=bottom><FONT SIZE=2><I>Unique</I></FONT></TD>
	<TD ALIGN=center ROWSPAN=2 VALIGN=bottom>Form Text</TD>
	<TD ALIGN=center ROWSPAN=2 VALIGN=bottom>Error Message</TD></TR>	
<TR BGCOLOR=orange><TD ALIGN=center>No</TD>
	<TD ALIGN=center>Yes</TD>
	<TD ALIGN=center><FONT SIZE=2>Req'd</FONT></TD></TR>

<TR><TD>First Name</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=firstName VALUE=0<CFIF ListFind(userList,"firstName") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=firstName VALUE=1<CFIF ListFind(userList,"firstName") NEQ 0 AND ListFind(userListRequired,"firstName") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=firstName VALUE=2<CFIF ListFind(userListRequired,"firstName") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=firstName<CFIF ListFind(userListEdit,"firstName")> CHECKED</CFIF>></TD>
	<TD ROWSPAN=2 ALIGN=center><INPUT TYPE=checkbox NAME=userListUnique VALUE=name<CFIF ListFind(userListUnique,"name") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textFirstName SIZE=16 VALUE="#textFirstName#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagefirstName SIZE=20 VALUE="#messagefirstName#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Last Name</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=lastName VALUE=0<CFIF ListFind(userList,"lastName") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=lastName VALUE=1<CFIF ListFind(userList,"lastName") NEQ 0 AND ListFind(userListRequired,"lastName") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=lastName VALUE=2<CFIF ListFind(userListRequired,"lastName") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=lastName<CFIF ListFind(userListEdit,"lastName")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textLastName SIZE=16 VALUE="#textLastName#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagelastName SIZE=20 VALUE="#messagelastName#"></TD></TR>
<TR><TD>Email Address</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=email VALUE=0<CFIF ListFind(userList,"email") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=email VALUE=1<CFIF ListFind(userList,"email") NEQ 0 AND ListFind(userListRequired,"email") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=email VALUE=2<CFIF ListFind(userListRequired,"email") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=email<CFIF ListFind(userListEdit,"email")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListUnique VALUE=email<CFIF ListFind(userListUnique,"email") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textEmail SIZE=16 VALUE="#textEmail#"></TD>
	<TD><CFINPUT TYPE=text NAME=messageemail SIZE=20 VALUE="#messageemail#"></TD></TR>
<TR><TD ALIGN=right VALIGN=top><FONT SIZE=2><I>Verify</I>:</FONT></TD>
	<TD COLSPAN=6><FONT SIZE=2><INPUT TYPE=checkbox NAME=userEmailVerify VALUE=1<CFIF userEmailVerify EQ 1> CHECKED</CFIF>> Send email to verify as valid address<BR>
	<INPUT TYPE=checkbox NAME=emailVerifyTwice VALUE=1<CFIF emailVerifyTwice EQ 1> CHECKED</CFIF>> Must enter email twice to verify</FONT><BR>
	<DIV ALIGN=right><CFINPUT TYPE=text NAME=textEmailVerify SIZE=16 VALUE="#textEmailVerify#"></DIV></TD>
	<TD VALIGN=bottom><CFINPUT TYPE=text NAME=messageemailVerify SIZE=20 VALUE="#messageemailVerify#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Organization</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=organization VALUE=0<CFIF ListFind(userList,"organization") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=organization VALUE=1<CFIF ListFind(userList,"organization") NEQ 0 AND ListFind(userListRequired,"organization") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=organization VALUE=2<CFIF ListFind(userListRequired,"organization") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=organization<CFIF ListFind(userListEdit,"organization")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListUnique VALUE=organization<CFIF ListFind(userListUnique,"organization") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textOrganization SIZE=16 VALUE="#textOrganization#"></TD>
	<TD><CFINPUT TYPE=text NAME=messageorganization SIZE=20 VALUE="#messageorganization#"></TD></TR>
<TR><TD>Phone</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone VALUE=0<CFIF ListFind(userList,"phone") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone VALUE=1<CFIF ListFind(userList,"phone") NEQ 0 AND ListFind(userListRequired,"phone") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone VALUE=2<CFIF ListFind(userListRequired,"phone") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=phone<CFIF ListFind(userListEdit,"phone")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListUnique VALUE=phone<CFIF ListFind(userListUnique,"phone") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textPhone SIZE=16 VALUE="#textPhone#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagephone SIZE=20 VALUE="#messagephone#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Phone<BR>Extension</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phoneExtension VALUE=0<CFIF ListFind(userList,"phoneExtension") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phoneExtension VALUE=1<CFIF ListFind(userList,"phoneExtension") NEQ 0 AND ListFind(userListRequired,"phoneExtension") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phoneExtension VALUE=2<CFIF ListFind(userListRequired,"phoneExtension") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center>-</TD>
	<TD ALIGN=center>-</TD>
	<TD><CFINPUT TYPE=text NAME=textPhoneExtension SIZE=16 VALUE="#textPhoneExtension#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagephoneExtension SIZE=20 VALUE="#messagephoneExtension#"></TD></TR>
<TR><TD>Phone2</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone2 VALUE=0<CFIF ListFind(userList,"phone2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone2 VALUE=1<CFIF ListFind(userList,"phone2") NEQ 0 AND ListFind(userListRequired,"phone2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone2 VALUE=2<CFIF ListFind(userListRequired,"phone2") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=phone2<CFIF ListFind(userListEdit,"phone2")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListUnique VALUE=phone2<CFIF ListFind(userListUnique,"phone2") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textPhone2 SIZE=16 VALUE="#textPhone2#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagephone2 SIZE=20 VALUE="#messagephone2#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Phone2<BR>Extension</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone2Extension VALUE=0<CFIF ListFind(userList,"phone2Extension") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone2Extension VALUE=1<CFIF ListFind(userList,"phone2Extension") NEQ 0 AND ListFind(userListRequired,"phone2Extension") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=phone2Extension VALUE=2<CFIF ListFind(userListRequired,"phone2Extension") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center>-</TD>
	<TD ALIGN=center>-</TD>
	<TD><CFINPUT TYPE=text NAME=textPhone2Extension SIZE=16 VALUE="#textPhone2Extension#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagephone2Extension SIZE=20 VALUE="#messagephone2Extension#"></TD></TR>
<TR><TD>Mother's<BR>Maiden Name</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=mothersMaidenName VALUE=0<CFIF ListFind(userList,"mothersMaidenName") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=mothersMaidenName VALUE=1<CFIF ListFind(userList,"mothersMaidenName") NEQ 0 AND ListFind(userListRequired,"mothersMaidenName") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=mothersMaidenName VALUE=2<CFIF ListFind(userListRequired,"mothersMaidenName") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=mothersMaidenName<CFIF ListFind(userListEdit,"mothersMaidenName")> CHECKED</CFIF>></TD>
	<TD ALIGN=center>-</TD>
	<TD><CFINPUT TYPE=text NAME=textmothersMaidenName SIZE=16 VALUE="#textMothersMaidenName#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagemothersMaidenName SIZE=20 VALUE="#messagemothersMaidenName#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TH BGCOLOR=purple ALIGN=center COLSPAN=7><FONT SIZE=5>Address Fields</FONT></TH>
<TR BGCOLOR=orange><TD>Field</TD>
	<TD ALIGN=center>No</TD>
	<TD ALIGN=center>Yes</TD>
	<TD ALIGN=center><FONT SIZE=2>Req'd</FONT></TD>
	<TD ALIGN=center><FONT SIZE=2>Edit</FONT></TD>
	<TD ALIGN=center>Form Text</TD>
	<TD ALIGN=center>Error Message</TD></TR>

<TR BGCOLOR=navy><TD><FONT COLOR=white><I><B>Shipping Header</B></I></FONT></TD>
	<TD COLSPAN=6><CFINPUT TYPE=text NAME=textShippingInformation SIZE=50 VALUE="#textShippingInformation#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right><INPUT TYPE=checkbox NAME=userListUnique VALUE=address<CFIF ListFind(userListUnique,"address")> CHECKED</CFIF>></TD>
	<TD COLSPAN=6>Shipping address must be unique</TD></TR>
<TR><TD>Address</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address VALUE=0<CFIF ListFind(userList,"address") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address VALUE=1<CFIF ListFind(userList,"address") NEQ 0 AND ListFind(userListRequired,"address") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address VALUE=2<CFIF ListFind(userListRequired,"address") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=address<CFIF ListFind(userListEdit,"address")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textAddress SIZE=16 VALUE="#textAddress#"></TD>
	<TD><CFINPUT TYPE=text NAME=messageaddress SIZE=20 VALUE="#messageaddress#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Address2</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address2 VALUE=0<CFIF ListFind(userList,"address2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address2 VALUE=1<CFIF ListFind(userList,"address2") NEQ 0 AND ListFind(userListRequired,"address2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address2 VALUE=2<CFIF ListFind(userListRequired,"address2") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=address2<CFIF ListFind(userListEdit,"address2")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textAddress2 SIZE=16 VALUE="#textAddress2#"></TD>
	<TD><CFINPUT TYPE=text NAME=messageaddress2 SIZE=20 VALUE="#messageaddress2#"></TD></TR>
<TR><TD>City</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=city VALUE=0<CFIF ListFind(userList,"city") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=city VALUE=1<CFIF ListFind(userList,"city") NEQ 0 AND ListFind(userListRequired,"city") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=city VALUE=2<CFIF ListFind(userListRequired,"city") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=city<CFIF ListFind(userListEdit,"city")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textCity SIZE=16 VALUE="#textCity#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagecity SIZE=20 VALUE="#messagecity#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>State/Province</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=state VALUE=0<CFIF ListFind(userList,"state") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=state VALUE=1<CFIF ListFind(userList,"state") NEQ 0 AND ListFind(userListRequired,"state") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=state VALUE=2<CFIF ListFind(userListRequired,"state") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=state<CFIF ListFind(userListEdit,"state")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textState SIZE=16 VALUE="#textState#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagestate SIZE=20 VALUE="#messagestate#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right VALIGN=top><FONT SIZE=2><I>Method</I>: </FONT></TD>
	<TD COLSPAN=6><FONT SIZE=2><INPUT TYPE=radio NAME=stateSelect VALUE=0<CFIF stateSelect EQ 0> CHECKED</CFIF>> Text field<BR>
	<INPUT TYPE=radio NAME=stateSelect VALUE=1<CFIF stateSelect EQ 1> CHECKED</CFIF>> Select list<BR>
	<INPUT TYPE=radio NAME=stateSelect VALUE=2<CFIF stateSelect EQ 2> CHECKED</CFIF>> Select list with &quot;<I>other</I>&quot; text field:</FONT> <CFINPUT TYPE=text NAME=textStateOther SIZE=15 VALUE="#textStateOther#"></TD></TR>
<TR><TD>Zip/Postal</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=zipCode VALUE=0<CFIF ListFind(userList,"zipCode") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=zipCode VALUE=1<CFIF ListFind(userList,"zipCode") NEQ 0 AND ListFind(userListRequired,"zipCode") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=zipCode VALUE=2<CFIF ListFind(userListRequired,"zipCode") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=zipCode<CFIF ListFind(userListEdit,"zipCode")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textZipCode SIZE=16 VALUE="#textZipCode#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagezipCode SIZE=20 VALUE="#messagezipCode#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Country</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=country VALUE=0<CFIF ListFind(userList,"country") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=country VALUE=1<CFIF ListFind(userList,"country") NEQ 0 AND ListFind(userListRequired,"country") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=country VALUE=2<CFIF ListFind(userListRequired,"country") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=country<CFIF ListFind(userListEdit,"country")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textCountry SIZE=16 VALUE="#textCountry#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagecountry SIZE=20 VALUE="#messagecountry#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right VALIGN=top><FONT SIZE=2><I>Method</I>: </FONT></TD>
	<TD COLSPAN=6><FONT SIZE=2><INPUT TYPE=radio NAME=countrySelect VALUE=0<CFIF countrySelect EQ 0> CHECKED</CFIF>> Text field<BR>
	<INPUT TYPE=radio NAME=countrySelect VALUE=1<CFIF countrySelect EQ 1> CHECKED</CFIF>> Select list<BR>
	<INPUT TYPE=radio NAME=countrySelect VALUE=2<CFIF countrySelect EQ 2> CHECKED</CFIF>> Select list with &quot;<I>other</I>&quot; text field:</FONT> <CFINPUT TYPE=text NAME=textCountryOther SIZE=15 VALUE="#textCountryOther#"></TD></TR>

<TR BGCOLOR=green><TD><FONT COLOR=white><I><B>Billing Header</B></I></FONT></TD>
	<TD COLSPAN=6><CFINPUT TYPE=text NAME=textBillingInformation SIZE=50 VALUE="#textBillingInformation#"></TD></TR>
<TR><TD ALIGN=right><INPUT TYPE=checkbox NAME=userListUnique VALUE=billingAddress<CFIF ListFind(userListUnique,"billingAddress")> CHECKED</CFIF>></TD>
	<TD COLSPAN=6>Billing address must be unique</TD></TR>
<TR BGCOLOR=DCDCDC><TD VALIGN=top>Billing Same<BR>&nbsp;As Shipping</TD>
	<TD COLSPAN=6><INPUT TYPE=checkbox NAME=billingSameAsShipping VALUE=1<CFIF ListFind(userList,"billingSameAsShipping") NEQ 0> CHECKED</CFIF>> Display optional billing-same-as-shipping checkbox<BR>
	<CFINPUT TYPE=text NAME=textBillingSameAsShipping SIZE=50 VALUE="#textBillingSameAsShipping#"></TD></TR>
<TR><TD>Billing Address</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress VALUE=0<CFIF ListFind(userList,"billingAddress") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress VALUE=1<CFIF ListFind(userList,"billingAddress") NEQ 0 AND ListFind(userListRequired,"billingAddress") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress VALUE=2<CFIF ListFind(userListRequired,"billingAddress") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=billingAddress<CFIF ListFind(userListEdit,"billingAddress")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textBillingAddress SIZE=16 VALUE="#textBillingAddress#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagebillingAddress SIZE=20 VALUE="#messagebillingAddress#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Billing Address2</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress2 VALUE=0<CFIF ListFind(userList,"billingAddress2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress2 VALUE=1<CFIF ListFind(userList,"billingAddress2") NEQ 0 AND ListFind(userListRequired,"billingAddress2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress2 VALUE=2<CFIF ListFind(userListRequired,"billingAddress2") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=billingAddress2<CFIF ListFind(userListEdit,"billingAddress2")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textBillingAddress2 SIZE=16 VALUE="#textBillingAddress2#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagebillingAddress2 SIZE=20 VALUE="#messagebillingAddress2#"></TD></TR>
<TR><TD>Billing City</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCity VALUE=0<CFIF ListFind(userList,"billingCity") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCity VALUE=1<CFIF ListFind(userList,"billingCity") NEQ 0 AND ListFind(userListRequired,"billingCity") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCity VALUE=2<CFIF ListFind(userListRequired,"billingCity") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=billingCity<CFIF ListFind(userListEdit,"billingCity")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textBillingCity SIZE=16 VALUE="#textBillingCity#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagebillingCity SIZE=20 VALUE="#messagebillingCity#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Billing State</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingState VALUE=0<CFIF ListFind(userList,"billingState") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingState VALUE=1<CFIF ListFind(userList,"billingState") NEQ 0 AND ListFind(userListRequired,"billingState") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingState VALUE=2<CFIF ListFind(userListRequired,"billingState") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=billingState<CFIF ListFind(userListEdit,"billingState")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textBillingState SIZE=16 VALUE="#textBillingState#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagebillingState SIZE=20 VALUE="#messagebillingState#"></TD></TR>
<TR><TD>Billing Zip/Postal</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingZipCode VALUE=0<CFIF ListFind(userList,"billingZipCode") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingZipCode VALUE=1<CFIF ListFind(userList,"billingZipCode") NEQ 0 AND ListFind(userListRequired,"billingZipCode") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingZipCode VALUE=2<CFIF ListFind(userListRequired,"billingZipCode") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=billingZipCode<CFIF ListFind(userListEdit,"billingZipCode")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textBillingZipCode SIZE=16 VALUE="#textBillingZipCode#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagebillingZipCode SIZE=20 VALUE="#messagebillingZipCode#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Billing Country</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCountry VALUE=0<CFIF ListFind(userList,"billingCountry") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCountry VALUE=1<CFIF ListFind(userList,"billingCountry") NEQ 0 AND ListFind(userListRequired,"billingCountry") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCountry VALUE=2<CFIF ListFind(userListRequired,"billingCountry") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=billingCountry<CFIF ListFind(userListEdit,"billingCountry")> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textBillingCountry SIZE=16 VALUE="#textBillingCountry#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagebillingCountry SIZE=20 VALUE="#messagebillingCountry#"></TD></TR>
</TABLE>

<!--- 
<TR><TD>Address</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address VALUE=0<CFIF ListFind(userList,"address") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address VALUE=1<CFIF ListFind(userList,"address") NEQ 0 AND ListFind(userListRequired,"address") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address VALUE=2<CFIF ListFind(userListRequired,"address") NEQ 0> CHECKED</CFIF>></TD>
		<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress VALUE=0<CFIF ListFind(userList,"billingAddress") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress VALUE=1<CFIF ListFind(userList,"billingAddress") NEQ 0 AND ListFind(userListRequired,"billingAddress") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress VALUE=2<CFIF ListFind(userListRequired,"billingAddress") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textAddress SIZE=16 VALUE="#textAddress#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Address2 <FONT SIZE=2>(2nd line)</FONT></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address2 VALUE=0<CFIF ListFind(userList,"address2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address2 VALUE=1<CFIF ListFind(userList,"address2") NEQ 0 AND ListFind(userListRequired,"address2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=address2 VALUE=2<CFIF ListFind(userListRequired,"address2") NEQ 0> CHECKED</CFIF>></TD>
		<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress2 VALUE=0<CFIF ListFind(userList,"billingAddress2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress2 VALUE=1<CFIF ListFind(userList,"billingAddress2") NEQ 0 AND ListFind(userListRequired,"billingAddress2") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingAddress2 VALUE=2<CFIF ListFind(userListRequired,"billingAddress2") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textAddress2 SIZE=16 VALUE="#textAddress2#"></TD></TR>
<TR><TD>City</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=city VALUE=0<CFIF ListFind(userList,"city") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=city VALUE=1<CFIF ListFind(userList,"city") NEQ 0 AND ListFind(userListRequired,"city") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=city VALUE=2<CFIF ListFind(userListRequired,"city") NEQ 0> CHECKED</CFIF>></TD>
		<TD ALIGN=center><INPUT TYPE=radio NAME=billingCity VALUE=0<CFIF ListFind(userList,"billingCity") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCity VALUE=1<CFIF ListFind(userList,"billingCity") NEQ 0 AND ListFind(userListRequired,"billingCity") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCity VALUE=2<CFIF ListFind(userListRequired,"billingCity") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textCity SIZE=16 VALUE="#textCity#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>State/Province</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=state VALUE=0<CFIF ListFind(userList,"state") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=state VALUE=1<CFIF ListFind(userList,"state") NEQ 0 AND ListFind(userListRequired,"state") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=state VALUE=2<CFIF ListFind(userListRequired,"state") NEQ 0> CHECKED</CFIF>></TD>
		<TD ALIGN=center><INPUT TYPE=radio NAME=billingState VALUE=0<CFIF ListFind(userList,"billingState") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingState VALUE=1<CFIF ListFind(userList,"billingState") NEQ 0 AND ListFind(userListRequired,"billingState") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingState VALUE=2<CFIF ListFind(userListRequired,"billingState") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textState SIZE=16 VALUE="#textState#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right VALIGN=top><FONT SIZE=2><I>Method</I>: </FONT></TD>
	<TD COLSPAN=8><FONT SIZE=2><INPUT TYPE=radio NAME=stateSelect VALUE=0<CFIF stateSelect EQ 0> CHECKED</CFIF>> Text field<BR>
	<INPUT TYPE=radio NAME=stateSelect VALUE=0<CFIF stateSelect EQ 1> CHECKED</CFIF>> Select list<BR>
	<INPUT TYPE=radio NAME=stateSelect VALUE=0<CFIF stateSelect EQ 1> CHECKED</CFIF>> Select list with &quot;<I>other</I>&quot; text field</FONT></TD></TR>
<TR><TD>Zip Code</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=zipCode VALUE=0<CFIF ListFind(userList,"zipCode") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=zipCode VALUE=1<CFIF ListFind(userList,"zipCode") NEQ 0 AND ListFind(userListRequired,"zipCode") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=zipCode VALUE=2<CFIF ListFind(userListRequired,"zipCode") NEQ 0> CHECKED</CFIF>></TD>
	<TD ROWSPAN=2 WIDTH=5 BGCOLOR=purple>&nbsp;</TD>
		<TD ALIGN=center><INPUT TYPE=radio NAME=billingZipCode VALUE=0<CFIF ListFind(userList,"billingZipCode") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingZipCode VALUE=1<CFIF ListFind(userList,"billingZipCode") NEQ 0 AND ListFind(userListRequired,"billingZipCode") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingZipCode VALUE=2<CFIF ListFind(userListRequired,"billingZipCode") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textZipCode SIZE=16 VALUE="#textZipCode#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>Country</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=country VALUE=0<CFIF ListFind(userList,"country") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=country VALUE=1<CFIF ListFind(userList,"country") NEQ 0 AND ListFind(userListRequired,"country") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=country VALUE=2<CFIF ListFind(userListRequired,"country") NEQ 0> CHECKED</CFIF>></TD>
		<TD ALIGN=center><INPUT TYPE=radio NAME=billingCountry VALUE=0<CFIF ListFind(userList,"billingCountry") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCountry VALUE=1<CFIF ListFind(userList,"billingCountry") NEQ 0 AND ListFind(userListRequired,"billingCountry") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=billingCountry VALUE=2<CFIF ListFind(userListRequired,"billingCountry") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textCountry SIZE=16 VALUE="#textCountry#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right VALIGN=top><FONT SIZE=2><I>Method</I>: </FONT></TD>
	<TD COLSPAN=8><FONT SIZE=2><INPUT TYPE=radio NAME=countrySelect VALUE=0<CFIF countrySelect EQ 0> CHECKED</CFIF>> Text field<BR>
	<INPUT TYPE=radio NAME=countrySelect VALUE=0<CFIF countrySelect EQ 1> CHECKED</CFIF>> Select list<BR>
	<INPUT TYPE=radio NAME=countrySelect VALUE=0<CFIF countrySelect EQ 1> CHECKED</CFIF>> Select list with &quot;<I>other</I>&quot; text field</FONT></TD></TR>
</TABLE>
--->

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TH BGCOLOR=purple ALIGN=center COLSPAN=8><FONT SIZE=5>Credit Card Fields</FONT></TH>
<TR BGCOLOR=orange><TD>Field</TD>
	<TD ALIGN=center>No</TD>
	<TD>Yes</TD>
	<TD><FONT SIZE=2>Req'd</FONT></TD>
	<TD><FONT SIZE=2>Edit</FONT></TD>
	<TD><FONT SIZE=2><I>Unique</I></FONT></TD>
	<TD ALIGN=center>Form Text</TD>
	<TD ALIGN=center>Error Message</TD></TR>

<TR><TD>CC Number</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardNumber VALUE=0<CFIF ListFind(userList,"creditCardNumber") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardNumber VALUE=1<CFIF ListFind(userList,"creditCardNumber") NEQ 0 AND ListFind(userListRequired,"creditCardNumber") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardNumber VALUE=2<CFIF ListFind(userListRequired,"creditCardNumber") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=creditCardNumber<CFIF ListFind(userListEdit,"creditCardNumber")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListUnique VALUE=creditCardNumber<CFIF ListFind(userListUnique,"creditCardNumber") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textCreditCardNumber SIZE=16 VALUE="#textCreditCardNumber#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagecreditCardNumber SIZE=20 VALUE="#messagecreditCardNumber#"></TD></TR>
<TR><TD ALIGN=right><FONT SIZE=2><I>Format Notice</I>: </FONT></TD>
	<TD COLSPAN=7><CFINPUT TYPE=text NAME=textCreditCardNumberFormat SIZE=50 VALUE="#textCreditCardNumberFormat#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>CC Name</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardName VALUE=0<CFIF ListFind(userList,"creditCardName") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardName VALUE=1<CFIF ListFind(userList,"creditCardName") NEQ 0 AND ListFind(userListRequired,"creditCardName") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardName VALUE=2<CFIF ListFind(userListRequired,"creditCardName") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=creditCardName<CFIF ListFind(userListEdit,"creditCardName")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListUnique VALUE=creditCardName<CFIF ListFind(userListUnique,"creditCardName") NEQ 0> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=textCreditCardName SIZE=16 VALUE="#textCreditCardName#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagecreditCardName SIZE=20 VALUE="#messagecreditCardName#"></TD></TR>
<TR><TD>CC Expiration</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardExpiration VALUE=0<CFIF ListFind(userList,"creditCardExpiration") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardExpiration VALUE=1<CFIF ListFind(userList,"creditCardExpiration") NEQ 0 AND ListFind(userListRequired,"creditCardExpiration") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardExpiration VALUE=2<CFIF ListFind(userListRequired,"creditCardExpiration") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=creditCardExpiration<CFIF ListFind(userListEdit,"creditCardExpiration")> CHECKED</CFIF>></TD>
	<TD ALIGN=center>-</TD>
	<TD><CFINPUT TYPE=text NAME=textCreditCardExpiration SIZE=16 VALUE="#textCreditCardExpiration#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagecreditCardExpiration SIZE=20 VALUE="#messagecreditCardExpiration#"></TD></TR>
<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2><I>Method</I>: </FONT></TD>
	<TD COLSPAN=7><FONT SIZE=2><INPUT TYPE=radio NAME=creditCardExpirationSelect VALUE=0<CFIF creditCardExpirationSelect EQ 0> CHECKED</CFIF>> Text field (mm/yy)<BR>
	<INPUT TYPE=radio NAME=creditCardExpirationSelect VALUE=1<CFIF creditCardExpirationSelect EQ 1> CHECKED</CFIF>> Select lists for month and year</FONT></TD></TR>
<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2><I>Format Notice</I>: </FONT></TD>
	<TD COLSPAN=7><CFINPUT TYPE=text NAME=textCreditCardExpirationFormat SIZE=50 VALUE="#textCreditCardExpirationFormat#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD>CC Type</TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardType VALUE=0<CFIF ListFind(userList,"creditCardType") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardType VALUE=1<CFIF ListFind(userList,"creditCardType") NEQ 0 AND ListFind(userListRequired,"creditCardType") EQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=radio NAME=creditCardType VALUE=2<CFIF ListFind(userListRequired,"creditCardType") NEQ 0> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=userListEdit VALUE=creditCardType<CFIF ListFind(userListEdit,"creditCardType")> CHECKED</CFIF>></TD>
	<TD ALIGN=center>-</TD>
	<TD><CFINPUT TYPE=text NAME=textCreditCardType SIZE=16 VALUE="#textCreditCardType#"></TD>
	<TD><CFINPUT TYPE=text NAME=messagecreditCardType SIZE=20 VALUE="#messagecreditCardType#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD VALIGN=top ALIGN=right><FONT SIZE=2><I>Accepted</I>: </FONT></TD>
<TD COLSPAN=7>
	<TABLE BORDER=0><TR>
	<TD VALIGN=top><FONT SIZE=2><INPUT TYPE=checkbox NAME=creditCardTypeList VALUE=Visa<CFIF ListFind(creditCardTypeList,"Visa") NEQ 0> CHECKED</CFIF>> Visa<BR>
	<INPUT TYPE=checkbox NAME=creditCardTypeList VALUE=MasterCard<CFIF ListFind(creditCardTypeList,"MasterCard") NEQ 0> CHECKED</CFIF>> MasterCard<BR>
	<INPUT TYPE=checkbox NAME=creditCardTypeList VALUE="American Express"<CFIF ListFind(creditCardTypeList,"American Express") NEQ 0> CHECKED</CFIF>> American Express<BR>
	<INPUT TYPE=checkbox NAME=creditCardTypeList VALUE="Diners Club/Carte Blanche"<CFIF ListFind(creditCardTypeList,"Diners Club/Carte Blanche") NEQ 0> CHECKED</CFIF>> Diners Club/<FONT SIZE=2>Carte Blanche</FONT></FONT></TD>
	<TD VALIGN=top><FONT SIZE=2><INPUT TYPE=checkbox NAME=creditCardTypeList VALUE=Discover<CFIF ListFind(creditCardTypeList,"Discover") NEQ 0> CHECKED</CFIF>> Discover<BR>
	<INPUT TYPE=checkbox NAME=creditCardTypeList VALUE=enRoute<CFIF ListFind(creditCardTypeList,"enRoute") NEQ 0> CHECKED</CFIF>> enRoute<BR>
	<INPUT TYPE=checkbox NAME=creditCardTypeList VALUE=JCB<CFIF ListFind(creditCardTypeList,"JCB") NEQ 0> CHECKED</CFIF>> JCB</FONT></TD>
	</TR></TABLE>
</TD></TR>
<TR><TD>CC Edit Notice</TD>
	<TD COLSPAN=7><CFINPUT TYPE=text NAME=textCreditCardEdit SIZE=50 VALUE="#textCreditCardEdit#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TD BGCOLOR="#CDCDCD" ALIGN=center><B>Email Options</B></TD></TR>
<TR><TD NOWRAP>
<INPUT TYPE=checkbox NAME=emailEventsList VALUE=dailystatus<CFIF ListFind(emailEventsList,"dailystatus")> CHECKED</CFIF>> <I>Daily status</I> - Send daily (or other period) email on status<BR>
<IMG SRC="../images/clearpixel.gif" HEIGHT=5 WIDTH=125 BORDER=0>of all lots I bid on, watched, or posted<BR>
<INPUT TYPE=checkbox NAME=emailEventsList VALUE=winner<CFIF ListFind(emailEventsList,"winner")> CHECKED</CFIF>> <I>Winner</I> - I am a winning bidder (after auction closes)<BR>
<INPUT TYPE=checkbox NAME=emailEventsList VALUE=loser<CFIF ListFind(emailEventsList,"loser")> CHECKED</CFIF>> <I>Loser</I> - I am <I>not</I> a winning bidder (after auction closes)<BR>
<INPUT TYPE=checkbox NAME=emailEventsList VALUE=outbid<CFIF ListFind(emailEventsList,"outbid")> CHECKED</CFIF>> <I>Outbid</I> - I am outbid during auction and need to raise my bid<BR>
<INPUT TYPE=checkbox NAME=emailEventsList VALUE=autobid<CFIF ListFind(emailEventsList,"autobid")> CHECKED</CFIF>> <I>Auto Bid</I> - My bid is automatically raised via auto-bid feature
</TD></TR>

<TR><TD>
	<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
	<TR BGCOLOR=orange><TH>Email Type</TH><TH>Form Text</TH></TR>
	<TR><TD ALIGN=right>Heading: </TD>
		<TD><CFINPUT TYPE=text NAME=textEmailMeWhen SIZE=48 VALUE="#textEmailMeWhen#"></TD></TR>
	<TR><TD ALIGN=right>Daily Status: </TD>
		<TD><CFINPUT TYPE=text NAME=textEmailDailyStatus SIZE=48 VALUE="#textEmailDailyStatus#"></TD></TR>
	<TR><TD ALIGN=right>Winner: </TD>
		<TD><CFINPUT TYPE=text NAME=textEmailWinner SIZE=48 VALUE="#textEmailWinner#"></TD></TR>
	<TR><TD ALIGN=right>Loser: </TD>
		<TD><CFINPUT TYPE=text NAME=textEmailLoser SIZE=48 VALUE="#textEmailLoser#"></TD></TR>
	<TR><TD ALIGN=right>Outbid: </TD>
		<TD><CFINPUT TYPE=text NAME=textEmailOutbid SIZE=48 VALUE="#textEmailOutbid#"></TD></TR>
	<TR><TD ALIGN=right>Autobid: </TD>
		<TD><CFINPUT TYPE=text NAME=textEmailAutobid SIZE=48 VALUE="#textEmailAutobid#"></TD></TR>
	</TABLE>
</TD></TR>

<TR><TH NOWRAP BGCOLOR="#CDCDCD">Send Emails Regardless of User Option</TH></TR>
<TR><TD>
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=3><TR>
	<TD VALIGN=top>
	<INPUT TYPE=checkbox NAME=forcedEmailEventsList VALUE=dailystatus<CFIF ListFind(forcedEmailEventsList,"dailystatus")> CHECKED</CFIF>> <I>Daily Status</I><BR>
	<INPUT TYPE=checkbox NAME=forcedEmailEventsList VALUE=winner<CFIF ListFind(forcedEmailEventsList,"winner")> CHECKED</CFIF>> <I>Winner</I><BR>
	<INPUT TYPE=checkbox NAME=forcedEmailEventsList VALUE=loser<CFIF ListFind(forcedEmailEventsList,"loser")> CHECKED</CFIF>> <I>Loser</I><BR>
	<INPUT TYPE=checkbox NAME=forcedEmailEventsList VALUE=outbid<CFIF ListFind(forcedEmailEventsList,"outbid")> CHECKED</CFIF>> <I>Outbid</I><BR>
	<INPUT TYPE=checkbox NAME=forcedEmailEventsList VALUE=autobid<CFIF ListFind(forcedEmailEventsList,"autobid")> CHECKED</CFIF>> <I>Auto Bid</I></TD>
	<TD WIDTH=10>&nbsp;</TD>
	<TD BGCOLOR="#CDCDCD"><FONT SIZE=2>Checking these options ignores the individual user<BR>
	setting. Users will receive the emails regardless<BR>
	of whether they chose it or not. This enables<BR>
	you to ignore the above email options so users<BR>
	are not even aware this option exists.</FONT></TD>
	</TR></TABLE>
</TD></TR>
</TABLE>

<P>
<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Determine User Fields">

</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>