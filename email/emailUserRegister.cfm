
<CFINCLUDE TEMPLATE="../system/emailUser.cfm">
<CFIF e_fromnameRegister NEQ "" AND e_fromnameRegister NEQ " ">
	<CFSET e_fromemailRegister = "#e_fromemailRegister# (#e_fromnameRegister#)">
</CFIF>
<CFIF emailUserAgreement EQ 1>
	<CFFILE ACTION=Read FILE="#systemPath#\system\userAgreementText.cfm" VARIABLE="userAgreementText">
</CFIF>

<CFMAIL TO="#email#"
	FROM="#e_fromemailRegister#"
	SUBJECT="Emaze Auction - Register"
	SERVER="#emailServer#">
This automated email was sent by Emaze Auction with your registration information.

<CFIF emailUsernamePassword EQ 1>Username: #username#
Password: #password#</CFIF>

<CFIF emailUserAgreement EQ 1>#userAgreementText#</CFIF>

</CFMAIL>
