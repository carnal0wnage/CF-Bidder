<!-----------------------------------------------------------------------------
Document:	edit_bidlist.cfm
Purpose:	List all items for bid with ability to edit, close, or delete them.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<cfquery name="getitems" datasource="#application.settings.dsn#">
	select id, name, bid_amount, status, maximum_bid, close_time from Item
	order by id
</cfquery>

<html>
<head>
<title>Edit Auction Bid List</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
</head>
<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<p><a href="index.cfm">Admin Menu</a></p>
<p>Items in <span class="red">RED</span> are awaiting approval or been closed.</p>
<table cellspacing="2" id="bidtable">
<tr>
	<th>Item No.</th>
	<th>Name</th>
	<th>Current Bid</th>
	<th>Maximum Bid</th>
	<th>Maintain</th>
</tr>
<cfoutput query="getitems">
<cfif getitems.currentrow mod 2 eq 0><tr class="odd"><cfelse><tr></cfif>
	<td align="center">#id#</td>
	<td><cfif not status><span class="red">#name#</span><cfelse>#name#</cfif></td>
	<td align="right">$ #numberformat(bid_amount,"999,999")#</td>
	<td align="right">$ #numberformat(maximum_bid,"999,999")#</td>
	<td><a href="edit_item.cfm?no=#id#" title="click to edit information for this item...">Edit</a> | 
	<a href="update.cfm?no=#id#&action=deleteitem" title="click to delete this item...">Delete</a> | 
	<cfif status><a href="update.cfm?no=#id#&action=closeitem" title="click to disallow bidding on this item...">Close</a> | 
	<cfelse><a href="update.cfm?no=#id#&action=openitem" title="click to allow bidding on this item...">Open</a> | </cfif>
	<a href="auto_close.cfm?no=#id#" title="click to set an auto close time for this item...">AutoClose</a>
	<cfif len(close_time)> <span class="smallgray">(closing: #dateformat(close_time,"short")# #timeformat(close_time,"short")#)</span></cfif></td>
</tr>
</cfoutput>
</table>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>