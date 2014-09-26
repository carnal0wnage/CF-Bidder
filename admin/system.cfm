<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: System Options</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<!--- Update sysetmInfo file with path, URL and datasource. --->
	<CFIF IsDefined("Form.okPath")>
		<CFSET newSystemPath = Form.systemPath>
		<B>System path updated.</B><BR>
	<CFELSE><CFSET newSystemPath = systemPath>
	</CFIF>

	<CFIF IsDefined("Form.okDatasource")>
		<CFSET newEAdatasource = Form.EAdatasource>
		<B>Cold Fusion datasource updated.</B><BR>
	<CFELSE><CFSET newEAdatasource = EAdatasource>
	</CFIF>

	<CFIF NOT IsDefined("Form.okURL")>
		<CFSET newSystemURL = systemURL>
	<CFELSE>
		<CFSET newSystemURL = Form.systemURL>
		<B>System URL updated.</B><BR>

		<CFQUERY NAME=getImages DATASOURCE="#newEAdatasource#">
			SELECT lotID, lotImage, lotImageThumbnail
			FROM Lot
			WHERE lotImage LIKE '#systemURL#/lotimage/%'
				OR lotImageThumbnail LIKE '#systemURL#/lotimage/%'
		</CFQUERY>
		<CFLOOP QUERY=getImages>
			<CFSET newImageURL = "none">
			<CFSET newThumbnailURL = "none">
			<CFIF Find("#systemURL#/lotimage/",getImages.lotImage,1) NEQ 0>
				<CFSET newImageURL = Replace(getImages.lotImage,"#systemURL#/lotimage/","#newSystemURL#/lotimage/","ONE")>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#getImages.lotID#LotInfo.cfm"
					OUTPUT="<CFSET lotImage = ""#newImageURL#"">">
			</CFIF>
			<CFIF Find("#systemURL#/lotimage/",getImages.lotImageThumbnail,1) NEQ 0>
				<CFSET newThumbnailURL = Replace(getImages.lotImageThumbnail,"#systemURL#/lotimage/","#newSystemURL#/lotimage/","ONE")>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#getImages.lotID#LotInfo.cfm"
					OUTPUT="<CFSET lotImageThumbnail = ""#newThumbnailURL#"">">
			</CFIF>
			<CFIF newImageURL NEQ "none" OR newThumbnailURL NEQ "none">
				<CFQUERY NAME=updateImage DATASOURCE="#newEAdatasource#">
					UPDATE Lot
					SET	<CFIF newImageURL NEQ "none" AND newThumbnailURL NEQ "none">lotImage = '#newImageURL#',
						<CFELSEIF newImageURL NEQ "none">lotImage = '#newImageURL#'</CFIF>
						<CFIF newThumbnailURL NEQ "none">lotImageThumbnail = '#newThumbnailURL#'</CFIF>
					WHERE lotID = #getImages.lotID#
				</CFQUERY>
			</CFIF>
		</CFLOOP>
		<CFIF getImages.RecordCount NEQ 0>
			<B>All uploaded images and thumbnails updated to new URL.</B>
		</CFIF>
	</CFIF>

	<CFIF IsDefined("Form.okSecureURL")>
		<CFSET newSecureSystemURL = Form.secureSystemURL>
		<B>Secure system URL updated.</B><BR>
	<CFELSE>
		<CFSET newSecureSystemURL = secureSystemURL>
	</CFIF>

	<CFIF NOT IsDefined("Form.okEncryptionCode")>
		<CFSET newEncryptionCode = encryptionCode>
	<CFELSE>
		<CFSET newEncryptionCode = Form.encryptionCode>
		<CFQUERY NAME=getCrypt DATASOURCE="#EAdatasource#">
			SELECT userID, password, creditCardNumber, creditCardExpiration
			FROM Member
		</CFQUERY>
		<CFLOOP QUERY=getCrypt>
			<CFSET passwordOrig = Decrypt(password,encryptionCode)>
			<CFSET passwordNew = Encrypt(passwordOrig,encryptionCode)>

			<CFIF creditCardNumber EQ "" OR creditCardNumber EQ " ">
				<CFSET ccNumberNew = creditCardNumber>
			<CFELSE>
				<CFSET ccNumberOrig = Decrypt(creditCardNumber,encryptionCode)>
				<CFSET ccNumberNew = Encrypt(ccNumberOrig,encryptionCode)>
			</CFIF>

			<CFIF creditCardExpiration EQ "" OR creditCardExpiration EQ " ">
				<CFSET ccExpiratioNew = creditCardExpiration>
			<CFELSE>
				<CFSET ccExpirationOrig = Decrypt(creditCardExpiration,encryptionCode)>
				<CFSET ccExpiratioNew = Encrypt(ccExpirationOrig,encryptionCode)>
			</CFIF>

			<CFQUERY NAME=updateCrypt DATASOURCE="#newEAdatasource#">
				UPDATE Member
				SET password = '#passwordNew#',
					creditCardNumber = '#ccNumberNew#',
					creditCardExpiration = '#ccExpiratioNew#'
				WHERE userID = #userID#
			</CFQUERY>
		</CFLOOP>
		<B>Encryption code updated. All passwords, credit card numbers, and credit card expiration dates were re-encrypted using the new code.</B><BR>
	</CFIF>

	<CFIF IsDefined("Form.okEmailServer")>
		<CFSET newEmailServer = Form.emailServer>
		<B>Email server updated.</B><BR>
	<CFELSE>
		<CFSET newEmailServer = emailServer>
	</CFIF>

	<CFIF IsDefined("Form.okDomain")>
		<CFSET newSystemDomain = Form.systemDomain>
		<B>System domain updated.</B><BR>
	<CFELSE>
		<CFSET newSystemDomain = systemDomain>
	</CFIF>

	<CFFILE ACTION=Write FILE="#newSystemPath#\Application.cfm"
		OUTPUT="<CFSETTING ENABLECFOUTPUTONLY=""Yes"">
