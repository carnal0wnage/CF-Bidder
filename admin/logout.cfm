<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 ---><!--- Delete interviewer cookie if it exists. (It should, but avoids error if not.) --->
<CFIF IsDefined("Cookie.EmazeAuction_master")>
	<CFCOOKIE NAME="EmazeAuction_master" VALUE=none EXPIRES=Now>
</CFIF>
<CFLOCATION URL="#systemURL#">