<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("categoryRedirect")>
	<HTML>
	<HEAD><TITLE>Emaze Auction: Lot Winners</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

	<CFQUERY NAME=getLotName DATASOURCE="#EAdatasource#">
		SELECT lotName, lotType, categoryID FROM Lot WHERE lotID = #lotID#
	</CFQUERY>

	<CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#getLotName.categoryID####lotID#">Return to category</A></CFOUTPUT>
	<H3><CFOUTPUT>#lotID# - #getLotName.lotName#</CFOUTPUT></H3>
	<H2><CFIF getLotName.lotType EQ 0>Buyers<CFELSE>Winners</CFIF></H2>
<CFELSE>
	<CFQUERY NAME=getLotName DATASOURCE="#EAdatasource#">
		SELECT lotName, lotType, categoryID FROM Lot WHERE lotID = #lotID#
	</CFQUERY>
	<H3><CFOUTPUT>#lotID# - #getLotName.lotName#</CFOUTPUT></H3>
</CFIF>

<CFIF NOT IsDefined("order")>
	<CFSET order = "Member.lastName, Member.firstName">
<CFELSEIF order EQ "name">
	<CFSET order = "Member.lastName, Member.firstName">
<CFELSEIF order EQ "nameDESC">
	<CFSET order = "Member.lastName DESC, Member.firstName DESC">
<CFELSEIF getLotName.lotType NEQ 0>
	<CFIF order EQ "bidPrice"><CFSET order = "Bid.bidPrice">
	<CFELSEIF order EQ "bidQuantityWin"><CFSET order = "Bid.bidQuantityWin">
	<CFELSEIF order EQ "bidQuantityWin*bidPrice"><CFSET order = "Bid.bidQuantityWin * Bid.bidPrice">
	<CFELSEIF order EQ "bidDateTime"><CFSET order = "Bid.bidDateTime">
	<CFELSEIF order EQ "bidPrice DESC"><CFSET order = "Bid.bidPrice DESC">
	<CFELSEIF order EQ "bidQuantityWin DESC"><CFSET order = "Bid.bidQuantityWin DESC">
	<CFELSEIF order EQ "(bidQuantityWin*bidPrice) DESC"><CFSET order = "(Bid.bidQuantityWin * Bid.bidPrice) DESC">
	<CFELSEIF order EQ "bidDateTime DESC"><CFSET order = "Bid.bidDateTime DESC">
	<CFELSE><CFSET order = "Bid.bidID">
	</CFIF>
<CFELSEIF order EQ "bidPrice"><CFSET order = "Buy.buyPrice">
<CFELSEIF order EQ "bidQuantityWin"><CFSET order = "Buy.buyQuantity">
<CFELSEIF order EQ "bidQuantityWin*bidPrice"><CFSET order = "Buy.buyQuantity * Buy.buyPrice">
<CFELSEIF order EQ "bidDateTime"><CFSET order = "Buy.buyDateTime">
<CFELSEIF order EQ "bidPrice DESC"><CFSET order = "Buy.buyPrice DESC">
<CFELSEIF order EQ "bidQuantityWin DESC"><CFSET order = "Buy.buyQuantity DESC">
<CFELSEIF order EQ "(bidQuantityWin*bidPrice) DESC"><CFSET order = "(Buy.buyQuantity * Buy.buyPrice) DESC">
<CFELSEIF order EQ "bidDateTime DESC"><CFSET order = "Buy.buyDateTime DESC">
<CFELSE><CFSET order = "Buy.buyID">
</CFIF>

<CFQUERY NAME=getWinningBids DATASOURCE="#EAdatasource#">
	SELECT Member.firstName, Member.lastName, Member.email,
		Member.organization, Member.phone, Member.username,
		Member.address, Member.address2, Member.city,
		Member.state, Member.zipCode, Member.country,
	<CFIF getLotName.lotType EQ 0>
			Buy.userID, Buy.buyDateTime AS bidDateTime, Buy.buyPrice AS bidPrice, Buy.buyQuantity AS bidQuantityWin
		FROM Buy INNER JOIN Member ON Buy.userID = Member.userID
		WHERE Buy.lotID = #lotID#
	<CFELSE>
			Bid.userID, Bid.bidDateTime, Bid.bidPrice, Bid.bidQuantityWin
		FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
		WHERE Bid.lotID = #lotID# AND Bid.bidWin = 1
	</CFIF>
	ORDER BY #order#
