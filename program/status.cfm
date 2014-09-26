<!--- Emaze Auction version 2.1, 1.03 / Tuesday, September 7, 1999 --->
<CFSET title = "titleBidStatus">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<P>

<CFIF IsDefined("Form.unwatch") AND IsDefined("Form.lotID") AND IsDefined("Cookie.EmazeAuction_user")>
	<CFQUERY NAME=unwatch DATASOURCE="#EAdatasource#">
		DELETE FROM LotWatch
		WHERE userID = #ListFirst(Cookie.EmazeAuction_user)#
			AND (lotID = #ListFirst(Form.lotID)#
		<CFLOOP INDEX=lotCount FROM=2 TO="#ListLen(Form.lotID)#">
			OR lotID = #ListGetAt(Form.lotID,lotCount)#
		</CFLOOP>)
	</CFQUERY>
	<H3>You have successfully stopped watching the requested lots.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=600 ALIGN=left><P>	
</CFIF>

<CFQUERY NAME="getName" DATASOURCE="#EAdatasource#">
	SELECT username FROM Member WHERE userID = #userID#
</CFQUERY>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD ALIGN=right><FONT SIZE=5><B>Name: </B></FONT></TD>
	<TD><FONT SIZE=5><B><CFOUTPUT>#getName.username#</CFOUTPUT></B></FONT></TD></TR>

<CFQUERY NAME="getBidStatus" DATASOURCE="#EAdatasource#">
	SELECT Bid.lotID, Lot.lotName, Lot.lotStatus, Lot.lotOpenDateTime, Lot.lotCloseDateTime, Lot.lotReservePriceMet,
		Category.categoryName, Bid.bidEditDateTime, Bid.bidUpdateDateTime, Bid.bidPrice, Bid.bidQuantity, Bid.bidWin, Bid.bidQuantityWin,
		Bid.bidFullQuantityOnly, Bid.bidAuto, Bid.bidPriceMaximum, Bid.bidPriceInitial, Bid.bidEditDateTime, Bid.bidDescription, Lot.lotHighBid,
		Lot.nextBidMinimum, Lot.lotType, Lot.lotProcureLowBidAutoWins, Lot.lotProcureBidDescription, Lot.lotType, Lot.lotCloseQueue
	FROM Category INNER JOIN (Bid INNER JOIN Lot ON Bid.lotID = Lot.lotID)
		ON Category.categoryID = Lot.categoryID
	WHERE Bid.userID = #userID#
	ORDER BY Lot.lotCloseDateTime DESC, Category.categoryName, Lot.lotName
</CFQUERY>

<CFQUERY NAME="getLotWatch" DATASOURCE="#EAdatasource#">
	SELECT LotWatch.lotID, Lot.lotName, Lot.lotStatus, Lot.lotOpenDateTime, Lot.lotCloseDateTime, Lot.lotReservePriceMet,
		Category.categoryName, Lot.lotHighBid, Lot.nextBidMinimum
	FROM Category INNER JOIN (LotWatch INNER JOIN Lot ON LotWatch.lotID = Lot.lotID)
		ON Category.categoryID = Lot.categoryID
	WHERE LotWatch.userID = #userID#
	ORDER BY Lot.lotCloseDateTime DESC, Category.categoryName, Lot.lotName
</CFQUERY>

<CFIF getBidStatus.RecordCount EQ 0 AND getLotWatch.RecordCount EQ 0>
	</TABLE>
	<H3>You do not have any current bids and are not watching any lots.</H3>
	<P><CFINCLUDE TEMPLATE="copyright.cfm">
	<P><CFINCLUDE TEMPLATE="closeCheck.cfm">
	</BODY></HTML><CFELSE>
</CFIF>

<TR><TD ALIGN=right><FONT COLOR=purple SIZE=5><B># Bids: </B></FONT></TD>
	<TD><FONT COLOR=purple SIZE=5><B><CFOUTPUT>#getBidStatus.RecordCount#</CFOUTPUT></B></FONT></TD></TR>
<TR><TD ALIGN=right><FONT COLOR=purple SIZE=5><B># Watch: </B></FONT></TD>
	<TD><FONT COLOR=purple SIZE=5><B><CFOUTPUT>#getLotWatch.RecordCount#</CFOUTPUT></B></FONT></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH COLSPAN=2 BGCOLOR="#FFFFCE">Status Colors Chart</TH></TR>
