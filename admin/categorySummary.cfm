<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Category Summary</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFINCLUDE TEMPLATE="../category/#categoryID#CategoryInfo.cfm">
<FONT COLOR=purple SIZE=5><B><CFOUTPUT>#categoryName#</CFOUTPUT></B></FONT>
<P>

<CFOUTPUT>#systemURL#/category.cfm?categoryID=#categoryID#</CFOUTPUT>
<P>
<CFQUERY NAME=getLots DATASOURCE="#EAdatasource#">
	SELECT lotID, lotName, lotOpenDateTime, lotCloseQueue, lotBidsExist, lotNoBidsStayOpenTimes,
		lotReservePrice, lotReservePriceMet, lotReserveStayOpenTimes
	FROM Lot
	WHERE categoryID = #categoryID# AND lotType = 1
	ORDER BY lotID
</CFQUERY>

<CFLOOP QUERY=getLots>
	<CFIF getLots.lotCloseQueue EQ 0>
		<CFIF IsDefined("statusInactive")>
			<CFSET statusInactive = ListAppend(statusInactive,getLots.lotID)>
		<CFELSE>
			<CFSET statusInactive = getLots.lotID>
		</CFIF>
	<CFELSEIF getLots.lotCloseQueue EQ 1 AND DateCompare(Now(),getLots.lotOpenDateTime) EQ -1>
		<CFIF IsDefined("statusPreview")>
			<CFSET statusPreview = ListAppend(statusPreview,getLots.lotID)>
		<CFELSE>
			<CFSET statusPreview = getLots.lotID>
		</CFIF>
	<CFELSEIF getLots.lotCloseQueue EQ 1>
		<CFIF IsDefined("statusOpen")>
			<CFSET statusOpen = ListAppend(statusOpen,getLots.lotID)>
		<CFELSE>
			<CFSET statusOpen = getLots.lotID>
		</CFIF>
	<CFELSEIF getLots.lotCloseQueue EQ 2>
		<CFIF IsDefined("statusClosing")>
			<CFSET statusClosing = ListAppend(statusClosing,getLots.lotID)>
		<CFELSE>
			<CFSET statusClosing = getLots.lotID>
		</CFIF>
	<CFELSEIF IsDefined("statusClosed")><!--- getLots.lotCloseQueue EQ 3 --->
		<CFSET statusClosed = ListAppend(statusClosed,getLots.lotID)>
	<CFELSE>
		<CFSET statusClosed = getLots.lotID>
	</CFIF>

	<CFIF getLots.lotReservePrice NEQ 0 AND getLots.lotCloseQueue NEQ 0
			AND DateCompare(Now(),getLots.lotOpenDateTime) NEQ -1>
		<CFIF getLots.lotReservePriceMet EQ 0>
			<CFIF IsDefined("reserveNotMet")>
				<CFSET reserveNotMet = ListAppend(reserveNotMet,getLots.lotID)>
			<CFELSE>
				<CFSET reserveNotMet = getLots.lotID>
			</CFIF>
		<CFELSEIF IsDefined("reserveMet")>
			<CFSET reserveMet = ListAppend(reserveMet,getLots.lotID)>
		<CFELSE>
			<CFSET reserveMet = getLots.lotID>
		</CFIF>
		<CFIF getLots.lotReserveStayOpenTimes NEQ 0>
			<CFIF getLots.lotReserveStayOpenTimes EQ 1>
				<CFIF IsDefined("reserveStayOpen1")>
					<CFSET reserveStayOpen1 = ListAppend(reserveStayOpen1,getLots.lotID)>
				<CFELSE>
					<CFSET reserveStayOpen1 = getLots.lotID>
				</CFIF>
			<CFELSEIF getLots.lotReserveStayOpenTimes EQ 2>
				<CFIF IsDefined("reserveStayOpen2")>
					<CFSET reserveStayOpen2 = ListAppend(reserveStayOpen2,getLots.lotID)>
				<CFELSE>
					<CFSET reserveStayOpen2 = getLots.lotID>
				</CFIF>
			<CFELSEIF getLots.lotReserveStayOpenTimes EQ 3>
				<CFIF IsDefined("reserveStayOpen3")>
					<CFSET reserveStayOpen3 = ListAppend(reserveStayOpen3,getLots.lotID)>
				<CFELSE>
					<CFSET reserveStayOpen3 = getLots.lotID>
				</CFIF>
			<CFELSEIF IsDefined("reserveStayOpen4plus")>
				<CFSET reserveStayOpen4plus = ListAppend(reserveStayOpen4plus,getLots.lotID)>
			<CFELSE>
				<CFSET reserveStayOpen4plus = getLots.lotID>
			</CFIF>
		</CFIF>
	</CFIF>

	<CFIF getLots.lotBidsExist EQ 0 AND getLots.lotCloseQueue NEQ 0
			AND DateCompare(Now(),getLots.lotOpenDateTime) NEQ -1>
		<CFIF IsDefined("noBids")>
			<CFSET noBids = ListAppend(noBids,getLots.lotID)>
		<CFELSE>
			<CFSET noBids = getLots.lotID>
		</CFIF>
		<CFIF getLots.lotNoBidsStayOpenTimes NEQ 0>
			<CFIF getLots.lotNoBidsStayOpenTimes EQ 1>
				<CFIF IsDefined("noBidsStayOpen1")>
					<CFSET noBidsStayOpen1 = ListAppend(noBidsStayOpen1,getLots.lotID)>
				<CFELSE>
					<CFSET noBidsStayOpen1 = getLots.lotID>
				</CFIF>
			<CFELSEIF getLots.lotNoBidsStayOpenTimes EQ 2>
				<CFIF IsDefined("noBidsStayOpen2")>
					<CFSET reserveStayOpen2 = ListAppend(reserveStayOpen2,getLots.lotID)>
				<CFELSE>
					<CFSET reserveStayOpen2 = getLots.lotID>
				</CFIF>
			<CFELSEIF getLots.lotNoBidsStayOpenTimes EQ 3>
				<CFIF IsDefined("noBidsStayOpen3")>
					<CFSET noBidsStayOpen3 = ListAppend(noBidsStayOpen3,getLots.lotID)>
				<CFELSE>
					<CFSET noBidsStayOpen3 = getLots.lotID>
				</CFIF>
			<CFELSEIF IsDefined("noBidsStayOpen4plus")>
				<CFSET noBidsStayOpen4plus = ListAppend(noBidsStayOpen4plus,getLots.lotID)>
			<CFELSE>
				<CFSET noBidsStayOpen4plus = getLots.lotID>
			</CFIF>
		</CFIF>
	</CFIF>
