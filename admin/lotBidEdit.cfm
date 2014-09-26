<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Edit Bid</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF NOT IsDefined("bidID")>
	<H3>No bid ID was defined.</H3>
	</BODY></HTML><CFABORT>
<CFELSEIF IsDefined("Form.first")>
	<CFIF Form.bidButton EQ "Delete Bid" AND NOT IsDefined("Form.okDelete")>
		<H3>You must check the checkbox to delete this bid.</H3>
		</BODY></HTML><CFABORT>
	<CFELSEIF Form.bidButton EQ "Delete Bid">
		<CFQUERY NAME=deleteBid DATASOURCE="#EAdatasource#">
			DELETE FROM Bid
			WHERE bidID = #Form.bidID#
		</CFQUERY>

		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
			SELECT lotBidCount, lotReservePrice, lotReservePriceMet, nextBidMinimum, lotBidIncrement
			FROM Lot
			WHERE lotID = #Form.lotID#
		</CFQUERY>
		<CFIF getLot.lotBidCount EQ 1>
			<CFSET lotBidsExist = 0>
			<CFIF getLot.lotReservePriceMet EQ 1><CFSET lotReservePriceMet = 0></CFIF>
		</CFIF>

		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
			UPDATE Lot
			SET lotBidCount = lotBidCount - 1
			<CFIF IsDefined("lotBidsExist")>
				, lotBidsExist = 0,
				nextBidMinimum = lotOpeningBid,
				nextNextBidMinimum = lotOpeningBid + lotBidIncrement
				<CFIF IsDefined("lotReservePriceMet")>, lotReservePriceMet = 0</CFIF>
			</CFIF>
			WHERE lotID = #Form.lotID#
		</CFQUERY>
	<CFELSE>
		<CFQUERY NAME=getUser DATASOURCE="#EAdatasource#">
			SELECT userID FROM Member WHERE username = '#Form.username#'
		</CFQUERY>
		<CFIF getUser.RecordCount NEQ 1>
			<H3>The user with username <CFOUTPUT>#Form.username#</CFOUTPUT> does not exist or is not unique.</H3>
			</BODY></HTML><CFABORT>
		</CFIF>

		<CFSET dateTimeNow = CreateODBCDateTime(Now())>
		<CFIF Form.bidTimeAMPM EQ "AM" AND Form.bidTimeHH NEQ 12>
			<CFSET bidHour = Form.bidTimeHH>
		<CFELSEIF Form.bidTimeAMPM EQ "PM" AND Form.bidTimeHH NEQ 12>
			<CFSET bidHour = Form.bidTimeHH + 12>
		<CFELSEIF Form.bidTimeAMPM EQ "AM" AND Form.bidTimeHH EQ 12>
			<CFSET bidHour = 0>
		<CFELSE><!--- Form.bidTimeAMPM EQ "PM" AND Form.bidTimeHH EQ 12 --->
			<CFSET bidHour = 12>
		</CFIF>
		<CFSET bidDateTime = CreateODBCDateTime(CreateDateTime(Form.bidDateYYYY, Form.bidDateMM, Form.bidDateDD, bidHour, Form.bidTimeMM, 0))>
	
		<CFIF Form.bidEditTimeAMPM EQ "AM" AND Form.bidEditTimeHH NEQ 12>
			<CFSET bidEditHour = Form.bidTimeHH>
		<CFELSEIF Form.bidEditTimeAMPM EQ "PM" AND Form.bidEditTimeHH NEQ 12>
			<CFSET bidEditHour = Form.bidEditTimeHH + 12>
		<CFELSEIF Form.bidEditTimeAMPM EQ "AM" AND Form.bidEditTimeHH EQ 12>
			<CFSET bidEditHour = 0>
		<CFELSE><!--- Form.bidEditTimeAMPM EQ "PM" AND Form.bidEditTimeHH EQ 12 --->
			<CFSET bidEditHour = 12>
		</CFIF>
		<CFSET bidEditDateTime = CreateODBCDateTime(CreateDateTime(Form.bidEditDateYYYY, Form.bidEditDateMM, Form.bidEditDateDD, bidEditHour, Form.bidEditTimeMM, 0))>

		<CFQUERY NAME=updateBid DATASOURCE="#EAdatasource#">
			UPDATE Bid
			SET bidPrice = #Form.bidPrice#,
				bidWin = 1,
				bidQuantity = #Form.bidQuantity#,
				bidQuantityWin = #Form.bidQuantity#,
				bidFullQuantityOnly = <CFIF IsDefined("Form.bidFullQuantityOnly")>1,<CFELSE>0,</CFIF>
				bidDateTime = #bidDateTime#,
				bidAuto = <CFIF IsDefined("Form.bidAuto")>1,<CFELSE>0,</CFIF>
				bidPriceMaximum = #Form.bidPriceMaximum#,
				bidPriceInitial = #Form.bidPriceInitial#,
				bidEditDateTime = #bidEditDateTime#,
				bidUpdateDateTime = #dateTimeNow#,
				userID = #getUser.userID#
			WHERE bidID = #Form.bidID#
		</CFQUERY>
	</CFIF>

	<CFIF NOT IsDefined("lotBidsExist")>
		<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
			SELECT nextBidMinimum, nextNextBidMinimum, lotReservePriceMet, lotBidsExist
			FROM Lot
			WHERE lotID = #lotID#
		</CFQUERY>
	
		<CFINCLUDE TEMPLATE="../system/emailEventsList.cfm">
		<CFINCLUDE TEMPLATE="../system/emailClose.cfm">
		<CFINCLUDE TEMPLATE="../system/bidOptions.cfm">
		<CFSET bidDateTime = CreateODBCDateTime(Now())>
		<CFINCLUDE TEMPLATE="../program/bidLogic.cfm">
	</CFIF>

	<CFIF Form.bidButton EQ "Delete Bid"><H3>Bid deleted.</H3><CFELSE><H3>Bid updated.</H3></CFIF>
	<P><HR NOSHADE SIZE=3 NOSHADE WIDTH=500 ALIGN=left COLOR=purple><P>
