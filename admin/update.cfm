<!-----------------------------------------------------------------------------
Document:	udpate.cfm
Purpose:	Update info about auction.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<cfswitch expression="#action#">

<cfcase value="updstatus">
	<!--- Update the open/closed status of the auction --->
	<cfif url.status eq "open">
		<cfset application.status = true>
	<cfelse>
		<cfset application.status = false>
	</cfif>
	<cfquery datasource="#application.settings.dsn#">
		update Master 
		set mst_status =
		<cfif url.status eq "open">
			1
		<cfelse>
			0
		</cfif>
		where mst_no = 1
	</cfquery>
	<cflocation url="index.cfm" addtoken="No">
</cfcase>

<cfcase value="delete">
	<cfif not structKeyExists(form,"delupd")>
		<html>
		<head>
		<title>Confirm Auction Items Deletion</title>
		<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
		</head>
		<body>
		<div id="wrap">
		<cfinclude template="/auction/includes/header_inc.cfm">
		<div id="content">
		<div align="center">
		<form action="update.cfm?action=delete" method="post">
		<p><b>Are you sure you want to delete <span class="red">ALL</span> items in the Auction and the log?</b></p>
		<input type="hidden" name="delupd">
		<input type="submit" value="Yes, Delete">
		</form>
		<br><br>
		<form action="index.cfm"><input type="submit" value="No, Do NOT Delete"></form>
		</div>
		</div>
		</body>
		</html>
	</cfif>
	
	<cfif structKeyExists(form,"delupd")>
		<cfquery datasource="#application.settings.dsn#">
			delete from Item
		</cfquery>
		<cfquery datasource="#application.settings.dsn#">
			delete from Log
		</cfquery>
		<cfdirectory action="list" directory="#expandPath('../images')#" name="dirList">
		<cfloop query="dirList">
			<cftry>
			<cffile action="delete" file="#ExpandPath('../images')#/#dirList.name#">
			<cfcatch type="any">
			</cfcatch>
			</cftry>
		</cfloop>
		<script language="JavaScript" type="text/javascript">
			alert("ALL auction items have been deleted");
			location.href="index.cfm";
		</script>
		ALL auction items have been deleted
		<cfabort>
	</cfif>
</cfcase>

<cfcase value="clear">
	<cfif not structKeyExists(form,"clrupd")>
		<html>
		<head>
		<title>Confirm Clearing of Bids</title>
		<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
		</style>
		</head>
		<body>
		<div id="wrap">
		<cfinclude template="/auction/includes/header_inc.cfm">
		<div id="content">
		<div align="center">
		<form action="update.cfm?action=clear" method="post">
		<p><b>Are you sure you want to clear ALL bids for ALL items and clear log file?</b></p>
		<input type="hidden" name="clrupd">
		<input type="submit" value="Yes, Clear Away">
		</form>
		<br> 
		<form action="index.cfm"><input type="submit" value="No, Do NOT Clear"></form>
		</div>
		</div>
		</body>
		</html>
	</cfif>
	
	<cfif structKeyExists(form,"clrupd")>
		<!--- Clear bid amount by setting value to same as initial minimum bid --->
		<cfquery datasource="#application.settings.dsn#">
			update Item set bid_amount=minimum_bid, maximum_bid=minimum_bid, bidder_id = ''
		</cfquery>
		<cfquery datasource="#application.settings.dsn#">
			delete from log
		</cfquery>
		<script language="JavaScript" type="text/javascript">
			alert("ALL bids have been cleared");
			location.href="index.cfm";
		</script>
		ALL bids have been cleared
		<cfabort>
	</cfif>
</cfcase>

<cfcase value="closeitem">
	<cfquery datasource="#application.settings.dsn#">
		update Item set status = 0
		where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
	</cfquery>
	<cflocation url="edit_bidlist.cfm" addtoken="No">
</cfcase>

<cfcase value="openitem">
	<cfquery datasource="#application.settings.dsn#">
		update Item set status = 1
		where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
	</cfquery>
	<cflocation url="edit_bidlist.cfm" addtoken="No">
