<!-----------------------------------------------------------------------------
Document:	high_bidder.cfm
Purpose:	List all bids the logged in user is the high bidder for.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif not structKeyExists(session,"username")>
	<script type="text/javascript">
	alert("You must be logged in to check high bidder. You will be taken to the login screen.");
	<cfoutput>location.href="login.cfm?frompage=#urlencodedformat("high_bidder.cfm")#";</cfoutput>
	</script>
	<cfabort>
</cfif>
<html>
<head>
<title>Items I'm High Bidder On</title>
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
</head>
<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2>Items I'm High Bidder On</h2>
<cfquery name="getitems" datasource="#application.settings.dsn#">
	select id, name, bid_amount, maximum_bid from Item, Bidder
	where bidder_id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.username#">
		and username = bidder_id
	order by id
</cfquery>
<cfif getitems.recordcount eq 0>
	<b>Sorry. You are not high bidder for any items.</b>
<cfelse>
	<table cellpadding="3">
	<tr>
		<th>Item No.</th>
		<th>Name</th>
		<th>Current Bid</th>
		<th>Maximum Bid</th></tr>
	<cfoutput query="getitems">
	<tr>
		<td align="center">#id#</td>
		<td>#name#</td>
		<td align="right">$ #numberformat(bid_amount,"999,999")#</td>
		<td align="right">$ #numberformat(maximum_bid,"999,999")#</td></tr>
	</cfoutput>
	</table>
</cfif>
<p><a href="index.cfm">List Auction Items</a></p>
</div>
</div>
</body>

