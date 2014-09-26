<CFIF FindNoCase("user.cfm",CGI.SCRIPT_NAME) EQ 0>
	<CFSET systemImageURL = systemURL>
<CFELSE>
	<CFSET systemImageURL = secureSystemURL>
</CFIF>

<CFOUTPUT>
<A HREF="#systemURL#/index.cfm"><img src="#systemImageURL#/images/navbarHome.gif" BORDER=0 ALT="Home" WIDTH=52 HEIGHT=37></A>
<A HREF="#systemURL#/program/search.cfm"><img src="#systemImageURL#/images/navbarSearch.gif" BORDER=0 ALT="Search" WIDTH=52 HEIGHT=37></A>
<A HREF="#secureSystemURL#/program/user.cfm"><img src="#systemImageURL#/images/navbarRegister.gif" BORDER=0 ALT="Register" WIDTH=52 HEIGHT=37></A>
<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
	<A HREF="#systemURL#/seller/helpSeller.cfm"><img src="#systemImageURL#/images/navbarSellers.gif" BORDER=0 ALT="Sellers" WIDTH=52 HEIGHT=37></A>
</CFIF>
<A HREF="#systemURL#/program/list.cfm"><img src="#systemImageURL#/images/navbarAllLots.gif" BORDER=0 ALT="List All Lots" WIDTH=52 HEIGHT=37></A>
<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>
	<A HREF="#systemURL#/forum/forum.cfm"><img src="#systemImageURL#/images/navbarForum.gif" BORDER=0 ALT="Forum" WIDTH=52 HEIGHT=37></A>
</CFIF>
<A HREF="#systemURL#/program/editUser.cfm?bidStatus=1"><img src="#systemImageURL#/images/navbarBidStatus.gif" BORDER=0 ALT="Bid Status" WIDTH=52 HEIGHT=37></A>
<A HREF="#systemURL#/program/help.cfm"><img src="#systemImageURL#/images/navbarHelp.gif" BORDER=0 ALT="Help" WIDTH=52 HEIGHT=37></A>
</CFOUTPUT>
