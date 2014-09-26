<CFSET title = "titleVerify">
<CFINCLUDE TEMPLATE="system/navigate.cfm">

<P>

<CFIF CGI.QUERY_STRING EQ "">
	<CFINCLUDE TEMPLATE="system/verifyReject.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFSET userVerifyCode = CGI.QUERY_STRING>
<CFQUERY NAME=checkUser DATASOURCE="#EAdatasource#">
	SELECT userID, email, username, password
	FROM Member
	WHERE userVerifyCode = '#userVerifyCode#'
</CFQUERY>

<CFIF checkUser.RecordCount EQ 0>
	<CFINCLUDE TEMPLATE="system/verifyReject.cfm">
<CFELSE>
	<CFQUERY NAME=updateStatus DATASOURCE="#EAdatasource#">
		UPDATE Member
		SET userStatus = 1
		WHERE userID = #checkUser.userID#
	</CFQUERY>
	<CFINCLUDE TEMPLATE="system/verifySuccess.cfm">
	<CFINCLUDE TEMPLATE="system/userList.cfm">
	<CFIF emailUsernamePassword EQ 1 OR emailUserAgreement EQ 1>
		<CFSET password = Decrypt(checkUser.password, encryptionCode)>
		<CFSET username = checkUser.username>
		<CFSET email = checkUser.email>
		<CFINCLUDE TEMPLATE="email/emailUserRegister.cfm">
	</CFIF>
</CFIF>

<CFINCLUDE TEMPLATE="program/copyright.cfm">
<P>
<CFINCLUDE TEMPLATE="program/closeCheck.cfm">

</BODY>
</HTML>