<!-----------------------------------------------------------------------------
Document:	add_item_update.cfm
Purpose:	Add item submitted from add_item.cfm to the database and upload image if included.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif not structKeyExists(form,"name")><cflocation url="index.cfm" addtoken="No"></cfif>

<html>
<head>
<title>Auction Item Submitted</title>
<link rel=stylesheet type="text/css" href="assets/styles/auction.css">
</style>
</head>
<body>

<!--- get the new item number --->
<cftransaction>
<cfquery name="max" datasource="#application.settings.dsn#">
	select max(id) as max_no from Item
</cfquery>
<cfif max.max_no is "">
	<cfset nid = 1>
<cfelse>
	<cfset nid = max.max_no + 1>
</cfif>

<cfif form.imgfile neq "">
	<!--- if image, upload & resize --->
	<cftry>
	<cffile action="UPLOAD" filefield="imgfile" destination="#ExpandPath('./images')#" nameconflict="MAKEUNIQUE">
	<cfset attfile=File.ServerDirectory & "/" & File.ServerFile>
    <cfinclude template="/auction/includes/resize_cf8_inc.cfm">
	<cfset imgfilename = "image_#nid#.jpg">
	<cfcatch type="any">
		<cfset imgfilename = "">
	</cfcatch>
	</cftry>
	<cftry>
	<cffile action="delete" file="#attfile#">
	<cfcatch type="any">
	</cfcatch>
	</cftry>
<cfelse>
	<cfset imgfilename = "">
</cfif>
<cfquery datasource="#application.settings.dsn#">
	insert into Item (id, name, description, submitter_name,
		submitter_phone, photo_file, bid_amount, bidder_id, status, category_id, maximum_bid, minimum_bid)
	values (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#nid#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.name#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.description#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.submitter_name#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.submitter_phone#">,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#imgfilename#">,
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.bid_amount#">,
		'', 
		<cfif application.settings.autoapprove>
			1,
		<cfelse>
			0,
		</cfif>
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.category#">,
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.bid_amount#">,
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.bid_amount#">)
</cfquery>
</cftransaction>

<cfif application.settings.sendemail>
	<cfmail from="#application.settings.email#"
	        to="#application.settings.email#"
	        subject="Auction Item Submitted">The following item was submitted for the Auction:
From: #form.submitter_name#
Item ##: #nid#
Item: #form.name#
Description: #form.description#
	<cfif not application.settings.autoapprove>
You can approve this item at http://#cgi.server_name##application.root#admin/
	</cfif>
	</cfmail>
</cfif>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2>Item Submitted</h2>
<p>Your item for the auction was successfully submitted.<cfif not application.settings.autoapprove> It will be listed once approved.</cfif></p>
<p><a href="add_item.cfm">Submit Another Item</a></p>
<p><a href="index.cfm">List Auction Items</a></p>
</div>
</div>
</body>
</html>
