<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">
<HTML>
<HEAD><TITLE>Emaze Auction: View Bids</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFQUERY NAME=getUser DATASOURCE="#EAdatasource#">
	SELECT email, firstName, lastName, username
	FROM Member
	WHERE userID = #userID#
</CFQUERY>

<CFOUTPUT>
	<H1>#getUser.lastName#, #getUser.firstName# (<A HREF="mailto:#getUser.email#">#getUser.username#</A>)</H1>
</CFOUTPUT>

<CFIF NOT IsDefined("order")><CFSET order = "Bid.bidDateTime"></CFIF>
<CFQUERY NAME=getBids DATASOURCE="#EAdatasource#">
	SELECT Bid.bidDateTime, Bid.bidPrice, Bid.bidQuantity, Bid.bidAuto,
		Bid.bidPriceMaximum, Bid.bidFullQuantityOnly, Bid.bidWin, Bid.bidID,
		Bid.bidPriceInitial, Bid.bidQuantityWin, Lot.lotName, Bid.bidUpdateDateTime,
		Lot.lotStatus, Lot.lotOpenDateTime, Lot.lotCloseDateTime,
		Lot.lotReservePriceMet, Lot.lotID
	FROM Bid INNER JOIN Lot ON Bid.lotID = Lot.lotID
	WHERE Bid.userID = #userID#
	ORDER BY #order#
</CFQUERY>

