<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Private Lot</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.private") AND IsDefined("Form.userID")>
	<CFIF Form.private EQ "add">
		<CFLOOP INDEX="privateCount" LIST="#Form.userID#">
			<CFQUERY NAME=addPrivate DATASOURCE="#EAdatasource#">
				INSERT INTO PrivateLotUser (lotID, userID)
				VALUES (#Form.lotID#, #privateCount#)
			</CFQUERY>
		</CFLOOP>
		<H3>Users added to this private lot.</H3>
	<CFELSE><!--- Form.private EQ "delete" --->
		<CFSET privateCount = 2>
		<CFQUERY NAME=deletePrivate DATASOURCE="#EAdatasource#">
			DELETE FROM PrivateLotUser
			WHERE lotID = #Form.lotID#
				AND (userID = #ListGetAt(Form.userID,1)#
			<CFLOOP INDEX="privateCount" LIST="#Form.userID#">
				OR userID = #privateCount#
			</CFLOOP>)
		</CFQUERY>
		<H3>Users removed from this private lot.</H3>
	</CFIF>
	<CFSET lotID = #Form.lotID#>
	<P><HR NOSHADE COLOR=purple><P>
</CFIF>

<CFQUERY NAME=getLotName DATASOURCE="#EAdatasource#">
	SELECT categoryID, lotName FROM Lot WHERE lotID = #lotID#
</CFQUERY>

<FONT SIZE=4><B><CFOUTPUT>#lotID# - #getLotName.lotName# </B></FONT>
(<A HREF="categoryLots.cfm?categoryID=#getLotName.categoryID#&order=lotName###lotID#">Return to category page</A>)</CFOUTPUT>
<H2>Private Bidders</H2>

<CFQUERY NAME="getPrivate" DATASOURCE="#EAdatasource#">
	SELECT PrivateLotUser.userID, Member.username, Member.organization,
		Member.firstName, Member.lastName
	FROM PrivateLotUser INNER JOIN Member ON PrivateLotUser.userID = Member.userID
	WHERE PrivateLotUser.lotID  = #lotID#
</CFQUERY>

<CFIF getPrivate.RecordCount EQ 0>
	<H3>No users currently have permission for this private lot.</H3>
<CFELSE>
	<CFFORM ACTION="lotPrivate.cfm">
	<INPUT TYPE=hidden NAME=private VALUE="delete">
	<CFOUTPUT><INPUT TYPE=hidden NAME=lotID VALUE=#lotID#></CFOUTPUT>

	Below is a list of users who currently have access to this private lot. To remove a user from the group, check the checkbox next to that user and click on the &quot;Remove User&quot; button below. You must check the checkbox below the button to verify your request.
	<P>
	<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
	<TH BGCOLOR="#20A491">Del</TH>
	<TH BGCOLOR="#20A491">Name (last, first)</TH>
	<TH BGCOLOR="#20A491">Username</TH>
	<TH BGCOLOR="#20A491">Organization</TH>
	
	<CFSET rowBG = 0>
	<CFOUTPUT QUERY="getPrivate">
		<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
			<CFELSE><TR BGCOLOR="##CDCDCD"><CFSET rowBG = 0></CFIF>
		<TD><INPUT TYPE=checkbox NAME=userID VALUE="#userID#"></TD>	
		<TD>#lastName#, #firstName#</TD>
		<TD>#username#</TD>
		<TD>#organization#</TD>
		</TR>
	</CFOUTPUT>
	</TABLE>
	<P>
	<INPUT TYPE=submit NAME="Remove Users"><BR>
	<CFINPUT TYPE=checkbox NAME=okRemove VALUE=1 REQUIRED="Yes" MESSAGE="Checkbox must be checked to remove users."> Must be checked to remove users.
	</CFFORM>
</CFIF>

<P><HR NOSHADE COLOR=purple><P>

<H3>Add Users</H3>
<CFINCLUDE TEMPLATE="userChoose.cfm">