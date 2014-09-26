<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Lot Options</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF Form.openHourAMPM EQ "AM" AND Form.openHourHourSet NEQ 12>
		<CFSET openHourHourSet24 = Form.openHourHourSet>
	<CFELSEIF Form.openHourAMPM EQ "PM" AND Form.openHourHourSet NEQ 12>
		<CFSET openHourHourSet24 = Form.openHourHourSet + 12>
	<CFELSEIF Form.openHourAMPM EQ "AM" AND Form.openHourHourSet EQ 12>
		<CFSET openHourHourSet24 = 0>
	<CFELSE><!--- Form.openHourAMPM EQ "PM" AND Form.openHourHourSet EQ 12 --->
		<CFSET openHourHourSet24 = 12>
	</CFIF>

	<CFIF Form.closeHourAMPM EQ "AM" AND Form.closeHourHourSet NEQ 12>
		<CFSET closeHourHourSet24 = Form.closeHourHourSet>
	<CFELSEIF Form.closeHourAMPM EQ "PM" AND Form.closeHourHourSet NEQ 12>
		<CFSET closeHourHourSet24 = Form.closeHourHourSet + 12>
	<CFELSEIF Form.closeHourAMPM EQ "AM" AND Form.closeHourHourSet EQ 12>
		<CFSET closeHourHourSet24 = 0>
	<CFELSE><!--- Form.closeHourAMPM EQ "PM" AND Form.closeHourHourSet EQ 12 --->
		<CFSET closeHourHourSet24 = 12>
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\system\lotDefaultImage.cfm"
		OUTPUT="<CFSET imageURL = ""#Form.imageURL#"">
<CFSET thumbnailURL = ""#Form.thumbnailURL#"">">

	<CFSET openBid = Replace(DecimalFormat(Form.openBid), ",", "", "ALL")>
		<CFIF openBid LT 1 AND openBid NEQ 0><CFSET openBid = "0#openBid#"></CFIF>
	<CFSET reserve = Replace(DecimalFormat(Form.reserve), ",", "", "ALL")>
		<CFIF reserve LT 1 AND reserve NEQ 0><CFSET reserve = "0#reserve#"></CFIF>
	<CFSET shipping = Replace(DecimalFormat(Form.shipping), ",", "", "ALL")>
		<CFIF shipping LT 1 AND shipping NEQ 0><CFSET shipping = "0#shipping#"></CFIF>
	<CFSET bidIncr = Replace(DecimalFormat(Form.bidIncr), ",", "", "ALL")>
		<CFIF bidIncr LT 1 AND bidIncr NEQ 0><CFSET bidIncr = "0#bidIncr#"></CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\system\lotDefault.cfm"
		OUTPUT="<CFSET openBid = #openBid#>
<CFSET bidIncr = #bidIncr#>
<CFSET reserve = #reserve#>
<CFSET shipping = #shipping#>
<CFSET imageURL = ""#Form.imageURL#"">
<CFSET thumbnailURL = ""#Form.thumbnailURL#"">
<CFSET openDay = ""#Form.openDay#"">
<CFSET openDaySet = #Form.openDaySet#>
<CFSET openDayAdd = #Form.openDayAdd#>
<CFSET openHour = ""#Form.openHour#"">
<CFSET openHourHourSet = #Form.openHourHourSet#>
<CFSET openHourHourSet24 = #openHourHourSet24#>
<CFSET openHourMinuteSet = #Form.openHourMinuteSet#>
<CFSET openHourAMPM = ""#Form.openHourAMPM#"">
<CFSET openHourHourAdd = #Form.openHourHourAdd#>
<CFSET openHourMinuteAdd = #Form.openHourMinuteAdd#>
<CFSET closeDay = ""#Form.closeDay#"">
<CFSET closeDaySet = #Form.closeDaySet#>
<CFSET closeDayAdd = #Form.closeDayAdd#>
<CFSET closeHour = ""#Form.closeHour#"">
<CFSET closeHourHourSet = #Form.closeHourHourSet#>
<CFSET closeHourHourSet24 = #closeHourHourSet24#>
<CFSET closeHourAMPM = ""#Form.closeHourAMPM#"">
<CFSET closeHourMinuteSet = #Form.closeHourMinuteSet#>
<CFSET closeHourHourAdd = #Form.closeHourHourAdd#>
<CFSET closeHourMinuteAdd = #Form.closeHourMinuteAdd#>
<CFSET lotCloseBasis = ""#Form.lotCloseBasis#"">
<CFSET lotCloseInactivity = #Form.lotCloseInactivity#>">

	<H3>Lot options updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Lot Options</B></FONT>

<CFINCLUDE TEMPLATE="../system/lotDefault.cfm">

