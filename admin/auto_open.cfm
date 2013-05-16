<!-----------------------------------------------------------------------------
Document:	auto_open.cfm
Purpose:	Set auto open date/time for entire auction.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<!--- If del URL parameter, delete the auto open from DB and CF schedule --->
<cfif structKeyExists(url,"del")>
	<cfquery datasource="#application.settings.dsn#">
		update Master set mst_open_time = null
		where mst_no = 1
	</cfquery>
	<cfschedule action="DELETE" task="auction_auto_open">
</cfif>

<!--- If upd URL parameter, set the auto open in DB and CF schedule --->
<cfif structKeyExists(url,"upd")>
	<cfset cdate="#form.month#/#form.day#/#form.year#">
	<cfif not isdate(cdate)>
		<script language="JavaScript" type="text/javascript">
			alert("<cfoutput>#form.month#/#form.day#/#form.year# is an invalid date.</cfoutput>");
			history.go(-1);
		</script>
		<cfoutput>#form.month#/#form.day#/#form.year# is an invalid date.</cfoutput>
		<cfabort>
	</cfif>
	<cfif datediff("d",now(),cdate) lt 0>
		<script language="JavaScript" type="text/javascript">
			alert("<cfoutput>#form.month#/#form.day#/#form.year# has already passed.</cfoutput>");
			history.go(-1);
		</script>
		<cfoutput>#form.month#/#form.day#/#form.year# has already passed.</cfoutput>
		<cfabort>
	</cfif>
	<cfif form.ampm eq "PM" and form.hour neq 12>
		<cfset form.hour = form.hour + 12>
	<cfelseif form.ampm eq "AM" and form.hour eq 12>
		<cfset form.hour = "00">
	</cfif>
	<cfset ctime="#form.hour#:#form.minute#:00">
	<!--- set open time on entire auction --->
	<cfquery datasource="#application.settings.dsn#">
		update Master set mst_open_time = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#cdate# #ctime#">
		where mst_no = 1
	</cfquery>
	<cfschedule action="UPDATE" task="auction_auto_open"  operation="HTTPRequest" url="http://localhost#application.root#open_auction.cfm?open=yes&task=auction_auto_open" startdate="#cdate#" starttime="#ctime#" interval="once" resolveurl="No" publish="No">
</cfif>

<!--- Query DB to get current open time --->
<cfquery name="getopen" datasource="#application.settings.dsn#">
	select mst_open_time from Master
	where mst_no = 1
</cfquery>

<html>
<head>
<title>Auction Auto open</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
</head>
<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2>Auction Auto Open</h2>
<p>Current Open:
<cfif len(getopen.mst_open_time) eq 0>
	<b>None</b>
<cfelse>
	<b><cfoutput>#dateformat(getopen.mst_open_time,"mm/dd/yyyy")# -  #timeformat(getopen.mst_open_time,"h:mm tt")#</cfoutput></b>&nbsp;&nbsp;&nbsp;<a href="auto_open.cfm?del=yes">Delete</a></p>
</cfif>
<form action="auto_open.cfm?upd=yes" method="post">
<table cellpadding="3">
<tr>
	<td align="right"><b>Open Auction on:</b></td>
	<td><select name="month">
   <option value="1">January
   <option value="2">February
   <option value="3">March
   <option value="4">April
   <option value="5">May
   <option value="6">June
   <option value="7">July
   <option value="8">August
   <option value="9">September
   <option value="10">October
   <option value="11">November
   <option value="12">December
	</select>
	<select name="day">
	<cfloop index="idx" from="1" to="31" step="1">
	<cfoutput><option value="#idx#">#idx#</cfoutput>
	</cfloop>
	</select>
	<select name="year">
	<cfloop index="idx" from="#dateformat(now(),'yyyy')#" to="#dateformat(dateadd('yyyy',3,now()),'yyyy')#" step="1">
  <cfoutput><option value="#idx#">#idx#</cfoutput>
	</cfloop>
	</select>
	</td></tr>
<tr>
	<td align="right"><b>At:</b></td>
	<td><select name="hour">
   <option>1
   <option>2
   <option>3
   <option>4
   <option>5
   <option>6
   <option>7
   <option>8
   <option>9
   <option>10
   <option>11
   <option>12
   </select>
   <b>:</b>
   <select name="minute">
   <option>00
   <option>15
   <option>30
   <option>45
   </select>
   <select name="ampm">
   <option>AM
   <option>PM
   </select>
	</td></tr>
<tr>
	<td colspan="2" align="center"><input type="Submit" value="Set Open Time"></td></tr>
</table>
</form>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>



