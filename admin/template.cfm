<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Templates</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<FONT SIZE=6 COLOR=purple><B>Templates</B></FONT>

<CFIF NOT IsDefined("Form.templateSubmit")>
	<CFQUERY NAME=getTemplate DATASOURCE="#EAdatasource#">
		SELECT templateName, templateType
		FROM Template
		WHERE templateFile = '#templateFile#'
	</CFQUERY>
	<CFFORM ACTION=template.cfm NAME=template>
	<CFOUTPUT>
		<INPUT TYPE=hidden NAME=oldTemplateFile VALUE="#templateFile#">
		<INPUT TYPE=hidden NAME=oldTemplateName VALUE="#getTemplate.templateName#">
		<INPUT TYPE=hidden NAME=oldTemplateType VALUE="#getTemplate.templateType#">
	</CFOUTPUT>
	<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
	<TR><TD ALIGN=right>Name: </TD>
		<TD><CFINPUT TYPE=text NAME=templateName SIZE=40 REQUIRED="Yes" MESSAGE="Template name cannot be empty" VALUE="#getTemplate.templateName#"></TD></TR>
	<TR><TD ALIGN=right>File: </TD>
		<TD><CFINPUT TYPE=text NAME=templateFile SIZE=40 VALUE="#templateFile#" REQUIRED="Yes" MESSAGE="Template file cannot be empty"></TD></TR>
	<TR><TD ALIGN=right VALIGN=top>Type: </TD>
		<TD><CFOUTPUT>#getTemplate.templateType#</CFOUTPUT></TD></TR>
	<TR><TD></TD><TD><INPUT TYPE=submit NAME="templateSubmit" VALUE="Edit Template"></TD></TR>
	</TABLE>
	</CFFORM>
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF Form.templateSubmit EQ "Edit Template">
	<CFIF Form.templateName NEQ Form.oldTemplateName>
		<CFQUERY NAME=checkTemplateName DATASOURCE="#EAdatasource#">
			SELECT templateName FROM Template
			WHERE templateName = '#Form.templateName#'
		</CFQUERY>
		<CFIF checkTemplateName.RecordCount GT 0>
			<CFSET badName = 1>
			<H3>Template name, <CFOUTPUT><I>#Form.templateName#</I></CFOUTPUT>, is already being used. Please choose another name.</H3>
		</CFIF>
	</CFIF>
	<CFIF Form.templateFile NEQ Form.oldTemplateFile>
		<CFQUERY NAME=checkTemplateFile DATASOURCE="#EAdatasource#">
			SELECT templateFile FROM Template
			WHERE templateFile = '#Form.templateFile#'
		</CFQUERY>
		<CFIF checkTemplateFile.RecordCount GT 0>
			<CFSET badFile = 1>
			<H3>Template name, <CFOUTPUT><I>#Form.templateFile#</I></CFOUTPUT>, is already being used. Please choose another filename.</H3>
		</CFIF>
	</CFIF>

	<CFIF IsDefined("badName") OR IsDefined("badFile")>
		<CFFORM ACTION=template.cfm NAME=template>
		<CFOUTPUT>
			<INPUT TYPE=hidden NAME=oldTemplateFile VALUE="#Form.oldTemplateFile#">
			<INPUT TYPE=hidden NAME=oldTemplateName VALUE="#Form.oldTemplateName#">
			<INPUT TYPE=hidden NAME=oldTemplateType VALUE="#Form.oldTemplateType#">
		</CFOUTPUT>
		<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
		<TR><TD ALIGN=right>Name: </TD>
		<CFIF IsDefined("badName")>
			<TD><CFINPUT TYPE=text NAME=templateName SIZE=40 REQUIRED="Yes" MESSAGE="Template name cannot be empty" VALUE="#Form.oldTemplateName#"></TD></TR>
		<CFELSE>
			<TD><CFINPUT TYPE=text NAME=templateName SIZE=40 REQUIRED="Yes" MESSAGE="Template name cannot be empty" VALUE="#Form.templateName#"></TD></TR>
		</CFIF>
		<TR><TD ALIGN=right>File: </TD>
		<CFIF IsDefined("badFile")>
			<TD><CFINPUT TYPE=text NAME=templateFile SIZE=40 REQUIRED="Yes" MESSAGE="Template file cannot be empty" VALUE="#Form.oldTemplateFile#"></TD></TR>
		<CFELSE>
			<TD><CFINPUT TYPE=text NAME=templateFile SIZE=40 REQUIRED="Yes" MESSAGE="Template file cannot be empty" VALUE="#Form.templateFile#"></TD></TR>
		</CFIF>
		<TR><TD ALIGN=right>Type: </TD>
			<TD><CFOUTPUT>#Form.oldTemplateType#</CFOUTPUT></TD></TR>
		<TR><TD></TD><TD><INPUT TYPE=submit NAME="templateSubmit" VALUE="Edit Template"></TD></TR>
		</TABLE>
		</CFFORM>
		<CFINCLUDE TEMPLATE="../program/copyright.cfm">
		</BODY></HTML><CFABORT>
	<CFELSE>
		<CFQUERY NAME=updateTemplate DATASOURCE="#EAdatasource#">
			UPDATE Template
			SET templateName = '#Form.templateName#',
				templateFile = '#Form.templateFile#'
			WHERE templateFile = '#Form.oldTemplateFile#'
		</CFQUERY>

		<CFIF Form.templateFile NEQ Form.oldTemplateFile AND Form.oldTemplateType EQ "category">
			<CFQUERY NAME=updateTemplate DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET templateFile = '#Form.templateFile#'
				WHERE templateFile = '#Form.oldTemplateFile#'
			</CFQUERY>
			<CFQUERY NAME=getCategories DATASOURCE="#EAdatasource#">
				SELECT categoryID FROM Category WHERE templateFile = '#Form.oldTemplateFile#'
			</CFQUERY>
			<CFLOOP QUERY="getCategories">
				<CFFILE ACTION=Append FILE="#systemPath#\category\#getCategories.categoryID#CategoryInfo.cfm"
					OUTPUT="<CFSET templateFile = ""#Form.templateFile#"">">
			</CFLOOP>
		<CFELSEIF Form.templateFile NEQ Form.oldTemplateFile AND Form.oldTemplateType EQ "lot">
			<CFQUERY NAME=updateTemplate DATASOURCE="#EAdatasource#">
				UPDATE Lot
				SET templateFile = '#Form.templateFile#'
				WHERE templateFile = '#Form.oldTemplateFile#'
			</CFQUERY>
			<CFQUERY NAME=getLots DATASOURCE="#EAdatasource#">
				SELECT lotID FROM Lot WHERE templateFile = '#Form.templateFile#'
			</CFQUERY>
			<CFLOOP QUERY="getLots">
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#getLots.lotID#LotInfo.cfm"
					OUTPUT="<CFSET templateFile = ""#Form.templateFile#"">">
			</CFLOOP>
		<CFELSEIF Form.templateFile NEQ Form.oldTemplateFile AND Form.oldTemplateType EQ "homepage">
			<CFIF indexTemplate EQ Form.oldTemplateFile>
				<CFFILE ACTION=Append FILE="#systemPath#\Application.cfm"
					OUTPUT="<CFSET indexTemplate = ""#Form.templateFile#"">">
				<CFSET indexTemplate = Form.templateFile>
			</CFIF>
		</CFIF>

		<H3>Template <CFOUTPUT>#Form.templateName#</CFOUTPUT> updated.</H3>

		<!---
		not old, new: all is well
		old, not new: old exists, but not new. rename old to new?
		old and new: both exist. delete old?
		not old, not new: neither exists. upload now?
		--->
		<CFIF Form.templateFile NEQ Form.oldTemplateFile>
			<CFIF FileExists("#systemPath#\template\#Form.oldTemplateFile#") EQ "NO"
					AND FileExists("#systemPath#\template\#Form.templateFile#") EQ "YES">
				Just wanted to let you know that the new template file exists and the old template file does not. Perfect!
			<CFELSEIF FileExists("#systemPath#\template\#Form.oldTemplateFile#") EQ "YES"
					AND FileExists("#systemPath#\template\#Form.templateFile#") EQ "NO">
				The old template file exists, but not the new one. To rename the old file to the new name, click the <I>Rename</I> button below.
				Otherwise, be sure to rename the file (or upload a file with the new name) before using this template.
				<P>
				<FORM METHOD=post ACTION=template.cfm>
				<CFOUTPUT>
					<INPUT TYPE=hidden NAME=oldTemplateFile VALUE="#Form.oldTemplateFile#">
					<INPUT TYPE=hidden NAME=templateFile VALUE="#Form.templateFile#">
				</CFOUTPUT>
				<INPUT TYPE=submit NAME="templateSubmit" VALUE="Rename Template">
				</FORM>
				<CFINCLUDE TEMPLATE="../program/copyright.cfm">
				</BODY></HTML>
				<CFABORT>
			<CFELSEIF FileExists("#systemPath#\template\#Form.oldTemplateFile#") EQ "YES"
					AND FileExists("#systemPath#\template\#Form.templateFile#") EQ "YES">
				Both the old and new template files exist. To delete the old template file, click the <I>Delete</I> button below.
				Otherwise, you may delete the template file at any time.
				<P>
				<FORM METHOD=post ACTION=template.cfm>
				<CFOUTPUT><INPUT TYPE=hidden NAME=templateFile VALUE="#Form.oldTemplateFile#"></CFOUTPUT>
				<CFOUTPUT><INPUT TYPE=submit NAME="templateSubmit" VALUE="Delete Old Template"></CFOUTPUT>
				</FORM>
				<CFINCLUDE TEMPLATE="../program/copyright.cfm">
				</BODY></HTML>
				<CFABORT>
			<CFELSEIF FileExists("#systemPath#\template\#Form.oldTemplateFile#") EQ "NO"
					AND FileExists("#systemPath#\template\#Form.templateFile#") EQ "NO">
				Neither the old nor the new template file exists on the server.
				To upload the new template file, use the form below. Otherwise, be sure to place the template file in the
				following directory: <I><CFOUTPUT>#systemPath#\template\</CFOUTPUT></I>.
				<P>
				<FORM METHOD=post ENCTYPE="multipart/form-data" ACTION="template.cfm">
				<CFOUTPUT><INPUT TYPE=hidden NAME=templateFile VALUE="#Form.templateFile#"></CFOUTPUT>
				<INPUT TYPE=file NAME=attachment SIZE=40><BR>
				<INPUT TYPE=submit NAME="templateSubmit" VALUE="Upload Template">
				</FORM>
				<CFINCLUDE TEMPLATE="../program/copyright.cfm">
				</BODY></HTML>
				<CFABORT>
			</CFIF>
		</CFIF>
	</CFIF>