<CFFORM NAME=optionsLot ACTION=optionsLot.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE">Opening Bid: </TD>
	<TD>$<CFINPUT TYPE=text NAME=openBid SIZE=10 MAXLENGTH=50 VALUE="#openBid#" REQUIRED="Yes" VALIDATE="float" MESSAGE="Opening bid must be a number."></TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE" VALIGN=top>Bid Increment: </TD>
	<TD>$<CFINPUT TYPE=text NAME=bidIncr SIZE=10 VALUE="#bidIncr#" REQUIRED="Yes" VALIDATE="float" MESSAGE="Bid increment must be a number."></TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE" ROWSPAN=2>Shipping: </TD>
	<TD>$<CFINPUT TYPE=text NAME=shipping SIZE=10 MAXLENGTH=50 VALUE="#shipping#" REQUIRED="Yes" VALIDATE="float" MESSAGE="Shipping fee must be a number."></TD></TR>
<TR><TD BGCOLOR="#DCDCDC"><FONT SIZE=2>Shipping / handling fee added to the winning bid of each lot.</FONT><BR>
	<FONT SIZE=2 COLOR=blue>Please note that we have <I>not</I> enabled this field. We have simply included it in<BR>
	response to customer requests. We do not automatically add the shipping<BR>
	fee to bids and the shipping fee is not included in our default lot template.</FONT></TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE">Reserve Price: </TD>
	<TD>$<CFINPUT TYPE=text NAME=reserve SIZE=10 MAXLENGTH=50 VALUE="#reserve#" REQUIRED="Yes" VALIDATE="float" MESSAGE="Reserve price must be a number."></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TR><TD COLSPAN=2 BGCOLOR="#DCDCDC"><FONT SIZE=2>Default URL for images and thumbnails. You may always upload images to the lotImage directory as well.<BR>
Default URL should <I>not</I> have a trailing slash (/) at the end. It will be included automatically.
</FONT></TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE">Image: </TD>
	<TD NOWRAP><CFINPUT TYPE=text NAME=imageURL SIZE=60 MAXLENGTH=100 VALUE="#imageURL#"></TD></TR>
<TR><TD ALIGN=right BGCOLOR="#FFFFCE">Thumbnail: </TD>
	<TD NOWRAP><CFINPUT TYPE=text NAME=thumbnailURL SIZE=60 MAXLENGTH=100 VALUE="#thumbnailURL#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TH COLSPAN=2 BGCOLOR="#20A491"><FONT COLOR=purple SIZE=5>Default Lot Opening Time</FONT></TH>
<TR BGCOLOR="#FFFFCE"><TH>Day</TH><TH>Time</TH></TR>
<TR>
<TD VALIGN=top NOWRAP>
<INPUT TYPE=radio NAME=openDay VALUE=set<CFIF #openDay# EQ "set"> CHECKED</CFIF>> 
<SELECT NAME=openDaySet SIZE=1>
<OPTION VALUE=1<CFIF openDaySet EQ 1> SELECTED</CFIF>>Sunday
<OPTION VALUE=2<CFIF openDaySet EQ 2> SELECTED</CFIF>>Monday
<OPTION VALUE=3<CFIF openDaySet EQ 3> SELECTED</CFIF>>Tuesday
<OPTION VALUE=4<CFIF openDaySet EQ 4> SELECTED</CFIF>>Wednesday
<OPTION VALUE=5<CFIF openDaySet EQ 5> SELECTED</CFIF>>Thursday
<OPTION VALUE=6<CFIF openDaySet EQ 6> SELECTED</CFIF>>Friday
<OPTION VALUE=7<CFIF openDaySet EQ 7> SELECTED</CFIF>>Saturday
</SELECT> Day<BR>
<INPUT TYPE=radio NAME=openDay VALUE=add<CFIF #openDay# EQ "add"> CHECKED</CFIF>> 
<CFINPUT TYPE=text NAME=openDayAdd SIZE=2 VALUE=#openDayAdd# REQUIRED="Yes" VALIDATE="integer" MESSAGE="Number of days after current date must be a non-blank integer."> # days after <I>current</I> date
</TD>

<TD VALIGN=top NOWRAP>
<INPUT TYPE=radio NAME=openHour VALUE=set<CFIF #openHour# EQ "set"> CHECKED</CFIF>> 
<CFINPUT TYPE=text NAME=openHourHourSet SIZE=2 MAXLENGTH=2 VALUE=#openHourHourSet# REQUIRED="Yes" VALIDATE="integer" RANGE="1,12" MESSAGE="Open hour must be a non-blank integer between 1-12."> : 
 <CFINPUT TYPE=text NAME=openHourMinuteSet SIZE=2 MAXLENGTH=2 VALUE=#openHourMinuteSet# REQUIRED="Yes" VALIDATE="integer" RANGE="0,59" MESSAGE="Open minute must be a non-blank integer between 0-59.">
