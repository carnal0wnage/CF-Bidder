<!-----------------------------------------------------------------------------
Document:	category_select.cfm
Purpose:	Maintain categories
------------------------------------------------------------------------------>
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="Wed, 20 Dec 2000 12:00:00 GMT">
<cfheader name="Cache-Control" value="no-cache, no-store, must-revalidate, max-age=0">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>

<cfquery name="qryCategories" datasource="#application.settings.dsn#">
	select id, name from category
	order by name
</cfquery>

<head>
<title>Maintain Categories</title>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
<script type="text/javascript">
function checkForm(form) {
	if (form.id.selectedIndex == "0") {
		alert("Please select the category to maintain");
		return false;
	}
	return true;
}
</script>
</head>

<body>
<div id="wrap"> 
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<h2>Maintain Categories</h2>
<form action="category_info.cfm?action=addcat" method="POST">
<input type="submit" value="Add New Category">
</form>
<p><b class="red">OR</b></p>
<form action="category_info.cfm?action=editcat" method="POST" onSubmit="return checkForm(this)">
<b>Category:</b> <select name="id">
<cfif qryCategories.recordcount is 0>
	<option value="0">No Categories on File
	</select>
<cfelse>
	<option value="0">-- select category --
	<cfoutput query="qryCategories">
	<option value="#id#">#name#
	</cfoutput>
	</select>
</cfif>
<p><input type="Submit" value="Update this Category"></p>
</form>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>
