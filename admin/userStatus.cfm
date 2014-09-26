<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: User Status</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFQUERY NAME=updateUser DATASOURCE="#EAdatasource#">
		UPDATE Member
		SET userStatus = #Form.userStatus#
		WHERE userID = #Form.userID#
	</CFQUERY>
	
	<H3>User status updated.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=500 COLOR=purple ALIGN=left><P>
</CFIF>

<CFQUERY NAME=getUser DATASOURCE="#EAdatasource#">
	SELECT username, firstName, lastName, email, userStatus, userVerifyCode
	FROM Member
	WHERE userID = #userID#
</CFQUERY>

<CFOUTPUT><H1>#getUser.lastName#, #getUser.firstName# (<A HREF="mailto:#getUser.email#">#getUser.username#</A>)</H1></CFOUTPUT>

<CFFORM ACTION=userStatus.cfm NAME=userStatus>
<INPUT TYPE=hidden NAME=first VALUE=1>
<CFOUTPUT><INPUT TYPE=hidden NAME=userID VALUE=#userID#></CFOUTPUT>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TD ALIGN=right BGCOLOR=DCDCDC>User Verify Code: </TD><TD><CFOUTPUT>#getUser.userVerifyCode#</CFOUTPUT></TD></TR>
<TR><TD ALIGN=right VALIGN=top BGCOLOR=DCDCDC>User Status: </TD>
	<TD><INPUT TYPE=radio NAME=userStatus VALUE=0<CFIF getUser.userStatus EQ ""> CHECKED</CFIF>> Not yet approved<BR>
	<INPUT TYPE=radio NAME=userStatus VALUE=1<CFIF getUser.userStatus EQ 1> CHECKED</CFIF>> Approved<BR>
	<INPUT TYPE=radio NAME=userStatus VALUE=0<CFIF getUser.userStatus EQ 0> CHECKED</CFIF>> On Probation<BR>
	<INPUT TYPE=radio NAME=userStatus VALUE=-1<CFIF getUser.userStatus EQ -1> CHECKED</CFIF>> Banished</TD></TR>
</TABLE>
<P>
<INPUT TYPE=submit VALUE="Update Status">
</CFFORM>

</body>
</html>