<TR><TD BGCOLOR="#7CFC00">&nbsp; &nbsp;</TD><TD>You win. The lot is closed, so you definitely win.</TD></TR>
<TR><TD BGCOLOR="yellow">&nbsp; &nbsp;</TD><TD>You currently have a winning bid, but the lot is still open.</TD></TR>
<TR><TD BGCOLOR="red">&nbsp; &nbsp;</TD><TD>You did not win this lot.</TD></TR>
</TABLE>

<P>

<CFIF getLotWatch.RecordCount NEQ 0>
	<CFOUTPUT>
	<FORM ACTION="#systemURL#/program/status.cfm" METHOD=post>
	<INPUT TYPE=hidden NAME=userID VALUE="#userID#">
	<INPUT TYPE=hidden NAME=username VALUE="#getName.username#">
	</CFOUTPUT>
</CFIF>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TH BGCOLOR="#FFFFCE">Lot ID</TH>
<TH BGCOLOR="#FFFFCE">Lot Name</TH>
<TH BGCOLOR="#FFFFCE">Lot Status</TH>
<TH BGCOLOR="#FFFFCE">Winning Bid</TH>
<TH BGCOLOR="#FFFFCE">Next Bid</TH>
<TH BGCOLOR="#FFFFCE">Your Bid</TH>
<TH BGCOLOR="#FFFFCE">Bid Result</TH>

