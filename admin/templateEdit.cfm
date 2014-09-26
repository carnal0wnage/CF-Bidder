<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Edit Templates</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFQUERY NAME=getTemplate DATASOURCE="#EAdatasource#">
	SELECT templateName
	FROM Template
	WHERE templateFile = '#templateFile#'
</CFQUERY>

<CFIF IsDefined("Form.first")>
	<CFIF NOT DirectoryExists("#systemPath#\template\backup")>
		<CFDIRECTORY ACTION=Create DIRECTORY="#systemPath#\template\backup">
		<CFSET backupDirectoryCreated = 1>
	</CFIF>
	<CFSET backupTemplateFile = Replace(Form.templateFile, ".cfm", "_#LSDateFormat(Now(),'yyyymmdd')#_#LSTimeFormat(Now(),'HHmmss')#.cfm", "ONE")>
	<CFFILE ACTION=Rename SOURCE="#systemPath#\template\#Form.templateFile#"
		DESTINATION="#systemPath#\template\backup\#backupTemplateFile#">

	<CFIF Form.templateEdit EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\template\#Form.templateFile#" OUTPUT=" ">
	<CFELSE>
		<CFSET templateEdit = Replace(Form.templateEdit, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\template\#templateFile#" OUTPUT="#templateEdit#">
	</CFIF>

	<H3>Template <CFOUTPUT><I>#getTemplate.templateName#</I></CFOUTPUT> updated.</H3>
	<CFOUTPUT>#systemPath#\template\#templateFile#</CFOUTPUT><BR>
	A backup of the original template has been made and stored as the following:<BR>
	<CFOUTPUT>#systemPath#\template\backup\#backupTemplateFile#</CFOUTPUT>
	<CFIF IsDefined("backupDirectoryCreated")><P>The template/backup directory did not previously exist. It was automatically created.</CFIF>

	<P><HR NOSHADE COLOR=purple ALIGN=left SIZE=3 WIDTH=500><P>
	<CFINCLUDE TEMPLATE="templateHome.cfm">
	<CFABORT>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Edit Template</B></FONT>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0><TR>
<TD VALIGN=top><FONT SIZE=4><B>Template - </B></FONT></TD>
<TD><FONT SIZE=4><B><CFOUTPUT>#getTemplate.templateName#<BR>#templateFile#</CFOUTPUT></B></FONT></TD>
</TR></TABLE>

<CFIF NOT FileExists("#systemPath#\template\#templateFile#")>
	<FONT SIZE=4 COLOR=purple><CFOUTPUT>#templateFile# does not exist in the template directory:<P>
	#systemPath#\template</CFOUTPUT></FONT>
<CFELSE>
	<FORM METHOD=post ACTION=templateEdit.cfm>
	<INPUT TYPE=hidden NAME=first VALUE=1>
	<CFOUTPUT><INPUT TYPE=hidden NAME=templateFile VALUE="#templateFile#"></CFOUTPUT>

	<CFFILE ACTION=Read FILE="#systemPath#\template\#templateFile#" VARIABLE="templateEdit">
	<CFSET templateEdit = #RTrim(templateEdit)#>
	<TEXTAREA NAME=templateEdit COLS=75 ROWS=25 WRAP=off><CFOUTPUT>#templateEdit#</CFOUTPUT></TEXTAREA>
	<P>
	<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit NAME=edit VALUE="Edit Template">
	</FORM>
</CFIF>

</BODY>
</HTML>
