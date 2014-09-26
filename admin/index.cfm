<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFIF IsDefined("Form.first")>
	<CFQUERY NAME=getMasterInfo DATASOURCE="#EAdatasource#">
		SELECT password
		FROM Member
		WHERE userID = 1
			AND username = '#Form.username#'
	</CFQUERY>

	<CFIF getMasterInfo.RecordCount NEQ 1>
		<H3>This is not your beautiful house.<P>
		You do not have admin permission to Emaze Auction.<P>
		Kindly vacate the premises.</H3>
	<CFELSEIF Form.password EQ Decrypt(getMasterInfo.password,encryptionCode)>
		<CFCOOKIE NAME="EmazeAuction_master" VALUE=0>
		<HTML>
		<HEAD>
		<TITLE>Emaze Auction: Admin Screens</TITLE>
		<!-- frames -->
		<FRAMESET  COLS="110,*" BORDER=0 FRAMEBORDER=0 FRAMESPACING=0>
			<FRAME NAME="toc" SRC="toc.cfm" MARGINWIDTH="10" MARGINHEIGHT="10" SCROLLING="auto" FRAMEBORDER="no" NORESIZE>
			<FRAME NAME="content" SRC="main.cfm" MARGINWIDTH="10" MARGINHEIGHT="10" SCROLLING="auto" FRAMEBORDER="no" NORESIZE>
		</FRAMESET>
		</HEAD>
		</HTML>
	<CFELSE>
		<H3>This is not your beautiful house.<P>
		You do not have admin permission to Emaze Auction.<P>
		Kindly vacate the premises.</H3>
	</CFIF>
<CFELSE>
<HTML>
<HEAD>
<TITLE>Emaze Auction: Admin Login</TITLE>
</HEAD>

<BODY BGCOLOR=white>

<CFOUTPUT><CENTER><IMG SRC="#systemURL#/images/emazelogo.gif"></CENTER></CFOUTPUT>
<H1 ALIGN=center><FONT COLOR=purple>Emaze Auction Admin Screens</FONT></H1>

<FORM METHOD=post ACTION="index.cfm">
<INPUT TYPE=hidden NAME=first VALUE=1>
<CENTER><TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD ALIGN=right>Username: </TD>
<TD><INPUT TYPE=text NAME=username SIZE=20></TD></TR>
<TR><TD ALIGN=right>Password: </TD>
<TD><INPUT TYPE=password NAME=password SIZE=20></TD></TR>
<TR><TD></TD><TD><INPUT TYPE=submit VALUE="Log In"></TD></TR>
</TABLE></CENTER>
</FORM>

<CFOUTPUT><CENTER><IMG SRC="#systemURL#/images/emazeauction.gif"></CENTER></CFOUTPUT>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>
</CFIF>