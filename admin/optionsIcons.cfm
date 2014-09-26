<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Icon Options</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF Form.iconQuery EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\iconQuery.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET iconQuery = Replace(Form.iconQuery, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\iconQuery.cfm" OUTPUT="#iconQuery#">
	</CFIF>

	<CFIF Form.iconDisplay EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\iconDisplay.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET iconDisplay = Replace(Form.iconDisplay, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\iconDisplay.cfm" OUTPUT="#iconDisplay#">
	</CFIF>

	<CFIF NOT IsDefined("Form.iconListIndex")><CFSET iconListIndex = " "></CFIF>
	<CFIF NOT IsDefined("Form.iconListCategory")><CFSET iconListCategory = " "></CFIF>
	<CFIF NOT IsDefined("Form.iconKeyDisplayOnHelpPage")><CFSET iconKeyDisplayOnHelpPage = 0></CFIF>
	<CFIF Form.iconLotBidCountHot EQ ""><CFSET iconLotBidCountHot = 0></CFIF>
	<CFIF Form.iconLotOpenDateTimeSoon EQ ""><CFSET iconLotOpenDateTimeSoon = 0></CFIF>
	<CFIF Form.iconLotCloseDateTimeSoon EQ ""><CFSET iconLotCloseDateTimeSoon = 0></CFIF>

	<CFSET iconListIndexFields = " ">
	<CFIF iconListIndex NEQ " ">
		<CFIF ListFind(iconListIndex,"pic")><CFSET iconListIndexFields = ListAppend(iconListIndexFields," Lot.lotImage")></CFIF>
		<CFIF ListFind(iconListIndex,"multiple")><CFSET iconListIndexFields = ListAppend(iconListIndexFields," Lot.lotQuantity")></CFIF>
		<CFIF ListFind(iconListIndex,"bids") OR ListFind(iconListIndex,"nobids") OR ListFind(iconListIndex,"hot")><CFSET iconListIndexFields = ListAppend(iconListIndexFields," Lot.lotBidCount")></CFIF>
		<CFIF ListFind(iconListIndex,"reservemet") OR ListFind(iconListIndex,"reservenotmet")><CFSET iconListIndexFields = ListAppend(iconListIndexFields," Lot.lotReservePriceMet")></CFIF>
		<CFIF ListFind(iconListIndex,"openingsoon")><CFSET iconListIndexFields = ListAppend(iconListIndexFields," Lot.lotOpenDateTime")></CFIF>
		<CFIF ListFind(iconListIndex,"closingsoon")><CFSET iconListIndexFields = ListAppend(iconListIndexFields," Lot.lotCloseDateTime")></CFIF>
		<CFIF ListFind(iconListIndex,"positiverating") OR ListFind(iconListIndex,"negativerating")><CFSET iconListIndexFields = ListAppend(iconListIndexFields," Member.feedbackRating")></CFIF>
		<CFSET iconListIndexFields = ListRest(iconListIndexFields)>
	</CFIF>

	<CFSET iconListCategoryFields = " ">
	<CFIF iconListCategory NEQ " ">
		<CFIF ListFind(iconListCategory,"pic")><CFSET iconListCategoryFields = ListAppend(iconListCategoryFields," Lot.lotImage")></CFIF>
		<CFIF ListFind(iconListCategory,"multiple")><CFSET iconListCategoryFields = ListAppend(iconListCategoryFields," Lot.lotQuantity")></CFIF>
		<CFIF ListFind(iconListCategory,"bids") OR ListFind(iconListCategory,"nobids") OR ListFind(iconListCategory,"hot")><CFSET iconListCategoryFields = ListAppend(iconListCategoryFields," Lot.lotBidCount")></CFIF>
		<CFIF ListFind(iconListCategory,"reservemet") OR ListFind(iconListCategory,"reservenotmet")><CFSET iconListCategoryFields = ListAppend(iconListCategoryFields," Lot.lotReservePriceMet")></CFIF>
		<CFIF ListFind(iconListCategory,"openingsoon")><CFSET iconListCategoryFields = ListAppend(iconListCategoryFields," Lot.lotOpenDateTime")></CFIF>
		<CFIF ListFind(iconListCategory,"closingsoon")><CFSET iconListCategoryFields = ListAppend(iconListCategoryFields," Lot.lotCloseDateTime")></CFIF>
		<CFIF ListFind(iconListCategory,"positiverating") OR ListFind(iconListCategory,"negativerating")><CFSET iconListCategoryFields = ListAppend(iconListCategoryFields," Member.feedbackRating")></CFIF>
		<CFSET iconListCategoryFields = ListRest(iconListCategoryFields)>
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\system\iconOptions.cfm"
		OUTPUT="<CFSET iconListIndex = ""#iconListIndex#"">
<CFSET iconListIndexFields = ""#iconListIndexFields#"">
<CFSET iconListCategory = ""#iconListCategory#"">
<CFSET iconListCategoryFields = ""#iconListCategoryFields#"">
<CFSET iconKeyDisplayOnHelpPage = #iconKeyDisplayOnHelpPage#>
<CFSET iconLotBidCountHot = #iconLotBidCountHot#>
<CFSET iconLotOpenDateTimeSoon = #iconLotOpenDateTimeSoon#>
<CFSET iconLotCloseDateTimeSoon = #iconLotCloseDateTimeSoon#>">

	<H3>Icon options updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Icon Options</B></FONT>

<CFINCLUDE TEMPLATE="../system/iconOptions.cfm">

<CFFORM NAME=optionsVarious ACTION=optionsIcons.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<TR><TH COLSPAN=2>Icon</TH><TH>Homepage</TH><TH>Category</TH></TR>
<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#systemURL#/images/pic.gif"></CFOUTPUT></TD><TD>Image for item</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="pic"<CFIF ListFind(iconListIndex,"pic")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="pic"<CFIF ListFind(iconListCategory,"pic")> CHECKED</CFIF>></TD></TR>
<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#systemURL#/images/multiple.gif"></CFOUTPUT></TD><TD>Multiple quantity</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="multiple"<CFIF ListFind(iconListIndex,"multiple")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="multiple"<CFIF ListFind(iconListCategory,"multiple")> CHECKED</CFIF>></TD></TR>

<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#systemURL#/images/bids.gif"></CFOUTPUT></TD><TD>Bids exist on item</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="bids"<CFIF ListFind(iconListIndex,"bids")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="bids"<CFIF ListFind(iconListCategory,"bids")> CHECKED</CFIF>></TD></TR>
<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#systemURL#/images/nobids.gif"></CFOUTPUT></TD><TD>No bids on item</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="nobids"<CFIF ListFind(iconListIndex,"nobids")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="nobids"<CFIF ListFind(iconListCategory,"nobids")> CHECKED</CFIF>></TD></TR>

<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#systemURL#/images/reservemet.gif"></CFOUTPUT></TD><TD>Reserve price met</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="reservemet"<CFIF ListFind(iconListIndex,"reservemet")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="reservemet"<CFIF ListFind(iconListCategory,"reservemet")> CHECKED</CFIF>></TD></TR>
<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#systemURL#/images/reservenotmet.gif"></CFOUTPUT></TD><TD>Reserve price not met</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="reservenotmet"<CFIF ListFind(iconListIndex,"reservenotmet")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="reservenotmet"<CFIF ListFind(iconListCategory,"reservenotmet")> CHECKED</CFIF>></TD></TR>

<TR><TD ALIGN=center VALIGN=top ROWSPAN=2><CFOUTPUT><IMG SRC="#systemURL#/images/hot.gif"></CFOUTPUT></TD><TD>Item is hot</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="hot"<CFIF ListFind(iconListIndex,"hot")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="hot"<CFIF ListFind(iconListCategory,"hot")> CHECKED</CFIF>></TD></TR>
<TR><TD COLSPAN=3><FONT SIZE=2># bids to qualify as hot:</FONT> <CFINPUT TYPE=text NAME=iconLotBidCountHot SIZE=4 VALUE="#iconLotBidCountHot#" REQUIRED=Yes VALIDATE="float" MESSAGE="The number of bids to be hot must be a number"></TD></TR>

<TR><TD ALIGN=center VALIGN=top ROWSPAN=2><CFOUTPUT><IMG SRC="#systemURL#/images/openingsoon.gif"></CFOUTPUT></TD><TD>Lot opens soon</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="openingsoon"<CFIF ListFind(iconListIndex,"openingsoon")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="openingsoon"<CFIF ListFind(iconListCategory,"openingsoon")> CHECKED</CFIF>></TD></TR>
<TR><TD COLSPAN=3><FONT SIZE=2># hours until open to qualify as opening soon:</FONT> <CFINPUT TYPE=text NAME=iconLotOpenDateTimeSoon SIZE=4 VALUE="#iconLotOpenDateTimeSoon#" REQUIRED=Yes VALIDATE="float" MESSAGE="The number of hours until a lot opens to be opening soon  must be a number"></TD></TR>

<TR><TD ALIGN=center VALIGN=top ROWSPAN=2><CFOUTPUT><IMG SRC="#systemURL#/images/closingsoon.gif"></CFOUTPUT></TD><TD>Lot closes soon</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="closingsoon"<CFIF ListFind(iconListIndex,"closingsoon")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="closingsoon"<CFIF ListFind(iconListCategory,"closingsoon")> CHECKED</CFIF>></TD></TR>
<TR><TD COLSPAN=3><FONT SIZE=2># hours until close to qualify as closing soon:</FONT> <CFINPUT TYPE=text NAME=iconLotCloseDateTimeSoon SIZE=4 VALUE="#iconLotCloseDateTimeSoon#" REQUIRED=Yes VALIDATE="float" MESSAGE="The number of hours until a lot closes to be closing soon must be a number"></TD></TR>

<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
	<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#systemURL#/images/positiverating.gif"></CFOUTPUT></TD><TD>User has positive rating</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="positiverating"<CFIF ListFind(iconListIndex,"positiverating")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="positiverating"<CFIF ListFind(iconListCategory,"positiverating")> CHECKED</CFIF>></TD></TR>
	<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#systemURL#/images/negativerating.gif"></CFOUTPUT></TD><TD>User has negative rating</TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListIndex VALUE="negativerating"<CFIF ListFind(iconListIndex,"negativerating")> CHECKED</CFIF>></TD>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=iconListCategory VALUE="negativerating"<CFIF ListFind(iconListCategory,"negativerating")> CHECKED</CFIF>></TD></TR>
</CFIF>

</TABLE>

<P>

<INPUT TYPE=checkbox NAME=iconKeyDisplayOnHelpPage VALUE=1<CFIF iconKeyDisplayOnHelpPage EQ 1> CHECKED</CFIF>> Display icon key on help page
<BR>
<CFOUTPUT><IMG SRC="#systemURL#/images/iconkey.gif"></CFOUTPUT>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">

<P>

<B>Determines which icons to display when displaying lots:</B><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\iconDisplay.cfm" VARIABLE="iconDisplay">
<CFSET iconDisplay = RTrim(iconDisplay)>
<TEXTAREA NAME=iconDisplay ROWS=18 COLS=70 WRAP=off><CFOUTPUT>#iconDisplay#</CFOUTPUT></TEXTAREA>

<P>

<B>Request proper icons fields in query when selecting lots:</B><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\iconQuery.cfm" VARIABLE="iconQuery">
<CFSET iconQuery = RTrim(iconQuery)>
<TEXTAREA NAME=iconQuery ROWS=6 COLS=70 WRAP=off><CFOUTPUT>#iconQuery#</CFOUTPUT></TEXTAREA>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">

</CFFORM>

</BODY>
</HTML>
