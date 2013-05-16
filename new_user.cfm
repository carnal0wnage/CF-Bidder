<!-----------------------------------------------------------------------------
Title:		New User Signup
Document:	new_user.cfm
Purpose:	Get new user information and store in database.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif structKeyExists(form,"username")>
	<cfquery name="getuser" datasource="#application.settings.dsn#">
		select username from bidder
		where username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lcase(form.username)#">
	</cfquery>
	<cfif getuser.recordcount gt 0>
		<script type="text/javascript">
			alert("This username is already taken. Please try another name.");
			history.go(-1);
		</script>
		This username is already taken. Please try another name.
		<cfabort>
	</cfif>
	<cfquery datasource="#application.settings.dsn#">
		insert into bidder (username, password, fullname, email, address, city, state, zip, phone)
		values (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form.username)#" maxlength="50">, 
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form.password)#" maxlength="50">, 
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form.fullname)#" maxlength="250">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form.email)#" maxlength="250">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form.address)#" maxlength="250">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form.city)#" maxlength="50">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ucase(form.state)#" maxlength="2">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.zip#" maxlength="5">,
			<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form.phone)#" maxlength="50">)
		</cfquery>
	<cfset session.username=form.username>
	<cfset session.fullname=form.fullname>
	<cfif structKeyExists(form,"frompage")>
		<cflocation url="#form.frompage#" addtoken="No">
	<cfelse>
		<cflocation url="index.cfm" addtoken="No">
	</cfif>
</cfif>

<html>
<head>
<title>New User Signup</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
<script type="text/javascript">
<!--
function testUsername(form, ctrl, value) {
	var validChar = /^[a-zA-Z0-9]+$/;
	if (value.length < 6 || validChar.test(value) == false) {
		return (false);
	} else {
		return (true);
	}
}
function testPassword(form, ctrl, value) {
	if (value.length < 4 || value.indexOf(" ") != -1) {
		return (false);
	} else {
		return (true);
	}
}
function validate(form) {
	if(form.password.value != form.password2.value) {
		alert("Passwords entered do not match. Please re-enter");
		return false;
	}
	return true;
}
// -->
</script>
</head>

<body onload="document.frmNewUser.username.focus()">
<div id="wrap">
<div id="header">
<h1>New User Signup</h1>
</div>
<div id="content">
<p>Enter the following information to register. (<span class="red">*</span>=required field)</p>
<cfform action="new_user.cfm" name="frmNewUser" method="post" onsubmit="return validate(document.frmNewUser)">
<table cellspacing="0" cellpadding="4">
<tr>
	<td align="right"><b><span class="red">*</span>Username:</b></td>
	<td><cfinput type="text" name="username" size="15" maxlength="20" required="yes" message="Please enter your desired Username" onvalidate="testUsername"> <span class="smallgray">(6 - 20 characters, letters and numbers only, no spaces)</span></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>Password:</b></td>
	<td><cfinput type="password" name="password" size="15" maxlength="20" required="yes" message="Please enter your desired  Password" onvalidate="testPassword"> <span class="smallgray">(4 - 20 characters, no spaces)</span></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>Confirm Password:</b></td>
	<td><cfinput type="password" name="password2" size="15" maxlength="20" required="yes" message="Please confirm your Password"></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>Name (first last):</b></td>
	<td><cfinput type="text" name="fullname" size="40" maxlength="250" required="yes" message="Please enter your Full Name"></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>Email:</b></td>
	<td><cfinput type="text" name="email" size="50" maxlength="100" required="yes" message="Please enter your Email Address" validate="email"></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>Address:</b></td>
	<td><cfinput type="text" name="address" size="30" maxlength="250" required="yes" message="Please enter your Address"></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>City:</b></td>
	<td><cfinput type="text" name="city" size="20" maxlength="250" required="yes" message="Please enter your City">&nbsp;&nbsp;&nbsp;<b><span class="red">*</span>State:</b> <cfinput type="text" name="state" size="2" maxlength="2" required="Yes" message="Please enter your State">&nbsp;&nbsp;&nbsp;<b><span class="red">*</span>Zip:</b> <cfinput type="text" name="zip" size="5" maxlength="5" required="Yes" message="Please enter your Zip" validate="zipcode"></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>Phone:</b></td>
	<td><cfinput type="text" name="phone" size="12" maxlength="20" required="Yes" message="Please enter your Phone Number"></td></tr>
<tr>
	<td align="center" colspan="2"><input type="submit" value="Sign Me Up"></td></tr>
</table>
<cfif structKeyExists(url,"frompage")>
	<cfoutput><input type="hidden" name="frompage" value="#url.frompage#"></cfoutput>
</cfif>
</cfform>
</div>
</div>
</body>
</html>