</CFLOOP>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH=500>
<TH COLSPAN=3 BGCOLOR="#20A491"><FONT SIZE=4 COLOR=purple>Summary of Lot Status</FONT></TH>
<TR><TH BGCOLOR="#FFFFCE" NOWRAP><FONT SIZE=2>Lot Status</FONT></TH>
	<TH BGCOLOR="#FFFFCE"><FONT SIZE=2>#</FONT></TH>
	<TH BGCOLOR="#FFFFCE" WIDTH=400><FONT SIZE=2>Lot ID(s)</FONT></TH></TR>
<CFIF NOT IsDefined("statusInactive") AND NOT IsDefined("statusPreview") AND NOT IsDefined("statusOpen")
		AND NOT IsDefined("statusClosing") AND NOT IsDefined("statusClosed")>
	<TR><TD COLSPAN=3 ALIGN=center ><FONT SIZE=2>There are no lots in this category.</FONT></TD></TR>
</CFIF>
<TR><TD VALIGN=top ALIGN=right>Inactive: </TD>
<CFIF IsDefined("statusInactive")>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(statusInactive)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(statusInactive))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(statusInactive,loopCount)#">#ListGetAt(statusInactive,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(statusInactive)#">#ListLast(statusInactive)#</A></CFOUTPUT></FONT></TD></TR>
<CFELSE><TD ALIGN=center><FONT SIZE=2>0</FONT></TD><TD><FONT SIZE=2>(none)</FONT></TD></TR></CFIF>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right><FONT SIZE=2>Preview: </FONT></TD>
<CFIF IsDefined("statusPreview")>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(statusPreview)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(statusPreview))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(statusPreview,loopCount)#">#ListGetAt(statusPreview,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(statusPreview)#">#ListLast(statusPreview)#</A></CFOUTPUT></FONT></TD></TR>
<CFELSE><TD ALIGN=center><FONT SIZE=2>0</FONT></TD><TD><FONT SIZE=2>(none)</FONT></TD></TR></CFIF>
<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2>Open: </FONT></TD>
<CFIF IsDefined("statusOpen")>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(statusOpen)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(statusOpen))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(statusOpen,loopCount)#">#ListGetAt(statusOpen,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(statusOpen)#">#ListLast(statusOpen)#</A></CFOUTPUT></FONT></TD></TR>
<CFELSE><TD ALIGN=center><FONT SIZE=2>0</FONT></TD><TD><FONT SIZE=2>(none)</FONT></TD></TR></CFIF>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right><FONT SIZE=2>Closing: </FONT></TD>
<CFIF IsDefined("statusClosing")>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(statusClosing)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(statusClosing))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID##systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(statusClosing,loopCount)#">#ListGetAt(statusClosing,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(statusClosing)#">#ListLast(statusClosing)#</A></CFOUTPUT></FONT></TD></TR>
<CFELSE><TD ALIGN=center><FONT SIZE=2>0</FONT></TD><TD><FONT SIZE=2>(none)</FONT></TD></TR></CFIF>
<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2>Closed: </FONT></TD>
<CFIF IsDefined("statusClosed")>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(statusClosed)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(statusClosed))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(statusClosed,loopCount)#">#ListGetAt(statusClosed,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(statusClosed)#">#ListLast(statusClosed)#</A></CFOUTPUT></FONT></TD></TR>
<CFELSE><TD ALIGN=center><FONT SIZE=2>0</TD><TD><FONT SIZE=2>(none)</TD></TR></CFIF>
</TABLE>

