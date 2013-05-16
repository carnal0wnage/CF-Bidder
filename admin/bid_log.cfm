<!-----------------------------------------------------------------------------
Document:	bid_log.cfm
Purpose:	Dump bidding log by item
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<cfparam name="form.id" default="0">
<cfquery name="qryItems" datasource="#application.settings.dsn#">
	select id, name from item
	order by id
</cfquery>

<cfif form.id neq 0>
	<cfquery name="getlog" datasource="#application.settings.dsn#">
		select item.id, name, log.bid_amount, log.bidder_id, bid_date
		from item, log
		where item.id = log.item_id
		<cfif form.id gt 0>
			and item.id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.id#">
		</cfif>
		order by item.id, bid_date desc
	</cfquery>
</cfif>

<html>
<head>
<title>Bidding Log by Item</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
<style type="text/css"><!--
table#loglist {font-size: .85em; border: 1px solid silver; border-collapse: collapse;}
table#loglist td, table#loglist th {vertical-align: top; padding: 2px 6px; border: 1px solid silver;}
table#loglist th {background-color: #ddd; text-align: center;}
.head {background-color: #eff3ff;}
--></style>
</head>
<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2>Bidding Log by Item</h2>
<form method="post">
<p><b>Show bidding for: </b> <select name="id">
<option value="-1">ALL Items</option>
<cfoutput query="qryItems">
<option value="#id#"<cfif form.id eq id> selected</cfif>>#id# - #left(name,80)#</option>
</cfoutput>
</select> <input type="Submit" value="Go"></p>
</form>

<cfif form.id neq 0>
	<table cellspacing="0" id="loglist">
	<tr>
		<th>Date/Time</th>
		<th>Username</th>
		<th>Bid Amount</th></tr>
	<cfoutput query="getlog" group="id">
	<tr>
		<td colspan="3" class="head">#name#</td></tr>
	<cfoutput>
	<tr>
		<td>#dateformat(bid_date,"mm/dd/yyyy")# - #timeformat(bid_date,"h:mm tt")#</td>
		<td>#bidder_id#</td>
		<td align="right">#numberformat(bid_amount,"999,999")#</td></tr>
	</cfoutput>
	</cfoutput>
	</table>
</cfif>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>