<CFOUTPUT><FONT SIZE=6><B>Bids</B></FONT> <FONT SIZE=5>(total: #getBids.RecordCount#)</B></FONT><P></CFOUTPUT>

<CFIF getBids.RecordCount EQ 0>
	<H3>There are no bids for this user.</H3>
<CFELSE>
	<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>

	<CFOUTPUT>
	<TR>
	<TD></TD>
	<TD BGCOLOR=20A491 ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Lot.lotID")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Lot.lotID DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A>
	 / <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Lot.lotName")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Lot.lotName DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	<TD BGCOLOR=red ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Lot.lotOpenDateTime")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Lot.lotOpenDateTime DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A>
	 / <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Lot.lotCloseDateTime")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Lot.lotCloseDateTime DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	<TD BGCOLOR=orange ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidDateTime")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidDateTime DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	<TD BGCOLOR=orange ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidUpdateDateTime")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidUpdateDateTime DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	<TD BGCOLOR=aqua ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidPrice")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidPrice DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	<TD BGCOLOR=CCCCFF ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidQuantity")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidQuantity DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	<TD BGCOLOR=lime ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidQuantityWin")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidQuantityWin DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	<TD BGCOLOR=99CCCC ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidPriceInitial")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidPriceInitial DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	<TD BGCOLOR=33FF99 ALIGN=center><A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidPriceMaximum")#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp; <A HREF="userBids.cfm?userID=#userID#&order=#URLEncodedFormat("Bid.bidPriceMaximum DESC")#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></TD>
	</TR>
	</CFOUTPUT>

	<TR>
	<TH BGCOLOR=white><FONT SIZE=2>Edit<BR>Bid</FONT></TH>
	<TH BGCOLOR="#20A491"><FONT SIZE=2>Lot ID / Name</FONT></TH>
	<TH BGCOLOR=red><FONT SIZE=2>Opens / Closes</FONT></TH>
	<TH BGCOLOR=orange><FONT SIZE=2>Bid<BR>Date/time</FONT></TH>
	<TH BGCOLOR=orange><FONT SIZE=2>Update<BR>Date/time</FONT></TH>
	<TH BGCOLOR=aqua><FONT SIZE=2>Current<BR>Bid</FONT></TH>
	<TH BGCOLOR=#CCCCFF><FONT SIZE=2>Quantity</FONT></TH>
	<TH BGCOLOR=lime><FONT SIZE=2>Win?</FONT></TH>
	<TH BGCOLOR=#99CCCC><FONT SIZE=2>Initial<BR>Bid</FONT></TH>
	<TH BGCOLOR=#33FF99><FONT SIZE=2>Maximum<BR>Bid</FONT></TH>
	</TR>

	<CFSET bidPriceTotal = 0>
	<CFSET bidPriceInitialTotal = 0>
	<CFSET bidPriceMaximumTotal = 0>
	<CFSET bidPriceWinTotal = 0>
	<CFSET bidPriceInitialWinTotal = 0>
	<CFSET bidPriceMaximumWinTotal = 0>
	<CFSET bidPriceWinOpenTotal = 0>
	<CFSET bidPriceInitialWinOpenTotal = 0>
	<CFSET bidPriceMaximumWinOpenTotal = 0>
	<CFSET bidPriceWinClosedTotal = 0>
	<CFSET bidPriceInitialWinClosedTotal = 0>
	<CFSET bidPriceMaximumWinClosedTotal = 0>

	<CFSET rowBG = 0>
	<CFOUTPUT QUERY="getBids">
		<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
			<CFELSE><TR BGCOLOR="##CDCDCD"><CFSET rowBG = 0></CFIF>
		<TD ALIGN=center><A HREF="lotBidEdit.cfm?bidID=#bidID#">#bidID#</A></TD>
		<TD><FONT SIZE=2><A HREF="lotMenu.cfm?lotID=#lotID#">#lotID#</A> - #lotName#</FONT></TD>
		<CFIF lotStatus EQ "Open">
			<TD><FONT SIZE=2 COLOR=green><B>#LSDateFormat(lotOpenDateTime, "mm-dd-yy")# #LSTimeFormat(lotOpenDateTime)#</B></FONT><BR>
			<FONT SIZE=2 COLOR=red>#LSDateFormat(lotCloseDateTime, "mm-dd-yy")# #LSTimeFormat(lotCloseDateTime)#</FONT></TD>
		<CFELSE>
			<TD><FONT SIZE=2 COLOR=green>#LSDateFormat(lotOpenDateTime, "mm-dd-yy")# #LSTimeFormat(lotOpenDateTime)#</FONT><BR>
			<FONT SIZE=2 COLOR=red><B>#LSDateFormat(lotCloseDateTime, "mm-dd-yy")# #LSTimeFormat(lotCloseDateTime)#</B></FONT></TD>
		</CFIF>
		<TD><FONT SIZE=2>#LSDateFormat(bidDateTime, "mm-dd-yy")#<BR>#LSTimeFormat(bidDateTime)#</FONT></TD>
		<TD><FONT SIZE=2>#LSDateFormat(bidUpdateDateTime, "mm-dd-yy")#<BR>#LSTimeFormat(bidUpdateDateTime)#</FONT></TD>
		<TD>#LSCurrencyFormat(bidPrice,"local")#</TD>
		<TD ALIGN=center>#bidQuantity#<CFIF bidFullQuantityOnly EQ 1 AND bidQuantity NEQ 1><BR>(full)</CFIF></TD>
		<CFIF bidWin EQ 1><TD ALIGN=center>#bidQuantityWin#</TD>
			<CFELSE><TD ALIGN=center>0</TD></CFIF>
		<CFIF bidAuto EQ 1>
			<TD>#LSCurrencyFormat(bidPriceInitial,"local")#</TD>
			<TD>#LSCurrencyFormat(bidPriceMaximum,"local")#</TD>
		<CFELSE>
			<TD ALIGN=center>-</TD>
			<TD ALIGN=center>-</TD>
		</CFIF>
		</TR>

		<CFSET bidPriceTotal = bidPriceTotal + (bidPrice * bidQuantity)>
		<CFSET bidPriceInitialTotal = bidPriceInitialTotal + (bidPriceInitial * bidQuantity)>
		<CFSET bidPriceMaximumTotal = bidPriceMaximumTotal + (bidPriceMaximum * bidQuantity)>
		<CFIF bidWin EQ 1>
			<CFSET bidPriceWinTotal = bidPriceWinTotal + (bidPrice * bidQuantityWin)>
			<CFSET bidPriceInitialWinTotal = bidPriceInitialWinTotal + (bidPriceInitial * bidQuantityWin)>
			<CFSET bidPriceMaximumWinTotal = bidPriceMaximumWinTotal + (bidPriceMaximum * bidQuantityWin)>
			<CFIF lotStatus EQ "Open">
				<CFSET bidPriceWinOpenTotal = bidPriceWinOpenTotal + (bidPrice * bidQuantityWin)>
				<CFSET bidPriceInitialWinOpenTotal = bidPriceInitialWinOpenTotal + (bidPriceInitial * bidQuantityWin)>
				<CFSET bidPriceMaximumWinOpenTotal = bidPriceMaximumWinOpenTotal + (bidPriceInitial * bidQuantityWin)>
			<CFELSE>
				<CFSET bidPriceWinClosedTotal = bidPriceWinClosedTotal + (bidPrice * bidQuantityWin)>
				<CFSET bidPriceInitialWinClosedTotal = bidPriceInitialWinClosedTotal + (bidPriceMaximum * bidQuantityWin)>
				<CFSET bidPriceMaximumWinClosedTotal = bidPriceMaximumWinClosedTotal + (bidPriceMaximum * bidQuantityWin)>
			</CFIF>
		</CFIF>
	</CFOUTPUT>
	</TABLE>
	
	<P>
	
	<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
	<TH COLSPAN=5><FONT SIZE=5 COLOR=purple>Bid Totals</FONT></TH>
	<CFOUTPUT>
	<TR ALIGN=left><TH COLSPAN=2>Summary of all bids</TH>
		<TD ROWSPAN=8 WIDTH=10 BGCOLOR=purple>&nbsp;</TD>
		<TH COLSPAN=2 BGCOLOR=DCDCDC>Winning Bids Summary - Open Lots</TH></TR>
	<TR><TD ALIGN=right>Current Bid * Quantity: </TD><TD>#LSCurrencyFormat(bidPriceTotal,"local")#</TD>
		<TD ALIGN=right BGCOLOR=DCDCDC>Current Bid * Quantity Won: </TD><TD BGCOLOR=DCDCDC>#LSCurrencyFormat(bidPriceWinOpenTotal,"local")#</TD></TR>
	<TR><TD ALIGN=right>Initial Bid * Quantity: </TD><TD>#LSCurrencyFormat(bidPriceInitialTotal,"local")#</TD>
		<TD ALIGN=right BGCOLOR=DCDCDC>Initial Bid * Quantity Won: </TD><TD BGCOLOR=DCDCDC>#LSCurrencyFormat(bidPriceInitialWinOpenTotal,"local")#</TD></TR>
	<TR><TD ALIGN=right>Maximum Bid * Quantity: </TD><TD>#LSCurrencyFormat(bidPriceMaximumTotal,"local")#</TD>
		<TD ALIGN=right BGCOLOR=DCDCDC>Maximum Bid * Quantity Won: </TD><TD BGCOLOR=DCDCDC>#LSCurrencyFormat(bidPriceMaximumWinOpenTotal,"local")#</TD></TR>

	<TR><TH ALIGN=left COLSPAN=2 BGCOLOR=DCDCDC>Winning Bid Summary</TH>
		<TH ALIGN=left COLSPAN=2>Winning Bids Summary - Closed Lots</TH></TR>
	<TR><TD ALIGN=right BGCOLOR=DCDCDC>Current Bid * Quantity Won: </TD><TD BGCOLOR=DCDCDC>#LSCurrencyFormat(bidPriceWinTotal,"local")#</TD>
		<TD ALIGN=right>Current Bid * Quantity Won: </TD><TD>#LSCurrencyFormat(bidPriceWinClosedTotal,"local")#</TD></TR>
	<TR><TD ALIGN=right BGCOLOR=DCDCDC>Initial Bid * Quantity Won: </TD><TD BGCOLOR=DCDCDC>#LSCurrencyFormat(bidPriceInitialWinTotal,"local")#</TD>
		<TD ALIGN=right>Initial Bid * Quantity Won: </TD><TD>#LSCurrencyFormat(bidPriceInitialWinClosedTotal,"local")#</TD></TR>
	<TR><TD ALIGN=right BGCOLOR=DCDCDC>Maximum Bid * Quantity Won: </TD><TD BGCOLOR=DCDCDC>#LSCurrencyFormat(bidPriceMaximumWinTotal,"local")#</TD>
		<TD ALIGN=right>Maximum Bid * Quantity Won: </TD><TD>#LSCurrencyFormat(bidPriceMaximumWinClosedTotal,"local")#</TD></TR>
	</CFOUTPUT>
	</TABLE>
</CFIF>
<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY></HTML>
