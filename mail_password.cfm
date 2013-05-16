<!-----------------------------------------------------------------------------
Title:		Mail Password
Document:	mail_password.cfm
Purpose:	Mail forgotten password to the user.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif structKeyExists(form,"username")>
	<cfif len(trim(form.username)) gt 0>
		<cfquery name="getuser" datasource="#application.settings.dsn#">
			select * from bidder 
			where username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.username#">
		</cfquery>
		<cfif getuser.recordcount eq 0>
			<script language="JavaScript" type="text/javascript">
				alert("Username entered does not exist. Try by email address.");
				history.go(-1);
			</script>
			Username entered does not exist. Try by email address. <a href="mail_password.cfm">Back to entry page</a>.
			<cfabort>
		</cfif>
	<cfelseif len(trim(form.email)) gt 0>
		<cfquery name="getuser" datasource="#application.settings.dsn#">
			select * from bidder 
			where email = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.email#">
		</cfquery>
		<cfif getuser.recordcount eq 0>
			<script language="JavaScript" type="text/javascript">
				alert("Email entered does not exist. Try by username.");
				history.go(-1);
			</script>
			Email entered does not exist. Try by username. <a href="mail_password.cfm">Back to entry page</a>.
			<cfabort>
		</cfif>
	<cfelse>
		<script language="JavaScript" type="text/javascript">
			alert("Enter your username OR email address.");
			history.go(-1);
		</script>
		Enter your username OR email address. <a href="mail_password.cfm">Back to entry page</a>.
		<cfabort>
	</cfif>
	<!--- Valid user found, email their info --->
	<cfmail to="#getuser.email#" from="#application.settings.email#" subject="Silent Auction Login Information">A request for login information has been received. You can login with this information:

username: #getuser.username#
password: #getuser.password#

You can login at http://#cgi.server_name##application.root#login.cfm
	</cfmail>
</cfif>
<html>
<head>
<title>Forgotten Password</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
</head>

<cfif structKeyExists(form,"username")>
	<body>
<cfelse>
	<body onload="document.frmLogin.username.focus()">
</cfif>
<div id="wrap">
<div id="header">
<h1>Forgotten Password</h1>
</div>
<div id="content">

<cfif structKeyExists(form,"username")>
	<p>Your login information has been sent to the email address on record.</p>
<cfelse>
	<p>Enter either your username <b>OR</b> email address to have your login information sent to you.</p>
	<cfform action="mail_password.cfm" name="frmLogin" method="post">
	<table cellspacing="0" cellpadding="4" id="login">
	<tr>
		<td align="right"><b>Username:</b></td>
		<td><cfinput type="text" name="username" size="10" maxlength="50"></td></tr>
	<tr>
		<td align="right"><b>Email:</b></td>
		<td><cfinput type="text" name="email" size="50" maxlength="100"></td></tr>
	<tr>
		<td align="center" colspan="2"><input type="submit" value="Send Login Information"></td></tr>
	</table>
	</cfform>
</cfif>
<p><a href="index.cfm">List Auction Items</a></p>
</div>
</div>
</body>
</html>
