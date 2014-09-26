<!--- Emaze Auction version 2.1, 1.02 / Thursday, August 12, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Lot Menu</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.lotMenuButton") AND IsDefined("Form.username")>
	<CFIF Form.lotMenuButton EQ "Get seller lots">
		<CFQUERY NAME=getSeller DATASOURCE="#EAdatasource#">
			SELECT userID, firstName, lastName, email
			FROM Member
			WHERE username = '#Form.username#'
		</CFQUERY>
		<CFIF getSeller.RecordCount EQ 0>
			<H3>No users exist with the username <CFOUTPUT>#Form.usernam#</CFOUTPUT>.</H3>
			</BODY></HTML><CFABORT>
		</CFIF>

		<CFQUERY NAME=getSellerLots DATASOURCE="#EAdatasource#">
			SELECT lotID
			FROM Lot
			WHERE userID = #getSeller.userID#
		</CFQUERY>
		<CFIF getSellerLots.RecordCount EQ 0>
			<H3>The user with username <CFOUTPUT>#Form.username#</CFOUTPUT> does not have any lots.</H3>
			</BODY></HTML><CFABORT>
		</CFIF>

		<CFSET lotID = ValueList(getSellerLots.lotID)>
		<CFOUTPUT><FONT COLOR=purple SIZE=5><B>Seller: #Form.username#</B></FONT><BR>
			<FONT COLOR=purple SIZE=4>#getSeller.firstName# #getSeller.lastName# (<A HREF="mailto:#getSeller.email#">#getSeller.email#</A>)</FONT>
		</CFOUTPUT>
	</CFIF>
</CFIF>

<H1><FONT COLOR=purple>Lot Menu</FONT></H1>