</CFIF>

<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
	SELECT Member.email, Member.firstName, Member.lastName, Member.username,
		Bid.lotID, Bid.bidDateTime, Bid.bidPrice, Bid.bidQuantity, Bid.bidAuto,
		Bid.bidPriceMaximum, Bid.bidFullQuantityOnly, Bid.bidWin, Bid.bidUpdateDateTime,
		Bid.bidPriceInitial, Bid.bidQuantityWin, Bid.userID, Bid.bidEditDateTime,
		Lot.lotName, Lot.nextBidMinimum, Lot.nextNextBidMinimum, Lot.lotBidIncrement,
		Lot.lotQuantity, Lot.lotQuantityMaximum
	FROM (Bid INNER JOIN Lot ON Bid.lotID = Lot.lotID) INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.bidID = #bidID#
</CFQUERY>

<CFIF getLot.RecordCount NEQ 1>
	<H3>This was not a valid bidID. Either the bid, lot or user does not exist.</H3>
	</BODY></HTML><CFABORT>
</CFIF>

<H1><FONT COLOR=purple>Edit Bid</FONT></H1>

<FONT SIZE=4><B>Lot <CFOUTPUT><A HREF="#systemURL#/lot.cfm?lotID=#getLot.lotID#">#getLot.lotID#</A>. #getLot.lotName#<P>
Bidder - #getLot.firstName# #getLot.lastName#</B></FONT><BR>
(<A HREF="mailto:#getLot.email#">#getLot.email#</A>)
<P>
<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TD ALIGN=right>Quantity: </TD><TD>#getLot.lotQuantity#</TD></TR>
<TR><TD ALIGN=right>Max. Quantity: </TD><TD>#getLot.lotQuantityMaximum#</TD></TR>
<TR><TD ALIGN=right>Bid Increment: </TD><TD>#LSCurrencyFormat(getLot.lotBidIncrement,"local")#</TD></TR>
<TR><TD ALIGN=right>Minimum Winning Bid: </TD><TD>#LSCurrencyFormat(getLot.nextBidMinimum,"local")#</TD></TR>
</TABLE>
</CFOUTPUT>
<P>

<CFFORM ACTION="lotBidEdit.cfm" NAME=lotBidEdit>
<INPUT TYPE=hidden NAME=first VALUE=1>
<CFOUTPUT>
	<INPUT TYPE=hidden NAME=bidID VALUE="#bidID#">
	<INPUT TYPE=hidden NAME=lotID VALUE="#getLot.lotID#">
</CFOUTPUT>

<INPUT TYPE=checkbox NAME=okDelete VALUE=1> Check and click to delete bid <INPUT TYPE=submit NAME=bidButton VALUE="Delete Bid">
<P><HR NOSHADE SIZE=3 COLOR=purple WIDTH=400 ALIGN=left><P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD ALIGN=right>Bid date/time: </TD><TD></TD><TD>
<CFINPUT TYPE=text NAME=bidDateMM SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(getLot.bidDateTime,'mm')# REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Bid month must be an integer between 1-12."> / 
 <CFINPUT TYPE=text NAME=bidDateDD SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(getLot.bidDateTime,'dd')# REQUIRED="Yes" RANGE="1,31" VALIDATE="integer" MESSAGE="Bid date must be an integer between 1-31."> / 
 <CFINPUT TYPE=text NAME=bidDateYYYY SIZE=4 MAXLENGTH=4 VALUE=#LSDateFormat(getLot.bidDateTime,'yyyy')# REQUIRED="Yes" RANGE="1998,9999" VALIDATE="integer" MESSAGE="Bid year is not a valid year."> , 
 <CFINPUT TYPE=text NAME=bidTimeHH SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(getLot.bidDateTime,'hh')#
	REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Bid hour must be an integer between 1-12."><B>:</B><CFINPUT TYPE=text NAME=bidTimeMM SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(getLot.bidDateTime,'mm')# REQUIRED="Yes" RANGE="0,59" VALIDATE="integer" MESSAGE="Bid minute must be an integer between 0-59."> 
<SELECT NAME=bidTimeAMPM SIZE=1>
	<OPTION VALUE=AM<CFIF LSTimeFormat(getLot.bidDateTime,"H") LT 12> SELECTED</CFIF>>AM
	<OPTION VALUE=PM<CFIF LSTimeFormat(getLot.bidDateTime,"H") GTE 12> SELECTED</CFIF>>PM
</SELECT> <FONT SIZE=2 COLOR=blue>(MM/DD/YYYY : HH:MM AM/PM)</FONT></TD></TR>

<TR><TD ALIGN=right>Bid edit date/time: </TD><TD></TD><TD>
<CFINPUT TYPE=text NAME=bidEditDateMM SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(getLot.bidEditDateTime,'mm')# REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Bid month must be an integer between 1-12."> / 
 <CFINPUT TYPE=text NAME=bidEditDateDD SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(getLot.bidEditDateTime,'dd')# REQUIRED="Yes" RANGE="1,31" VALIDATE="integer" MESSAGE="Bid date must be an integer between 1-31."> / 
 <CFINPUT TYPE=text NAME=bidEditDateYYYY SIZE=4 MAXLENGTH=4 VALUE=#LSDateFormat(getLot.bidEditDateTime,'yyyy')# REQUIRED="Yes" RANGE="1998,9999" VALIDATE="integer" MESSAGE="Bid year is not a valid year."> , 
 <CFINPUT TYPE=text NAME=bidEditTimeHH SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(getLot.bidEditDateTime,'hh')#
	REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Bid hour must be an integer between 1-12."><B>:</B><CFINPUT TYPE=text NAME=bidEditTimeMM SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(getLot.bidEditDateTime,'mm')# REQUIRED="Yes" RANGE="0,59" VALIDATE="integer" MESSAGE="Bid minute must be an integer between 0-59."> 
<SELECT NAME=bidEditTimeAMPM SIZE=1>
	<OPTION VALUE=AM<CFIF LSTimeFormat(getLot.bidEditDateTime,"H") LT 12> SELECTED</CFIF>>AM
	<OPTION VALUE=PM<CFIF LSTimeFormat(getLot.bidEditDateTime,"H") GTE 12> SELECTED</CFIF>>PM
</SELECT> <FONT SIZE=2 COLOR=blue>(MM/DD/YYYY : HH:MM AM/PM)</FONT></TD></TR>

<TR><TD ALIGN=right>Username: </TD><TD></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 VALUE="#getLot.username#" REQUIRED="Yes" MESSAGE="You must enter a username."></TD></TR>
<TR><TD ALIGN=right><BR>Initial Bid: </TD><TD><BR>$</TD>
	<TD><BR><CFINPUT TYPE=text NAME="bidPriceInitial" SIZE=10 VALUE="#Replace(DecimalFormat(getLot.bidPriceInitial), ",", "", "ALL")#" REQUIRED="Yes" VALIDATE="float" MESSAGE="You must enter the initial bid."></TD></TR>
<TR><TD ALIGN=right>Current Bid: </TD><TD>$</TD>
	<TD><CFINPUT TYPE=text NAME="bidPrice" SIZE=10 VALUE="#Replace(DecimalFormat(getLot.bidPrice), ",", "", "ALL")#" REQUIRED="Yes" VALIDATE="float" MESSAGE="You must enter the current bid."></TD></TR>
<TR><TD ALIGN=right>Quantity: </TD><TD></TD>
	<TD><CFINPUT TYPE=text NAME="bidQuantity" SIZE=4 VALUE=#getLot.bidQuantity# REQUIRED="Yes" RANGE="1, #getLot.lotQuantity#" VALIDATE="integer" MESSAGE="Quantity must be between 1 and #getLot.lotQuantity#"> (maximum: <CFOUTPUT><CFIF getLot.lotQuantityMaximum EQ 0>#getLot.lotQuantity#<CFELSE>#getLot.lotQuantityMaximum#</CFIF></CFOUTPUT>)</TD></TR>
<TR><TD></TD><TD></TD>
	<TD><INPUT TYPE=checkbox NAME=bidFullQuantityOnly VALUE=1<CFIF getLot.bidFullQuantityOnly EQ 1> CHECKED</CFIF>> Check to accept full quantity only</TD></TR>
<TR><TD></TD><TD></TD>
	<TD><INPUT TYPE=checkbox NAME=bidAuto VALUE=1<CFIF getLot.bidAuto EQ 1> CHECKED</CFIF>> Automatically increment bid to maintain winning bid status</TD></TR>
<TR><TD ALIGN=right>Maximum Bid: </TD><TD>$</TD>
	<TD><CFINPUT TYPE=text NAME="bidPriceMaximum" SIZE=10 VALUE="#Replace(DecimalFormat(getLot.bidPriceMaximum), ",", "", "ALL")#" REQUIRED="No" VALIDATE="float" MESSAGE="The maximum bid must be a number."> (only if choosing auto-bid feature)</TD></TR>
<TR><TD ALIGN=right HEIGHT=40><INPUT TYPE=reset VALUE=Clear></TD><TD></TD>
	<TD HEIGHT=40> <INPUT TYPE=submit NAME=bidButton VALUE="Edit Bid"></TD></TR>
</TABLE>
</CFFORM>

<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">

</BODY>
</HTML>