<P>

<UL><TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH=500>
<TH COLSPAN=3 BGCOLOR="#20A491"><FONT SIZE=4 COLOR=purple>Summary of Lot Reserve Price</FONT></TH>
<TR><TH BGCOLOR="#FFFFCE" NOWRAP><FONT SIZE=2>Lot Status</FONT></TH>
	<TH BGCOLOR="#FFFFCE"><FONT SIZE=2>#</FONT></TH>
	<TH BGCOLOR="#FFFFCE" WIDTH=400><FONT SIZE=2>Lot ID(s)</FONT></TH></TR>
<CFIF NOT IsDefined("reserveMet") AND NOT IsDefined("reserveNotMet") AND NOT IsDefined("reserveStayOpen1")
		AND NOT IsDefined("reserveStayOpen2") AND NOT IsDefined("reserveStayOpen3") AND NOT IsDefined("reserveStayOpen4plus")>
	<TR><TD COLSPAN=3 ALIGN=center ><FONT SIZE=2>No lots have reserve prices. No lots have been extended for not having reached the reserve price.</FONT></TD></TR>
</CFIF>

<CFIF IsDefined("reserveMet")>
	<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2>Met: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(reserveMet)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(reserveMet))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(reserveMet,loopCount)#">#ListGetAt(reserveMet,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(reserveMet)#">#ListLast(reserveMet)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("reserveNotMet")>
	<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right><FONT SIZE=2>Not Met: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(reserveNotMet)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(reserveNotMet))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(reserveNotMet,loopCount)#">#ListGetAt(reserveNotMet,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(reserveNotMet)#">#ListLast(reserveNotMet)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("reserveStayOpen1")>
	<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2>Extended 1: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(reserveStayOpen1)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(reserveStayOpen1))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(reserveStayOpen1,loopCount)#">#ListGetAt(reserveStayOpen1,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(reserveStayOpen1)#">#ListLast(reserveStayOpen1)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("reserveStayOpen2")>
	<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right><FONT SIZE=2>Extended 2: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(reserveStayOpen2)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(reserveStayOpen2))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(reserveStayOpen2,loopCount)#">#ListGetAt(reserveStayOpen2,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(reserveStayOpen2)#">#ListLast(reserveStayOpen2)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("reserveStayOpen3")>
	<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2>Extended 3: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(reserveStayOpen3)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(reserveStayOpen3))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(reserveStayOpen3,loopCount)#">#ListGetAt(reserveStayOpen3,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(reserveStayOpen3)#">#ListLast(reserveStayOpen3)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("reserveStayOpen4plus")>
	<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right NOWRAP><FONT SIZE=2>Extended 4+: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(reserveStayOpen4plus)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(reserveStayOpen4plus))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(reserveStayOpen4plus,loopCount)#">#ListGetAt(reserveStayOpen4plus,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(reserveStayOpen4plus)#">#ListLast(reserveStayOpen4plus)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
