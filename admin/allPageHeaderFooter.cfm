<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Headers / Footer</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFSET helpContext = "headers">

<CFIF IsDefined("first")>
	<CFIF Form.pageHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\pageHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET pageHeader = Replace(Form.pageHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\pageHeader.cfm" OUTPUT="#pageHeader#">
	</CFIF>

	<CFIF Form.pageFooter EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\pageFooter.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET pageFooter = Replace(Form.pageFooter, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\pageFooter.cfm" OUTPUT="#pageFooter#">
	</CFIF>

	<H3>Headers and footer updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Header / Footer</B></FONT>
<P>
<CFFORM NAME=pageNotes ACTION=allPageHeaderFooter.cfm>
<INPUT TYPE=hidden NAME=first VALUE=0>

<DL>
<DT><B>Page Header</B> (above navigation bar on every page)
<CFFILE ACTION=Read FILE="#systemPath#\system\pageHeader.cfm" VARIABLE="pageHeader">
<CFSET pageHeader = RTrim(pageHeader)>
<DD><TEXTAREA NAME="pageHeader" COLS="60" ROWS="7" WRAP="virtual"><CFOUTPUT>#pageHeader#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Page Footer</B> (at bottom of every page)
<CFFILE ACTION=Read FILE="#systemPath#\system\pageFooter.cfm" VARIABLE="pageFooter">
<CFSET pageFooter = RTrim(pageFooter)>
<DD><TEXTAREA NAME="pageFooter" COLS="60" ROWS="7" WRAP="virtual"><CFOUTPUT>#pageFooter#</CFOUTPUT></TEXTAREA>
<BR>
<BR>

<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit NAME=edit VALUE="Edit Header / Footer">
</DL>

</CFFORM>
</BODY>
</HTML>