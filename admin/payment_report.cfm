<!-----------------------------------------------------------------------------
Document:	payment_report.cfm
Purpose:	Edit screen to record payment of auction items
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfparam name="url.sort" default="i.id">
<cfquery name="qryPayments" datasource="#application.settings.dsn#">
	select b.fullname, b.phone, i.id, i.name, i.bid_amount, i.checkno, i.cash, i.date_paid
	from item i, bidder b
	where i.bidder_id = b.username
	order by #url.sort#
</cfquery>
<html>
<head>
<title>Payment Report</title>
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
<h2>Payment Report</h2>
<table cellspacing="0" id="paytable">
<tr>
	<th><a href="payment_report.cfm?sort=b.fullname">Name</a></th>
	<th>Phone</th>
	<th><a href="payment_report.cfm?sort=i.id">Item</a></th>
	<th>Amount</th>
	<th>Check #</th>
	<th>Cash</th>
	<th>Date Paid</th></tr>
<cfoutput query="qryPayments">
<tr>
	<td>#fullname#</td>
	<td>#phone#</td>
	<td>#id# - #name#</td>
	<td align="right">$ #numberformat(bid_amount)#</td>
	<td>#checkno#</td>
	<td>#cash#</td>
	<td>#dateformat(date_paid,"mm/dd/yyyy")#</td></tr>
</cfoutput>
</table>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>
