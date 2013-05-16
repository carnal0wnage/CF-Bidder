<!-----------------------------------------------------------------------------
Document:	category_info.cfm
Purpose:	Add or edit category info
------------------------------------------------------------------------------>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<cfif structKeyExists(form,"edit")>
	<cfif form.action eq "addcat">
		<cfquery datasource="#application.settings.dsn#">
			insert into category (name)
			values (<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">)
		</cfquery>
	<cfelse>
		<cfquery datasource="#application.settings.dsn#">
			update category set name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.name#">
			where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
		</cfquery>
	</cfif>
    <cflocation url="category_select.cfm" addtoken="no">
<cfelseif structKeyExists(form,"delete")>
	<cfquery name="qryItems" datasource="#application.settings.dsn#">
		select id from item
		where category_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
	</cfquery>
	<cfif qryItems.recordcount>
		<script type="text/javascript">
			alert("This category is in use by an auction item and cannot be deleted.");
			history.go(-1);
		</script>
		<p>This category is in use by an auction item and cannot be deleted.</p>
		<cfabort>
	</cfif>
	<cfquery datasource="#application.settings.dsn#">
		delete from category
		where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
	</cfquery>
    <cflocation url="category_select.cfm" addtoken="no">
</cfif>

<cfif url.action eq "addcat">
	<cfset form.id = -1>
</cfif>
<cfquery name="qryCategory" datasource="#application.settings.dsn#">
	select name from category
	where id = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.id#">
</cfquery>

<html>
<head><title>Cagtegory Information</title>
<script language="JavaScript" type="text/javascript">
function confirmDelete() {
	if (confirm("Do you really want to delete this category?") == false) return false;
	return true;
}
</script>
<link rel="stylesheet" type="text/css" href="../assets/styles/auction.css">
</head>
<body onLoad="document.frmInfo.name.focus()">
<div id="wrap"> 
<cfinclude template="/auction/includes/header_inc.cfm">
<div id="content">
<cfif url.action is "addcat"><h2>Add New Category</h2><cfset button = "Add New Category">
<cfelse><h2>Update Category</h2><cfset button = "Update Category">
</cfif>
<cfoutput>
<cfform name="frmInfo" method="POST">
<p><b>Category Name:</b> <cfinput type="text" name="name" value="#qryCategory.name#" size="50" maxlength="50" required="yes" message="Please enter the Category name"></p>
<p><input type="submit" value="#Button#" name="edit"></p>
<input type="Hidden" name="id" value="#form.id#">
<input type="Hidden" name="action" value="#url.action#">
</cfform>
<cfif form.id neq -1>
	<form name="frmDelete" onSubmit="return confirmDelete(this)"method="POST">
	<input type="submit" value="Delete Category" name="delete">
	<input type="Hidden" name="id" value="#form.id#">
	</form>
</cfif>
</cfoutput>
<p><a href="index.cfm">Admin Menu</a></p>
</div>
</div>
</body>
</html>
