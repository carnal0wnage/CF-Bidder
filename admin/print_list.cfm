<!-----------------------------------------------------------------------------
Document:	print_list.cfm
Purpose:	Create a printable list of all bid information.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<cfquery name="getitems" datasource="#application.settings.dsn#">
	SELECT id, name, description, bidder_id, bid_amount FROM Item 
	WHERE status = 1
	ORDER BY id
</cfquery>

<html>
<head>
<title>Auction Bid Report</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
<style type="text/css"><!--
body {margin: 0 1%; background-color: #fff; text-align: left;}
table#printlist {font-size: 1em; border: 1px solid silver; border-collapse: collapse;}
table#printlist td, table#printlist th {vertical-align: top; padding: 2px 6px; border: 1px solid silver;}
table#printlist th {background-color: #ddd; text-align: center;}
--></style>
</head>
<body>
<h2>Auction Item List</h2>
<table cellspacing="0" id="printlist">
<tr>
	<th>Item No.</th>
	<th>Name</th>
	<th>Description</th>
	<th>Current Bid</th>
</tr>
<cfset tot = 0>
<cfoutput query="getitems">
<cfif len(bidder_id) gt 0>
	<cfset tot = tot + bid_amount>	<!--- don't add if no bidder in case minimum bid --->
</cfif>
<tr>
	<td align="center">#id#</td>
	<td>#name#</td>
	<td>#description#</td>
	<td align="right"><cfif len(bidder_id) gt 0>$ #numberformat(bid_amount,"999,999")#
		<cfelse>$ 0</cfif></td>
</tr>
</cfoutput>
<tr>
	<td colspan=3 align="right"><b>Total Amount</b></td>
	<td align="right"><cfoutput>$ #numberformat(tot,"9,999,999")#</cfoutput></td>
</tr>
</table>
<cfoutput><p>#dateformat(now(),"mmm d, yyyy")# - #timeformat(now(),"h:mm tt")#</p></cfoutput>
<p><a href="index.cfm">Admin Menu</a></p>

</body>
</html>