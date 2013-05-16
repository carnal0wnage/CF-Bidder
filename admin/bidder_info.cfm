<cfif structKeyExists(form,"submit")>
	<!--- update info for bidderer --->
	<cfquery datasource="#application.settings.dsn#">
		update bidder set address = '#trim(form.address)#', city = '#trim(form.city)#', state = '#form.state#',
			zip = '#form.zip#', email = '#trim(form.email)#', phone = '#trim(form.phone)#'
		where username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.username#">
	</cfquery>
	<p>Bidder Info Updated.</p>
<cfelse>
	<cfquery name="qryBidder" datasource="#application.settings.dsn#">
		select * from bidder
		where username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.username#">
	</cfquery>

	<cfform method="POST">
	<cfoutput query="qryBidder">
	<h3>Info for #fullname#</h3>
	<table cellspacing="0" cellpadding="5">
	<tr>
		<td nowrap align="right"><b>Address:</b></td>
		<td nowrap><input type="text" name="address" size="40" maxlength="50" value="#address#"></td></tr>
	<tr>
		<td nowrap align="right"><b>City:</b></td>
		<td nowrap><input type="text" name="city" size="20" maxlength="50" value="#city#">&nbsp;&nbsp;&nbsp;
		<b>State:</b> <input type="text" name="state" size="2" maxlength="2" value="#state#">&nbsp;&nbsp;&nbsp;
		<b>Zip:</b> <input type="text" name="zip" size="5" maxlength="5" value="#zip#"></td></tr>
	<tr>
		<td nowrap align="right"><b>Email:</b></td>
		<td nowrap><input type="text" name="email" size="50" maxlength="250" value="#email#"></td></tr>
	<tr>
		<td nowrap align="right"><b>Phone:</b></td>
		<td nowrap><input type="text" name="phone" size="12" maxlength="50" value="#phone#"></td></tr>
	</table>
	<input type="hidden" name="username" value="#url.username#">
	<p><input type="submit" value="Update Bidder Info" name="submit"></p>
	</cfoutput>
	</cfform>
</cfif>
