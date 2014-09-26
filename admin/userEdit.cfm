<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: User Manager</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF NOT IsDefined("Form.button")><CFSET button = "Get User"></CFIF>

<CFIF button EQ "Edit Users" OR button EQ "Add Users">
	<CFIF IsDefined("Form.userID")>
		<CFSET lenID = ListLen(Form.userID)>
	<CFELSE><CFSET lenID = 0>
	</CFIF>
	<CFIF IsDefined("Form.username")>
		<CFSET lenUsername = ListLen(Form.username)>
	<CFELSE><CFSET lenUsername = 0>
	</CFIF>
	<CFIF IsDefined("Form.name")>
		<CFSET lenName = ListLen(Form.name)>
	<CFELSE><CFSET lenName = 0>
	</CFIF>

	<CFQUERY NAME=getUsers DATASOURCE="#EAdatasource#">
		SELECT userID, firstName, lastName, username
		FROM Member
		WHERE userID = -2
		<CFIF lenID GT 0>
			<CFLOOP INDEX=count FROM=1 TO="#lenID#">
				OR userID = #ListGetAt(Form.userID,count)#
			</CFLOOP>
		</CFIF>
		<CFIF lenUsername GT 0>
			<CFLOOP INDEX=count FROM=1 TO="#lenUsername#">
				OR userID = #ListGetAt(Form.username,count)#
			</CFLOOP>
		</CFIF>
		<CFIF lenName GT 0>
			<CFLOOP INDEX=count FROM=1 TO="#lenName#">
				OR userID = #ListGetAt(Form.name,count)#
			</CFLOOP>
		</CFIF>
		ORDER BY #Form.orderUser#
	</CFQUERY>

