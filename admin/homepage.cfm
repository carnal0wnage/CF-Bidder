<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">
<HTML>
<HEAD><TITLE>Emaze Auction: Home Page</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFSET helpContext = "homepage">
<CFIF IsDefined("first")>
	<CFIF Form.indexBanner EQ ""><CFSET banner = " ">
		<CFELSE><CFSET banner = Form.indexBanner></CFIF>
	<CFIF Form.indexSpecialHeader EQ ""><CFSET special = " ">
		<CFELSE><CFSET special = Form.indexSpecialHeader></CFIF>
	<CFIF Form.indexUser EQ ""><CFSET user = " ">
		<CFELSE><CFSET user = Form.indexUser></CFIF>

	<CFIF Form.indexLogoFile NEQ "">
		<CFFILE ACTION=Upload FILEFIELD="indexLogoFile"
			DESTINATION="#systemPath#\images\"
			NAMECONFLICT="MakeUnique">
		<CFSET indexLogo = "#systemURL#/images/#File.ServerFile#">
		Homepage logo uploaded to server as the following URL:<BR>
		&nbsp; &nbsp; &nbsp; <CFOUTPUT>#systemURL#/images/#File.ServerFile#</CFOUTPUT><P>
	<CFELSEIF Form.indexLogoURL EQ "" OR Form.indexLogoURL EQ "#systemURL#/images/">
		<CFSET indexLogo = " ">
	<CFELSE>
		<CFSET indexLogo = Form.indexLogoURL>
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\system\indexInfo.cfm"
		OUTPUT="<CFSET indexBanner = ""#banner#"">
<CFSET indexSpecial = ""#special#"">
<CFSET indexUser = ""#user#"">
<CFSET indexLogo = ""#indexLogo#"">
<CFSET indexLogoLocation = #Form.indexLogoLocation#>">

	<CFFILE ACTION=Write FILE="#systemPath#\Application.cfm"
		OUTPUT="<CFSETTING ENABLECFOUTPUTONLY=""Yes"">