</CFQUERY>

<CFIF getWinningBids.RecordCount EQ 0>
	<H3>There are no winning bids for this lot.</H3>
	<CFIF NOT IsDefined("categoryRedirect")></BODY></HTML><CFABORT></CFIF>
<CFELSE>
	<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
	<CFIF NOT IsDefined("categoryRedirect")>
		<TR>
		<TD></TD>
		<TD BGCOLOR=red ALIGN=center><CFOUTPUT><A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=name"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=nameDESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=aqua ALIGN=center><CFOUTPUT><A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidPrice"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidPrice+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=#CCCCFF ALIGN=center><CFOUTPUT><A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidQuantityWin"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidQuantityWin+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=#CCCC99><CFOUTPUT><A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidQuantityWin*bidPrice"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=(bidQuantityWin*bidPrice)+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=orange ALIGN=center><CFOUTPUT><A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidDateTime"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidDateTime+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		</TR>
	</CFIF>

	<TR>
	<TH BGCOLOR="#20A491">ID</TH>
	<TH BGCOLOR=red>User</TH>
	<TH BGCOLOR=aqua><CFIF getLotName.lotType EQ 0>Price<CFELSE>Bid</CFIF></TH>
	<TH BGCOLOR=#CCCCFF>Quantity</TH>
	<TH BGCOLOR=#CCCC99>Total</TH>
	<TH BGCOLOR=orange>Date/time</TH>
	</TR>

	<CFSET rowBG = 0>
	<CFOUTPUT QUERY="getWinningBids">
		<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
			<CFELSE><TR BGCOLOR="##CDCDCD"><CFSET rowBG = 0></CFIF>
		<CFIF IsDefined("categoryRedirect")><TD ALIGN=center><FONT SIZE=2><A HREF="#secureSystemURL#/admin/userCreate.cfm?userID=#userID#">Edit</A></FONT></TD>
			<CFELSE><TD><A HREF="###userID#">#userID#</A>. </TD></CFIF>
		<TD>#lastName#, #firstName# (#username#)</TD>
		<TD>#LSCurrencyFormat(bidPrice,"local")#</TD>
		<TD>#bidQuantityWin#</TD>
		<TD>#LSCurrencyFormat(bidPrice * bidQuantityWin,"local")#</TD>
		<TD><FONT SIZE=2>#LSDateFormat(bidDateTime, "mm-dd-yyyy")#<BR>#LSTimeFormat(bidDateTime)#</FONT></TD>
		</TR>
	</CFOUTPUT>
	</TABLE>
</CFIF>

<CFIF NOT IsDefined("categoryRedirect")>
	<HR NOSHADE COLOR=purple SIZE=3 WIDTH=500 ALIGN=left>
	
	<DL>
	<CFOUTPUT QUERY="getWinningBids">
		<DT><A NAME="#userID#"></A>#lastName#, #firstName# <FONT SIZE=2>(<A HREF="#secureSystemURL#/admin/userCreate.cfm?userID=#userID#">Edit</A>)</FONT>
		<DD><TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
		<TR><TD><TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
			<TR><TD ALIGN=right>Price: </TD><TD>#LSCurrencyFormat(bidPrice,"local")#</TD>
				<TD ROWSPAN=3>&nbsp;</TD></TR>
			<TR><TD ALIGN=right>Quantity: </TD><TD>#bidQuantityWin#</TD></TR>
			<TR><TD ALIGN=right>Date/time: </TD><TD>#LSDateFormat("#bidDateTime#", "mm-dd-yyyy")# / #LSTimeFormat("#bidDateTime#")#</TD></TR>
		</TABLE></TD></TR>
		<TR><TD>#email#<BR>
		#phone#<BR>
		#organization#</TD></TR>
		<TR><TD>#address#<BR>
		<CFIF address2 NEQ "" AND address2 NEQ " ">#address2#<BR></CFIF>
		#city#, #state# #zipCode#<BR>
		#country#</TD></TR>
		</TABLE>
		<P>
	</CFOUTPUT>
	</DL>
	
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML>
</CFIF>