<cfquery name="count" datasource="#application.settings.dsn#">
	SELECT id FROM Item
</cfquery>


<!-----------------------------------------------------------------------------
Document:	add_item.cfm
Purpose:	Data entry form to submit a new item for the auction.
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfquery name="getCategories" datasource="#application.settings.dsn#">
	select id, name from category
	order by name
</cfquery>
<html>
<head>
<title>Submit Item for Auction</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="assets/styles/auction.css">
<script type="text/javascript">
<!--
function validate(form) {
	if (form.category.selectedIndex == "0") {
		alert("Please select the category of your item");
		return false;
	}

}
// -->
</script>
</head>
<body onload="document.frmBid.name.focus()">
<div id="wrap">
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2 align="center">Submit Item for Auction</h2>
<p><span class="red"><b>*</b></span> = required field</p>
<cfform action="add_item_update.cfm" enctype="multipart/form-data" method="POST" name="frmBid" onsubmit="return validate(document.frmBid)">
<table cellpadding="3">
<tr>
	<td align="right"><b><span class="red">*</span>Item Name:</b></td>
	<td><cfinput type="text" name="name" size="60" maxlength="100" required="Yes" message="Please enter the item name" class="input"></td></tr>
<tr>
	<td align="right" valign="top"><b><span class="red">*</span>Description:</b></td>
	<td><cftextarea cols="80" rows="5" name="description" class="input" required="Yes" message="Pleae enter the item description"></cftextarea></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>Category:</b></td>
	<td><select name="category" class="input" >
	<option value="0">--select category--
	<cfoutput query="getCategories">
	<option value="#id#">#name#
	</cfoutput>
	</select></td></tr>
<tr>
	<td align="right"><b><span class="red">*</span>Your Name:</b></td>
	<td><cfinput type="text" name="submitter_name" size="30" maxlength="50" required="Yes" message="Please enter your name" class="input"></td></tr>
<tr>
	<td align="right"><b>Your Phone:</b></td>
	<td><input type="text" name="submitter_phone" size="15" maxlength="20" class="input"></td></tr>
<cfif application.settings.minbid>
	<tr>
		<td align="right"><b><span class="red">*</span>Minimum Bid:</b></td>
		<td><cfinput type="text" name="bid_amount" value="0" size="10" maxlength="10" required="Yes" validate="numeric" message="Please enter only numeric values for minimum bid" class="input"></td></tr>
<cfelse>
	<input type="hidden" name="bid_amount" value="0">
</cfif>
<tr>
	<td align="right"><b>Digital Photo File:</b></td>
	<td><input name="imgfile" size="40" type="file" class="input"></td></tr>
<tr>
	<td colspan="2" align="center"><input type="submit" value="Submit Item"></td></tr>
</table>
</cfform>
<p><a href="index.cfm">List Auction Items</a></p>
</div>
</div>
</body>
</html>