</cfcase>

<cfcase value="edititem">
	<cfset nid = url.no>
	<cfif len(form.imgfile) neq 0 and not structKeyExists(form,"deleteimg")>
		<!--- if image, upload & resize --->
		<cftry>
		<cffile action="UPLOAD" filefield="imgfile" destination="#ExpandPath('../images')#" nameconflict="MAKEUNIQUE">
		<cfset attfile=File.ServerDirectory & "/" & File.ServerFile>
	    <cfinclude template="/auction/includes/resize_cf8_inc.cfm">
		<cfset imgfilename = "image_#url.no#.jpg">
		<cfcatch type="any">
		<cfset imgfilename = "">
		</cfcatch>
		</cftry>
		<cftry>
		<cffile action="delete" file="#attfile#">
		<cfcatch type="any">
		</cfcatch>
		</cftry>
	<cfelseif structKeyExists(form,"deleteimg")>
		<cfquery name="getimage" datasource="#application.settings.dsn#">
			select photo_file from Item
			where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
		</cfquery>
		<cftry>
		<cffile action="delete" file="#ExpandPath('../images')#/#getimage.photo_file#">
		<cfcatch type="any">
		</cfcatch>
		</cftry>
		<cfset imgfilename = "">
	</cfif>
	<cfquery datasource="#application.settings.dsn#">
		update Item set name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.name#">,
			description = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.description#">
			<cfif len(form.imgfile) neq 0 or structKeyExists(form,"deleteimg")>
				,photo_file = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#imgfilename#">
			</cfif>
		where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
	</cfquery>
	<cflocation url="edit_bidlist.cfm" addtoken="No">
</cfcase>

<cfcase value="deleteitem">
	<cfif not structKeyExists(form,"delupd")>
		<cfquery name="getname" datasource="#application.settings.dsn#">
			select name from Item
			where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
		</cfquery>
		<html>
		<head>
		<title>Confirm Item Deletion</title>
		<link rel=stylesheet type="text/css" href="../assets/styles/auction.css">
		</style>
		</head>
		<body>
		<div id="wrap">
		<cfinclude template="/auction/includes/header_inc.cfm">
		<div id="content">
		<div align="center">
		<cfoutput><form action="update.cfm?no=#url.no#&action=deleteitem" method="post">
		<p><b>Are you sure you want to delete<br>
		#getname.name#?</b></p></cfoutput>
		<input type="hidden" name="delupd">
		<input type="submit" value="Yes, Delete">
		</form>
		<form action="edit_bidlist.cfm"><p><input type="submit" value="No, Do NOT Delete"></p></form>
		</div>
		</div>
		</div>
		</body>
		</html>
	<cfelse>
		<cfquery name="getimage" datasource="#application.settings.dsn#">
			select photo_file from Item
			where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
		</cfquery>
		<cfquery datasource="#application.settings.dsn#">
			delete from Item
			where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
		</cfquery>
		<cfif len(getimage.photo_file)>
			<cftry>
			<cffile action="delete" file="#ExpandPath('../images')#/#getimage.photo_file#">
			<cfcatch type="any">
			</cfcatch>
			</cftry>
		</cfif>
		<cflocation url="edit_bidlist.cfm" addtoken="No">
	</cfif>
</cfcase>

<cfcase value="payment">
	<!--- Record payment for items. Called from payment.cfm --->
	<cfloop index="i" from="1" to="#form.max#">
		<cfif len(trim(form["chk" & i])) gt 0 or len(trim(form["cash" & i])) gt 0>
			<cfquery datasource="#application.settings.dsn#">
				update item set checkno = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form["chk" & i])#">, 
				cash = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(form["cash" & i])#">, 
				date_paid = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#now()#">
				where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form["id" & i]#">
			</cfquery>
		</cfif>
	</cfloop>
	<script type="text/javascript">
		alert("Payments Recorded");
		location.href='index.cfm';
	</script>
</cfcase>

<cfdefaultcase>
	<cflocation url="index.cfm" addtoken="no">
</cfdefaultcase>

</cfswitch>
