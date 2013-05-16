<!-----------------------------------------------------------------------------
Document:	submit_bid.cfm
Purpose:	Submit a bid for the item number passed on URL line. Check for logged in.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif not structKeyExists(url,"no")><cflocation url="index.cfm" addtoken="No"></cfif>
<cfif not structKeyExists(session,"username")>
	<script type="text/javascript">
	alert("You must be logged in to bid on an item. You will be taken to the login screen.");
<cfoutput>	location.href="login.cfm?frompage=#urlencodedformat("submit_bid.cfm?no=")##url.no#";</cfoutput>
	</script>
	<cfabort>
</cfif>

<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="Wed, 20 Dec 2000 12:00:00 GMT">
<cfheader name="Cache-Control" value="no-cache, no-store, must-revalidate, max-age=0">

<!--- If complete auction is closed, don't let them bid --->
<cfif not application.status>
	<h3>The auction is closed.</h3>
	<a href="index.cfm">Back to Auction Items</a>
	<cfabort>
</cfif>

<!--- If this item is closed, don't let them bid --->
<cfquery name="getitem" datasource="#application.settings.dsn#">
	select name, bid_amount, status, bidder_id, maximum_bid
	from Item
	where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
</cfquery>
<cfif not getitem.status>
	<h3>Bidding is closed on this item.</h3>
	<a href="index.cfm">Back to Auction Items</a>
	<cfabort>
</cfif>

<cfset bidamt = getitem.bid_amount + 1.00>	<!--- prefill bid with $1 more --->

<html>
<head>
<title>Bid on Auction Item</title>
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
<style type="text/css"><!--
#fixedBid {float: right; margin-top: 20px; border: 1px solid #800; background-color: #eee; padding: 1em; width: 180px; font-size: .85em; line-height: 1.4;}
--></style>
<script type="text/javascript">
function validate(form) {
<cfoutput>
	if ((form.bid_amount.value * 1.00) <= (#getitem.bid_amount# * 1.00)) {
</cfoutput>
    alert("Amount to bid must be higher than current bid.");
    return false;
   }

return true;
}
</script>
</head>
<body onload="document.frmBid.bid_amount.focus()">
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<cfform action="submit_bid_update.cfm" method="POST" name="frmBid" onsubmit="return validate(document.frmBid)">
<div id="fixedBid">
<b>Fixed Bid Option</b> - check this box to make your MAXIMUM Bid be a fixed bid. Your bid will be the maximum entered and no auto bidding will occur.
<p><input type="Checkbox" name="fixed_bid" value="Yes"> Maximum Bid amount <b>IS EXACTLY</b> what I want to bid</p>
</div>
<cfoutput query="getitem">
<h3>Submit Bid For: #name#</h3>
<p><b>Current Bid: <span class="red">$ #numberformat(getitem.bid_amount,"999,999")#</span></b></p>
<cfset minbid = getitem.bid_amount + 1>
<table cellpadding="3">
<tr>
	<td align="right"><b>Your Name:</b></td>
	<td>#session.fullname#&nbsp;&nbsp;<span class="smaller">(<a href="login.cfm?frompage=#urlencodedformat('submit_bid.cfm?no=')##url.no#">login if this isn't you</a>)</span></td></tr>
<cfif session.username eq getitem.bidder_id>
	<tr>
		<td colspan="2" class="red"><b>NOTE: You are already the high bidder on this item with a maximum bid of $ #numberformat(getitem.maximum_bid,"999,999")#</b></td></tr>
</cfif>
<tr>
	<td align="right" nowrap valign="top"><b><span class="red">*</span>MAXIMUM Bid $:</b></td>
	<td><cfinput type="text" name="bid_amount" value="#bidamt#" size="10" maxlength="10" required="yes" message="Please enter your Bid Amount (numbers only)" validate="integer" class="inputform"> <span class="smaller">(<i>whole $ only, no &cent;</i>, maximum bid will auto bid for you in $1 increments up to this amount)</span></td></tr>
</table>
<p><input type="submit" value="Submit Bid"></p>
<input type="Hidden" name="no" value="#url.no#">
</cfoutput>
</cfform>
<p><a href="index.cfm">List Auction Items</a></p>
</div>
</div>
</body>
</html>

