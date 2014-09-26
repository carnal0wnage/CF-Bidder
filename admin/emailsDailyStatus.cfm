<!--- Emaze Auction version 2.1, 1.03 / Sunday, July 4, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Daily Status Email</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF NOT IsDefined("Form.openLotsBid")><CFSET openLotsBid = 0></CFIF>
	<CFIF NOT IsDefined("Form.openLotsWatch")><CFSET openLotsWatch = 0></CFIF>
	<CFIF NOT IsDefined("Form.closedLotsBid")><CFSET closedLotsBid = 0></CFIF>
	<CFIF NOT IsDefined("Form.closedLotsWatch")><CFSET closedLotsWatch = 0></CFIF>
	<CFIF NOT IsDefined("Form.subscribedCategory")><CFSET subscribedCategory = 0></CFIF>

	<CFSET e_fromnameDailyStatus = Replace(Form.e_fromnameDailyStatus, """", "&quot;", "ALL")>
	<CFSET e_fromemailDailyStatus = Replace(Form.e_fromemailDailyStatus, """", "&quot;", "ALL")>
	<CFSET e_subjectDailyStatus = Replace(Form.e_subjectDailyStatus, """", "&quot;", "ALL")>
	<CFSET openLotsBidHeading = Replace(Form.openLotsBidHeading, """", "&quot;", "ALL")>
	<CFSET openLotsWatchHeading = Replace(Form.openLotsWatchHeading, """", "&quot;", "ALL")>
	<CFSET closedLotsBidHeading = Replace(Form.closedLotsBidHeading, """", "&quot;", "ALL")>
	<CFSET closedLotsWatchHeading = Replace(Form.closedLotsWatchHeading, """", "&quot;", "ALL")>
	<CFSET subscribedCategoryHeading = Replace(Form.subscribedCategoryHeading, """", "&quot;", "ALL")>
	<CFSET bidPriceHeading = Replace(Form.bidPriceHeading, """", "&quot;", "ALL")>
	<CFSET bidPriceInitialHeading = Replace(Form.bidPriceInitialHeading, """", "&quot;", "ALL")>
	<CFSET bidPriceMaximumHeading = Replace(Form.bidPriceMaximumHeading, """", "&quot;", "ALL")>
	<CFSET bidQuantityHeading = Replace(Form.bidQuantityHeading, """", "&quot;", "ALL")>
	<CFSET bidQuantityWinHeading = Replace(Form.bidQuantityWinHeading, """", "&quot;", "ALL")>
	<CFSET bidWinHeading = Replace(Form.bidWinHeading, """", "&quot;", "ALL")>
	<CFSET bidWinYesHeading = Replace(Form.bidWinYesHeading, """", "&quot;", "ALL")>
	<CFSET bidWinNoHeading = Replace(Form.bidWinNoHeading, """", "&quot;", "ALL")>
	<CFSET lotReservePriceMetHeading = Replace(Form.lotReservePriceMetHeading, """", "&quot;", "ALL")>
	<CFSET lotReservePriceNotMetHeading = Replace(Form.lotReservePriceNotMetHeading, """", "&quot;", "ALL")>
	<CFSET bidTotalPriceHeading = Replace(Form.bidTotalPriceHeading, """", "&quot;", "ALL")>
	<CFSET lotIDHeading = Replace(Form.lotIDHeading, """", "&quot;", "ALL")>
	<CFSET lotNameHeading = Replace(Form.lotNameHeading, """", "&quot;", "ALL")>
	<CFSET lotQuantityHeading = Replace(Form.lotQuantityHeading, """", "&quot;", "ALL")>
	<CFSET lotOpeningBidHeading = Replace(Form.lotOpeningBidHeading, """", "&quot;", "ALL")>
	<CFSET lotOpenDateTimeHeading = Replace(Form.lotOpenDateTimeHeading, """", "&quot;", "ALL")>
	<CFSET lotCloseDateTimeHeading = Replace(Form.lotCloseDateTimeHeading, """", "&quot;", "ALL")>
	<CFSET lotHighBidHeading = Replace(Form.lotHighBidHeading, """", "&quot;", "ALL")>
	<CFSET nextBidMinimumHeading = Replace(Form.nextBidMinimumHeading, """", "&quot;", "ALL")>
	<CFSET categoryNameHeading = Replace(Form.categoryNameHeading, """", "&quot;", "ALL")>
	<CFSET newLotSeparator = Replace(Form.newLotSeparator, """", "&quot;", "ALL")>

	<CFSET e_fromnameDailyStatus = Replace(e_fromnameDailyStatus, "##", "####", "ALL")>
	<CFSET e_fromemailDailyStatus = Replace(e_fromemailDailyStatus, "##", "####", "ALL")>
	<CFSET e_subjectDailyStatus = Replace(e_subjectDailyStatus, "##", "####", "ALL")>
	<CFSET openLotsBidHeading = Replace(openLotsBidHeading, "##", "####", "ALL")>
	<CFSET openLotsWatchHeading = Replace(openLotsWatchHeading, "##", "####", "ALL")>
	<CFSET closedLotsBidHeading = Replace(closedLotsBidHeading, "##", "####", "ALL")>
	<CFSET closedLotsWatchHeading = Replace(closedLotsWatchHeading, "##", "####", "ALL")>
	<CFSET subscribedCategoryHeading = Replace(subscribedCategoryHeading, "##", "####", "ALL")>
	<CFSET bidPriceHeading = Replace(bidPriceHeading, "##", "####", "ALL")>
	<CFSET bidPriceInitialHeading = Replace(bidPriceInitialHeading, "##", "####", "ALL")>
	<CFSET bidPriceMaximumHeading = Replace(bidPriceMaximumHeading, "##", "####", "ALL")>
	<CFSET bidQuantityHeading = Replace(bidQuantityHeading, "##", "####", "ALL")>
	<CFSET bidQuantityWinHeading = Replace(bidQuantityWinHeading, "##", "####", "ALL")>
	<CFSET bidTotalPriceHeading = Replace(bidTotalPriceHeading, "##", "####", "ALL")>
	<CFSET bidWinHeading = Replace(bidWinHeading, "##", "####", "ALL")>
	<CFSET bidWinYesHeading = Replace(bidWinYesHeading, "##", "####", "ALL")>
	<CFSET bidWinNoHeading = Replace(bidWinNoHeading, "##", "####", "ALL")>
	<CFSET lotReservePriceMetHeading = Replace(lotReservePriceMetHeading, "##", "####", "ALL")>
	<CFSET lotReservePriceNotMetHeading = Replace(lotReservePriceNotMetHeading, "##", "####", "ALL")>
	<CFSET lotIDHeading = Replace(lotIDHeading, "##", "####", "ALL")>
	<CFSET lotNameHeading = Replace(lotNameHeading, "##", "####", "ALL")>
	<CFSET lotQuantityHeading = Replace(lotQuantityHeading, "##", "####", "ALL")>
	<CFSET lotOpeningBidHeading = Replace(lotOpeningBidHeading, "##", "####", "ALL")>
	<CFSET lotOpenDateTimeHeading = Replace(lotOpenDateTimeHeading, "##", "####", "ALL")>
	<CFSET lotCloseDateTimeHeading = Replace(lotCloseDateTimeHeading, "##", "####", "ALL")>
	<CFSET lotHighBidHeading = Replace(lotHighBidHeading, "##", "####", "ALL")>
	<CFSET nextBidMinimumHeading = Replace(nextBidMinimumHeading, "##", "####", "ALL")>
	<CFSET categoryNameHeading = Replace(categoryNameHeading, "##", "####", "ALL")>
	<CFSET newLotSeparator = Replace(newLotSeparator, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\dailyStatusOptions.cfm"
		OUTPUT="<CFSET e_fromnameDailyStatus = ""#e_fromnameDailyStatus#"">
<CFSET e_fromemailDailyStatus = ""#e_fromemailDailyStatus#"">
<CFSET e_subjectDailyStatus = ""#e_subjectDailyStatus#"">
<CFSET openLotsBid = #openLotsBid#>
<CFSET openLotsWatch = #openLotsWatch#>
<CFSET closedLotsBid = #closedLotsBid#>
<CFSET closedLotsWatch = #closedLotsWatch#>
<CFSET subscribedCategory = #subscribedCategory#>

<CFSET bidPriceHeading = ""#bidPriceHeading#"">
<CFSET bidPriceInitialHeading = ""#bidPriceInitialHeading#"">
<CFSET bidPriceMaximumHeading = ""#bidPriceMaximumHeading#"">
<CFSET bidQuantityHeading = ""#bidQuantityHeading#"">
<CFSET bidQuantityWinHeading = ""#bidQuantityWinHeading#"">
<CFSET bidWinHeading = ""#bidWinHeading#"">
<CFSET bidWinYesHeading = ""#bidWinYesHeading#"">
<CFSET bidWinNoHeading = ""#bidWinNoHeading#"">
<CFSET bidTotalPriceHeading = ""#bidTotalPriceHeading#"">
<CFSET lotReservePriceMetHeading = ""#lotReservePriceMetHeading#"">
<CFSET lotReservePriceNotMetHeading = ""#lotReservePriceNotMetHeading#"">
<CFSET lotIDHeading = ""#lotIDHeading#"">
<CFSET lotNameHeading = ""#lotNameHeading#"">
<CFSET lotQuantityHeading = ""#lotQuantityHeading#"">
<CFSET lotOpeningBidHeading = ""#lotOpeningBidHeading#"">
<CFSET lotOpenDateTimeHeading = ""#lotOpenDateTimeHeading#"">
<CFSET lotCloseDateTimeHeading = ""#lotCloseDateTimeHeading#"">
<CFSET lotHighBidHeading = ""#lotHighBidHeading#"">
<CFSET nextBidMinimumHeading = ""#nextBidMinimumHeading#"">
<CFSET categoryNameHeading = ""#categoryNameHeading#"">
<CFSET newLotSeparator = ""#newLotSeparator#"">

<CFSET openLotsBidHeading = ""#openLotsBidHeading#"">
<CFSET openLotsWatchHeading = ""#openLotsWatchHeading#"">
<CFSET closedLotsBidHeading = ""#closedLotsBidHeading#"">
<CFSET closedLotsWatchHeading = ""#closedLotsWatchHeading#"">
<CFSET subscribedCategoryHeading = ""#subscribedCategoryHeading#"">">

	<CFFILE ACTION=Write FILE="#systemPath#\email\emailDailyStatus.cfm" OUTPUT="
<CFMAIL TO=""##bidderEmail##""
	FROM=""##e_fromemailDailyStatus##""
	SUBJECT=""##e_subjectDailyStatus##""
	SERVER=""##emailServer##"">
#dailyStatusHeader#

##dailyStatusEmail##

#dailyStatusFooter#

</CFMAIL>">

	<CFIF Form.dailyStatusHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\dailyStatusHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET dailyStatusHeader = Replace(Form.dailyStatusHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\dailyStatusHeader.cfm" OUTPUT="#dailyStatusHeader#">
	</CFIF>

	<CFIF Form.dailyStatusFooter EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\dailyStatusFooter.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET dailyStatusFooter = Replace(Form.dailyStatusFooter, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\dailyStatusFooter.cfm" OUTPUT="#dailyStatusFooter#">
	</CFIF>

	<H3><I>Daily</I> status email updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B><I>Daily</I> Status Emails</B></FONT>

<P>We call it a <I>daily</I> status email, but you can run it however often you want, such as weekly, every other day, etc. The daily status email is designed to do the following:

<UL>
<LI TYPE=square>Email the status of bids on all open and recently closed lots
<LI TYPE=square>Email the status of all open or recently closed lots that the user is watching
<LI TYPE=square>Email the list of new items posted to the categories each user subscribes to
</UL>

<P>To run the script, you call the system via the following URL:
<P><BLOCKQUOTE><CFOUTPUT>#systemURL#/program/dailyStatus.cfm?emazedaily</CFOUTPUT></BLOCKQUOTE>
<P>The <I>?emazedaily</I> component is added to ensure that someone does not just call the URL directly and send the emails.
<P>You should also probably add a RequestTimeOut variable to the URL. This will change the number of seconds until the script times out. The server will time out a script to prevent it from running forever. Set the timeout value to a time high enough to run thru the entire script. So the full URL would now be something like:<P>
<BLOCKQUOTE><CFOUTPUT>#secureSystemURL#/seller/chargeSeller.cfm?emazecharge&amp;RequestTimeOut=500</CFOUTPUT></BLOCKQUOTE><P>
This would let the script run for 500 seconds before it times out.
<P>

<CFINCLUDE TEMPLATE="../system/dailyStatusOptions.cfm">

<CFFORM ACTION=emailsDailyStatus.cfm NAME=emailsDailyStatus>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH BGCOLOR=FFFFCE>Email</TH>
	<TH BGCOLOR=FFFFCE>From Name</TH>
	<TH BGCOLOR=FFFFCE>Reply-to Email</TH></TR>
<TR BGCOLOR=DCDCDC><TD>Daily Status</TD>
	<TD><CFINPUT TYPE=text NAME=e_fromnameDailyStatus SIZE=25 VALUE="#e_fromnameDailyStatus#"> <FONT SIZE=2>(leave blank for no name)</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=e_fromemailDailyStatus SIZE=25 VALUE="#e_fromemailDailyStatus#" REQUIRED="Yes" MESSAGE="You must enter a reply-to email address for the daily status email."></TD></TR>
<TR BGCOLOR=DCDCDC><TD ALIGN=right>Subject: </TD>
	<TD COLSPAN=2><CFINPUT TYPE=text NAME=e_subjectDailyStatus SIZE=35 VALUE="#e_subjectDailyStatus#" REQUIRED="Yes" MESSAGE="You must enter a subject for the daily status email."></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH BGCOLOR=FFFFCE COLSPAN=2><FONT SIZE=4 FACE=Arial>Lots to include:</FONT><BR></TH>
	<TH BGCOLOR=FFFFCE>Text Heading</TH></TR>
<TR><TD>Open lots user has bid on</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=openLotsBid VALUE=1<CFIF openLotsBid EQ 1> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=openLotsBidHeading SIZE=50 VALUE="#openLotsBidHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD>Lots user has bid on closed since last email</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=closedLotsBid VALUE=1<CFIF closedLotsBid EQ 1> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=openLotsWatchHeading SIZE=50 VALUE="#openLotsWatchHeading#"></TD></TR>
<TR><TD>Open lots user is watching</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=openLotsWatch VALUE=1<CFIF openLotsWatch EQ 1> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=closedLotsBidHeading SIZE=50 VALUE="#closedLotsBidHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD>Lots user is watching closed since last email</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=closedLotsWatch VALUE=1<CFIF closedLotsWatch EQ 1> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=closedLotsWatchHeading SIZE=50 VALUE="#closedLotsWatchHeading#"></TD></TR>
<TR><TD>New lots in subscribed categories</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=subscribedCategory VALUE=1<CFIF subscribedCategory EQ 1> CHECKED</CFIF>></TD>
	<TD><CFINPUT TYPE=text NAME=subscribedCategoryHeading SIZE=50 VALUE="#subscribedCategoryHeading#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH COLSPAN=2 BGCOLOR=FFFFCE><FONT SIZE=4 FACE=Arial>Field Headings</FONT></TH></TR>
<TR><TD ALIGN=right>Lot ID: </TD><TD><CFINPUT TYPE=text NAME=lotIDHeading SIZE=30 VALUE="#lotIDHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Lot name: </TD><TD><CFINPUT TYPE=text NAME=lotNameHeading SIZE=30 VALUE="#lotNameHeading#"></TD></TR>
<TR><TD ALIGN=right>Quantity in lot: </TD><TD><CFINPUT TYPE=text NAME=lotQuantityHeading SIZE=30 VALUE="#lotQuantityHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Opening bid for lot: </TD><TD><CFINPUT TYPE=text NAME=lotOpeningBidHeading SIZE=30 VALUE="#lotOpeningBidHeading#"></TD></TR>
<TR><TD ALIGN=right>Opening time: </TD><TD><CFINPUT TYPE=text NAME=lotOpenDateTimeHeading SIZE=30 VALUE="#lotOpenDateTimeHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Closing time: </TD><TD><CFINPUT TYPE=text NAME=lotCloseDateTimeHeading SIZE=30 VALUE="#lotCloseDateTimeHeading#"></TD></TR>
<TR><TD ALIGN=right>High Bid: </TD><TD><CFINPUT TYPE=text NAME=lotHighBidHeading SIZE=30 VALUE="#lotHighBidHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Next Minimum Bid: </TD><TD><CFINPUT TYPE=text NAME=nextBidMinimumHeading SIZE=30 VALUE="#nextBidMinimumHeading#"></TD></TR>

<TR><TD ALIGN=right>Current Bid: </TD><TD><CFINPUT TYPE=text NAME=bidPriceHeading SIZE=30 VALUE="#bidPriceHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Initial Bid: </TD><TD><CFINPUT TYPE=text NAME=bidPriceInitialHeading SIZE=30 VALUE="#bidPriceInitialHeading#"></TD></TR>
<TR><TD ALIGN=right>Maximum Bid: </TD><TD><CFINPUT TYPE=text NAME=bidPriceMaximumHeading SIZE=30 VALUE="#bidPriceMaximumHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Winning Bid: </TD><TD><CFINPUT TYPE=text NAME=bidWinHeading SIZE=30 VALUE="#bidWinHeading#"></TD></TR>
<TR><TD ALIGN=right>Yes Winning Bid: </TD><TD><CFINPUT TYPE=text NAME=bidWinYesHeading SIZE=30 VALUE="#bidWinYesHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>No, Not Winning Bid: </TD><TD><CFINPUT TYPE=text NAME=bidWinNoHeading SIZE=30 VALUE="#bidWinNoHeading#"></TD></TR>
<TR><TD ALIGN=right>Reserve Price Met: </TD><TD><CFINPUT TYPE=text NAME=lotReservePriceMetHeading SIZE=30 VALUE="#lotReservePriceMetHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Reserve Price Not Met: </TD><TD><CFINPUT TYPE=text NAME=lotReservePriceNotMetHeading SIZE=30 VALUE="#lotReservePriceNotMetHeading#"></TD></TR>
<TR><TD ALIGN=right>Quantity Won: </TD><TD><CFINPUT TYPE=text NAME=bidQuantityWinHeading SIZE=30 VALUE="#bidQuantityWinHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Quantity requested: </TD><TD><CFINPUT TYPE=text NAME=bidQuantityHeading SIZE=30 VALUE="#bidQuantityHeading#"></TD></TR>
<TR><TD ALIGN=right>Total Price: </TD><TD><CFINPUT TYPE=text NAME=bidTotalPriceHeading SIZE=30 VALUE="#bidTotalPriceHeading#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Category Name: </TD><TD><CFINPUT TYPE=text NAME=categoryNameHeading SIZE=30 VALUE="#categoryNameHeading#"></TD></TR>
<TR><TD ALIGN=right>To Separate Lots: </TD><TD><CFINPUT TYPE=text NAME=newLotSeparator SIZE=30 VALUE="#newLotSeparator#"></TD></TR>
</TABLE>

<DL>
<CFFILE ACTION=Read FILE="#systemPath#\system\dailyStatusHeader.cfm" VARIABLE="dailyStatusHeader">
<CFSET dailyStatusHeader = RTrim(dailyStatusHeader)>
<DT><FONT SIZE=4>Header of daily status email</FONT>
<DD><TEXTAREA NAME=dailyStatusHeader ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#dailyStatusHeader#</CFOUTPUT></TEXTAREA>

<P>

<CFFILE ACTION=Read FILE="#systemPath#\system\dailyStatusFooter.cfm" VARIABLE="dailyStatusFooter">
<CFSET dailyStatusFooter = RTrim(dailyStatusFooter)>
<DT><FONT SIZE=4>Footer of daily status email</FONT>
<DD><TEXTAREA NAME=dailyStatusFooter ROWS=10 COLS=70 WRAP=virtual><CFOUTPUT>#dailyStatusFooter#</CFOUTPUT></TEXTAREA>
</DL>


<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Email Options">
</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>