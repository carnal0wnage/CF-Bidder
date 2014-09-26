<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Import users</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.again")>
	<CFSET numFields = 1>
	<CFSET fieldOrder = Form.order1>

	<CFIF Form.order2 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order2)>
	</CFIF>
	<CFIF Form.order3 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order3)>
	</CFIF>
	<CFIF Form.order4 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order4)>
	</CFIF>
	<CFIF Form.order5 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order5)>
	</CFIF>
	<CFIF Form.order6 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order6)>
	</CFIF>
	<CFIF Form.order7 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order7)>
	</CFIF>
	<CFIF Form.order8 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order8)>
	</CFIF>
	<CFIF Form.order9 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order9)>
	</CFIF>
	<CFIF Form.order10 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order10)>
	</CFIF>
	<CFIF Form.order11 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order11)>
	</CFIF>
	<CFIF Form.order12 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order12)>
	</CFIF>
	<CFIF Form.order13 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order13)>
	</CFIF>
	<CFIF Form.order14 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order14)>
	</CFIF>
	<CFIF Form.order15 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order15)>
	</CFIF>
	<CFIF Form.order16 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order16)>
	</CFIF>
	<CFIF Form.order17 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order17)>
	</CFIF>
	<CFIF Form.order18 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order18)>
	</CFIF>
	<CFIF Form.order19 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order19)>
	</CFIF>
	<CFIF Form.order20 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order20)>
	</CFIF>
	<CFIF Form.order21 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order21)>
	</CFIF>
	<CFIF Form.order22 NEQ 0>
		<CFSET numFields = numFields + 1>
		<CFSET fieldOrder = ListAppend(fieldOrder,Form.order22)>
	</CFIF>

	<CFSET fields = numFields - 1>
	<CFLOOP INDEX=count1 FROM="1" TO="#fields#">
		<CFSET count2 = count1 + 1>
		<CFLOOP INDEX=count3 FROM=#count2# TO="#numFields#">
			<CFIF ListGetAt(fieldOrder,count1) EQ ListGetAt(fieldOrder,count3)>
				<H3>The <CFOUTPUT><I>#ListGetAt(fieldOrder,count1)#</I></CFOUTPUT> field is repeated. Please re-enter the values.</H3>
			</CFIF>
		</CFLOOP>
	</CFLOOP>

	<CFFILE ACTION=Read FILE="#Form.importFile#" VARIABLE="importList">
	<CFSET listLength = ListLen(importList,",
")>
	<CFSET userLength = ListLen(importList,"
")>
	<CFSET userMod = listLength MOD numFields>
	<CFIF userMod NEQ 0>
		<H3>Whoa! You are trying to import <CFOUTPUT>#numFields# fields per record.  The file contains #userLength# records, but #listLength# fields, leaving #userMod#</CFOUTPUT> extra record(s). Users will not be imported until this problem is fixed.</H3>
		<CFABORT>
	</CFIF>

	<CFIF IsDefined("Form.ignoreFirstLine")>
		<CFSET count = numFields + 1>
	<CFELSE><CFSET count = 1>
	</CFIF>

	<CFIF ListFind(fieldOrder,"username") EQ 0>
		<CFSET username = " ">
	</CFIF>
	<CFQUERY NAME=getUsernames DATASOURCE="#EAdatasource#">
		SELECT username FROM Member
	</CFQUERY>
	<CFSET checkUserList = ValueList(getUsernames.username)>

<!---
Loop through designated number of users
	Loop thru number of fields per user
		Assign field value to variable
	Insert user
--->

	<CFSET listCount = 1>
	<CFLOOP INDEX="countUser" FROM="1" TO="#userLength#">
		<CFSET thisUserList = ListGetAt(importList,countUser,"
")>
		<CFLOOP INDEX=countField FROM=1 TO=#numFields#>
			<CFSET temp = ListGetAt(thisUserList,countField,",")>

			<CFIF ListGetAt(fieldOrder,countField) EQ "username"><CFSET username = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "password"><CFSET password = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "firstName"><CFSET firstName = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "lastName"><CFSET lastName = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "email"><CFSET email = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "organization"><CFSET organization = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "phone"><CFSET phone = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "creditCardNumber"><CFSET creditCardNumber = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "creditCardExpiration"><CFSET creditCardExpiration = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "creditCardName"><CFSET creditCardName = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "address"><CFSET address = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "address2"><CFSET address2 = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "city"><CFSET city = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "state"><CFSET state = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "zipCode"><CFSET zipCode = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "country"><CFSET country = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "billingAddress"><CFSET billingAddress = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "billingAddress2"><CFSET billingAddress2 = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "billingCity"><CFSET billingCity = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "billingState"><CFSET billingState = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "billingZipCode"><CFSET billingZipCode = temp>
			<CFELSEIF ListGetAt(fieldOrder,countField) EQ "billingCountry"><CFSET billingCountry = temp>
			</CFIF>
		</CFLOOP>

		<CFIF ListFind(fieldOrder,"username") NEQ 0 AND ListFind(checkUserList,"#username#") NEQ 0>
			Username <CFOUTPUT><I>#username#</I></CFOUTPUT> already taken. User not added.<BR>
		<CFELSE>
			<CFQUERY NAME=insertUser DATASOURCE="#EAdatasource#">
				INSERT INTO Member (
					<CFIF ListFind(fieldOrder,"username") NEQ 0>username, </CFIF>
					<CFIF ListFind(fieldOrder,"password") NEQ 0>password, </CFIF>
					<CFIF ListFind(fieldOrder,"firstName") NEQ 0>firstName, </CFIF>
					<CFIF ListFind(fieldOrder,"lastName") NEQ 0>lastName, </CFIF>
					<CFIF ListFind(fieldOrder,"email") NEQ 0>email, </CFIF>
					<CFIF ListFind(fieldOrder,"organization") NEQ 0>organization, </CFIF>
					<CFIF ListFind(fieldOrder,"phone") NEQ 0>phone, </CFIF>
					<CFIF ListFind(fieldOrder,"creditCardNumber") NEQ 0>creditCardNumber, </CFIF>
					<CFIF ListFind(fieldOrder,"creditCardExpiration") NEQ 0>creditCardExpiration, </CFIF>
					<CFIF ListFind(fieldOrder,"creditCardName") NEQ 0>creditCardName, </CFIF>
					<CFIF ListFind(fieldOrder,"address") NEQ 0>address, </CFIF>
					<CFIF ListFind(fieldOrder,"address2") NEQ 0>address2, </CFIF>
					<CFIF ListFind(fieldOrder,"city") NEQ 0>city, </CFIF>
					<CFIF ListFind(fieldOrder,"state") NEQ 0>state, </CFIF>
					<CFIF ListFind(fieldOrder,"zipCode") NEQ 0>zipCode, </CFIF>
					<CFIF ListFind(fieldOrder,"country") NEQ 0>country, </CFIF>
					<CFIF ListFind(fieldOrder,"billingAddress") NEQ 0>billingAddress, </CFIF>
					<CFIF ListFind(fieldOrder,"billingAddress2") NEQ 0>billingAddress2, </CFIF>
					<CFIF ListFind(fieldOrder,"billingCity") NEQ 0>billingCity, </CFIF>
					<CFIF ListFind(fieldOrder,"billingState") NEQ 0>billingState, </CFIF>
					<CFIF ListFind(fieldOrder,"billingZipCode") NEQ 0>billingZipCode, </CFIF>
					<CFIF ListFind(fieldOrder,"billingCountry") NEQ 0>billingCountry, </CFIF>
					userStatus)
				VALUES (
					<CFIF ListFind(fieldOrder,"username") NEQ 0>'#username#', </CFIF>
					<CFIF ListFind(fieldOrder,"password") NEQ 0>'#password#', </CFIF>
					<CFIF ListFind(fieldOrder,"firstName") NEQ 0>'#firstName#', </CFIF>
					<CFIF ListFind(fieldOrder,"lastName") NEQ 0>'#lastName#', </CFIF>
					<CFIF ListFind(fieldOrder,"email") NEQ 0>'#email#', </CFIF>
					<CFIF ListFind(fieldOrder,"organization") NEQ 0>'#organization#', </CFIF>
					<CFIF ListFind(fieldOrder,"phone") NEQ 0>'#phone#', </CFIF>
					<CFIF ListFind(fieldOrder,"creditCardNumber") NEQ 0>'#creditCardNumber#', </CFIF>
					<CFIF ListFind(fieldOrder,"creditCardExpiration") NEQ 0>'#creditCardExpiration#', </CFIF>
					<CFIF ListFind(fieldOrder,"creditCardName") NEQ 0>'#creditCardName#', </CFIF>
					<CFIF ListFind(fieldOrder,"address") NEQ 0>'#address#', </CFIF>
					<CFIF ListFind(fieldOrder,"address2") NEQ 0>'#address2#', </CFIF>
					<CFIF ListFind(fieldOrder,"city") NEQ 0>'#city#', </CFIF>
					<CFIF ListFind(fieldOrder,"state") NEQ 0>'#state#', </CFIF>
					<CFIF ListFind(fieldOrder,"zipCode") NEQ 0>'#zipCode#', </CFIF>
					<CFIF ListFind(fieldOrder,"country") NEQ 0>'#country#', </CFIF>
					<CFIF ListFind(fieldOrder,"billingAddress") NEQ 0>'#billingAddress#', </CFIF>
					<CFIF ListFind(fieldOrder,"billingAddress2") NEQ 0>'#billingAddress2#', </CFIF>
					<CFIF ListFind(fieldOrder,"billingCity") NEQ 0>'#billingCity#', </CFIF>
					<CFIF ListFind(fieldOrder,"billingState") NEQ 0>'#billingState#', </CFIF>
					<CFIF ListFind(fieldOrder,"billingZipCode") NEQ 0>'#billingZipCode#', </CFIF>
					<CFIF ListFind(fieldOrder,"billingCountry") NEQ 0>'#billingCountry#', </CFIF>
					1)
			</CFQUERY>
		</CFIF>
	</CFLOOP>

	<H3>Users successfully added to the system.</H3>
	<P><HR NOSHADE COLOR=purple><P>
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML>
	<CFABORT>
</CFIF>

<FORM METHOD=post ACTION="userImport.cfm">
<INPUT TYPE=hidden NAME=again VALUE=0>

<FONT SIZE=6 COLOR=purple><B>Import Users</B></FONT>

<P>You can import users via a comma-delimited text file. The text file may contain the following fields: <I>username</I>, <I>password</I>, <I>first name</I>, <I>last name</I>, and <I>email</I>. Please note that if you try to import too many users at a time, Cold Fusion may time out. If this happens, either change the timeout setting in the Cold Fusion Administrator or import fewer users at a time.
<P>
<B>Path to file:</B> <CFOUTPUT><INPUT TYPE=text NAME=importFile SIZE=50 VALUE="#systemPath#\"></CFOUTPUT>
<P>
<B>Field order:</B> The fields can be in any order, but you must declare below what that order is. The file must contain at least one field. You may not choose a field more than once. Please note that if the username is included in the list, the system will only add those records which have unique usernames. The system will return a list of users which were not added.
<P>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD WIDTH=35 ALIGN=right>1: </TD>
<TD><SELECT NAME="order1" SIZE="1">
	<OPTION VALUE="username" SELECTED>Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
</SELECT></TD>
<TD ROWSPAN=12 WIDTH=25>&nbsp;</TD>
<TD ALIGN=right>12: </TD>
<TD><SELECT NAME="order12" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2" SELECTED>Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>2: </TD>
<TD><SELECT NAME="order2" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password" SELECTED>Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD>
<TD ALIGN=right>13: </TD>
<TD><SELECT NAME="order13" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city" SELECTED>Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>3: </TD>
<TD><SELECT NAME="order3" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName" SELECTED>First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD>
<TD ALIGN=right>14: </TD>
<TD><SELECT NAME="order14" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state" SELECTED>Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>4: </TD>
<TD><SELECT NAME="order4" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName" SELECTED>Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD>
<TD ALIGN=right>15: </TD>
<TD><SELECT NAME="order15" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode" SELECTED>Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>5: </TD>
<TD><SELECT NAME="order5" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email" SELECTED>Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD>
<TD ALIGN=right>16: </TD>
<TD><SELECT NAME="order16" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country" SELECTED>Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>6: </TD>
<TD><SELECT NAME="order6" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization" SELECTED>Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD><TD ALIGN=right>17: </TD>
<TD><SELECT NAME="order17" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress" SELECTED>Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>7: </TD>
<TD><SELECT NAME="order7" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone" SELECTED>Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT>
</TD><TD ALIGN=right>18: </TD>
<TD><SELECT NAME="order18" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2" SELECTED>Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>8: </TD>
<TD><SELECT NAME="order8" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber" SELECTED>Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT>
</TD><TD ALIGN=right>19: </TD>
<TD><SELECT NAME="order19" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity" SELECTED>Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>9: </TD>
<TD><SELECT NAME="order9" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration" SELECTED>Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT>
</TD><TD ALIGN=right>20: </TD>
<TD><SELECT NAME="order20" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState" SELECTED>Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>10: </TD>
<TD><SELECT NAME="order10" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName" SELECTED>Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT>
</TD><TD ALIGN=right>21: </TD>
<TD><SELECT NAME="order21" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode" SELECTED>Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

<TR><TD ALIGN=right>11: </TD>
<TD><SELECT NAME="order11" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address" SELECTED>Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry">Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT>
</TD><TD ALIGN=right>22: </TD>
<TD><SELECT NAME="order22" SIZE="1">
	<OPTION VALUE="username">Username
	<OPTION VALUE="password">Password
	<OPTION VALUE="firstName">First Name
	<OPTION VALUE="lastName">Last Name
	<OPTION VALUE="email">Email
	<OPTION VALUE="organization">Organization
	<OPTION VALUE="phone">Phone
	<OPTION VALUE="creditCardNumber">Credit Card Number
	<OPTION VALUE="creditCardExpiration">Credit Card Expiration
	<OPTION VALUE="creditCardName">Credit Card Name
	<OPTION VALUE="address">Shipping Address
	<OPTION VALUE="address2">Shipping Address2
	<OPTION VALUE="city">Shipping City
	<OPTION VALUE="state">Shipping State/Prov
	<OPTION VALUE="zipCode">Shipping Zip Code
	<OPTION VALUE="country">Shipping Country
	<OPTION VALUE="billingAddress">Billing Address
	<OPTION VALUE="billingAddress2">Billing Address2
	<OPTION VALUE="billingCity">Billing City
	<OPTION VALUE="billingState">Billing State/Prov
	<OPTION VALUE="billingZipCode">Billing Zip Code
	<OPTION VALUE="billingCountry" SELECTED>Billing Country
	<OPTION VALUE="0">NOT INCLUDED
</SELECT></TD></TR>

</TABLE>
<P>
<TABLE BORDER=0><TR>
<TD VALIGN=top><INPUT TYPE=checkbox NAME=ignoreFirstLine VALUE=1></TD>
<TD>Check here if the first line of the file contains the field names.<BR>
<FONT SIZE=-1>(The import script will ignore this line.)</FONT></TD>
</TR></TABLE>
<P>

<P>
<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit VALUE="Import Users">

</FORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>