<CFELSEIF Form.templateSubmit EQ "Delete Template(s)">
	<CFIF NOT IsDefined("Form.okDelete")>
		<H3>You did not check the checkbox to verify your delete request.</H3>
	<CFELSEIF NOT IsDefined("Form.template")>
		<H3>You did not select any templates to delete.</H3>
	<CFELSE>
		<CFSET templateCount = 2>
		<CFQUERY NAME=deleteTemplate DATASOURCE="#EAdatasource#">
			DELETE FROM Template
			WHERE templateFile = '#ListGetAt(Form.template,1)#'
			<CFLOOP INDEX="templateCount" LIST="#Form.template#">
				OR templateFile = '#templateCount#'
			</CFLOOP>
		</CFQUERY>
		<H3>Template(s) deleted from system.</H3>

		<CFIF IsDefined("Form.okDeleteFiles")>
			<CFSET templateCount = 1>
			<CFLOOP INDEX="templateCount" LIST="#Form.template#">
				<CFIF FileExists("#systemPath#\template\#templateCount#") EQ "YES">
					<CFFILE ACTION=Delete FILE="#systemPath#\template\#templateCount#">
					<B>Template file <CFOUTPUT><I>#templateCount#</I></CFOUTPUT> deleted from server.</B><BR>
				<CFELSE>
					<B>&nbsp; &nbsp; Template file <CFOUTPUT><I>#templateCount#</I></CFOUTPUT> does not exist.</B><BR>
				</CFIF>
			</CFLOOP>
		<CFELSE><H3>Template file(s) not actually deleted from server. You may delete them at any time.</H3>
		</CFIF>
	</CFIF>
