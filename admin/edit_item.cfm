<!-----------------------------------------------------------------------------
Document:	edit_item.cfm
Purpose:	Allow admin to change the name, description, or photo of an item.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<cfquery name="getitem" datasource="#application.settings.dsn#">
	select name, description, photo_file from Item
	where id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.no#">
</cfquery>

<html>
<head>
<title>Edit Item for Auction</title>
<link rel=stylesheet type="text/css" href="../assets/styles/auction.css">
</head>
<body>
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2 align="center">Edit Item for Auction</h2>
<cfoutput>	
<cfform action="update.cfm?no=#url.no#&action=edititem" enctype="multipart/form-data" method="POST">
<table cellpadding="3">
<tr>
	<td align="right">Item Name</td>
	<td><cfinput type="text" name="name" size="50" maxlength="100" value="#getitem.name#"  required="Yes" message="You must enter the item name" class="input"></td></tr>
<tr>
	<td align="right" valign="top">Description</td>
	<td><textarea cols="50" rows="5" name="description" class="input">#getitem.description#</textarea></td></tr>
<tr>
	<td align="right" valign="top">New Digital Photo File</td>
	<td><input name="imgfile" size="40" type="file" class="input"></td></tr>
<tr>
	<td align="right"><input type="checkbox" name="deleteimg" value=""></td>
	<td>Check to delete current image</td></tr>
<tr>
	<td colspan="2" align="center"><input type="submit" value="Update Item"></td></tr>
</table>
<input type="Hidden" name="name_required" value="You must enter the item name">
</cfform>
<cfif getitem.photo_file neq "">
	<img src="../images/#getitem.photo_file#" border="0" alt="item photo">
</cfif>
</cfoutput>

<p><a href="edit_bidlist.cfm">Maintain Auction List Items</a></p>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>

</body>
</html>



