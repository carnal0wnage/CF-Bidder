
<CFINCLUDE TEMPLATE="../system/emailUser.cfm">
<CFIF e_fromnameVerify NEQ "" AND e_fromnameVerify NEQ " ">
	<CFSET e_fromemailVerify = "#e_fromemailVerify# (#e_fromnameVerify#)">
</CFIF>

<CFMAIL TO="#email#"
	FROM="#e_fromemailVerify#"
	SUBJECT="Emaze Auction - Verify Email"
	SERVER="#emailServer#">
This automated email was sent by Emaze Auction to verify that you entered a valid email address upon signing up as a bidder. Simply click the URL below to verify your email address, or copy the URL to your browser. Going to the URL below will complete this process. You will then be able to bid on any lots.

#systemURL#/verify.cfm?#userVerifyCode#

</CFMAIL>