<CFSET rowBG = 0>
<CFOUTPUT QUERY=getBidStatus>
	<CFIF rowBG EQ 0><TR><CFSET rowBG = 1><CFELSE><TR BGCOLOR=DCDCDC><CFSET rowBG = 0></CFIF>
	<TD ALIGN=center><FONT SIZE=2><A HREF="###lotID#">#lotID#</A></FONT></TD>
	<TD><FONT SIZE=2>#lotName#</FONT></TD>
	<TD ALIGN=center><FONT SIZE=2>#lotStatus#</FONT></TD>
	<TD><FONT SIZE=2>#LSCurrencyFormat(lotHighBid,"local")#</FONT></TD>
	<CFIF lotStatus EQ "Open">
		<TD><FONT SIZE=2>#LSCurrencyFormat(nextBidMinimum,"local")#</FONT></TD>
	<CFELSE>
		<TD><FONT SIZE=2>&nbsp; -</FONT></TD>
	</CFIF>
	<TD><FONT SIZE=2>#LSCurrencyFormat(bidPrice,"local")#</FONT></TD>
	<CFIF bidWin EQ 0><TD ALIGN=center BGCOLOR=red><FONT SIZE=2>Not Win</FONT></TD>
	<CFELSEIF lotStatus EQ "Open" AND lotReservePriceMet EQ 0>
		<TD ALIGN=center BGCOLOR=yellow><FONT SIZE=2><CFIF lotType EQ 1>High Bid<CFELSE>Low Bid</CFIF><BR>(reserve not met)</FONT></TD>
	<CFELSEIF lotStatus EQ "Open">
		<TD ALIGN=center BGCOLOR=yellow><FONT SIZE=2>Win!<BR>(still open)</FONT></TD>
	<CFELSEIF lotStatus EQ "Closed" AND lotReservePriceMet EQ 0>
		<TD ALIGN=center BGCOLOR="red"><FONT SIZE=2><CFIF lotType EQ 1>High Bid<CFELSE>Low Bid</CFIF><BR>(reserve not met)</FONT></TD>
	<CFELSE>
		<TD ALIGN=center BGCOLOR="##7CFC00"><FONT SIZE=2>WIN! (#bidQuantityWin#)</FONT></TD>
	</CFIF>
	</TR>
</CFOUTPUT>
<CFOUTPUT QUERY=getLotWatch>
	<CFIF rowBG EQ 0><TR><CFSET rowBG = 1><CFELSE><TR BGCOLOR=DCDCDC><CFSET rowBG = 0></CFIF>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=lotID VALUE=#lotID#>	<FONT SIZE=2><A HREF="#systemURL#/lot.cfm?lotID=#lotID#">#lotID#</A></FONT></TD>
	<TD><FONT SIZE=2>#lotName#</FONT></TD>
	<TD ALIGN=center><FONT SIZE=2>#lotStatus#</FONT></TD>
	<TD><FONT SIZE=2>#LSCurrencyFormat(lotHighBid,"local")#</FONT></TD>
	<CFIF lotStatus EQ "Open">
		<TD><FONT SIZE=2>#LSCurrencyFormat(nextBidMinimum,"local")#</FONT></TD>
	<CFELSE>
		<TD><FONT SIZE=2>&nbsp; -</FONT></TD>
	</CFIF>
	<TD><FONT SIZE=2>&nbsp; -</FONT></TD>
	<TD ALIGN=center><FONT SIZE=2>Watching</FONT></TD>
	</TR>
</CFOUTPUT>

<CFIF getLotWatch.RecordCount EQ 0>
	</TABLE>
<CFELSE>
	<TR><TD COLSPAN=7 ALIGN=center>To stop watching a lot, check the checkbox next <BR>
	to that lot ID and click the "Stop Watching" button below.<BR>
	<INPUT TYPE=submit NAME=unwatch VALUE="Stop Watching Lots">
	</TD></TR>
	</TABLE>
	</FORM>
</CFIF>

<P><HR NOSHADE SIZE=3 WIDTH=600 ALIGN=left><P>

<CFIF ListFind(ValueList(getBidStatus.lotType),-1)>
	<CFQUERY NAME=getFees DATASOURCE="#EAdatasource#">
		SELECT lotID, bidFee, bidWinFee, bidFeeFinal, bidViewFee
		FROM FeeBid
		WHERE userID = #userID#
	</CFQUERY>
	<CFQUERY NAME=getBidViews DATASOURCE="#EAdatasource#">
		SELECT Distinct(lotID), Count(lotID) AS bidCount
		FROM BidDescriptionView
		WHERE userID = #userID#
		GROUP BY lotID
		ORDER BY lotID
	</CFQUERY>
</CFIF>

<DL>
<CFOUTPUT QUERY="getBidStatus">
	<DT>
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
	<TR><TD>#categoryName#</TD></TR>
	<TR><TD>##<A NAME=#lotID#></A><A HREF="#systemURL#/lot.cfm?lotID=#lotID#">#lotID#</A>. #lotName#</TD></TR>
	<TR><TD>
		<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2><TR>
		<TD ALIGN=right WIDTH=100 NOWRAP><I>Status</I>: <CFIF lotStatus EQ "Open"><B>OPEN</B><CFELSE>#lotStatus#</CFIF></TD>
		<TD WIDTH=15>&nbsp;</TD>
		<TD ALIGN=right WIDTH=200 NOWRAP><I>Opens</I>: #LSDateFormat(lotOpenDateTime,dateFormatDisplay)# / #LSTimeFormat(lotOpenDateTime,timeFormatDisplay)#</TD>
		<TD WIDTH=15>&nbsp;</TD>
		<TD ALIGN=right WIDTH=200 NOWRAP><I>Closes</I>: #LSDateFormat(lotCloseDateTime,dateFormatDisplay)# / #LSTimeFormat(lotCloseDateTime,timeFormatDisplay)#</TD>
		</TR></TABLE>
	</TD></TR>
	</TABLE>
	<DD>
	<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=0>
	<TR><TD ALIGN=right BGCOLOR="##FFFFCE"><FONT COLOR=purple SIZE=4><B>Win? (quantity): </B></FONT></TD>
	<CFIF bidWin EQ 0><TD BGCOLOR=red><FONT SIZE=4>&nbsp;<B>NOT WIN</B></FONT></TD>
	<CFELSEIF lotStatus EQ "Open"><TD BGCOLOR=yellow>&nbsp;
		<CFIF lotReservePriceMet EQ 0>
			<B><CFIF lotType EQ 1>High Bid<CFELSE>Low Bid</CFIF></B> (but auction is still open and reserve price has not yet been met)
		<CFELSE>
			<B>WIN! (#bidQuantityWin#)</B> (but auction is still open)
		</CFIF></TD>
	<CFELSEIF lotStatus EQ "Closed" AND lotReservePriceMet EQ 0>
		<TD BGCOLOR="yellow">&nbsp;<B><CFIF lotType EQ 1>High Bid<CFELSE>Low Bid</CFIF></B> (but reserve was not met)</TD>
	<CFELSEIF lotStatus EQ "Closed">
		<TD BGCOLOR="##7CFC00">&nbsp;<B>WIN! (#bidQuantityWin#)</B></TD>
	</CFIF>
	</TR>

	<CFIF bidAuto EQ 0>
		<TR><TD ALIGN=right BGCOLOR="##FFFFCE">Bid: </TD><TD BGCOLOR="##FFFFCE">#LSCurrencyFormat(bidPrice,"local")#</TD></TR>
		<TR><TD ALIGN=right BGCOLOR="##FFFFCE">Quantity: </TD><TD BGCOLOR="##FFFFCE">#bidQuantity# <CFIF #bidFullQuantityOnly# EQ 1>(full quantity only)</CFIF></TD></TR>
		<TR><TD ALIGN=right BGCOLOR="##FFFFCE">Date/time: </TD><TD BGCOLOR="##FFFFCE">#LSDateFormat(bidEditDateTime,dateFormatDisplay)# / #LSTimeFormat(bidEditDateTime,timeFormatDisplay)#</TD></TR>
	<CFELSE>
		<TR><TD COLSPAN=2>
			<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
			<TR><TD ALIGN=right BGCOLOR="##FFFFCE">Current Bid:</TD><TD BGCOLOR="##FFFFCE">#LSCurrencyFormat(bidPrice,"local")#</TD>
				<TD ALIGN=right BGCOLOR="##ADD8E6">Initial bid: </TD><TD BGCOLOR="##ADD8E6">#LSCurrencyFormat(bidPriceInitial,"local")#</TD></TR>
			<TR><TD ALIGN=right BGCOLOR="##FFFFCE">Quantity: </TD><TD BGCOLOR="##FFFFCE">#bidQuantity# <CFIF bidFullQuantityOnly EQ 1>(full quantity only)</CFIF></TD>
				<TD ALIGN=right BGCOLOR="##ADD8E6"><CFIF lotType EQ 1>Maximum Bid: <CFELSE>Minimum Bid: </CFIF></TD><TD BGCOLOR="##ADD8E6">#LSCurrencyFormat(bidPriceMaximum,"local")#</TD></TR>
			<TR><TD ALIGN=right BGCOLOR="##FFFFCE">Date/time: </TD><TD BGCOLOR="##FFFFCE">#LSDateFormat(bidEditDateTime,dateFormatDisplay)# / #LSTimeFormat(bidEditDateTime,timeFormatDisplay)#</TD>
				<TD ALIGN=right BGCOLOR="##ADD8E6">Last auto-bid: </TD><TD BGCOLOR="##ADD8E6">#LSDateFormat(bidUpdateDateTime,dateFormatDisplay)# / #LSTimeFormat(bidUpdateDateTime,timeFormatDisplay)#</TD></TR>
			</TABLE>
		</TD></TR>
	</CFIF>
	</TABLE>

	<CFIF lotType EQ -1>
		<CFIF lotCloseQueue EQ 3 AND IsDefined("getFees")>
			<CFIF ListFind(ValueList(getFees.lotID),lotID)>
				<CFSET lotPosition = ListFind(ValueList(getFees.lotID),lotID)>
				<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
				<CFIF ListGetAt(ValueList(getFees.bidFee),lotPosition) GT 0>
					<TR><TD ALIGN=right>Fee To Bid: </TD><TD>#LSCurrencyFormat(ListGetAt(ValueList(getFees.bidFee),lotPosition),"local")#</TD></TR>
				</CFIF>
				<CFIF ListGetAt(ValueList(getFees.bidWinFee),lotPosition) GT 0>
					<TR><TD ALIGN=right>Fee For Winning Bid: </TD><TD>#LSCurrencyFormat(ListGetAt(ValueList(getFees.bidWinFee),lotPosition),"local")#</TD></TR>
				</CFIF>
				<CFIF ListGetAt(ValueList(getFees.bidViewFee),lotPosition) GT 0>
					<TR><TD ALIGN=right>Bid Description Views Fee: </TD><TD>#LSCurrencyFormat(ListGetAt(ValueList(getFees.bidViewFee),lotPosition),"local")#</TD></TR>
				</CFIF>
				<CFIF ListGetAt(ValueList(getFees.bidFeeFinal),lotPosition) EQ 0>
					<TR><TD COLSPAN=2><FONT SIZE-2>This lot is not yet closed, so this fee is not final.</FONT></TD></TR>
				</CFIF>
				</TABLE>
			</CFIF>
		</CFIF>

		<CFIF lotProcureBidDescription EQ 1>
			<P><FONT SIZE=4><B>Bid Description:</B> 
			<CFIF ListFind(ValueList(getBidViews.lotID),lotID)>
				<CFSET lotPosition = ListFind(ValueList(getBidViews.lotID),lotID)>
				(Viewed: #ListGetAt(ValueList(getBidViews.bidCount),lotPosition)#)
			<CFELSE>(Viewed: 0)
			</CFIF>
			</FONT><BR>
			<CFIF bidDescription EQ "" OR bidDescription EQ " ">No bid description
			<CFELSE>#bidDescription#</CFIF>
		</CFIF>
	</CFIF>
	<P><HR NOSHADE SIZE=3 ALIGN=left WIDTH=500><P>
</CFOUTPUT>
</DL>

<P>
<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
<CFINCLUDE TEMPLATE="closeCheck.cfm">
</BODY>
</HTML>