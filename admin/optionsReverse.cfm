<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Reverse Options</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF NOT IsDefined("Form.reverseBidDescription")><CFSET reverseBidDescription = 0></CFIF>
	<CFIF NOT IsDefined("Form.reverseBidDescriptionDisplay")><CFSET reverseBidDescriptionDisplay = 0></CFIF>
	<CFIF NOT IsDefined("Form.reverseBidDescriptionCheckboxSame")><CFSET reverseBidDescriptionCheckboxSame = 0></CFIF>
	<CFIF NOT IsDefined("Form.reverseBidAboveOpeningBid")><CFSET reverseBidAboveOpeningBid = 0></CFIF>
	<CFIF NOT IsDefined("Form.reverseDescriptionLog")><CFSET reverseDescriptionLog = 0></CFIF>

	<CFSET reverseBidTextBidMinimum = Replace(Form.reverseBidTextBidMinimum, """", "&quot;", "ALL")>
	<CFSET reverseBidTextBidDescription = Replace(Form.reverseBidTextBidDescription, """", "&quot;", "ALL")>
	<CFSET reverseBidDescriptionCheckboxText = Replace(Form.reverseBidDescriptionCheckboxText, """", "&quot;", "ALL")>
	<CFSET reversebadBidPriceHigh = Replace(Form.reversebadBidPriceHigh, """", "&quot;", "ALL")>
	<CFSET reverseBadBidPriceMaximumHigh = Replace(Form.reverseBadBidPriceMaximumHigh, """", "&quot;", "ALL")>
	<CFSET reverseBidLogicOrder = Replace(Form.reverseBidLogicOrder, """", "&quot;", "ALL")>
	<CFSET reverseBadUpdateBidPriceMore = Replace(Form.reverseBadUpdateBidPriceMore, """", "&quot;", "ALL")>
	<CFSET reverseBadBidPriceMaximumEmpty = Replace(Form.reverseBadBidPriceMaximumEmpty, """", "&quot;", "ALL")>
	<CFSET reverseBadUpdateBidPriceMaximumMore = Replace(Form.reverseBadUpdateBidPriceMaximumMore, """", "&quot;", "ALL")>
	<CFSET reverseBadBidPriceMaximumIncrement = Replace(Form.reverseBadBidPriceMaximumIncrement, """", "&quot;", "ALL")>
	<CFSET reverseBidTextBidError = Replace(Form.reverseBidTextBidError, """", "&quot;", "ALL")>
	<CFSET reverseBidTextBidMaximumError = Replace(Form.reverseBidTextBidMaximumError, """", "&quot;", "ALL")>

	<CFSET reverseDescriptionNoLot = Replace(Form.reverseDescriptionNoLot, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionBaddLot = Replace(Form.reverseDescriptionBaddLot, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionNoBidder = Replace(Form.reverseDescriptionNoBidder, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionBadBidder = Replace(Form.reverseDescriptionBadBidder, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionBadBid = Replace(Form.reverseDescriptionBadBid, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionReturnToLot = Replace(Form.reverseDescriptionReturnToLot, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionBlank = Replace(Form.reverseDescriptionBlank, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionBidder = Replace(Form.reverseDescriptionBidder, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionBid = Replace(Form.reverseDescriptionBid, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionQuantity = Replace(Form.reverseDescriptionQuantity, """", "&quot;", "ALL")>
	<CFSET reverseDescriptionDescription = Replace(Form.reverseDescriptionDescription, """", "&quot;", "ALL")>

	<CFSET reverseBidTextBidMinimum = Replace(reverseBidTextBidMinimum, "##", "####", "ALL")>
	<CFSET reverseBidTextBidDescription = Replace(reverseBidTextBidDescription, "##", "####", "ALL")>
	<CFSET reverseBidDescriptionCheckboxText = Replace(reverseBidDescriptionCheckboxText, "##", "####", "ALL")>
	<CFSET reversebadBidPriceHigh = Replace(reversebadBidPriceHigh, "##", "####", "ALL")>
	<CFSET reverseBadBidPriceMaximumHigh = Replace(reverseBadBidPriceMaximumHigh, "##", "####", "ALL")>
	<CFSET reverseBidLogicOrder = Replace(reverseBidLogicOrder, "##", "####", "ALL")>
	<CFSET reverseBadUpdateBidPriceMore = Replace(reverseBadUpdateBidPriceMore, "##", "####", "ALL")>
	<CFSET reverseBadBidPriceMaximumEmpty = Replace(reverseBadBidPriceMaximumEmpty, "##", "####", "ALL")>
	<CFSET reverseBadUpdateBidPriceMaximumMore = Replace(reverseBadUpdateBidPriceMaximumMore, "##", "####", "ALL")>
	<CFSET reverseBadBidPriceMaximumIncrement = Replace(reverseBadBidPriceMaximumIncrement, "##", "####", "ALL")>
	<CFSET reverseBidTextBidError_file = Replace(reverseBidTextBidError, "##", "####", "ALL")>
	<CFSET reverseBidTextBidMaximumError_file = Replace(reverseBidTextBidMaximumError, "##", "####", "ALL")>

	<CFSET reverseDescriptionNoLot = Replace(reverseDescriptionNoLot, "##", "####", "ALL")>
	<CFSET reverseDescriptionBaddLot = Replace(reverseDescriptionBaddLot, "##", "####", "ALL")>
	<CFSET reverseDescriptionNoBidder = Replace(reverseDescriptionNoBidder, "##", "####", "ALL")>
	<CFSET reverseDescriptionBadBidder = Replace(reverseDescriptionBadBidder, "##", "####", "ALL")>
	<CFSET reverseDescriptionBadBid = Replace(reverseDescriptionBadBid, "##", "####", "ALL")>
	<CFSET reverseDescriptionReturnToLot = Replace(reverseDescriptionReturnToLot, "##", "####", "ALL")>
	<CFSET reverseDescriptionBlank = Replace(reverseDescriptionBlank, "##", "####", "ALL")>
	<CFSET reverseDescriptionBidder = Replace(reverseDescriptionBidder, "##", "####", "ALL")>
	<CFSET reverseDescriptionBid = Replace(reverseDescriptionBid,"##", "####", "ALL")>
	<CFSET reverseDescriptionQuantity = Replace(reverseDescriptionQuantity, "##", "####", "ALL")>
	<CFSET reverseDescriptionDescription = Replace(reverseDescriptionDescription, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\bidReverse.cfm"
		OUTPUT="<CFSET reverseLowBidAutoWins = #Form.reverseLowBidAutoWins#>
<CFSET reverseBidAboveOpeningBid = #reverseBidAboveOpeningBid#>
<CFSET reverseBidDescription = #reverseBidDescription#>
<CFSET reverseBidDescriptionDisplay = #reverseBidDescriptionDisplay#>
<CFSET reverseBidDisplayAllBids = #Form.reverseBidDisplayAllBids#>
<CFSET reverseBidTextBidMinimum = ""#reverseBidTextBidMinimum#"">
<CFSET reverseBidTextBidDescription = ""#reverseBidTextBidDescription#"">
<CFSET reverseBidDescriptionCheckboxSame = #reverseBidDescriptionCheckboxSame#>
<CFSET reverseBidDescriptionCheckboxText = ""#reverseBidDescriptionCheckboxText#"">

<CFSET reversebadBidPriceHigh = ""#reversebadBidPriceHigh#"">
<CFSET reverseBadBidPriceMaximumHigh = ""#reverseBadBidPriceMaximumHigh#"">
<CFSET reverseBidLogicOrder = ""#reverseBidLogicOrder#"">
<CFSET reverseBadUpdateBidPriceMore = ""#reverseBadUpdateBidPriceMore#"">
<CFSET reverseBadBidPriceMaximumEmpty = ""#reverseBadBidPriceMaximumEmpty#"">
<CFSET reverseBadUpdateBidPriceMaximumMore = ""#reverseBadUpdateBidPriceMaximumMore#"">
<CFSET reverseBadBidPriceMaximumIncrement = ""#reverseBadBidPriceMaximumIncrement#"">

<CFPARAM NAME=getLot.nextBidMinimum DEFAULT=0>
<CFPARAM NAME=getLot.nextNextBidMinimum DEFAULT=0>
<CFSET reverseBidTextBidError = ""#reverseBidTextBidError#"">
<CFSET reverseBidTextBidMaximumError = ""#reverseBidTextBidMaximumError#"">
<CFSET reverseBidTextBidError_file = ""#reverseBidTextBidError_file#"">
<CFSET reverseBidTextBidMaximumError_file = ""#reverseBidTextBidMaximumError_file#"">

<CFSET reverseDescriptionNoLot = ""#reverseDescriptionNoLot#"">
<CFSET reverseDescriptionBaddLot = ""#reverseDescriptionBaddLot#"">
<CFSET reverseDescriptionNoBidder = ""#reverseDescriptionNoBidder#"">
<CFSET reverseDescriptionBadBidder = ""#reverseDescriptionBadBidder#"">
<CFSET reverseDescriptionBadBid = ""#reverseDescriptionBadBid#"">
<CFSET reverseDescriptionReturnToLot = ""#reverseDescriptionReturnToLot#"">
<CFSET reverseDescriptionBlank = ""#reverseDescriptionBlank#"">
<CFSET reverseDescriptionBidder = ""#reverseDescriptionBidder#"">
<CFSET reverseDescriptionBid = ""#reverseDescriptionBid#"">
<CFSET reverseDescriptionQuantity = ""#reverseDescriptionQuantity#"">
<CFSET reverseDescriptionDescription = ""#reverseDescriptionDescription#"">
<CFSET reverseDescriptionLog = #reverseDescriptionLog#>">

	<H3>Reverse options updated.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=500 ALIGN=left COLOR=purple><P>
</CFIF>

<CFINCLUDE TEMPLATE="../system/bidReverse.cfm">
<H1><FONT COLOR=purple FACE=Arial>Reverse Options</FONT></H1>

<CFFORM NAME=optionsReverse ACTION=optionsReverse.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>

<TR><TD	COLSPAN=2><INPUT TYPE=radio NAME=reverseLowBidAutoWins VALUE=1<CFIF reverseLowBidAutoWins EQ 1> CHECKED</CFIF>> Lowest bidder automatically wins <FONT SIZE=2>(new bids must be less than existing bid)</FONT><BR>
	<INPUT TYPE=radio NAME=reverseLowBidAutoWins VALUE=0<CFIF reverseLowBidAutoWins EQ 0> CHECKED</CFIF>> Choose winner manually after item closes</TD></TR>
<TR BGCOLOR=DCDCDC><TD	COLSPAN=2><INPUT TYPE=checkbox NAME=reverseBidAboveOpeningBid VALUE=1<CFIF reverseBidAboveOpeningBid EQ 1> CHECKED</CFIF>> Allow bids above opening bid</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Bid Logic: </TD>
	<TD><INPUT TYPE=radio NAME=reverseBidLogicOrder VALUE="Bid.bidPriceMaximum, Bid.bidQuantity DESC, Bid.bidEditDateTime"<CFIF reverseBidLogicOrder EQ "Bid.bidPriceMaximum, Bid.bidQuantity DESC, Bid.bidEditDateTime"> CHECKED</CFIF>> Minimum Bid, Bid Quantity, Bid Date/Time<BR>
	<INPUT TYPE=radio NAME=reverseBidLogicOrder VALUE="Bid.bidPriceMaximum, Bid.bidEditDateTime, Bid.bidQuantity DESC"<CFIF reverseBidLogicOrder EQ "Bid.bidPriceMaximum, Bid.bidEditDateTime, Bid.bidQuantity DESC"> CHECKED</CFIF>> Minimum Bid, Bid Date/Time, Bid Quantity<BR>
	<INPUT TYPE=radio NAME=reverseBidLogicOrder VALUE="Bid.bidPriceMaximum, Bid.bidEditDateTime"<CFIF reverseBidLogicOrder EQ "Bid.bidPriceMaximum, Bid.bidEditDateTime"> CHECKED</CFIF>> Minimum Bid, Bid Date/Time</TD></TR>
<TR BGCOLOR=DCDCDC><TD	COLSPAN=2><INPUT TYPE=radio NAME=reverseBidDisplayAllBids VALUE=0<CFIF reverseBidDisplayAllBids EQ 0> CHECKED</CFIF>> Display only winning bid(s) on lot page<BR>
	<INPUT TYPE=radio NAME=reverseBidDisplayAllBids VALUE=1<CFIF reverseBidDisplayAllBids EQ 1> CHECKED</CFIF>> Display all bids on lot page</TD></TR>
<TR><TD COLSPAN=2><INPUT TYPE=checkbox NAME=reverseBidDescription VALUE=1<CFIF reverseBidDescription EQ 1> CHECKED</CFIF>> Display bid description field<BR>
	&nbsp; &nbsp; &nbsp; <INPUT TYPE=checkbox NAME=reverseBidDescriptionCheckboxSame VALUE=1<CFIF reverseBidDescriptionCheckboxSame EQ 1> CHECKED</CFIF>> Display checkbox to allow keeping existing description when updating bid<BR>
	&nbsp; &nbsp; &nbsp; <INPUT TYPE=checkbox NAME=reverseBidDescriptionDisplay VALUE=1<CFIF reverseBidDescriptionDisplay EQ 1> CHECKED</CFIF>> Display link to bid description on lot page<BR>
	&nbsp; &nbsp; &nbsp; Description Checkbox:<BR>
	&nbsp; &nbsp; &nbsp; <CFINPUT TYPE=text NAME=reverseBidDescriptionCheckboxText SIZE=73 VALUE="#reverseBidDescriptionCheckboxText#"></TD></TR>
</TABLE>

<P>
&nbsp; &nbsp; &nbsp; <INPUT TYPE=submit VALUE="Update Reverse Options">
<P>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Minimum Bid: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBidTextBidMinimum SIZE=20 VALUE="#reverseBidTextBidMinimum#"></TD></TR>
<TR><TD ALIGN=right>Bid Description: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBidTextBidDescription SIZE=20 VALUE="#reverseBidTextBidDescription#"></TD></TR>

<TR BGCOLOR=DCDCDC><TD ALIGN=right>Bid Too High<BR>(bid form): </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBidTextBidError SIZE=60 VALUE="#reverseBidTextBidError_file#"></TD></TR>
<TR><TD ALIGN=right>Minimum Bid <BR>Too High (bid form): </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBidTextBidMaximumError SIZE=60 VALUE="#reverseBidTextBidMaximumError_file#"></TD></TR>

<TR BGCOLOR=DCDCDC><TD ALIGN=right>Bid Amount <BR>Too High: </TD>
	<TD><CFINPUT TYPE=text NAME=reversebadBidPriceHigh SIZE=60 VALUE="#reversebadBidPriceHigh#"></TD></TR>
<TR><TD ALIGN=right>Minimum Bid <BR>Too High: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBadBidPriceMaximumHigh SIZE=60 VALUE="#reverseBadBidPriceMaximumHigh#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Updated Bid <BR>Too High: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBadUpdateBidPriceMore SIZE=60 VALUE="#reverseBadUpdateBidPriceMore#"></TD></TR>
<TR><TD ALIGN=right>Updated Mininmum<BR>Bid Too High: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBadUpdateBidPriceMaximumMore SIZE=60 VALUE="#reverseBadUpdateBidPriceMaximumMore#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Blank Bid: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBadBidPriceMaximumEmpty SIZE=60 VALUE="#reverseBadBidPriceMaximumEmpty#"></TD></TR>
<TR><TD ALIGN=right>Blank Minimum Bid: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseBadBidPriceMaximumIncrement SIZE=60 VALUE="#reverseBadBidPriceMaximumIncrement#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TR><TH COLSPAN=2><FONT SIZE=5 FACE=Arial COLOR=purple>View Bid Description Options</FONT></TH></TR>
<TR BGCOLOR=DCDCDC><TD COLSPAN=2><INPUT TYPE=checkbox NAME=reverseDescriptionLog VALUE=1<CFIF reverseDescriptionLog EQ 1> CHECKED</CFIF>>Log when descriptions are viewed <FONT SIZE=2>(bidder, seller who posted item, and date/time)</FONT></TD></TR>
<TR><TD ALIGN=right>No lot specified: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionNoLot SIZE=50 VALUE="#reverseDescriptionNoLot#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Lot does not exist: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionBaddLot SIZE=50 VALUE="#reverseDescriptionBaddLot#"></TD></TR>
<TR><TD ALIGN=right>No bidder specified: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionNoBidder SIZE=50 VALUE="#reverseDescriptionNoBidder#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Bidder blank: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionBadBidder SIZE=50 VALUE="#reverseDescriptionBadBidder#"></TD></TR>
<TR><TD ALIGN=right>Bidder did not<BR>bid on this lot: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionBadBid SIZE=50 VALUE="#reverseDescriptionBadBid#"></TD></TR>

<TR BGCOLOR=DCDCDC><TD ALIGN=right>Description is blank: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionBlank SIZE=50 VALUE="#reverseDescriptionBlank#"></TD></TR>
<TR><TD ALIGN=right>Bidder: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionBidder SIZE=30 VALUE="#reverseDescriptionBidder#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Bid Price: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionBid SIZE=30 VALUE="#reverseDescriptionBid#"></TD></TR>
<TR><TD ALIGN=right>Bid Quantity: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionQuantity SIZE=30 VALUE="#reverseDescriptionQuantity#"></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Bid Description: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionDescription SIZE=30 VALUE="#reverseDescriptionDescription#"></TD></TR>
<TR><TD ALIGN=right>Return to lot: </TD>
	<TD><CFINPUT TYPE=text NAME=reverseDescriptionReturnToLot SIZE=50 VALUE="#reverseDescriptionReturnToLot#"></TD></TR>
</TABLE>

<P>
&nbsp; &nbsp; &nbsp; <INPUT TYPE=submit VALUE="Update Reverse Options">
</CFFORM>

</body>
</html>
