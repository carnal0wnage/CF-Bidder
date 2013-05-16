<cfquery name="count" datasource="#application.settings.dsn#">
	SELECT id FROM Item
</cfquery>


<!-----------------------------------------------------------------------------
Document:	index.cfm
Purpose:	List all open items for bid. If auction is open, provide link to bid on item.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfparam name="form.category" default="0">

<cfquery name="getCategories" datasource="#application.settings.dsn#">
	select id, name from category
	order by name
</cfquery>


<!--- get count of items that have a close time --->
<cfquery name="countclose" datasource="#application.settings.dsn#">
	select count(id) as closecnt from Item
	where not close_time is null 
		and status = 1
</cfquery>

<!--- get approved items for bidding --->
<cfquery name="getitems" datasource="#application.settings.dsn#">
	select item.id, item.name, photo_file, bid_amount, close_time  
	from Item, category
	where status = 1
		and category.id = category_id
	<cfif form.category neq 0>
		and category.id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.category#">
	</cfif>
	<!--- next AND should not be needed as those closed should have had status set to 1 by scheduled task,
	but just in case. --->
	and (close_time is null or close_time > #now()#)
	order by item.id
</cfquery>

<html>
<head>
<title>CF-Bidder - Auctions List</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
</head>

<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<p><a href="add_item.cfm">Submit An Item</a><br>
<a href="high_bidder.cfm">Am I the High Bidder?</a></p>
<cfif application.status eq 0 and len(application.open_time) neq 0>
	<cfoutput><p align="center"><b>Auction Opens: #dateformat(application.open_time,"mmm d, yyyy")# - #timeformat(application.open_time,"h:mm tt")#</b></p></cfoutput>
</cfif>
<cfif application.status eq 1 and len(application.close_time) neq 0>
	<cfoutput><p align="center"><b>Auction Closes: #dateformat(application.close_time,"mmm d, yyyy")# - #timeformat(application.close_time,"h:mm tt")#</b>, Current Time: <b>#timeformat(now(),"h:mm:ss tt")#</b></p></cfoutput>
</cfif>
<form action="index.cfm" method="post" class="clear">show only: 
<select name="category" class="inputform">
<option value="0">ALL Categories
<cfoutput query="getCategories">
<option value="#id#"<cfif structkeyexists(form,"category") and form.category eq getCategories.id> selected</cfif>>#name#
</cfoutput>
</select>
<input type="submit" value="Go" title="display only the selected category">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Click on item name for details</b>
</form>
<br>
<table cellspacing="2" id="bidtable">
<tr>
	<th>Item No.</th>
	<th>Name</th>
	<th>Current Bid</th>
	<th>Bid On Item</th>
	<cfif countclose.closecnt gt 0>
		<th>Closes</th>
	</cfif>
	</tr>
<cfoutput query="getitems">
<cfif getitems.currentrow mod 2 eq 0>
	<tr class="odd">
<cfelse>
	<tr>
</cfif>
	<td align="center">#id#</td>
	<td><a href="bid_detail.cfm?no=#id#" title="click for more info on this item...">#name#</a>
	<cfif len(photo_file) gt 0>
		&nbsp;&nbsp;<img src="assets/images/camera.gif" border="0" alt="photo" width="20" height="14">
	</cfif></td>
	<td align="right">$ #numberformat(bid_amount,"99,999")#</td>
	<td nowrap><cfif application.status>
		<a href="submit_bid.cfm?no=#id#" title="click to bid on this item...">Bid On Item ###id#</a>
	<cfelse>
		&nbsp;
	</cfif></td>
	<cfif countclose.closecnt gt 0>
		<td nowrap><cfif len(close_time) eq 0>
			&nbsp;
		<cfelse>
			#dateformat(close_time,"mmm d, yyyy")# - #timeformat(close_time,"h:mm tt")#
		</cfif></td>
	</cfif>
</tr>
</cfoutput>
</table>

</div>
</div>
</body>
</html>
