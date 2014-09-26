<P>
<DL>
<DT><CFFORM NAME=editUser ACTION="#systemURL#/program/editUser.cfm">
<FONT SIZE=5 TYPE=Arial><B>Edit User</B></FONT>
<DD>
<CFIF IsDefined("Cookie.EmazeAuction_user")>
	<INPUT TYPE=checkbox NAME=useCookie VALUE=1 CHECKED> Use my cookie<P>
</CFIF>
<A NAME=edit></A><TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD ALIGN=right><FONT FACE=Arial>Username: </FONT></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED=Yes MESSAGE="You must enter your username"></TD></TR>
<TR><TD ALIGN=right><FONT FACE=Arial>Password: </FONT></TD>
	<TD><CFINPUT TYPE=password NAME=password SIZE=20 REQUIRED=Yes MESSAGE="You must enter your username"></TD></TR>
<TR><TD ALIGN=right></TD><TD><INPUT NAME=userSubmit TYPE=submit VALUE="Edit User"></TD></TR>
</TABLE>
</CFFORM>

<P>

<CFINCLUDE TEMPLATE="getPasswordOptions.cfm">
<CFIF getPasswordFields NEQ " ">
	<HR NOSHADE WIDTH=500 SIZE=3 ALIGN=left><P>
	<DT><A NAME=password></A><CFFORM NAME=getPassword ACTION="#systemURL#/program/getPassword.cfm">
	<FONT SIZE=5 TYPE=Arial><B>Retrieve your password</B></FONT><BR>
	<DD>Complete the form below. If your information is correct, your password will be emailed to you.<P>
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
	<CFIF ListFind(getPasswordFields,"email")>
		<TR><TD ALIGN=right><FONT FACE=Arial>Email: </FONT></TD>
		<TD><CFINPUT TYPE=text NAME=email SIZE=20 REQUIRED=Yes MESSAGE="You must enter your email address"></TD></TR>
	</CFIF>
	<CFIF ListFind(getPasswordFields,"username")>
		<TR><TD ALIGN=right><FONT FACE=Arial>Username: </FONT></TD>
		<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED=Yes MESSAGE="You must enter your username"></TD></TR>
	</CFIF>
	<CFIF ListFind(getPasswordFields,"mothersMaidenName")>
		<TR><TD ALIGN=right><FONT FACE=Arial>Mother's Maiden Name: </FONT></TD>
		<TD><CFINPUT TYPE=text NAME=mothersMaidenName SIZE=20 REQUIRED=Yes MESSAGE="You must enter your username"></TD></TR>
	</CFIF>
	<TR><TD ALIGN=right></TD><TD><INPUT TYPE=submit VALUE="Get Password"></TD></TR>
	</TABLE>
	</CFFORM>
</CFIF>

<CFINCLUDE TEMPLATE="iconOptions.cfm">
<CFIF iconKeyDisplayOnHelpPage EQ 1>
	<P><HR NOSHADE WIDTH=500 SIZE=3 ALIGN=left><P>
	<DT><A NAME=icon></A><FONT SIZE=5 TYPE=Arial><B>Icon Key</B></FONT>
	<DD><CFOUTPUT><IMG SRC="#systemURL#/images/iconkey.gif"></CFOUTPUT><P>
</CFIF>

<CFINCLUDE TEMPLATE="emailOtherUserOptions.cfm">
<CFIF emailOtherUser EQ 1>
	<P><HR NOSHADE WIDTH=500 SIZE=3 ALIGN=left><P>
	<CFFORM ACTION="#systemURL#/program/email.cfm" NAME=email>
	<DT><A NAME=email></A><FONT SIZE=5 TYPE=Arial><B>Email another registered user</B></FONT>
	<DD><TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
	<TR><TD ALIGN=right>Recipient Username: </TD>
		<TD><CFINPUT TYPE=text NAME=recipientUsername SIZE=20 REQUIRED=Yes MESSAGE="You must enter the username of the recipient"></TD></TR>
	<TR><TD ALIGN=right>Your username: </TD>
		<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED=Yes MESSAGE="You must enter your username"></TD></TR>
	<TR><TD ALIGN=right>Your Password: </TD>
		<TD><CFINPUT TYPE=password NAME=password SIZE=20 REQUIRED=Yes MESSAGE="You must enter your password"></TD></TR>
	<CFIF emailOtherUserCCSender EQ 1>
		<TR><TD ALIGN=right></TD>
		<TD><INPUT TYPE=checkbox NAME=CCSender VALUE=1> Check to send a copy of this email to yourself</TD></TR>
	</CFIF>
	<TR><TD ALIGN=right VALIGN=top>Message: </TD>
		<TD><TEXTAREA NAME=message ROWS=8 COLS=55 WRAP=virtual></TEXTAREA></TD></TR>
	<TR><TD ALIGN=right></TD><TD><INPUT TYPE=submit VALUE="Send Email"></TD></TR>
	</TABLE>
	</CFFORM>
</CFIF>

<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
	<P><HR NOSHADE WIDTH=500 SIZE=3 ALIGN=left><P>
	<CFFORM NAME=editUser ACTION="#systemURL#/feedback/feedback.cfm">
	<DT><A NAME=feedback></A><FONT SIZE=5 TYPE=Arial><B>Leave feedback about a user</B></FONT>
	<DD><FONT FACE=Arial>Username: </FONT> <INPUT TYPE=text NAME=username SIZE=20> <INPUT TYPE=submit VALUE=" go ">
	</CFFORM>

	<DT><CFFORM NAME=editUser ACTION="#systemURL#/seller/sellerHome.cfm">
	<FONT SIZE=5 TYPE=Arial><A HREF=sellerHome></A><B>View all lots by a seller</B></FONT>
	<DD><FONT FACE=Arial>Username: </FONT> <INPUT TYPE=text NAME=username SIZE=20> <INPUT TYPE=submit VALUE=" go ">
	</CFFORM>
</CFIF>
</DL>
<P>
<BR><P>