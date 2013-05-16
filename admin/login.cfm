<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif structKeyExists(form,"password")>
	<cfquery name="getPassword" datasource="#application.settings.dsn#">
		select mst_password from Master
		where mst_password = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.password#"> 
			and mst_no = 1
	</cfquery>
	
	<cfif getPassword.recordcount gt 0>
		<cfset session.level = "admin">
		<cflocation url="index.cfm" addtoken="No">
		<cfabort>
	</cfif>
</cfif>

<html>
<head>
<title>Auction Admin Login</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
</head>
<body onload="document.frmLogin.password.focus()">
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<div align="center">
<form action="login.cfm" method="POST" name="frmLogin">
<cfif structKeyExists(form,"password")>
	<p><b><span class="red">Invalid Password!</span></b></p>
</cfif>
<h2>Please Login</h2>
<p>Password: <input type="PASSWORD" size="20" name="password"></p>
<p><input type="SUBMIT" value="Login"></p>
</form>
</div>
</div>
</body>
</html>