<CFELSEIF button EQ "List Users">
	<CFIF IsDefined("Form.userIDrange")>
		<CFSET lenID = ListLen(Form.userIDrange)>
	<CFELSE><CFSET lenID = 0>
	</CFIF>
	<CFIF IsDefined("Form.usernameRange")>
		<CFSET lenUsername = ListLen(Form.usernameRange)>
	<CFELSE><CFSET lenUsername = 0>
	</CFIF>
	<CFIF IsDefined("Form.lastNameRange")>
		<CFSET lenLastName = ListLen(Form.lastNameRange)>
	<CFELSE><CFSET lenLastName = 0>
	</CFIF>

	<CFQUERY NAME=getUsers DATASOURCE="#EAdatasource#">
		SELECT userID, firstName, lastName, username
		FROM Member
		WHERE userID = -2
		<CFIF lenID GT 0>
			<CFLOOP INDEX=count FROM=1 TO="#lenID#" STEP=2>
				OR (userID >= #ListGetAt(Form.userIDrange,count)#
					AND userID <= #ListGetAt(Form.userIDrange,count+1)#)
			</CFLOOP>
		</CFIF>
		<CFIF lenUsername GT 0>
			<CFLOOP INDEX=count FROM=1 TO="#lenUsername#">
				OR username LIKE '#ListGetAt(Form.usernameRange,count)#%'
			</CFLOOP>
		</CFIF>
		<CFIF lenLastName GT 0>
			<CFLOOP INDEX=count FROM=1 TO="#lenLastName#">
				OR lastName LIKE '#ListGetAt(Form.lastNameRange,count)#%'
			</CFLOOP>
		</CFIF>
		ORDER BY #Form.orderUser#
	</CFQUERY>

<CFELSE><!--- button EQ "Search" --->
	<CFQUERY NAME=getUsers DATASOURCE="#EAdatasource#">
		SELECT userID, firstName, lastName, username, organization
		FROM Member
		WHERE #Form.searchUser# LIKE '%#Form.userInfo#%'
			AND userID > 0
		ORDER BY #Form.orderSearch#
	</CFQUERY>

</CFIF><!--- End of IF statement determing which query to do --->

<CFIF getUsers.RecordCount EQ 0>
	<H3>No users satisfied your search criteria.</H3>
	</BODY></HTML><CFABORT>
</CFIF>

<CFIF IsDefined("Form.lotID")>
	<H2 ALIGN=center>Add Users to Private Lot</H2>
	To grant a user permission for this private lot, chech the checkbox next to their name. When you have chosen all of the users, click the &quot;Add Users&quot; button at the bottom of the table. You may also choose to edit the user by clicking on the userID, which will open a new browser window.
	<P>
	<FORM METHOD=post ACTION="lotPrivate.cfm">
	<INPUT TYPE=hidden NAME=private VALUE="add">
	<CFOUTPUT><INPUT TYPE=hidden NAME=lotID VALUE=#Form.lotID#></CFOUTPUT>
<CFELSE>
	<P>Click on userID to edit user. If you change the username, the system will check that the username is not already taken. You cannot edit the password, only change it. Be sure to verify that you entered the password correctly.
	<P>
	You can also choose to delete the user(s) from the user database. Simply check the checkbox next to the user(s) you want to delete, and then click on the &quot;Delete Users&quot; button at the bottom of the list. Be sure to check the checkbox following the Delete button.
	<P>
	<FORM METHOD=post ACTION="userDelete.cfm">
</CFIF>

<CENTER>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TH BGCOLOR="#CDCDCD" VALIGN=bottom>?</TH>
<TH BGCOLOR="#CDCDCD"><FONT SIZE=2>userID<BR>(edit)</FONT></TH>
<TH BGCOLOR="#CDCDCD" VALIGN=bottom><FONT SIZE=2>Status</FONT></TH>
<TH BGCOLOR="#CDCDCD" VALIGN=bottom><FONT SIZE=2>Bids</FONT></TH>
<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
	<TH BGCOLOR="#CDCDCD" VALIGN=bottom><FONT SIZE=2>Feedback</FONT></TH>
</CFIF>
<TH BGCOLOR="#CDCDCD" VALIGN=bottom>Username</TH>
<TH BGCOLOR="#CDCDCD" VALIGN=bottom>Name (Last, First)</TH>
<CFIF button EQ "Search" AND Form.orderSearch EQ "organization">
	<TH BGCOLOR="#CDCDCD" VALIGN=bottom>Organization</TH>
</CFIF>

<CFSET row = 1>
<CFOUTPUT QUERY=getUsers>
	<CFIF userID NEQ 0>
		<CFIF row EQ 2><TR BGCOLOR="##CDCDCD"><CFELSE><TR></CFIF>
		<TD ALIGN=center><INPUT TYPE=checkbox NAME=userID VALUE=#userID#></TD>
		<TD ALIGN=center><A HREF="#secureSystemURL#/admin/userCreate.cfm?userID=#userID#">#userID#</A></TD>
		<TD ALIGN=center><A HREF="userStatus.cfm?userID=#userID#"><FONT SIZE=2>status</FONT></A></TD>
		<TD ALIGN=center><A HREF="userBids.cfm?userID=#userID#"><FONT SIZE=2>bids</FONT></A></TD>
		<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
			<TD ALIGN=center><A HREF="sellerFeedback.cfm?userID=#userID#"><FONT SIZE=2>feedback</FONT></A></TD>
		</CFIF>
		<TD>#username#</TD>
		<CFIF lastName NEQ " " AND lastName NEQ "" AND firstName NEQ " " AND firstName NEQ "">
			<TD>#lastName#, #firstName#</TD>
		<CFELSEIF lastName NEQ " " AND lastName NEQ ""><TD>#lastName#</TD>
		<CFELSEIF firstName NEQ " " AND firstName NEQ ""><TD>#firstName#</TD>
		<CFELSE><TD>&nbsp;</TD>
		</CFIF>
		<CFIF button EQ "Search" AND Form.orderSearch EQ "organization">
			<TD>#organization#</TD>
		</CFIF>
		</TR>
		<CFIF row EQ 1><CFSET row = 2><CFELSE><CFSET row = 1></CFIF>
	</CFIF>
</CFOUTPUT>
</TABLE><BR>
<INPUT TYPE=reset VALUE=Clear> 
<CFIF IsDefined("Form.lotID")>
	<INPUT TYPE=submit VALUE="Add Users">
<CFELSE>
	<INPUT TYPE=submit VALUE="Delete Users"><BR>
	<INPUT TYPE=checkbox NAME=okDelete VALUE=1>Must be checked to delete user(s)<BR>
	&nbsp; &nbsp; &nbsp; <FONT SIZE=2>(Please note that deleting a user will also delete all bids by that user.)</FONT>
</CFIF>
</CENTER>
</FORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>