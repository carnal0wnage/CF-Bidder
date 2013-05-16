<!-----------------------------------------------------------------------------
Title:		Login
Document:	login.cfm
Purpose:	Login the user. Used for bidding.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif structKeyExists(form,"username")>
	<cfquery name="getuser" datasource="#application.settings.dsn#">
		select username, password, fullname from bidder
		where username=<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lcase(form.username)#">
	</cfquery>
	<cfif getuser.recordcount eq 0>
		<script type="text/javascript">
			alert("Invalid Username or Password. Please re-enter.");
			history.go(-1);
		</script>
		Invalid Username or Password. Please re-enter.
		<cfabort>
	</cfif>	
	<cfset session.username=form.username>
	<cfset session.fullname=getuser.fullname>
	<cfif structKeyExists(form,"frompage")>
		<cflocation url="#form.frompage#" addtoken="No">
	</cfif>
</cfif>

<html>
<head>
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
</head>
<body onload="document.frmLogin.username.focus()">
<div id="wrap">
<div id="header">
<h1>Login</h1>
</div>
<div id="content">
<cfform action="login.cfm" name="frmLogin" method="post">
<table cellspacing="0" cellpadding="4" id="login">
<tr>
	<td align="right"><b>Username:</b></td>
	<td><cfinput type="text" name="username" size="10" maxlength="50" required="yes" message="Please enter your username"></td></tr>
<tr>
	<td align="right"><b>Password:</b></td>
	<td><cfinput type="password" name="password" size="10" maxlength="50" required="yes" message="Please enter your password"></td></tr>
<tr>
	<td align="center" colspan="2"><input type="submit" value="Login"></td></tr>
</table>
<cfif structKeyExists(url,"frompage")>
	<cfoutput><input type="hidden" name="frompage" value="#url.frompage#"></cfoutput>
</cfif>
</cfform>
<p>New User? - <a href="new_user.cfm<cfif structKeyExists(url,"frompage")><cfoutput>?frompage=#url.frompage#</cfoutput></cfif>">Create a Login</a></p>
<p><a href="mail_password.cfm">Forgot Your Password?</a></p>
<p><a href="index.cfm">List Auction Items</a></p>
</div>
</div>
</body>
</html>
