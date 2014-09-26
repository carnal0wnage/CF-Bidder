<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("lotID")>
	<HTML>
	<HEAD><TITLE>Emaze Auction: User Manager</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
</CFIF>

<CFQUERY NAME=getUsers DATASOURCE="#EAdatasource#">
	SELECT userID, username, lastName, firstName
	FROM Member
	WHERE userID > 1
	ORDER BY userID
</CFQUERY>

<FORM METHOD=post ACTION=userEdit.cfm>
<INPUT TYPE=hidden NAME=fromUserChoose VALUE=1>
<CFIF IsDefined("lotID")>
	<CFOUTPUT><INPUT TYPE=hidden NAME=lotID VALUE=#lotID#></CFOUTPUT>
</CFIF>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=3>
<TH COLSPAN=3 BGCOLOR="#CDCDCD">User Manager</TH>
<TR>
<TH><FONT SIZE=-1>User ID</FONT></TH>
<TH>Username</TH>

<CFIF getUsers.RecordCount LT 100><!--- Less than 100 users --->
	<TH>Name (last, first)</TH></TR>
	<TR>
	<TD ALIGN=center><SELECT NAME="userID" SIZE="10" MULTIPLE>
	<CFOUTPUT QUERY=getUsers><OPTION VALUE=#userID#>#userID#</CFOUTPUT>
	</SELECT></TD>

	<CFQUERY NAME=getUsers-username DATASOURCE="#EAdatasource#">
		SELECT userID, username, lastName, firstName
		FROM Member
		WHERE userID > 1
		ORDER BY username
	</CFQUERY>
	<TD ALIGN=center><SELECT NAME="username" SIZE="10" MULTIPLE>
	<CFOUTPUT QUERY=getUsers-username><OPTION VALUE=#userID#>#username#</CFOUTPUT>
	</SELECT></TD>
	
	<CFQUERY NAME=getUsers-name DATASOURCE="#EAdatasource#">
		SELECT userID, username, lastName, firstName
		FROM Member
		WHERE userID > 1
		ORDER BY lastName, firstName
	</CFQUERY>
	<TD ALIGN=center><SELECT NAME="name" SIZE="10" MULTIPLE>
	<CFOUTPUT QUERY=getUsers-name>
		<CFIF lastName NEQ " " AND lastName NEQ "" AND firstName NEQ " " AND firstName NEQ "">
			<OPTION VALUE=#userID#>#lastName#, #firstName#
		<CFELSEIF lastName NEQ " " AND lastName NEQ ""><OPTION VALUE=#userID#>#lastName#
		<CFELSEIF firstName NEQ " " AND firstName NEQ ""><OPTION VALUE=#userID#>#firstName#
		</CFIF>
	</CFOUTPUT>
	</SELECT></TD></TR>

	<TR><TD COLSPAN=3>Order users by:<BR>
	<TABLE><TR>
	<TD><INPUT TYPE=radio NAME=orderUser VALUE=lastName CHECKED> Last name<BR>
	<INPUT TYPE=radio NAME=orderUser VALUE=firstName> First name</TD>
	<TD><INPUT TYPE=radio NAME=orderUser VALUE=username> Username<BR>
	<INPUT TYPE=radio NAME=orderUser VALUE=userID> User ID</TD>
	</TR></TABLE></TD></TR>

	<TR><TD COLSPAN=3 HEIGHT=40 VALIGN=center ALIGN=center>
	<INPUT TYPE=reset VALUE=Clear> 
	<CFIF IsDefined("lotID")><INPUT TYPE=submit NAME=button VALUE="Add Users">
		<CFELSE><INPUT TYPE=submit NAME=button VALUE="Edit Users"></CFIF>
	</TD></TR>

