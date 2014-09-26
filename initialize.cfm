<HTML>
<HEAD><TITLE>Emaze Auction: Initialization</TITLE></HEAD>
<BODY BGCOLOR=white>

<CFIF IsDefined("Form.first")>
	<CFFILE ACTION=Write FILE="#Form.systemPath#\Application.cfm"
		OUTPUT="<CFSETTING ENABLECFOUTPUTONLY=""Yes"">
<CFSET systemPath = ""#Form.systemPath#"">
<CFSET systemURL = ""#Form.systemURL#"">
<CFSET EAdatasource = ""#Form.EAdatasource#"">
<CFSET secureSystemURL = ""#Form.secureSystemURL#"">
<CFSET emailServer = ""#Form.emailServer#"">
<CFSET systemDomain = ""#Form.systemDomain#"">
<CFSET encryptionCode = ""#Form.encryptionCode#"">
<CFSET indexTitle = ""#indexTitle#"">
<CFSET dateFormatDisplay = ""#dateFormatDisplay#"">
<CFSET timeFormatTimeZone = ""#timeFormatTimeZone#"">
<CFSET timeFormatDisplay = ""#timeFormatDisplay#"">
<CFSET subCategorySeparator = ""#subCategorySeparator#"">
<CFSET indexTemplate = ""#indexTemplate#"">
<CFSET currentlocale = SetLocale(""English (US)"")>
<CFSETTING ENABLECFOUTPUTONLY=""No"">">

	<CFSET passwordNew = Encrypt("emaze",Form.encryptionCode)>
	<CFQUERY NAME=updateMaster DATASOURCE="#Form.EAdatasource#">
		UPDATE Member
		SET password = '#passwordNew#'
		WHERE userID = 1
	</CFQUERY>

	<CFIF IsDefined("Form.useScheduler")>
		<CFFILE ACTION=Write FILE="#Form.systemPath#\system\useScheduler.cfm"
			OUTPUT="<CFSET useScheduler = 1>">
	</CFIF>

	<CFFILE ACTION=Write FILE="#Form.systemPath#\system\useCookies.cfm"
		OUTPUT="<CFSET allowCookieLogin = 1>
<CFSET allowCookieBid = 1>">

	<H1><FONT COLOR=purple>System initialized!</FONT></H1>
	
	System initialized on <CFOUTPUT>#LSDateFormat(Now(),"mmm-dd-yyyy")#</CFOUTPUT>.
	<P>
	We highly recommend that you delete this file, or at least place it in a non-public directory. The file is <CFOUTPUT><I>#systemPath#\initialize.cfm</I> or <I>#systemURL#/initialize.cfm</I>.</CFOUTPUT>
	<P>
	To log into Emaze Auction:<P>
	<CFOUTPUT><A HREF="#Form.systemURL#/admin/index.cfm">#Form.systemURL#/admin/index.cfm</A>.</CFOUTPUT><BR>
	username: master<BR>
	password: emaze
	<P>
	We encourage you to change the password upon logging in. You may also change the username as well. After logging in, simply click on <I>Edit Master User</I> link on the homepage, which will allow you to edit your information.
	<P>

	<CFIF IsDefined("Form.useScheduler")>
		You have checked the option to use the Cold Fusion Scheduler. Please be sure you register this option in the Cold Fusion Administrator. Otherwise, emails which should be sent upon closing a lot will never get sent.<P>
	</CFIF>
	
	</BODY></HTML><CFABORT>
</CFIF>

<H1><FONT COLOR=purple>Emaze Auction: Initialization</FONT></H1>

To get started, you must enter the requested data in the fields below. All values can be changed later. If you do not enter at least the correct path to the EmazeAuction directory, you will get an error. You should verify that your Emaze Auction datasource is working properly by testing it in the Cold Fusion Administrator.
<P>
If you receive an error, it is because the path to the Emaze Auction directory is not correct. If so, simply back up and try again.
<P>

<CFFORM METHOD=post ACTION="initialize.cfm">
<INPUT TYPE=hidden NAME=first VALUE=1>
<DL>

<CFSET systemPath = Replace(GetBaseTemplatePath(), "\initialize.cfm", "", "ONE")>
<DT>Full path to Emaze Auction directory
<DD><CFINPUT TYPE=text NAME=systemPath VALUE="#systemPath#" SIZE=50> <FONT SIZE=-1>(no trailing slash)</FONT>
<P>
<DT>URL to Emaze Auction directory
<DD><CFINPUT TYPE=text NAME=systemURL SIZE=50 VALUE="#systemURL#"> <FONT SIZE=-1>(no trailing slash)</FONT>
<P>
<DT><I>Secure</I> URL to Emaze Auction directory <FONT SIZE=2>(Must point to same directory as above. If not secure, enter same URL.)</FONT>
<DD><CFINPUT TYPE=text NAME=secureSystemURL SIZE=50 VALUE="#secureSystemURL#"> <FONT SIZE=-1>(no trailing slash)</FONT>
<P>
<DT>Encryption code <FONT SIZE=2>(text used as basis of encrypting passwords and credit card numbers)</FONT>
<DD><CFINPUT TYPE=text NAME=encryptionCode SIZE=50 VALUE="#encryptionCode#">
<P>
<DT>Cold Fusion datasource of database
<DD><CFINPUT TYPE=text NAME=EAdatasource VALUE="#EAdatasource#" SIZE=30>
<P>
<DT>Email server for sending emails
<DD><CFINPUT TYPE=text NAME=emailServer VALUE="#emailServer#" SIZE=30>
<P>
<DT>Domain name for cookie login: <I><FONT COLOR=red><B>.</B></FONT>domain.extension</I> or IP address
<DD><CFINPUT TYPE=text NAME=systemDomain VALUE="#systemDomain#" SIZE=30>
<P>
<DT><INPUT TYPE=checkbox NAME=useScheduler VALUE=1> I am using the Cold Fusion Scheduler to send the automated emails
<DD><FONT SIZE=2 COLOR=blue>&nbsp; &nbsp; &nbsp; The Scheduler must be registered in the CF Administrator. If you check this option,<BR>
&nbsp; &nbsp; &nbsp; but have not actually set up the Scheduler, the above emails will never get sent.</FONT>

<P>
<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit VALUE="Initialize Emaze Auction">
</DL>
</CFFORM>

</BODY>
</HTML>