<CFELSEIF Form.templateSubmit EQ "Create">
	<CFQUERY NAME=checkTemplateName DATASOURCE="#EAdatasource#">
		SELECT templateFile FROM Template WHERE templateName = '#Form.templateName#'
	</CFQUERY>
	<CFIF checkTemplateName.RecordCount GT 0>
		<H3>Template name, <CFOUTPUT><I>#Form.templateName#</I></CFOUTPUT>, is already being used. Please choose another.</H3>
		<CFSET badName = 1>
	</CFIF>

	<CFQUERY NAME=checkTemplateFile DATASOURCE="#EAdatasource#">
		SELECT templateFile FROM Template WHERE templateFile = '#Form.templateFile#'
	</CFQUERY>
	<CFIF checkTemplateFile.RecordCount GT 0>
		<H3>Template file, <CFOUTPUT><I>#Form.templateFile#</I></CFOUTPUT>, is already being used. Please choose another name.</H3>
		<CFSET badFile = 1>
	</CFIF>

	<CFIF IsDefined("badName") OR IsDefined("badFile")>
		<CFFORM ACTION=template.cfm NAME=template>
		<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
		<TR><TD ALIGN=right>Name: </TD>
		<CFIF IsDefined("badName")>
			<TD><CFINPUT TYPE=text NAME=templateName SIZE=20 REQUIRED="Yes" MESSAGE="Template name cannot be empty"></TD></TR>
		<CFELSE>
			<TD><CFINPUT TYPE=text NAME=templateName SIZE=20 VALUE="#Form.templateName#" REQUIRED="Yes" MESSAGE="Template name cannot be empty"></TD></TR>
		</CFIF>
		<TR><TD ALIGN=right>File: </TD>
		<CFIF IsDefined("badFile")>
			<TD><CFINPUT TYPE=text NAME=templateFile SIZE=20 VALUE=".cfm" REQUIRED="Yes" MESSAGE="Template file cannot be empty"></TD></TR>
		<CFELSE>
			<TD><CFINPUT TYPE=text NAME=templateFile SIZE=20 VALUE="#Form.templateFile#" REQUIRED="Yes" MESSAGE="Template file cannot be empty"></TD></TR>
		</CFIF>
		<TR><TD ALIGN=right VALIGN=top>Type: </TD>
			<TD><SELECT NAME=templateType SIZE=1>
		<OPTION VALUE="homepage"<CFIF Form.templateType EQ "homepage"> SELECTED</CFIF>>homepage
		<OPTION VALUE="category"<CFIF Form.templateType EQ "category"> SELECTED</CFIF>>category
		<OPTION VALUE="lot"<CFIF Form.templateType EQ "lot"> SELECTED</CFIF>>lot
		</SELECT></TD></TR>
		<TR><TD></TD>
			<TD><INPUT TYPE=submit NAME="templateSubmit" VALUE="Create"></TD></TR>
		</TABLE>
		</CFFORM>
		</BODY></HTML>
		<CFABORT>
	<CFELSE>
		<CFQUERY NAME=insertTemplate DATASOURCE="#EAdatasource#">
			INSERT INTO Template (templateName, templateFile, templateType)
			VALUES ('#Form.templateName#', '#Form.templateFile#', '#Form.templateType#')
		</CFQUERY>
		<H3>Template <CFOUTPUT>#Form.templateName#</CFOUTPUT> created.</H3>

		<CFIF FileExists("#systemPath#\template\#Form.templateFile#") EQ "YES">
			<P>Just wanted to let you know that the template file <CFOUTPUT>#Form.templateFile#</CFOUTPUT> already exists on the server.
			We assume you previously uploaded the template.<P>
		<CFELSE>
			<P>The template file <CFOUTPUT>#Form.templateFile#</CFOUTPUT> has not yet been uploaded to the server.
			<P>You may upload it now via the form below. Otherwise, be sure to place the template file in the following directory:
			<P><I><CFOUTPUT>#systemPath#\template\</CFOUTPUT></I><P>
			<FORM METHOD=post ENCTYPE="multipart/form-data" ACTION="template.cfm">
			<CFOUTPUT><INPUT TYPE=hidden NAME=templateFile VALUE="#Form.templateFile#"></CFOUTPUT>
			<INPUT TYPE=file NAME=attachment SIZE=40><BR>
			<INPUT TYPE=submit NAME="templateSubmit" VALUE="Upload Template">
			</FORM>
			<CFINCLUDE TEMPLATE="../program/copyright.cfm">
			</BODY></HTML>
			<CFABORT>
		</CFIF>
	</CFIF>
