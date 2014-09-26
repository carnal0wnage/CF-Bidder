<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: User Manager</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF NOT IsDefined("Form.okDelete")>
	<H3>The checkbox was not checked.<BR>No users were deleted.</H3>
<CFELSEIF NOT IsDefined("Form.userID")>
	<H3>You did not check any users.<BR>No users were deleted.</H3>
<CFELSE>
	<CFSET count = 2>
	<CFQUERY NAME=deleteUser DATASOURCE="#EAdatasource#">
		DELETE
		FROM Member
		WHERE userID = #ListGetAt(Form.userID,1)#
		<CFLOOP INDEX=count LIST="#Form.userID#">
			OR userID = #count#
		</CFLOOP>
	</CFQUERY>

	<CFSET count = 2>
	<CFQUERY NAME=deleteBid DATASOURCE="#EAdatasource#">
		DELETE
		FROM Bid
		WHERE userID = #ListGetAt(Form.userID,1)#
		<CFLOOP INDEX=count LIST="#Form.userID#">
			OR userID = #count#
		</CFLOOP>
	</CFQUERY>

	<CFSET count = 2>
	<CFQUERY NAME=deletePrivate DATASOURCE="#EAdatasource#">
		DELETE
		FROM PrivateLotUser
		WHERE userID = #ListGetAt(Form.userID,1)#
		<CFLOOP INDEX=count LIST="#Form.userID#">
			OR userID = #count#
		</CFLOOP>
	</CFQUERY>

	<H3>User(s) deleted.</H3>
</CFIF>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>