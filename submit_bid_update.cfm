<!-----------------------------------------------------------------------------
Document:	submit_bid_update.cfm
Purpose:	Record bidders info into database.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif not structKeyExists(form,"bid_amount")><cflocation url="index.cfm" addtoken="No"></cfif>
<cfset form.bid_amount=replace(form.bid_amount,"$","","ALL")>
<cfset form.bid_amount=replace(form.bid_amount,",","","ALL")>
<html>
<head>
<title>Bid Successful</title>
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
</head>
<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">

<!--- If complete auction is closed, don't let them bid --->
<cfif not application.status>
	<h3>The auction is closed.</h3>
	<a href="index.cfm">Back to Auction Items</a>
	</div>
	</div>
	</body>
	</html>
	<cfabort>
</cfif>

<!--- If this item is closed, don't let them bid --->
<cfquery name="getitem" datasource="#application.settings.dsn#">
	select status from Item
	where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.no#">
</cfquery>
<cfif not getitem.status>
	<h3>Bidding is closed on this item.</h3>
	<a href="index.cfm">Back to Auction Items</a>
	</div>
	</div>
	</body>
	</html>
	<cfabort>
</cfif>

<!--- Get the previous high bidder to notify them someone else has bid higher --->
<cfquery name="getcurbidder" datasource="#application.settings.dsn#">
	select username, email, fullname, item.name as item_name
	from Bidder, Item
	where item.id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.no#"> and 
		username = bidder_id
</cfquery>

<!--- Get current bid from database and make sure this one is larger in case we have mutliple threads active --->
<cftransaction>
<cfquery name="getbid" datasource="#application.settings.dsn#">
	SELECT bid_amount, maximum_bid FROM Item
	WHERE item.id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.no#">
</cfquery>
<cfif form.bid_amount lte getbid.bid_amount>
	<script type="text/javascript">
		alert("Sorry, your bid has been eclipsed in the last few seconds since the page was loaded.");
		<cfoutput>location.href="submit_bid.cfm?no=#form.no#";</cfoutput>
	</script>
	Sorry, your bid has been eclipsed since the bid page was loaded.
	<cfabort>
</cfif>
<!--- Check this bid against maximum bid. If less than or equal to, proxy bidder is still the high bidder --->
<cfset current_bid = form.bid_amount>
<cfif current_bid lt getbid.maximum_bid>
	<cfset current_bid = current_bid + 1>
	<cfquery datasource="#application.settings.dsn#">
		UPDATE Item
		SET bid_amount = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#current_bid#">
		WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.no#">
	</cfquery>
	<h2 align="center">Bid Eclipsed</h2>
	<p><cfoutput>Sorry, your bid of $#form.bid_amount# has been exceeded by someone else's maximum bid. You may <a href="submit_bid.cfm?no=#form.no#">re-bid if desired</a>.</cfoutput></p>
<cfelseif current_bid eq getbid.maximum_bid>
	<cfquery datasource="#application.settings.dsn#">
		UPDATE Item
		SET bid_amount = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#current_bid#">
		WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.no#">
	</cfquery>
	<h2 align="center">Bid Eclipsed</h2>
	<p><cfoutput>Your bid of $#form.bid_amount# has been exceeded by someone else's maximum bid. You may <a href="submit_bid.cfm?no=#form.no#">re-bid if desired</a>.</cfoutput></p>
<cfelse>
	<cfif getcurbidder.recordcount gt 0>
		<cfmail to="#getcurbidder.email#" from="#application.settings.email#" subject="Silent Auction Bid Eclipsed">#getcurbidder.fullname#
		
Your bid on "#getcurbidder.item_name#", item ###form.no#, in the Silent Auction has been surpassed. You may re-bid on this by going to http://#cgi.server_name##application.root#submit_bid.cfm?no=#form.no#
		</cfmail>
	</cfif>
	<cfquery datasource="#application.settings.dsn#">
		UPDATE Item
		SET  
			<cfif structKeyExists(form,"fixed_bid")>
				bid_amount = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.bid_amount#">,
				maximum_bid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.bid_amount#">,
			<cfelse>
				bid_amount = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#getbid.maximum_bid + 1#">,
				maximum_bid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#current_bid#">,
		</cfif>
			bidder_id = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.username#">
		WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.no#">
	</cfquery>
	<cfquery name="getitem" datasource="#application.settings.dsn#">
		SELECT name FROM Item
		WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.no#">
	</cfquery>
	<cfif application.settings.logging>
		<!--- Log successful bid --->
		<cfquery datasource="#application.settings.dsn#">
			insert into log (item_id, bid_amount, bidder_id, bid_date)
			values (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.no#">,
				<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.bid_amount#">,
				<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.username#">,
				<cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#now()#">)
		</cfquery>
	</cfif>
	<h2 align="center">Bid Successful</h2>
	<cfoutput query="getitem">
	<p>Your bid for <b>#name#</b>, item ###form.no#, of <b>$#numberformat(form.bid_amount,"99,999")#</b> is now the current maximum bid.</p>
	</cfoutput>
</cfif>
</cftransaction>
<p><a href="index.cfm">List Auction Items</a></p>
</div>
</div>
</body>
</html>