<CFELSEIF Form.templateSubmit EQ "Upload Template">
	<CFFILE ACTION=Upload FILEFIELD="attachment" DESTINATION="#systemPath#\template\">
	<CFIF File.ServerFile EQ Form.templateFile AND File.ServerFileExt EQ "cfm">
		<H3>Template file <CFOUTPUT><I>#File.ServerFile#</I></CFOUTPUT> uploaded successfully.</H3>
	<CFELSEIF File.ServerFile NEQ "#Form.templateFile#">
		<P>The uploaded template file, <CFOUTPUT><I>#File.ServerFile#</I></CFOUTPUT>, is not the same filename
		you specified when creating this template: <CFOUTPUT>#Form.templateFile#</CFOUTPUT>.
		The file has been uploaded, but will not work properly until the filename is changed.<P>
	<CFELSE><!--- File.ServerFileExt NEQ "cfm" --->
		<P>The uploaded template file, <CFOUTPUT><I>#File.ServerFile#</I></CFOUTPUT>, does not have the appropriate &quot;.cfm&quot; extension.
		<P>The file has been uploaded, but will not work properly until the extension is changed.<P>
	</CFIF>
<CFELSEIF Form.templateSubmit EQ "Rename Template">
	<CFFILE ACTION=Rename SOURCE="#systemPath#\template\#Form.oldTemplateFile#"
		DESTINATION="#systemPath#\template\#Form.templateFile#">
	<H3>Template file renamed.</H3>
<CFELSEIF Form.templateSubmit EQ "Delete Old Template">
	<CFFILE ACTION=Delete FILE="#systemPath#\template\#Form.templateFile#">
	<H3>Old template file deleted.</H3>
</CFIF>

<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=500 ALIGN=left><P>
<CFSET noHeader = 1>
<CFINCLUDE TEMPLATE="templateHome.cfm">
