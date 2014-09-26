<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>User Fields</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFSET messageBadRegistration = Replace(Form.messageBadRegistration, """", "&quot;", "ALL")>
	<CFSET messageBadRegistration2 = Replace(Form.messageBadRegistration2, """", "&quot;", "ALL")>
	<CFSET userNameBlank = Replace(Form.userNameBlank, """", "&quot;", "ALL")>
	<CFSET usernameTaken = Replace(Form.usernameTaken, """", "&quot;", "ALL")>
	<CFSET usernameBlankEdit = Replace(Form.usernameBlankEdit, """", "&quot;", "ALL")>
	<CFSET usernameTakenEdit = Replace(Form.usernameTakenEdit, """", "&quot;", "ALL")>
	<CFSET passwordEmpty = Replace(Form.passwordEmpty, """", "&quot;", "ALL")>
	<CFSET passwordVerifyNew = Replace(Form.passwordVerifyNew, """", "&quot;", "ALL")>
	<CFSET passwordVerifyEdit = Replace(Form.passwordVerifyEdit, """", "&quot;", "ALL")>
	<CFSET emailValidNew = Replace(Form.emailValidNew, """", "&quot;", "ALL")>
	<CFSET emailValidEdit = Replace(Form.emailValidEdit, """", "&quot;", "ALL")>
	<CFSET emailVerifyNew = Replace(Form.emailVerifyNew, """", "&quot;", "ALL")>
	<CFSET emailVerifyEdit = Replace(Form.emailVerifyEdit, """", "&quot;", "ALL")>
	<CFSET stateSelectBlank = Replace(Form.stateSelectBlank, """", "&quot;", "ALL")> 
	<CFSET billingStateSelectBlank = Replace(Form.billingStateSelectBlank, """", "&quot;", "ALL")>
	<CFSET billingStateSelectBlankText = Replace(Form.billingStateSelectBlankText, """", "&quot;", "ALL")>
	<CFSET countrySelectBlank = Replace(Form.countrySelectBlank, """", "&quot;", "ALL")>
	<CFSET countrySelectBlankText = Replace(Form.countrySelectBlankText, """", "&quot;", "ALL")>
	<CFSET billingCountrySelectBlank = Replace(Form.billingCountrySelectBlank, """", "&quot;", "ALL")>
	<CFSET billingCountrySelectBlankText = Replace(Form.billingCountrySelectBlankText, """", "&quot;", "ALL")>
	<CFSET creditCardExpirationText = Replace(Form.creditCardExpirationText, """", "&quot;", "ALL")>
	<CFSET creditCardExpirationExpired = Replace(Form.creditCardExpirationExpired, """", "&quot;", "ALL")>
	<CFSET creditCardExpirationSelectBlank = Replace(Form.creditCardExpirationSelectBlank, """", "&quot;", "ALL")>
	<CFSET creditCardNumberLength = Replace(Form.creditCardNumberLength, """", "&quot;", "ALL")>
	<CFSET creditCardNumberText = Replace(Form.creditCardNumberText, """", "&quot;", "ALL")>
	<CFSET creditCardNumberValid = Replace(Form.creditCardNumberValid, """", "&quot;", "ALL")>
	<CFSET creditCardNumberType = Replace(Form.creditCardNumberType, """", "&quot;", "ALL")>
	<CFSET creditCardNumberTypeMismatch = Replace(Form.creditCardNumberTypeMismatch, """", "&quot;", "ALL")>
	<CFSET uniqueName = Replace(Form.uniqueName, """", "&quot;", "ALL")>
	<CFSET uniqueEmail = Replace(Form.uniqueEmail, """", "&quot;", "ALL")>
	<CFSET uniqueOrganization = Replace(Form.uniqueOrganization, """", "&quot;", "ALL")>
	<CFSET uniquePhone = Replace(Form.uniquePhone, """", "&quot;", "ALL")>
	<CFSET uniquePhone2 = Replace(Form.uniquePhone2, """", "&quot;", "ALL")>
	<CFSET uniqueCreditCardNumber = Replace(Form.uniqueCreditCardNumber, """", "&quot;", "ALL")>
	<CFSET uniqueCreditCardName = Replace(Form.uniqueCreditCardName, """", "&quot;", "ALL")>
	<CFSET uniqueAddress = Replace(Form.uniqueAddress, """", "&quot;", "ALL")>
	<CFSET uniqueBillingAddress = Replace(Form.uniqueBillingAddress, """", "&quot;", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\userFormText2.cfm"
		OUTPUT="<CFSET messageBadRegistration = ""#messageBadRegistration#"">
<CFSET messageBadRegistration2 = ""#messageBadRegistration2#"">
<CFSET userNameBlank = ""#userNameBlank#"">
<CFSET usernameTaken = ""#usernameTaken#"">
<CFSET usernameBlankEdit = ""#usernameBlankEdit#"">
<CFSET usernameTakenEdit = ""#usernameTakenEdit#"">
<CFSET passwordEmpty = ""#passwordEmpty#"">
<CFSET passwordVerifyNew = ""#passwordVerifyNew#"">
<CFSET passwordVerifyEdit = ""#passwordVerifyEdit#"">
<CFSET emailValidNew = ""#emailValidNew#"">
<CFSET emailValidEdit = ""#emailValidEdit#"">
<CFSET emailVerifyNew = ""#emailVerifyNew#"">
<CFSET emailVerifyEdit = ""#emailVerifyEdit#"">
<CFSET stateSelectBlank = ""#stateSelectBlank#""> 
<CFSET billingStateSelectBlank = ""#billingStateSelectBlank#"">
<CFSET billingStateSelectBlankText = ""#billingStateSelectBlankText#"">
<CFSET countrySelectBlank = ""#countrySelectBlank#"">
<CFSET countrySelectBlankText = ""#countrySelectBlankText#"">
<CFSET billingCountrySelectBlank = ""#billingCountrySelectBlank#"">
<CFSET billingCountrySelectBlankText = ""#billingCountrySelectBlankText#"">
<CFSET creditCardExpirationText = ""#creditCardExpirationText#"">
<CFSET creditCardExpirationExpired = ""#creditCardExpirationExpired#"">
<CFSET creditCardExpirationSelectBlank = ""#creditCardExpirationSelectBlank#"">
<CFSET creditCardNumberLength = ""#creditCardNumberLength#"">
<CFSET creditCardNumberText = ""#creditCardNumberText#"">
<CFSET creditCardNumberValid = ""#creditCardNumberValid#"">
<CFSET creditCardNumberType = ""#creditCardNumberType#"">
<CFSET creditCardNumberTypeMismatch = ""#creditCardNumberTypeMismatch#"">
<CFSET uniqueName = ""#uniqueName#"">
<CFSET uniqueEmail = ""#uniqueEmail#"">
<CFSET uniqueOrganization = ""#uniqueOrganization#"">
<CFSET uniquePhone = ""#uniquePhone#"">
<CFSET uniquePhone2 = ""#uniquePhone2#"">
<CFSET uniqueCreditCardNumber = ""#uniqueCreditCardNumber#"">
<CFSET uniqueCreditCardName = ""#uniqueCreditCardName#"">
<CFSET uniqueAddress = ""#uniqueAddress#"">
<CFSET uniqueBillingAddress = ""#uniqueBillingAddress#"">
">

	<H3>Registration error messages updated.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=500 ALIGN=left><P>
</CFIF>

<CFPARAM NAME="Form.username" DEFAULT=" ">
<CFINCLUDE TEMPLATE="../system/userFormText2.cfm">

<CFFORM NAME=userFields2 ACTION="userErrors.cfm">
<INPUT TYPE=hidden NAME=first VALUE=1>

<H1><FONT COLOR="purple">Registration Error Messages</FONT></H1>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2 WIDTH="600">
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bad Registration (header):  </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=messageBadRegistration SIZE=55 VALUE="#messageBadRegistration#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Bad Registration (footer):  </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=messageBadRegistration2 SIZE=55 VALUE="#messageBadRegistration2#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>User Name Field Empty: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=userNameBlank SIZE=55 VALUE="#userNameBlank#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>User Name In Use: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=usernameTaken SIZE=55 VALUE="#usernameTaken#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Edit User Field Blank: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=usernameBlankEdit SIZE=55 VALUE="#usernameBlankEdit#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Duplicate User Name when Edited: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=usernameTakenEdit SIZE=55 VALUE="#usernameTakenEdit#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Password Field Empty: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=passwordEmpty SIZE=55 VALUE="#passwordEmpty#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Password Verification Incorrect: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=passwordVerifyNew SIZE=55 VALUE="#passwordVerifyNew#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Edited Password Verified Incorrect: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=passwordVerifyEdit SIZE=55 VALUE="#passwordVerifyEdit#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Invalid Email Address: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=emailValidNew SIZE=55 VALUE="#emailValidNew#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Invalid Edited Email Address: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=emailValidEdit SIZE=55 VALUE="#emailValidEdit#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Incorrect Email Verification: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=emailVerifyNew SIZE=55 VALUE="#emailVerifyNew#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Incorrect Edited Email Verification: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=emailVerifyEdit SIZE=55 VALUE="#emailVerifyEdit#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>State Field Empty: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=stateSelectBlank SIZE=55 VALUE="#stateSelectBlank#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Edited State Field Empty: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=billingStateSelectBlank SIZE=55 VALUE="#billingStateSelectBlank#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Selected State List and Text Fields Empty: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=billingStateSelectBlankText SIZE=55 VALUE="#billingStateSelectBlankText#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Country Not Selected: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=countrySelectBlank SIZE=55 VALUE="#countrySelectBlank#"></TD></TR>	
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No Country Chosen: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=countrySelectBlankText SIZE=55 VALUE="#countrySelectBlankText#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Billing Country Blank: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=billingCountrySelectBlank SIZE=55 VALUE="#billingCountrySelectBlank#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No Billing Country Selected: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=billingCountrySelectBlankText SIZE=55 VALUE="#billingCountrySelectBlankText#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Incorrect Credit Card Exp Format: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=creditCardExpirationText SIZE=55 VALUE="#creditCardExpirationText#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Credit Card Expired: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=creditCardExpirationExpired SIZE=55 VALUE="#creditCardExpirationExpired#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Credit Card Mo/Yr Not Chosen: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=creditCardExpirationSelectBlank SIZE=55 VALUE="#creditCardExpirationSelectBlank#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Invalid Credit Card# Length: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=creditCardNumberLength SIZE=55 VALUE="#creditCardNumberLength#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Alph Characters in Credit Card Field: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=creditCardNumberText SIZE=55 VALUE="#creditCardNumberText#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Invalid Credit Card #: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=creditCardNumberValid  SIZE=55 VALUE="#creditCardNumberValid #"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Unaccepted Credit Card: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=creditCardNumberType SIZE=55 VALUE="#creditCardNumberType#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Invalid Credit Card Type/Numbers: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=creditCardNumberTypeMismatch SIZE=55 VALUE="#creditCardNumberTypeMismatch#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>First and Last Name Taken: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniqueName SIZE=55 VALUE="#uniqueName#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Email Address already registered: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniqueEmail SIZE=55 VALUE="#uniqueEmail#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Organization Name Already In Use: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniqueOrganization SIZE=55 VALUE="#uniqueOrganization#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Phone Number Already In Use: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniquePhone SIZE=55 VALUE="#uniquePhone#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Phone Number #2 Already In Use: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniquePhone2 SIZE=55 VALUE="#uniquePhone2#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Credit Card Number Already In Use: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniqueCreditCardNumber SIZE=55 VALUE="#uniqueCreditCardNumber#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Credit Card Name Already In Use: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniqueCreditCardName SIZE=55 VALUE="#uniqueCreditCardName#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Address Already In Use: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniqueAddress SIZE=55 VALUE="#uniqueAddress#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Billing Address Already In Use: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=uniqueBillingAddress SIZE=55 VALUE="#uniqueBillingAddress#"></TD></TR>

<TR><TD COLSPAN="2" ALIGN="Center"><INPUT TYPE=submit VALUE="Update Error Messages"></TD></TR</TABLE>
</TABLE>
</CFFORM>
</body>
</html>
