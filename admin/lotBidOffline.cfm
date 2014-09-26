<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: View Category</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("manualBid")>
	<H3>Bid successfully completed! You may enter another bid below.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=400 ALIGN=left COLOR=purple><P>
</CFIF>

<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
	SELECT lotName, categoryID, nextBidMinimum, nextNextBidMinimum,
		lotQuantity, lotQuantityMaximum, lotBidIncrement
	FROM Lot
	WHERE lotID = #lotID#
</CFQUERY>

<CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#getLot.categoryID####lotID#">Return to category</A></CFOUTPUT>
<H1><FONT COLOR=purple>Offline Bid</FONT></H1>

<CFOUTPUT>
<FONT SIZE=4><B>Lot <A HREF="#systemURL#/lot.cfm?lotID=#lotID#">#lotID#</A>. #getLot.lotName#
<P>
<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TD ALIGN=right>Quantity: </TD><TD>#getLot.lotQuantity#</TD></TR>
<TR><TD ALIGN=right>Max. Quantity: </TD><TD>#getLot.lotQuantityMaximum#</TD></TR>
<TR><TD ALIGN=right>Bid Increment: </TD><TD>#LSCurrencyFormat(getLot.lotBidIncrement,"local")#</TD></TR>
<TR><TD ALIGN=right>Minimum Winning Bid: </TD><TD>#LSCurrencyFormat(getLot.nextBidMinimum,"local")#</TD></TR>
</TABLE>
</CFOUTPUT>
<P>

<CFFORM ACTION="#systemURL#/program/bid.cfm">
<INPUT TYPE=hidden NAME=IamOfflineBidder VALUE=1>
<INPUT TYPE=hidden NAME=password VALUE="ignore">
<CFOUTPUT><INPUT TYPE=hidden NAME=lotID VALUE="#lotID#"></CFOUTPUT>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD ALIGN=right>Bid date/time: </TD>
<TD></TD><TD>
<CFSET bidDateTime = Now()>
<CFINPUT TYPE=text NAME=bidDateMM SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(bidDateTime,'mm')# REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Bid month must be an integer between 1-12."> / 
 <CFINPUT TYPE=text NAME=bidDateDD SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(bidDateTime,'dd')# REQUIRED="Yes" RANGE="1,31" VALIDATE="integer" MESSAGE="Bid date must be an integer between 1-31."> / 
 <CFINPUT TYPE=text NAME=bidDateYYYY SIZE=4 MAXLENGTH=4 VALUE=#LSDateFormat(bidDateTime,'yyyy')# REQUIRED="Yes" RANGE="1998,9999" VALIDATE="integer" MESSAGE="Bid year is not a valid year."> , 
 <CFINPUT TYPE=text NAME=bidTimeHH SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(bidDateTime,'hh')#
	REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Bid hour must be an integer between 1-12."><B>:</B><CFINPUT TYPE=text NAME=bidTimeMM SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(bidDateTime,'mm')# REQUIRED="Yes" RANGE="0,59" VALIDATE="integer" MESSAGE="Bid minute must be an integer between 0-59."> 
<SELECT NAME=bidTimeAMPM SIZE=1>
	<OPTION VALUE=AM<CFIF LSTimeFormat(bidDateTime,"H") LT 12> SELECTED</CFIF>>AM
	<OPTION VALUE=PM<CFIF LSTimeFormat(bidDateTime,"H") GTE 12> SELECTED</CFIF>>PM
</SELECT> <FONT SIZE=2 COLOR=blue>(MM/DD/YYYY : HH:MM AM/PM)</FONT></TD></TR>

<TR><TD ALIGN=right>Username: </TD><TD></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED="Yes" MESSAGE="You must enter a username."></TD></TR>
<TR><TD ALIGN=right><BR>Current Bid: </TD><TD><BR>$</TD>
	<TD><BR><CFINPUT TYPE=text NAME="bidPrice" SIZE=10 VALUE="#Replace(DecimalFormat(getLot.nextBidMinimum), ",", "", "ALL")#" REQUIRED="Yes" VALIDATE="float" MESSAGE="You must enter the initial bid."></TD></TR>
<TR><TD ALIGN=right>Quantity: </TD><TD></TD>
	<TD><CFINPUT TYPE=text NAME="bidQuantity" SIZE=4 VALUE=#getLot.lotQuantity# REQUIRED="Yes" RANGE="1, #getLot.lotQuantity#" VALIDATE="integer" MESSAGE="Quantity must be between 1 and #getLot.lotQuantity#"> (maximum: <CFOUTPUT><CFIF getLot.lotQuantityMaximum EQ 0>#getLot.lotQuantity#<CFELSE>#getLot.lotQuantityMaximum#</CFIF></CFOUTPUT>)</TD></TR>
<TR><TD></TD><TD></TD>
	<TD><INPUT TYPE=checkbox NAME=bidFullQuantityOnly VALUE=1> Check to accept full quantity only</TD></TR>
<TR><TD></TD><TD></TD>
	<TD><INPUT TYPE=checkbox NAME=bidAuto VALUE=1> Automatically increment bid to maintain winning bid status</TD></TR>
<TR><TD ALIGN=right>Maximum Bid: </TD><TD>$</TD>
	<TD><CFINPUT TYPE=text NAME="bidPriceMaximum" SIZE=10 REQUIRED="No" VALIDATE="float" MESSAGE="The maximum bid must be a number."> (only if choosing auto-bid feature)</TD></TR>
<TR><TD ALIGN=right HEIGHT=40><INPUT TYPE=reset VALUE=Clear>  </TD><TD></TD>
	<TD HEIGHT=40> <INPUT TYPE=submit NAME=bidButton VALUE="Submit Bid"></TD></TR>
</TABLE>
</CFFORM>

<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">

</BODY>
</HTML>