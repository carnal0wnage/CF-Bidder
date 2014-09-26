<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: User Agreement</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF Form.navigateLinks EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\navigateLinks.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET navigateLinks = #Replace(Form.navigateLinks, "
", "", "ALL")#>
		<CFFILE ACTION=Write FILE="#systemPath#\system\navigateLinks.cfm" OUTPUT="#navigateLinks#">
	</CFIF>

	<CFIF Form.navigate EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\navigate.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET navigate = #Replace(Form.navigate, "
", "", "ALL")#>
		<CFFILE ACTION=Write FILE="#systemPath#\system\navigate.cfm" OUTPUT="#navigate#">
	</CFIF>

	<H3>Navigation bar updated.</H3>
	<HR NOSHADE SIZE=3 WIDTH=500 ALIGN=left>
</CFIF>

<H1><FONT COLOR=purple>Navigation Bar</FONT></H1>

<FORM METHOD=post ACTION=navigation.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<B><FONT SIZE=4>Navigation Links:</FONT></B><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\navigateLinks.cfm" VARIABLE="navigateLinks">
<CFSET navigateLinks = RTrim(navigateLinks)>
<TEXTAREA NAME=navigateLinks ROWS=15 COLS=70><CFOUTPUT>#navigateLinks#</CFOUTPUT></TEXTAREA>

<P>

<B><FONT SIZE=4>Title, Navigation Bar</FONT></B><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\navigate.cfm" VARIABLE="navigate">
<CFSET navigate = RTrim(navigate)>
<TEXTAREA NAME=navigate ROWS=15 COLS=70><CFOUTPUT>#navigate#</CFOUTPUT></TEXTAREA>

<UL><INPUT TYPE=submit VALUE="Update Navigation Bar"></UL>
</FORM>

</body>
</html>