<SELECT NAME=openHourAMPM SIZE=1>
<OPTION VALUE="AM"<CFIF openHourAMPM EQ "AM"> SELECTED</CFIF>>AM
<OPTION VALUE="PM"<CFIF openHourAMPM EQ "PM"> SELECTED</CFIF>>PM
</SELECT> Time opens<BR>
<INPUT TYPE=radio NAME=openHour VALUE=add<CFIF #openHour# EQ "add"> CHECKED</CFIF>> 
<CFINPUT TYPE=text NAME=openHourHourAdd SIZE=2 VALUE=#openHourHourAdd# REQUIRED="Yes" VALIDATE="integer" RANGE="0,23" MESSAGE="Number of hours to add to current time must be a non-blank integer between 0-23."> : 
<CFINPUT TYPE=text NAME=openHourMinuteAdd SIZE=2 MAXLENGTH=2 VALUE=#openHourMinuteAdd# REQUIRED="Yes" VALIDATE="integer" RANGE="0,59" MESSAGE="Number of minutes to add to current time must be a non-blank integer between 0-59."> # hours : minutes after <I>next hour</I><BR>
</TD>
</TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TH COLSPAN=2 BGCOLOR="#20A491"><FONT COLOR=purple SIZE=5>Default Lot Closing Time</FONT></TH>
<TR BGCOLOR="#FFFFCE"><TH>Day</TH><TH>Time</TH></TR>
<TR>
<TD VALIGN=top NOWRAP>
<INPUT TYPE=radio NAME=closeDay VALUE=set<CFIF closeDay EQ "set"> CHECKED</CFIF>> 
<SELECT NAME=closeDaySet SIZE=1>
<OPTION VALUE=1<CFIF closeDaySet EQ 1> SELECTED</CFIF>>Sunday
<OPTION VALUE=2<CFIF closeDaySet EQ 2> SELECTED</CFIF>>Monday
<OPTION VALUE=3<CFIF closeDaySet EQ 3> SELECTED</CFIF>>Tuesday
<OPTION VALUE=4<CFIF closeDaySet EQ 4> SELECTED</CFIF>>Wednesday
<OPTION VALUE=5<CFIF closeDaySet EQ 5> SELECTED</CFIF>>Thursday
<OPTION VALUE=6<CFIF closeDaySet EQ 6> SELECTED</CFIF>>Friday
<OPTION VALUE=7<CFIF closeDaySet EQ 7> SELECTED</CFIF>>Saturday
</SELECT> Day<BR>
<INPUT TYPE=radio NAME=closeDay VALUE=add<CFIF #closeDay# EQ "add"> CHECKED</CFIF>> 
<CFINPUT TYPE=text NAME=closeDayAdd SIZE=2 VALUE=#closeDayAdd# REQUIRED="Yes" VALIDATE="integer" MESSAGE="Number of days after opening date must be a non-blank integer."> # days after <I>opening</I> date
</TD>

<TD VALIGN=top NOWRAP>
<INPUT TYPE=radio NAME=closeHour VALUE=set<CFIF closeHour EQ "set"> CHECKED</CFIF>> 
<CFINPUT TYPE=text NAME=closeHourHourSet SIZE=2 MAXLENGTH=2 VALUE=#closeHourHourSet# REQUIRED="Yes" VALIDATE="integer" RANGE="1,12" MESSAGE="Closing hour must be a non-blank integer between 1-12."> : 
 <CFINPUT TYPE=text NAME=closeHourMinuteSet SIZE=2 MAXLENGTH=2 VALUE=#closeHourMinuteSet# REQUIRED="Yes" VALIDATE="integer" RANGE="0,59" MESSAGE="Closing minute must be a non-blank integer between 0-59.">
<SELECT NAME=closeHourAMPM SIZE=1>
<OPTION VALUE="AM"<CFIF closeHourAMPM EQ "AM"> SELECTED</CFIF>>AM
<OPTION VALUE="PM"<CFIF closeHourAMPM EQ "PM"> SELECTED</CFIF>>PM
</SELECT> Time opens<BR>
<INPUT TYPE=radio NAME=closeHour VALUE=add<CFIF #closeHour# EQ "add"> CHECKED</CFIF>> 
<CFINPUT TYPE=text NAME=closeHourHourAdd SIZE=2 VALUE=#closeHourHourAdd# REQUIRED="Yes" VALIDATE="integer" RANGE="0,23" MESSAGE="Number of hours to add to opening time must be a non-blank integer between 0-23."> : 
<CFINPUT TYPE=text NAME=closeHourMinuteAdd SIZE=2 MAXLENGTH=2 VALUE=#closeHourMinuteAdd# REQUIRED="Yes" VALIDATE="integer" RANGE="0,59" MESSAGE="Number of minutes to add to opening time must be a non-blank integer between 0-59."> # hours : minutes after <I>opening</I> time<BR>
</TD>
</TR>

<TR><TD COLSPAN=2>
Close basis: 	<INPUT TYPE=radio NAME=lotCloseBasis VALUE=time<CFIF lotCloseBasis EQ "time"> CHECKED</CFIF>> Time / 
	<INPUT TYPE=radio NAME=lotCloseBasis VALUE=timeInactivity<CFIF lotCloseBasis EQ "timeInactivity"> CHECKED</CFIF>> Time + Inactivity<BR>
Close Inactivity: <CFINPUT TYPE=text NAME=lotCloseInactivity SIZE=3 MAXLENGTH=10 VALUE="#lotCloseInactivity#" REQUIRED="Yes" VALIDATE="integer" MESSAGE="Inactivity must be an integer."> <FONT SIZE=2 COLOR=blue>(in whole minutes)</FONT>
</TD></TR>
</TABLE>

<P>
<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">

</CFFORM>

</BODY>
</HTML>