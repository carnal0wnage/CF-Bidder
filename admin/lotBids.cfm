<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("categoryRedirect")>
	<HTML>
	<HEAD><TITLE>Emaze Auction: View Bids</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

	<CFQUERY NAME=getLotName DATASOURCE="#EAdatasource#">
		SELECT lotName, categoryID FROM Lot WHERE lotID = #lotID#
	</CFQUERY>
	<CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#getLotName.categoryID####lotiD#">Return to category</A></CFOUTPUT>
	<H3><CFOUTPUT>#lotID# - #getLotName.lotName#</CFOUTPUT></H3>
<CFELSE>
	<CFQUERY NAME=getLotName DATASOURCE="#EAdatasource#">
		SELECT lotName, categoryID FROM Lot WHERE lotID = #lotID#
	</CFQUERY>
	<H3><CFOUTPUT>#lotID# - #getLotName.lotName#</CFOUTPUT></H3>
</CFIF>

<CFIF order EQ "name">
	<CFSET order = "Member.lastName, Member.firstName">
<CFELSEIF order EQ "nameDESC">
	<CFSET order = "Member.lastName DESC, Member.firstName DESC">
</CFIF>

<CFQUERY NAME=getBids DATASOURCE="#EAdatasource#">
	SELECT Member.email, Member.firstName, Member.lastName, Member.username,
		Bid.bidDateTime, Bid.bidPrice, Bid.bidQuantity, Bid.bidAuto,
		Bid.bidPriceMaximum, Bid.bidFullQuantityOnly, Bid.bidWin, Bid.bidID,
		Bid.bidPriceInitial, Bid.bidQuantityWin, Bid.userID, Bid.bidEditDateTime
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #lotID#
	ORDER BY #order#
</CFQUERY>

<CFIF NOT IsDefined("categoryRedirect")>
	<CFOUTPUT><FONT SIZE=6><B>Bids</B></FONT> <FONT SIZE=5>(total: #getBids.RecordCount#)</B></FONT><P></CFOUTPUT>
<CFELSE>
	<CFOUTPUT><B>Total Bids: #getBids.RecordCount#<P></CFOUTPUT>
</CFIF>

<CFIF getBids.RecordCount EQ 0>
	<H3>There are no bids for this lot.</H3>
<CFELSE>
	<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>

	<CFIF NOT IsDefined("categoryRedirect")>
		<TR>
		<TD></TD>
		<TD></TD>
		<TD BGCOLOR=red ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=name"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=nameDESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=orange ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=bidDateTime"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=bidDateTime+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=orange ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=bidEditDateTime"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=bidEditDateTime+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=aqua ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=bidPrice"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=bidPrice+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=#CCCCFF ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=bidQuantity"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=bidQuantity+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=lime ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=bidQuantityWin"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=bidQuantityWin+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=#CCCC99 ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=bidAuto"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=bidAuto+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=#99CCCC ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=bidPriceInitial"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=bidPriceInitial+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		<TD BGCOLOR=#33FF99 ALIGN=center><CFOUTPUT><A HREF="lotBids.cfm?lotID=#lotID#&order=bidPriceMaximum"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="lotBids.cfm?lotID=#lotID#&order=bidPriceMaximum+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
		</TR>
	</CFIF>

	<TR>
	<TH BGCOLOR="#20A491"><FONT SIZE=2>Edit<BR>Bid</FONT></TH>
	<TH BGCOLOR="#20A491"><FONT SIZE=2>Edit<BR>User</FONT></TH>
	<TH BGCOLOR=red><FONT SIZE=2>Name (username)</FONT></TH>
	<TH BGCOLOR=orange><FONT SIZE=2>Date/time</FONT></TH>
	<TH BGCOLOR=orange><FONT SIZE=2>Edit Date/time</FONT></TH>
	<TH BGCOLOR=aqua><FONT SIZE=2>Current Bid</FONT></TH>
	<TH BGCOLOR=#CCCCFF><FONT SIZE=2>#</FONT></TH>
	<TH BGCOLOR=lime><FONT SIZE=2>Win?</FONT></TH>
	<TH BGCOLOR=#CCCC99><FONT SIZE=2>Auto?</FONT></TH>
	<TH BGCOLOR=#99CCCC><FONT SIZE=2>Initial Bid</FONT></TH>
	<TH BGCOLOR=#33FF99><FONT SIZE=2>Max. Bid</FONT></TH>
	</TR>

	<CFINCLUDE TEMPLATE="../system/userList.cfm">
	<CFIF ListFind(userList,"creditCardNumber") EQ 0>
		<CFSET action = "#systemURL#/admin/userCreate.cfm">
	<CFELSE>
		<CFSET action = "#secureSystemURL#/admin/userCreate.cfm">
	</CFIF>

	<CFSET rowBG = 0>
	<CFOUTPUT QUERY="getBids">
		<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
			<CFELSE><TR BGCOLOR="##CDCDCD"><CFSET rowBG = 0></CFIF>
		<TD><A HREF="lotBidEdit.cfm?bidID=#bidID#"><FONT SIZE=2>bid</FONT></A></TD>
		<TD><A HREF="#action#?userID=#userID#"><FONT SIZE=2>user</FONT></A></TD>
		<TD><FONT SIZE=2><A HREF="mailto:#email#">#lastName#, #firstName#</A><BR>(#username#)</FONT></TD>
		<TD><FONT SIZE=2>#LSDateFormat(bidDateTime, "mm-dd-yyyy")#<BR>#LSTimeFormat(bidDateTime)#</FONT></TD>
		<TD><FONT SIZE=2>#LSDateFormat(bidEditDateTime, "mm-dd-yyyy")#<BR>#LSTimeFormat(bidEditDateTime)#</FONT></TD>
		<TD>#LSCurrencyFormat(bidPrice,"local")# (#LSCurrencyFormat(bidPrice * bidQuantityWin,"local")#)</TD>
		<TD ALIGN=center>#bidQuantity#<CFIF bidFullQuantityOnly EQ 1><BR>(full)</CFIF></TD>
		<CFIF bidWin EQ 1><TD ALIGN=center>#bidQuantityWin#</TD>
			<CFELSE><TD ALIGN=center>0</TD></CFIF>
		<CFIF bidAuto EQ 1>
			<TD ALIGN=center>yes</TD>
			<TD>#LSCurrencyFormat(bidPriceInitial,"local")#</TD>
			<TD>#LSCurrencyFormat(bidPriceMaximum,"local")#</TD>
		<CFELSE>
			<TD ALIGN=center>-</TD>
			<TD ALIGN=center>-</TD>
			<TD ALIGN=center>-</TD>
		</CFIF>
		</TR>
	</CFOUTPUT>
	</TABLE>
</CFIF>

<CFIF NOT IsDefined("categoryRedirect")>
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML>
</CFIF>