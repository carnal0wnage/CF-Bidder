<!-----------------------------------------------------------------------------
Document:	bid_detail.cfm
Purpose:	List the detailed info and photo of auction item.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<cfif not structKeyExists(url,"no")><cflocation url="index.cfm" addtoken="No"></cfif>

<cfquery name="getitem" datasource="#application.settings.dsn#">
	select * from Item
	where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
</cfquery>

<html>
<head>
<title>Auction Item Detail</title>
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
</head>
<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<cfoutput query="getitem">
<h2>#name#</h2>
<cfset newtext=replace(description,chr(13) & chr(10),"<br>","ALL")>
<p>#paragraphformat(newtext)#</p>
<p><b>Submitted by:</b> #submitter_name#</p>
<p><b>Current Bid:</b> $ #numberformat(bid_amount,"99,999")#</p>
<cfif photo_file neq "">
	<img src="images/#photo_file#" border="0" alt="item photo">
</cfif>
<cfif application.status><p><a href="submit_bid.cfm?no=#url.no#" title="click to bid on this item...">Bid On This</a></p></cfif>
</cfoutput>
<p><a href="javascript:history.go(-1)">List Auction Items</a></p>
</div>
</div>
</body>