<CFQUERY NAME=getLots DATASOURCE="#EAdatasource#">
	SELECT Lot.categoryID, Lot.lotID, Lot.lotName, Lot.lotOpenDateTime, Lot.lotCloseDateTime, Lot.lotCloseInactivity,
		Lot.lotPublic, Lot.lotStatus, Lot.lotCloseQueue, Lot.lotBidCount, Lot.lotNoBidsStayOpenTimes,
		Lot.lotReservePrice, Lot.lotReservePriceMet, Lot.lotReserveStayOpenTimes, Lot.lotViewCount,
		Lot.lotQuantity, Lot.lotQuantityTaken, Lot.nextBidMinimum, Lot.lotBidIncrement, Lot.lotOpeningBid,
		Category.categoryName, Lot.lotName, Lot.lotType
	FROM Lot INNER JOIN Category ON Lot.categoryID = Category.categoryID
	WHERE Lot.lotID IN (#lotID#)
</CFQUERY>

<CFIF getLots.RecordCount EQ 0>
	<CFOUTPUT><H3>There is no lot with lotID #lotID#.</H3></CFOUTPUT>
	</BODY></HTML><CFABORT>
</CFIF>

<CFIF getLots.RecordCount GT 1>
	<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2 WIDTH=500>
	<TH BGCOLOR="#20A491" WIDTH=65 ALIGN=right>ID&nbsp;</TH>
	<TH BGCOLOR="#20A491" WIDTH=460 ALIGN=left>Lot Name</TH>
	<CFSET rowBG = 0>
	<CFOUTPUT QUERY="getLots">
		<CFIF rowBG EQ 0><TR><CFSET rowBG = 1><CFELSE><TR BGCOLOR="CDCDCD"><CFSET rowBG = 0></CFIF>
		<TD ALIGN=right VALIGN=top><FONT SIZE=2><A HREF="###lotID#">#lotID#</A>. </FONT></TD>
		<TD><FONT SIZE=2>#lotName#</FONT></TD></TR>
	</CFOUTPUT>
	</TABLE>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=500 ALIGN=left><P>
</CFIF>

<DL>
<CFOUTPUT QUERY="getLots">
	<CFIF lotType EQ 1 OR lotType EQ 2><CFSET lotCreateURL = "lotCreate">
	<CFELSEIF lotType EQ 0><CFSET lotCreateURL = "marketCreate">
	<CFELSE><CFSET lotCreateURL = "procureCreate">
	</CFIF>

	<DT><A NAME=#lotID#></A>#lotID#. #lotName#<BR>
	<FONT SIZE=2>#systemURL#/lot.cfm?lotID=#lotID#</FONT>
	<DD><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=1>
	<TR><TD BGCOLOR="lime" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="../lot.cfm?lotID=#lotID#">View</A>&nbsp;</FONT></TD>
	 <TD BGCOLOR="aqua" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="#lotCreateURL#.cfm?lotID=#lotID#">Edit</A>&nbsp;</FONT></TD>
	<TD BGCOLOR="orange" ALIGN=center><FONT SIZE=2>&nbsp;
	<CFIF lotPublic EQ 0><A HREF="lotPrivate.cfm?lotID=#lotID#">Private</A>
		<CFELSE>Private</CFIF>&nbsp;</FONT></TD>
	<TD BGCOLOR="##CCCCFF" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="#lotCreateURL#.cfm?copy=1&lotID=#lotID#">Copy</A>&nbsp;</FONT></TD>
	<TD BGCOLOR="##33FF99" ALIGN=center><FONT SIZE=2>&nbsp;
	<CFIF lotType EQ 0>Bids<CFELSE><A HREF="lotBids.cfm?lotID=#lotID#&order=bidID">Bids</A></CFIF>&nbsp;</FONT></TD>
	<TD BGCOLOR="##99CCCC" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidID">Winners</A>&nbsp;</FONT></TD>
	<TD BGCOLOR="##CCFFFF" ALIGN=center><FONT SIZE=2><CFIF lotType EQ 1 OR lotType EQ 2><A HREF=lotBidOffline.cfm?lotID=#lotID#>Offline Bid</A><CFELSEIF lotType EQ 0>Offline Buy<CFELSE>Offline Bid</CFIF></FONT></TD>
	</TR>

	<TR><TD ALIGN=right>Status: </TD><TD COLSPAN=5>#lotStatus#
	<CFIF lotStatus EQ "Open" AND DateCompare(lotOpenDateTime,Now()) EQ 1> (<I>Preview</I>)</CFIF></TD>
		<TD BGCOLOR="##7FFFD4" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="lotEmail.cfm?bidder=winner&lotID=#lotID#">Email Winners</A>&nbsp;</FONT></TD></TR>
	<TR><TD ALIGN=right>Open: </TD><TD COLSPAN=5>#LSDateFormat("#lotOpenDateTime#", "mm-dd-yyyy")# / #LSTimeFormat("#lotOpenDateTime#")#</TD>
		<TD ALIGN=center BGCOLOR="##CCCC99"><FONT SIZE=2>&nbsp;<A HREF="lotEmail.cfm?bidder=loser&lotID=#lotID#">Email Losers</A>&nbsp;</FONT></TD></TR>
	<TR><TD ALIGN=right>Close: </TD><TD COLSPAN=5>#LSDateFormat("#lotCloseDateTime#", "mm-dd-yyyy")# / #LSTimeFormat("#lotCloseDateTime#")#</TD>
		<TD ALIGN=center BGCOLOR="yellow"><FONT SIZE=2>Archive
		<!--- <CFIF lotStatus NEQ "Open"><A HREF="lotArchive.cfm?categoryID=#categoryID#&lotID=#lotID#">Archive</A>
		<CFELSE>Archive</CFIF> ---></FONT></TD></TR>
	<TR><TD ALIGN=right>Winning Bid: </TD><TD COLSPAN=5>
		<CFIF nextBidMinimum GT lotOpeningBid>#LSCurrencyFormat(nextBidMinimum - lotBidIncrement,"local")#
		<CFELSEIF lotBidCount GT 0>#LSCurrencyFormat(lotOpeningBid,"local")#
		<CFELSE>(no bids)
		</CFIF></TD>
		<TD ALIGN=center BGCOLOR="red"><FONT SIZE=2><A HREF="lotDelete.cfm?categoryID=#categoryID#&lotID=#lotID#">Delete</A></FONT></TD></TR>
	<TR><TD ALIGN=right>Viewed: </TD><TD COLSPAN=2>#lotViewCount#</TD>
		<TD ALIGN=right>Bids: </TD><TD COLSPAN=2>#lotBidCount#
		<CFIF lotNoBidsStayOpenTimes NEQ 0> (#lotNoBidsStayOpenTimes#)</CFIF></TD>
	<TR><TD ALIGN=right>## Taken: </TD><TD COLSPAN=2>
		<CFIF lotQuantityTaken NEQ "">#lotQuantityTaken#<CFELSE>0</CFIF> / #lotQuantity#</TD>
		<TD ALIGN=right>Reserve: </TD><TD COLSPAN=2>
		<CFIF lotReservePriceMet EQ 0>#LSCurrencyFormat(lotReservePrice,"local")# (not met)<CFELSEIF #lotReservePriceMet# EQ 1>#LSCurrencyFormat(lotReservePrice,"local")# (met)<CFELSE>(N/A)</CFIF>
		<CFIF lotReserveStayOpenTimes NEQ 0> (#lotReserveStayOpenTimes#)</CFIF></TD></TR>
	<TR><TD ALIGN=right>Category: </TD><TD COLSPAN=5>#categoryName#</TD></TR>
	</TABLE>
	<HR NOSHADE COLOR=purple ALIGN=left WIDTH=400>
</CFOUTPUT>
</DL>

<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>