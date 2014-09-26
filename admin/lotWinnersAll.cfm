<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Lot Winners - All</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFINCLUDE TEMPLATE="../category/#categoryID#CategoryInfo.cfm">
<CFOUTPUT><FONT COLOR=purple SIZE=5><B>All Lot Winners in Category:</B></FONT><BR>
<A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotName">#categoryID#</A> - #categoryName#</H2></CFOUTPUT>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=3><TR>
<TD ROWSPAN=3 BGCOLOR=teal ALIGN=center><B>&nbsp;Order by: </B><BR>
<FONT COLOR=yellow SIZE=2>
	<CFIF order EQ "lotName">name (+)
	<CFELSEIF order EQ "lotName DESC">name (-)
	<CFELSEIF order EQ "lotOpenDateTime">open time (+)
	<CFELSEIF order EQ "lotOpenDateTime DESC">open time (-)
	<CFELSEIF order EQ "lotCloseDateTime">close time (+)
	<CFELSEIF order EQ "lotCloseDateTime DESC">close time (-)
	<CFELSEIF order EQ "lotDateTimeCreated">time created (+)
	<CFELSEIF order EQ "lotDateTimeCreated DESC">time created (-)
	<CFELSEIF order EQ "lotDateTimeLastEdited">last edited (+)
	<CFELSEIF order EQ "lotDateTimeLastEdited DESC">last edited (-)
	</CFIF>
</FONT></TD>
<TD ALIGN=center BGCOLOR="#99CCCC"><FONT SIZE=2>Name</FONT></TD>
<TD ALIGN=center BGCOLOR="#20A491"><FONT SIZE=2>Opens</FONT></TD>
<TD ALIGN=center BGCOLOR="#99CCCC"><FONT SIZE=2>Closes</FONT></TD>
<TD ALIGN=center BGCOLOR="#20A491"><FONT SIZE=2>Created (ID)</FONT></TD>
<TD ALIGN=center BGCOLOR="#99CCCC"><FONT SIZE=2>Last edited</FONT></TD>
</TR>

<TR>
<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotName"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotName+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#99CCCC" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotOpenDateTime"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotOpenDateTime+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotCloseDateTime"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotCloseDateTime+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#99CCCC" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotDateTimeCreated"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotDateTimeCreated+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotDateTimeLastEdited"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="lotWinnersAll.cfm?categoryID=#categoryID#&order=lotDateTimeLastEdited+DESC"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
</TR>
</TABLE>


<CFQUERY NAME=getWinningBids DATASOURCE="#EAdatasource#">
	SELECT Lot.lotID, Lot.lotName, Lot.lotStatus, Bid.bidPrice,
	Bid.bidQuantityWin, Bid.userID, Member.email, Member.firstName, Member.lastName
	FROM (Bid INNER JOIN Lot ON Bid.lotID = Lot.lotID)
		INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.bidWin = 1 AND Lot.categoryID = #categoryID#
	ORDER BY Lot.#order#
</CFQUERY>

<HR NOSHADE COLOR=purple SIZE=3 WIDTH=500 ALIGN=left>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TR>
<TH BGCOLOR="#20A491"><FONT SIZE=2>ID</FONT></TH>
<TH BGCOLOR=#33FF99><FONT SIZE=2>Lot Name</FONT></TH>
<TH BGCOLOR=aqua><FONT SIZE=2>Bid</FONT></TH>
<TH BGCOLOR=yellow><FONT SIZE=2>#</FONT></TH>
<TH BGCOLOR=yellow><FONT SIZE=2>Total</FONT></TH>
<TH BGCOLOR=red><FONT SIZE=2>User</FONT></TH>
<TH BGCOLOR=orange><FONT SIZE=2>Status</FONT></TH>
</TR>

<CFSET rowBG = 0>

<CFOUTPUT QUERY="getWinningBids">
	<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
		<CFELSE><TR BGCOLOR="##CDCDCD"><CFSET rowBG = 0></CFIF>
	<TD><FONT SIZE=2><A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidID">#lotID#</A></FONT></TD>
	<TD><FONT SIZE=2>#lotName#</FONT></TD>
	<TD><FONT SIZE=2>#LSCurrencyFormat(bidPrice,"local")#</FONT></TD>
	<TD ALIGN=center><FONT SIZE=2>#bidQuantityWin#</FONT></TD>
	<TD><FONT SIZE=2>#LSCurrencyFormat(bidPrice * bidQuantityWin,"local")#</FONT></TD>
	<TD><FONT SIZE=2><A HREF="mailto:#email#">#firstName# #lastName#</A></FONT></TD>
	<TD><FONT SIZE=2>#lotStatus#</FONT></TD>
	</TR>
</CFOUTPUT>
</TABLE>
<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>