<CFSET systemPath = ""#newSystemPath#"">
<CFSET systemURL = ""#newSystemURL#"">
<CFSET EAdatasource = ""#newEAdatasource#"">
<CFSET secureSystemURL = ""#newSecureSystemURL#"">
<CFSET systemDomain = ""#newSystemDomain#"">
<CFSET emailServer = ""#newEmailServer#"">
<CFSET indexTitle = ""#indexTitle#"">
<CFSET encryptionCode = ""#newEncryptionCode#"">
<CFSET dateFormatDisplay = ""#dateFormatDisplay#"">
<CFSET timeFormatTimeZone = ""#timeFormatTimeZone#"">
<CFSET timeFormatDisplay = ""#timeFormatDisplay#"">
<CFSET subCategorySeparator = ""#subCategorySeparator#"">
<CFSET indexTemplate = ""#indexTemplate#"">
<CFSET currentlocale = SetLocale(""#currentLocale#"")>
<CFSETTING ENABLECFOUTPUTONLY=""No"">
">

	<CFINCLUDE TEMPLATE="../Application.cfm">
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<!--- Display current values --->

<FONT SIZE=6 COLOR=purple><B>System Info</B></FONT>
<FORM METHOD=post ACTION="system.cfm">
<INPUT TYPE=hidden NAME=first VALUE=1>

<DL>
<DT><INPUT TYPE=checkbox NAME=okPath VALUE=1> Full path to Emaze Auction directory
<DD><CFOUTPUT><INPUT TYPE=text NAME=systemPath VALUE="#systemPath#" SIZE=50></CFOUTPUT> <FONT SIZE=2>(no trailing slash)</FONT><BR>
	<FONT SIZE=2 COLOR=blue>Change system path only <I>after</I> you move the directory.</FONT>
<P>
<DT><INPUT TYPE=checkbox NAME=okURL VALUE=1> URL to Emaze Auction directory
<DD><CFOUTPUT><INPUT TYPE=text NAME=systemURL SIZE=50 VALUE="#systemURL#"></CFOUTPUT> <FONT SIZE=2>(no trailing slash)</FONT>
<P>
<DT><INPUT TYPE=checkbox NAME=okSecureURL VALUE=1> <I>Secure</I> URL to Emaze Auction directory <FONT SIZE=2>(Must point to same directory as above. If not secure, enter same URL.)</FONT>
<DD><CFOUTPUT><INPUT TYPE=text NAME=secureSystemURL SIZE=50 VALUE="#secureSystemURL#"></CFOUTPUT> <FONT SIZE=2>(no trailing slash)</FONT>
<P>
<DT><INPUT TYPE=checkbox NAME=okEncryptionCode VALUE=1> Encryption code <FONT SIZE=2>(text used as basis of encrypting passwords and credit card numbers)</FONT>
<DD><CFOUTPUT><INPUT TYPE=text NAME=encryptionCode SIZE=50 VALUE="#encryptionCode#"></CFOUTPUT>
<P>
<DT><INPUT TYPE=checkbox NAME=okDatasource VALUE=1> Cold Fusion datasource of database
<DD><CFOUTPUT><INPUT TYPE=text NAME=EAdatasource VALUE="#EAdatasource#" SIZE=30></CFOUTPUT>
<P>
<DT><INPUT TYPE=checkbox NAME=okEmailServer VALUE=1> Email server for sending emails
<DD><CFOUTPUT><INPUT TYPE=text NAME=emailServer VALUE="#emailServer#" SIZE=30></CFOUTPUT>
<P>
<DT><INPUT TYPE=checkbox NAME=okDomain VALUE=1> Domain name for cookies: <I><B><FONT COLOR=red>.</FONT></B>domain.extension</I> (<B><FONT COLOR=red>.</FONT></B>emaze.com) or <I>IP address</I> (127.0.0.1)
<DD><CFOUTPUT><INPUT TYPE=text NAME=systemDomain VALUE="#systemDomain#" SIZE=30></CFOUTPUT>
<P>
<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit VALUE="Update System Info"><BR>
<FONT SIZE=2 COLOR=blue>(All checkboxes must be checked next to each field<BR>
you want to update except the two cookie options.)</FONT>
</DL>
</FORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>