<CFSET systemPath = ""#systemPath#"">
<CFSET systemURL = ""#systemURL#"">
<CFSET EAdatasource = ""#EAdatasource#"">
<CFSET secureSystemURL = ""#secureSystemURL#"">
<CFSET emailServer = ""#emailServer#"">
<CFSET systemDomain = ""#systemDomain#"">
<CFSET encryptionCode = ""#encryptionCode#"">
<CFSET indexTitle = ""#RTrim(Form.indexTitle)#"">
<CFSET dateFormatDisplay = ""#dateFormatDisplay#"">
<CFSET timeFormatTimeZone = ""#timeFormatTimeZone#"">
<CFSET timeFormatDisplay = ""#timeFormatDisplay#"">
<CFSET subCategorySeparator = ""#subCategorySeparator#"">
<CFSET indexTemplate = ""#RTrim(Form.indexTemplate)#"">
<CFSET currentlocale = SetLocale(""#currentLocale#"")>
<CFSETTING ENABLECFOUTPUTONLY=""No"">">

	<CFSET indexTemplate = Form.indexTemplate>
	<CFSET indexTitle = Form.indexTitle>

	<CFIF Form.indexSpecialText EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\indexSpecial.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET indexSpecialText = Replace(Form.indexSpecialText, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\indexSpecial.cfm" OUTPUT="#indexSpecialText#">
	</CFIF>

	<CFIF Form.indexHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\indexHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET indexHeader = Replace(Form.indexHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\indexHeader.cfm" OUTPUT="#indexHeader#">
	</CFIF>

	<CFIF Form.indexMiddle EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\indexMiddle.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET indexMiddle = Replace(Form.indexMiddle, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\indexMiddle.cfm" OUTPUT="#indexMiddle#">
	</CFIF>

	<CFIF Form.indexFooter EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\indexFooter.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET indexFooter = Replace(Form.indexFooter, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\indexFooter.cfm" OUTPUT="#indexFooter#">
	</CFIF>

	<H3>Home page options updated.</H3>
	<CFINCLUDE TEMPLATE="../Application.cfm">
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Home Page</B></FONT>

<CFINCLUDE TEMPLATE="../system/indexInfo.cfm">

<CFFORM NAME=homepage ACTION=homepage.cfm ENCTYPE="multipart/form-data">
<INPUT TYPE=hidden NAME=first VALUE=0>

<DL>
<CFQUERY NAME=getTemplates DATASOURCE="#EAdatasource#">
	SELECT templateFile, templateName
	FROM Template
	WHERE templateType = 'homepage'
	ORDER BY templateName
</CFQUERY>

<DT><B>Home page template</B>
<DD><SELECT NAME="indexTemplate" SIZE=1>
<CFOUTPUT QUERY=getTemplates>
	<CFIF getTemplates.templateFile EQ indexTemplate>
		<OPTION VALUE="#getTemplates.templateFile#" SELECTED>#getTemplates.templateName#
	<CFELSE>
		<OPTION VALUE="#getTemplates.templateFile#">#getTemplates.templateName#
	</CFIF>
</CFOUTPUT>
</SELECT>
<P>

<CFSET indexTitle = Replace(indexTitle, "<", "&lt;", "ALL")>
<CFSET indexTitle = Replace(indexTitle, "<", "&gt;", "ALL")>
<CFSET indexTitle = Replace(indexTitle, """", "&quot;", "ALL")>
<DT><B>Title</B> (for all page titles)
<DD><CFINPUT TYPE=text NAME=indexTitle SIZE=25 VALUE="#indexTitle#">

<P>

<CFSET indexBanner = Replace(indexBanner, "<", "&lt;", "ALL")>
<CFSET indexBanner = Replace(indexBanner, "<", "&gt;", "ALL")>
<CFSET indexBanner = Replace(indexBanner, """", "&quot;", "ALL")>
<DT><B>Banner</B> (text at top of home page)
<DD><CFINPUT TYPE=text NAME=indexBanner SIZE=40 VALUE="#indexBanner#">

<P>

<DT><B>Logo</B> (at top of home page above navigation)
<DD><INPUT TYPE=radio NAME=indexLogoLocation VALUE=-1<CFIF indexLogoLocation EQ -1> CHECKED</CFIF>> Do not display homepage logo<BR>
<INPUT TYPE=radio NAME=indexLogoLocation VALUE=0<CFIF indexLogoLocation EQ 0> CHECKED</CFIF>> Display homepage logo above navigation bar<BR>
<INPUT TYPE=radio NAME=indexLogoLocation VALUE=1<CFIF indexLogoLocation EQ 1> CHECKED</CFIF>> Display homepage logo between navigation bar and title bar<BR>
<INPUT TYPE=radio NAME=indexLogoLocation VALUE=2<CFIF indexLogoLocation EQ 2> CHECKED</CFIF>> Display homepage logo instead of title bar below navigation bar
<P>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD ALIGN=right>Upload Image: </TD><TD><INPUT TYPE=file NAME=indexLogoFile SIZE=45></TD></TR>
<CFIF indexLogo EQ "" OR indexLogo EQ " ">
	<CFSET indexLogo = "#systemURL#/images/">
</CFIF>
<TR><TD ALIGN=right>URL to Image: </TD><TD><CFINPUT TYPE=text NAME=indexLogoURL SIZE=59 VALUE="#indexLogo#"></TD></TR>
</TABLE>
<CFIF indexLogo EQ "#systemURL#/images/">
	<FONT SIZE=2>(No homepage logo at this time.)</FONT>
<CFELSE>
	<CFOUTPUT><IMG SRC="#indexLogo#"></CFOUTPUT>
</CFIF>

<P>

<CFSET indexUser = Replace(indexUser, "<", "&lt;", "ALL")>
<CFSET indexUser = Replace(indexUser, "<", "&gt;", "ALL")>
<CFSET indexUser = Replace(indexUser, """", "&quot;", "ALL")>
<DT><B>User</B> (header for table containing username and password fields)
<DD><CFINPUT TYPE=text NAME=indexUser SIZE=20 VALUE="#indexUser#">

<P>

<CFSET indexSpecial = Replace(indexSpecial, "<", "&lt;", "ALL")>
<CFSET indexSpecial = Replace(indexSpecial, "<", "&gt;", "ALL")>
<CFSET indexSpecial = Replace(indexSpecial, """", "&quot;", "ALL")>
<DT><B>Special</B> (header and message)
<DD><CFINPUT TYPE=text NAME=indexSpecialHeader SIZE=20 VALUE="#indexSpecial#"><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\indexSpecial.cfm" VARIABLE="indexSpecial">
<CFSET indexSpecial = RTrim(indexSpecial)>
<TEXTAREA NAME=indexSpecialText ROWS=5 COLS=55 WRAP=virtual><CFOUTPUT>#indexSpecial#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Header</B> (before table of auctions opening today)
<CFFILE ACTION=Read FILE="#systemPath#\system\indexHeader.cfm" VARIABLE="indexHeader">
<CFSET indexHeader = RTrim(indexHeader)>
<DD><TEXTAREA NAME=indexHeader ROWS=6 COLS=55 WRAP=virtual><CFOUTPUT>#indexHeader#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Middle</B> (between tables of auction opening and closing today)
<CFFILE ACTION=Read FILE="#systemPath#\system\indexMiddle.cfm" VARIABLE="indexMiddle">
<CFSET indexMiddle = RTrim(indexMiddle)>
<DD><TEXTAREA NAME=indexMiddle ROWS=6 COLS=55 WRAP=virtual><CFOUTPUT>#indexMiddle#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Footer</B> (after table of auctions closing today)
<CFFILE ACTION=Read FILE="#systemPath#\system\indexFooter.cfm" VARIABLE="indexFooter">
<CFSET indexFooter = RTrim(indexFooter)>
<DD><TEXTAREA NAME=indexFooter ROWS=6 COLS=55 WRAP=virtual><CFOUTPUT>#indexFooter#</CFOUTPUT></TEXTAREA>
</DL>
<P>
<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit NAME=edit VALUE="Update Homepage Options">
</CFFORM>

</BODY>
</HTML>