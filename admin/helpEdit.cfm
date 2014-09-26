<!--- Emaze Auction version 2.1, 1.01 / Monday, June 14, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Help Page</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("first")>
	<CFIF Form.helpPage EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\helpPage.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET helpPage = Replace(Form.helpPage, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\helpPage.cfm" OUTPUT="#helpPage#">
	</CFIF>

	<H3>Help page updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Help Page</B></FONT>
<P>
<CFFORM NAME=helpPage ACTION=helpEdit.cfm>
<INPUT TYPE=hidden NAME=first VALUE=0>

<CFFILE ACTION=Read FILE="#systemPath#\system\helpPage.cfm" VARIABLE="helpPage">
<CFSET helpPage = RTrim(helpPage)>
<CFSET helpPage = Replace(helpPage, "<", "&lt;", "ALL")>
<CFSET helpPage = Replace(helpPage, ">", "&gt;", "ALL")>
<TEXTAREA NAME="helpPage" COLS="70" ROWS="20"><CFOUTPUT>#helpPage#</CFOUTPUT></TEXTAREA>
<BR>

<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit VALUE="Edit Help Page">
</DL>

</CFFORM>
</BODY>
</HTML>