</TABLE></UL>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH=500>
<TH COLSPAN=3 BGCOLOR="#20A491"><FONT SIZE=4 COLOR=purple>Summary of Lot Bids</FONT></TH>
<TR><TH BGCOLOR="#FFFFCE" NOWRAP><FONT SIZE=2>Lot Status</FONT></TH>
	<TH BGCOLOR="#FFFFCE"><FONT SIZE=2>#</FONT></TH>
	<TH BGCOLOR="#FFFFCE" WIDTH=400><FONT SIZE=2>Lot ID(s)</FONT></TH></TR>
<CFIF NOT IsDefined("noBids") AND NOT IsDefined("noBidsStayOpen1") AND NOT IsDefined("noBidsStayOpen2")
		AND NOT IsDefined("noBidsStayOpen3") AND NOT IsDefined("noBidsStayOpen4plus")>
	<TR><TD COLSPAN=3 ALIGN=center ><FONT SIZE=2>All lots have at least one bid. No lots have been extended for having no bids.</FONT></TD></TR>
</CFIF>
<CFIF IsDefined("noBids")>
	<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2>No Bids: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(noBids)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(noBids))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(noBids,loopCount)#">#ListGetAt(noBids,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(noBids)#">#ListLast(noBids)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("noBidsStayOpen1")>
	<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right><FONT SIZE=2>Extended 1: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(noBidsStayOpen1)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(noBidsStayOpen1))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(noBidsStayOpen1,loopCount)#">#ListGetAt(noBidsStayOpen1,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(noBidsStayOpen1)#">#ListLast(noBidsStayOpen1)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("noBidsStayOpen2")>
	<TR><TD VALIGN=top ALIGN=right><FONT SIZE=2>Extended 2: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(noBidsStayOpen2)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(noBidsStayOpen2))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(noBidsStayOpen2,loopCount)#">#ListGetAt(noBidsStayOpen2,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(noBidsStayOpen2)#">#ListLast(noBidsStayOpen2)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("noBidsStayOpen3")>
	<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right><FONT SIZE=2>Extended 3: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(noBidsStayOpen3)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(noBidsStayOpen3))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(noBidsStayOpen3,loopCount)#">#ListGetAt(noBidsStayOpen3,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(noBidsStayOpen3)#">#ListLast(noBidsStayOpen3)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF IsDefined("noBidsStayOpen4plus")>
	<TR><TD VALIGN=top ALIGN=right NOWRAP><FONT SIZE=2>Extended 4+: </FONT></TD>
	<TD VALIGN=top ALIGN=center><FONT SIZE=2><CFOUTPUT>#ListLen(noBidsStayOpen4plus)#</CFOUTPUT></FONT></TD><TD><FONT SIZE=2>
	<CFLOOP INDEX=loopCount FROM=1 TO=#DecrementValue(ListLen(noBidsStayOpen4plus))#>
		<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListGetAt(noBidsStayOpen4plus,loopCount)#">#ListGetAt(noBidsStayOpen4plus,loopCount)#</A>, </CFOUTPUT>
	</CFLOOP> 
	<CFOUTPUT><A HREF="#systemURL#/admin/categoryLots.cfm?categoryID=#categoryID####ListLast(noBidsStayOpen4plus)#">#ListLast(noBidsStayOpen4plus)#</A></CFOUTPUT></FONT></TD></TR>
</CFIF>
</TABLE>

<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>