<!--- Emaze Auction version 2.1, 1.02 / Tuesday, July 13, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction</TITLE></HEAD>

<BODY BGCOLOR=purple TEXT=yellow LINK=yellow VLINK=yellow ALINK=lime>

<A HREF=help/TOC.html TARGET=content>HELP</A>!<BR>
<A HREF=main.cfm TARGET=content><B><I>HOME</I></B></A>
<HR COLOR=yellow SIZE=3>
<FONT SIZE=2>
<A HREF=homepage.cfm TARGET=content>Homepage</A><BR>
<A HREF=marquee.cfm TARGET=content>Marquee</A><BR>
<A HREF=newsletter.cfm TARGET=content>Newsletter</A><BR>
<!--- <A HREF=bannerads.cfm TARGET=content>Banner Ads</A> --->

<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
	<HR COLOR=yellow SIZE=3>
	Sellers<BR>
	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm")>
		&nbsp; Approve<BR>
		&nbsp; &nbsp; <A HREF=sellerApproval.cfm TARGET=content>Auction</A><BR>
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>&nbsp; &nbsp; <A HREF=marketApproval.cfm TARGET=content>Classified</A><BR></CFIF>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>&nbsp; &nbsp; <A HREF=procureApproval.cfm TARGET=content>Procure</A><BR></CFIF>
	<CFELSE>
		&nbsp; <A HREF=sellerApproval.cfm TARGET=content>Approve</A><BR>
	</CFIF>
	&nbsp; <A HREF=sellerStatus.cfm TARGET=content>Status</A><BR>
	&nbsp; <A HREF=sellerFees.cfm TARGET=content>Fees</A><BR>
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>&nbsp; <A HREF=procureBidViews.cfm TARGET=content>Bid Views</A><BR></CFIF>
</CFIF>

<HR COLOR=yellow SIZE=3>
<NOBR><A HREF=lotClose.cfm TARGET=content>Close Lots</A></NOBR><BR>
<A HREF=categoryCount.cfm TARGET=content>Lot Counts</A>
<P>
<A HREF=categoryHome.cfm TARGET=content><I><B>Categories</B></I></A><BR>
<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm")>
	Create Lot<BR>
	&nbsp; &nbsp; <A HREF=lotCreate.cfm TARGET=content>Auction</A><BR>
	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>&nbsp; &nbsp; <NOBR><A HREF=marketCreate.cfm TARGET=content>Classified</A></NOBR><BR></CFIF>
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>&nbsp; &nbsp; <NOBR><A HREF=procureCreate.cfm TARGET=content>Procure</A></NOBR><BR></CFIF>
<CFELSE>
	<A HREF=lotCreate.cfm TARGET=content>Create Lot</A><BR>
</CFIF>
<CFOUTPUT><A HREF="#secureSystemURL#/admin/userCreate.cfm" TARGET=content>Create User</A><BR></CFOUTPUT>
<A HREF=userHome.cfm TARGET=content>Edit Users</A><BR>
<!--- <A HREF=userBlacklist.cfm TARGET=content>Black List</A><BR> --->
<HR COLOR=yellow SIZE=3>
<A HREF="logout.cfm" target="_parent">LOGOUT</A>
</FONT>
</BODY>
</HTML>