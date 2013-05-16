<!-----------------------------------------------------------------------------
Document:	email_winners.cfm
Purpose:	Enter message to send to all winning bidders.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif structKeyExists(form,"message")>
	<cfquery name="getwinners" datasource="#application.settings.dsn#">
		select name, bid_amount, email from Item, Bidder 
		where bidder_id = username and
		not email is null
	</cfquery>
	
	<cfmail query="getwinners" to="#email#" from="#application.settings.email#" subject="Winning Auction Bid">
Congratulations! Your are the winning bidder on: #name#, for #dollarformat(bid_amount)#.
	
#message#
	</cfmail>
	<script language="JavaScript" type="text/javascript">
		alert("Winning bidders have been sent an email");
		location.href="index.cfm";
	</script>
	Winning bidders have been sent an email
	<cfabort>
</cfif>

<cfif application.status>
	<script language="JavaScript" type="text/javascript">
		alert("Auction is still open for bidding. Mail cannot be sent until auction is closed.");
		location.href="index.cfm";
	</script>
	Auction is still open for bidding. Mail cannot be sent until auction is closed.
	<cfabort>
</cfif>

<html>
<head>
<title>Email Winning Bidders</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
</head>
<body onload="document.frmEmail.message.focus()">
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2>Email Winning Bidders</h2>
<p>Send email to all winning bidders.</p>
<form action="email_winners.cfm" method="POST" name="frmEmail">
<b>Message</b> (<i>will follow this introduction</i>):<br>
Congratulations! Your are the winning bidder on:<br>
<i>item name</i>, for $<i>bid amount</i>.<br>
<textarea name="message" cols="90" rows="8" wrap="VIRTUAL"></textarea><p>
<input type="Submit" value="Send Email">
</form></td></tr>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>
