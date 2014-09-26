<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 ---><CFIF NOT IsDefined("Cookie.EmazeAuction_master")>
	<H3>This is not your beautiful house.<P>You do not have admin permission to Emaze Auction.<P>Kindly vacate the premises.</H3>
	<H3>If you are the Admin user and this is your first attempt at logging in (and you will swear you entered the username and password correctly) there are 2 possible causes for this error:
	<OL>
	<LI>Your browser does not accept cookies.
	<LI>You entered the incorrect domain name upon initialization. Just re-initialize the system with the proper domain. If using a domain name, enter &quot;.yourdomain.com&quot; . If using an IP address, just enter the IP address as is.
	</OL></H3>
	</BODY></HTML>
	<CFABORT>
<CFELSEIF Cookie.EmazeAuction_master NEQ 0>
	<H3>This is not your beautiful house.<P>You do not have admin permission to Emaze Auction.<P>Kindly vacate the premises.</H3>
	</BODY></HTML>
	<CFABORT>
</CFIF>

