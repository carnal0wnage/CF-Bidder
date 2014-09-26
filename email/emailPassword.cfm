
<CFSET password = Decrypt(getPassword.password,encryptionCode)>
<CFIF getPasswordFromName NEQ "" AND getPasswordFromName NEQ " ">
	<CFSET getPasswordFromEmail = "#getPasswordFromEmail# (#getPasswordFromName#)">
</CFIF>

<CFMAIL	TO="#getPassword.email#"
	FROM="#getPasswordFromEmail#"
	SUBJECT="Password Retrieval"
	SERVER="#emailServer#">
This automated email was sent because you requested that your password be emailed to you from our auction site.

<CFIF getPasswordUsername EQ 1>username: #getPassword.username#</CFIF>
password: #password#

#systemURL#

</CFMAIL>

<CFIF getPasswordUsername EQ 1>
	<CFMAIL	TO="#getPasswordAdminEmail#"
		FROM="#getPasswordFromEmail#"
		SUBJECT="#getPasswordSubject#"
		SERVER="#emailServer#">
The following user requested their password be emailed:

username: #getPassword.username#
email: #getPassword.email#

	</CFMAIL>
</CFIF>
