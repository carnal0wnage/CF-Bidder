<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfajaximport tags="cfform">
<cfquery name="qryBidders" datasource="#application.settings.dsn#">
	select username, fullname
	from bidder
	order by username
</cfquery>
<html>
<head>
<title>Update Bidder Info</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
</head>
<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h1>Update Bidder Info</h1>
<cfform action="submitter_info.cfm" method="POST">
<b>Bidder:</b> <select name="username">
<option value="0">select bidder...</option>
<cfoutput query="qryBidders">
<option value="#username#">#fullname#</option>
</cfoutput>
</select>
</cfform>
<cfdiv bind="url:bidder_info.cfm?username={username}" bindonload="false"></cfdiv>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>