<CFELSE><!--- More than 100 users --->

	<TH>Last Name</TH></TR>
	<TR>
	<TD ALIGN=center><SELECT NAME="userIDrange" SIZE="10" MULTIPLE>
	<OPTION VALUE="1,99">1-99
	<CFSET numOptions = ((ListLast(ValueList(getUsers.userID)) - 1) \ 100) - 1>
	<CFLOOP INDEX="counter" FROM="1" TO="#numOptions#">
		<CFOUTPUT><OPTION VALUE="#counter#00,#counter#99">#counter#00-#counter#99</CFOUTPUT>
	</CFLOOP>
	<CFSET counter = numOptions + 1>
	<CFSET last = ListLast(ValueList(getUsers.userID)) - 1>
	<CFOUTPUT><OPTION VALUE="#counter#00,#last#">#counter#00-#last#</CFOUTPUT>
	</SELECT></TD>

	<TD ALIGN=center><SELECT NAME="usernameRange" SIZE="10" MULTIPLE>
	<OPTION VALUE=a>A<OPTION VALUE=b>B<OPTION VALUE=c>C<OPTION VALUE=d>D
	<OPTION VALUE=e>E<OPTION VALUE=f>F<OPTION VALUE=g>G<OPTION VALUE=h>H
	<OPTION VALUE=i>I<OPTION VALUE=j>J<OPTION VALUE=k>K<OPTION VALUE=l>L
	<OPTION VALUE=m>M<OPTION VALUE=n>N<OPTION VALUE=o>O<OPTION VALUE=p>P
	<OPTION VALUE=q>Q<OPTION VALUE=r>R<OPTION VALUE=s>S<OPTION VALUE=t>T
	<OPTION VALUE=u>U<OPTION VALUE=v>V<OPTION VALUE=w>W<OPTION VALUE=x>X
	<OPTION VALUE=y>Y<OPTION VALUE=z>Z<OPTION VALUE=0>0<OPTION VALUE=1>1
	<OPTION VALUE=2>2<OPTION VALUE=3>3<OPTION VALUE=4>4<OPTION VALUE=5>5
	<OPTION VALUE=6>6<OPTION VALUE=7>7<OPTION VALUE=8>8<OPTION VALUE=9>9
	</SELECT></TD>
	<TD ALIGN=center><SELECT NAME="lastNameRange" SIZE="10" MULTIPLE>
	<OPTION VALUE=a>A<OPTION VALUE=b>B<OPTION VALUE=c>C
	<OPTION VALUE=d>D<OPTION VALUE=e>E<OPTION VALUE=f>F<OPTION VALUE=g>G
	<OPTION VALUE=h>H<OPTION VALUE=i>I<OPTION VALUE=j>J<OPTION VALUE=k>K
	<OPTION VALUE=l>L<OPTION VALUE=m>M<OPTION VALUE=n>N<OPTION VALUE=o>O
	<OPTION VALUE=p>P<OPTION VALUE=q>Q<OPTION VALUE=r>R<OPTION VALUE=s>S
	<OPTION VALUE=t>T<OPTION VALUE=u>U<OPTION VALUE=v>V<OPTION VALUE=w>W
	<OPTION VALUE=x>X<OPTION VALUE=y>Y<OPTION VALUE=z>Z
	</SELECT></TD></TR>

	<TR><TD COLSPAN=3>Order users by:<BR>
	<TABLE><TR>
	<TD><INPUT TYPE=radio NAME=orderUser VALUE=lastName CHECKED> Last name<BR>
	<INPUT TYPE=radio NAME=orderUser VALUE=firstName> First name</TD>
	<TD><INPUT TYPE=radio NAME=orderUser VALUE=username> Username<BR>
	<INPUT TYPE=radio NAME=orderUser VALUE=userID> User ID</TD>
	</TR></TABLE></TD></TR>

	<TR><TD COLSPAN=3 HEIGHT=40 VALIGN=center ALIGN=center>
	<INPUT TYPE=reset VALUE=Clear> 
	<CFIF IsDefined("lotID")><INPUT TYPE=submit NAME=button VALUE="List Users">
		<CFELSE><INPUT TYPE=submit NAME=button VALUE="List Users"></CFIF>
	</TD></TR>
</CFIF>

</TABLE>

<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=3>
<TR><TD COLSPAN=2>Search for user(s):<BR>
&nbsp; &nbsp; <INPUT TYPE=text SIZE=20 NAME=userInfo> <INPUT TYPE=submit NAME=button VALUE="Search"></TD></TR>

<TR BGCOLOR="#CDCDCD">
<TD HEIGHT=35 VALIGN=bottom ALIGN=center>Search by Field: </TD>
<TD VALIGN=bottom ALIGN=center>Order by Field: </TD>
</TR>

<TR>
<TD ALIGN=center><TABLE><TR><TD>
<INPUT TYPE=radio NAME=searchUser VALUE=lastName CHECKED> Last name<BR>
<INPUT TYPE=radio NAME=searchUser VALUE=firstName> First name<BR>
<INPUT TYPE=radio NAME=searchUser VALUE=organization> Organization<BR>
<INPUT TYPE=radio NAME=searchUser VALUE=username> Username<BR>
<INPUT TYPE=radio NAME=searchUser VALUE=email> Email
</TD></TR></TABLE></TD>
<TD ALIGN=center><TABLE><TR><TD>
<INPUT TYPE=radio NAME=orderSearch VALUE=lastName CHECKED> Last name<BR>
<INPUT TYPE=radio NAME=orderSearch VALUE=firstName> First name<BR>
<INPUT TYPE=radio NAME=orderSearch VALUE=organization> Organization<BR>
<INPUT TYPE=radio NAME=orderSearch VALUE=username> Username<BR>
<INPUT TYPE=radio NAME=orderSearch VALUE=userID> User ID
</TD></TR></TABLE></TD>
</TR>

</TABLE>

</FORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>