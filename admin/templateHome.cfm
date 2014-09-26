<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("noHeader")>
	<HTML>
	<HEAD><TITLE>Emaze Auction: Templates</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
	
	<FONT SIZE=6 COLOR=purple><B>Templates</B></FONT>
</CFIF>

<P>Adding templates is similar to adding data sources to Cold Fusion. There are 4 steps:
<OL>
<LI>Create the template and place it in the <I>EmazeAuction/template/</I> directory. If the template is not already on the server, you will be given the option of uploading it directly.
<LI>Choose a name for the template and enter the filename. The file must end with &quot;.cfm&quot; .
<LI>Specify whether the template is for the auction home page, category home page, or lot page.
<LI>Edit the category, lot and/or system to use that template.
</OL>

<P>

<FORM METHOD=post ACTION=template.cfm>

<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=3>
<TH BGCOLOR="#20A491">Del</TH>
<TH BGCOLOR="#20A491">Name</TH>
<TH BGCOLOR="#20A491">File Name</TH>
<TH BGCOLOR="#20A491">Type</TH>
<TH BGCOLOR="#20A491"><FONT SIZE=2>Edit Name,<BR>File name</FONT></TH>
<TH BGCOLOR="#20A491"><FONT SIZE=2>Edit<BR>File</FONT></TH>

<TR>
<TD>&nbsp;</TD>
<TD><INPUT TYPE=text NAME=templateName SIZE=20></TD>
<TD><INPUT TYPE=text NAME=templateFile SIZE=20 VALUE=".cfm"></TD>
<TD><SELECT NAME=templateType SIZE=1>
	<OPTION VALUE="category">category
	<OPTION VALUE="classified">classified
	<OPTION VALUE="homepage">homepage
	<OPTION VALUE="lot" SELECTED>lot
	<OPTION VALUE="reverse">reverse
</SELECT></TD>
<TD VALIGN=top COLSPAN=2><INPUT TYPE=submit NAME=templateSubmit VALUE="Create"></TD>
</TR>

<CFQUERY NAME=getTemplates DATASOURCE="#EAdatasource#">
	SELECT *
	FROM Template
	ORDER BY templateName
</CFQUERY>

<CFQUERY NAME=checkCategoryTemplates DATASOURCE="#EAdatasource#">
	SELECT templateFile FROM Category GROUP BY templateFile
</CFQUERY>
<CFQUERY NAME=checkLotTemplates DATASOURCE="#EAdatasource#">
	SELECT templateFile FROM Lot GROUP BY templateFile
</CFQUERY>

<CFSET rowBG = 0>
<CFOUTPUT QUERY=getTemplates>
	<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
		<CFELSE><TR BGCOLOR="##CDCDCD"><CFSET rowBG = 0></CFIF>

	<CFIF (getTemplates.templateType EQ "homepage" AND getTemplates.templateFile NEQ indexTemplate)
			OR (getTemplates.templateType EQ "category"
				AND ListContains(ValueList(checkCategoryTemplates.templateFile),getTemplates.templateFile) EQ 0)
			OR (getTemplates.templateType EQ "lot"
				AND ListContains(ValueList(checkLotTemplates.templateFile),getTemplates.templateFile) EQ 0)>
		<TD ALIGN=center><INPUT TYPE=checkbox NAME=template VALUE="#getTemplates.templateFile#"></TD>
	<CFELSE>
		<TD ALIGN=center>-</TD>
	</CFIF>

	<TD>#getTemplates.templateName#</TD>
	<TD>#getTemplates.templateFile#</TD>
	<TD>#getTemplates.templateType#</TD>
	<TD><FONT SIZE=2><A HREF="template.cfm?templateFile=#getTemplates.templateFile#">Name/File</A></FONT></TD>
	<TD><FONT SIZE=2><A HREF="templateEdit.cfm?templateFile=#getTemplates.templateFile#">Edit</A></FONT></TD>
	</TR>
</CFOUTPUT>
</TABLE>
<P>
<INPUT TYPE=submit NAME=templateSubmit VALUE="Delete Template(s)"><BR>
<INPUT TYPE=checkbox NAME=okDelete VALUE=1> Must be checked to delete templates <FONT SIZE=2>(avoids accidently deleting templates)</FONT><BR>
<INPUT TYPE=checkbox NAME=okDeleteFiles VALUE=1> Check here to have Emaze Auction actually delete these files from the server<BR>
&nbsp; &nbsp; &nbsp; <FONT SIZE=2>(It will only delete those files which still exist.)</FONT>
</FORM>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>