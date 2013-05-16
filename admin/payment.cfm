<!-----------------------------------------------------------------------------
Document:	payment.cfm
Purpose:	Edit screen to record payment of auction items
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfparam name="url.sort" default="i.id">
<cfquery name="qry2BPaid" datasource="#application.settings.dsn#">
	select b.fullname, b.phone, b.email, i.id, i.name, i.bid_amount
	from item i, bidder b
	where i.bidder_id = b.username
		and date_paid is null
	order by #url.sort#
</cfquery>
<html>
<head>
<title>Enter Payment Information</title>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
<style type="text/css"><!--
table#paytable {font-size: .85em; border: 1px solid silver; border-collapse: collapse;}
table#paytable td, table#paytable th {vertical-align: top; padding: 2px 6px; border: 1px solid silver;}
table#paytable th {background-color: #eee; text-align: center;}
--></style>
</head>
<body>
<div id="wrap"> 
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2>Enter Payment Information</h2>
<p>Enter the payment information for the following unpaid items. An item is considered paid if the check number or cash fields are filled in.</p>
<cfform action="update.cfm?action=payment" method="post">
<table cellspacing="0" id="paytable">
<tr>
	<th><a href="payment.cfm?sort=b.fullname">Name</a></th>
	<th>Phone</th>
	<th>Email</th>
	<th><a href="payment.cfm?sort=i.id">Item</a></th>
	<th>Amount</th>
	<th>Check #</th>
	<th>Cash</th></tr>
<cfoutput query="qry2BPaid">
<tr>
	<td>#fullname#</td>
	<td>#phone#</td>
	<td><a href="mailto:#email#">#email#</a></td>
	<td>#id# - #name#</td>
	<td align="right">$ #numberformat(bid_amount)#</td>
	<td><input type="Text" name="chk#qry2BPaid.currentrow#" size="5" maxlength="10" class="inputform"></td>
	<td><input type="Text" name="cash#qry2BPaid.currentrow#" size="5" maxlength="10" class="inputform"></td>
	<input type="hidden" name="id#qry2BPaid.currentrow#" value="#id#"></td></tr>
</cfoutput>
</table>
<p><input type="Submit" value="Record Payments"></p>
<cfoutput><input type="hidden" name="max" value="#qry2BPaid.recordcount#"></cfoutput>
</cfform>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>
