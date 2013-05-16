<!-----------------------------------------------------------------------------
Document:	index.cfm
Purpose:	Menu of administrator functions.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>CF-Bidder - Administration</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
<style type="text/css"><!--
body li {margin-bottom: .5em;}
.column {float: left; width: 40%;}
.clear {clear: left;}
--></style>
</head>
<body>
<div id="wrap">
<cfinclude template="../includes/header_inc.cfm">
<div id="content">
<h2>Auction Admin Menu</h2>
<p>Auction Status: 
<cfif application.status>
	<span class="green"><b>OPEN</b></span>
<cfelse>
	<span class="red"><b>CLOSED</b></span>
</cfif></p>
<cfif len(application.open_time) neq 0>
	<cfoutput><p><b>Auction Auto Opens: #dateformat(application.open_time,"mmm d, yyyy")# - #timeformat(application.open_time,"h:mm tt")#</b></p></cfoutput>
</cfif>
<cfif len(application.close_time) neq 0>
	<cfoutput><p><b>Auction Auto Closes: #dateformat(application.close_time,"mmm d, yyyy")# - #timeformat(application.close_time,"h:mm tt")#</b></p></cfoutput>
</cfif>
<div class="column">
<p><b>Auction Maintenance</b></p>
<ul>
<li><a href="update.cfm?action=updstatus&status=open">Open Auction</a></li>
<li><a href="update.cfm?action=updstatus&status=close">Close Auction</a></li>
<li><a href="auto_open.cfm">Set Auction Auto Open Time</a></li>
<li><a href="auto_close.cfm">Set Auction Auto Close Time</a></li>
<li><a href="edit_bidlist.cfm">Maintain Auction Items</a></li>
<li><a href="category_select.cfm">Maintain Categories</a></li>
<li><a href="bidder_select.cfm">Update Bidder Info</a></li>
<li><a href="print_list.cfm">Create Printable Bid Report</a></li>
<li><a href="bid_log.cfm">Bidding Log</a></li>
<li><a href="../index.cfm" target="_blank">Public Auction Page</a><br><br></li>
</div>
<div class="column">
<p><b>Post Auction</b></p>
<ul>
<li><a href="winner_list.cfm">Create Winning Bids Report</a></li>
<li><a href="email_winners.cfm">Email Winning Bidders</a></li>
<li><a href="payment.cfm">Record Payment</a></li>
<li><a href="payment_report.cfm">Payment Report</a></li>
</ul>
<p><b>Clear Out Auction</b></p>
<ul>
<li><a href="update.cfm?action=clear">Clear All Bids</a></li>
<li><a href="update.cfm?action=delete">Delete ALL Auction Items</a><br><br></li>
</ul>
</div>
<p class="clear"><a href="logoff.cfm">Logoff</a></p>
</div>
</div>
</body>
</html>