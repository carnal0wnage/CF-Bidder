<!-----------------------------------------------------------------------------
Document:	winner_list.cfm
Purpose:	Create a list of all winning bids.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<cfquery name="getitems" datasource="#application.settings.dsn#">
	select * from (Item LEFT OUTER JOIN Bidder 
	on Item.bidder_id = Bidder.username)
	where status = 1
	order by id
</cfquery>

<html>
<head>
<title>Winning Bids</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
<style type="text/css"><!--
body {margin: 0 1%; background-color: #fff; text-align: left;}
table#printlist {font-size: 1em; border: 1px solid silver; border-collapse: collapse;}
table#printlist td, table#printlist th {vertical-align: top; padding: 2px 6px; border: 1px solid silver;}
table#printlist th {background-color: #ddd; text-align: center;}
--></style>
</head>
<body>
<h2>Winning Bids</h2>
<table cellspacing="0" id="printlist">
<tr>
	<th>Item No.</th>
	<th>Name</th>
	<th>Winning Bidder</th>
	<th>Bid Amount</th>
</tr>
<cfset tot = 0>
<cfoutput query="getitems">
<cfif len(bidder_id) gt 0>
	<cfset tot = tot + bid_amount>	<!--- don't add if no bidder in case minimum bid --->
</cfif>
<tr>
	<td align="center" valign="top">#id#</td>
	<td valign="top">#name#</td>
	<td><cfif len(bidder_id) gt 0>#fullname#<br>Phone: #phone#<br>#email#
		<cfelse>No Bids</cfif></td>
	<td align="right" valign="top"><cfif len(bidder_id) gt 0>$ #numberformat(bid_amount,"999,999")#
		<cfelse>&nbsp;</cfif></td>
</tr>
</cfoutput>
<tr>
	<td colspan=3 align="right"><b>Total Amount</b></td>
	<td align="right"><cfoutput>$ #numberformat(tot,"9,999,999")#</cfoutput></td>
</tr>
</table>
<p><a href="index.cfm">Admin Menu</a></p>
</body>
</html>