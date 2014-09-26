<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Search Options</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF NOT IsDefined("Form.searchFields")><CFSET searchFields = " "></CFIF>

	<CFSET searchTextText = Replace(Form.searchTextText, """", "&quot;", "ALL")>
	<CFSET searchTextMultiple = Replace(Form.searchTextMultiple, """", "&quot;", "ALL")>
	<CFSET searchOpens = Replace(Form.searchOpens, """", "&quot;", "ALL")>
	<CFSET searchCloses = Replace(Form.searchCloses, """", "&quot;", "ALL")>
	<CFSET searchBefore = Replace(Form.searchBefore, """", "&quot;", "ALL")>
	<CFSET searchAt = Replace(Form.searchAt, """", "&quot;", "ALL")>
	<CFSET searchAfter = Replace(Form.searchAfter, """", "&quot;", "ALL")>
	<CFSET searchAllDay = Replace(Form.searchAllDay, """", "&quot;", "ALL")>
	<CFSET searchCategory = Replace(Form.searchCategory, """", "&quot;", "ALL")>
	<CFSET searchButton = Replace(Form.searchButton, """", "&quot;", "ALL")>
	<CFSET searchNoRecords = Replace(Form.searchNoRecords, """", "&quot;", "ALL")>

	<CFSET searchTextText = Replace(searchTextText, "##", "####", "ALL")>
	<CFSET searchTextMultiple = Replace(searchTextMultiple, "##", "####", "ALL")>
	<CFSET searchOpens = Replace(searchOpens, "##", "####", "ALL")>
	<CFSET searchCloses = Replace(searchCloses, "##", "####", "ALL")>
	<CFSET searchBefore = Replace(searchBefore, "##", "####", "ALL")>
	<CFSET searchAt = Replace(searchAt, "##", "####", "ALL")>
	<CFSET searchAfter = Replace(searchAfter, "##", "####", "ALL")>
	<CFSET searchAllDay = Replace(searchAllDay, "##", "####", "ALL")>
	<CFSET searchCategory = Replace(searchCategory, "##", "####", "ALL")>
	<CFSET searchButton = Replace(searchButton, "##", "####", "ALL")>
	<CFSET searchNoRecords = Replace(searchNoRecords, "##", "####", "ALL")>

	<CFIF Form.searchMonths EQ "January,February,March,April,May,June,July,August,September,October,November,December"
			OR Form.searchMonths EQ "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"
			OR Form.searchMonths EQ "01,02,03,04,05,06,07,08,09,10,11,12">
		<CFSET searchMonths = Form.searchMonths>
	<CFELSE>
		<CFSET searchMonths = 0>
		<CFLOOP INDEX=monthCount FROM=1 TO=12>
			<CFSET searchMonthsValue = Evaluate("searchMonths#monthCount#")>
			<CFIF searchMonthsValue EQ "">
				<H3>You chose to customize the months, but left month <CFOUTPUT>#monthCount#</CFOUTPUT> blank.</H3>
				<H3>Please back up and complete all months.</H3>
				</BODY></HTML><CFABORT>
			<CFELSE>
				<CFSET searchMonthsValue = Replace(searchMonthsValue, """", "&quot;", "ALL")>
				<CFSET searchMonthsValue = Replace(searchMonthsValue, "##", "####", "ALL")>
				<CFSET searchMonths = ListAppend(searchMonths,searchMonthsValue)>
			</CFIF>
		</CFLOOP>
		<CFSET searchMonths = ListRest(searchMonths)>
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\system\searchFields.cfm"
		OUTPUT="<CFSET searchFields = ""#searchFields#"">
<CFSET searchTextText = ""#searchTextText#"">
<CFSET searchTextMultiple = ""#searchTextMultiple#"">
<CFSET searchOpens = ""#searchOpens#"">
<CFSET searchCloses = ""#searchCloses#"">
<CFSET searchBefore = ""#searchBefore#"">
<CFSET searchAt = ""#searchAt#"">
<CFSET searchAfter = ""#searchAfter#"">
<CFSET searchAllDay = ""#searchAllDay#"">
<CFSET searchCategory = ""#searchCategory#"">
<CFSET searchButton = ""#searchButton#"">
<CFSET searchNoRecords = ""#searchNoRecords#"">
<CFSET searchMonths = ""#searchMonths#"">
">

	<CFIF Form.searchHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\searchHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET searchHeader = Replace(Form.searchHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\searchHeader.cfm" OUTPUT="#searchHeader#">
	</CFIF>

	<CFIF Form.searchResultsHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\searchResultsHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET searchResultsHeader = Replace(Form.searchResultsHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\searchResultsHeader.cfm" OUTPUT="#searchResultsHeader#">
	</CFIF>

	<H3>Search options and header updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Search Options &amp; Headers</B></FONT>

<CFINCLUDE TEMPLATE="../system/searchFields.cfm">

<CFFORM NAME=optionsSearch ACTION=optionsSearch.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<FONT SIZE=4 FACE=Arial>Fields Users May Search</FONT><BR>
<BLOCKQUOTE>
<INPUT TYPE=checkbox NAME=searchFields VALUE=categoryID<CFIF ListFind(searchFields,"categoryID") NEQ 0> CHECKED</CFIF>> Category name<BR>
<INPUT TYPE=checkbox NAME=searchFields VALUE=lotName<CFIF ListFind(searchFields,"lotName") NEQ 0> CHECKED</CFIF>> Lot name<BR>
<INPUT TYPE=checkbox NAME=searchFields VALUE=lotLocation<CFIF ListFind(searchFields,"lotLocation") NEQ 0> CHECKED</CFIF>> Lot location<BR>
<INPUT TYPE=checkbox NAME=searchFields VALUE=lotSummary<CFIF ListFind(searchFields,"lotSummary") NEQ 0> CHECKED</CFIF>> Lot summary<BR>
<INPUT TYPE=checkbox NAME=searchFields VALUE=lotDescription<CFIF ListFind(searchFields,"lotDescription") NEQ 0> CHECKED</CFIF>> Lot description<BR>
<INPUT TYPE=checkbox NAME=searchFields VALUE=lotOpenDateTime<CFIF ListFind(searchFields,"lotOpenDateTime") NEQ 0> CHECKED</CFIF>> Lot opening time<BR>
<INPUT TYPE=checkbox NAME=searchFields VALUE=lotCloseDateTime<CFIF ListFind(searchFields,"lotCloseDateTime") NEQ 0> CHECKED</CFIF>> Lot closing time
</BLOCKQUOTE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">

<P><HR NOSHADE SIZE=3 COLOR=purple WIDTH=400 ALIGN=left><P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=4 WIDTH="600">
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Text Field:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchTextText SIZE=20 VALUE="#searchTextText#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Multiple Terms Notice:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchTextMultiple SIZE=60 VALUE="#searchTextMultiple#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Opens:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchOpens SIZE=20 VALUE="#searchOpens#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Closes:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchCloses SIZE=20 VALUE="#searchCloses#"></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Opens/Closes Before:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchBefore SIZE=20 VALUE="#searchBefore#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Opens/Closes At:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchAt SIZE=20 VALUE="#searchAt#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Opens/Closes After:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchAfter SIZE=20 VALUE="#searchAfter#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>All Day (time):</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchAllDay SIZE=20 VALUE="#searchAllDay#"></TD></TR>

<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Category:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchCategory SIZE=20 VALUE="#searchCategory#"></TD></TR>
<TR><TD ALIGN=right><FONT FACE="Arial" SIZE=2>Search Button:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchButton SIZE=20 VALUE="#searchButton#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right><FONT FACE="Arial" SIZE=2>No Items Found:</FONT></TD>
	<TD><CFINPUT TYPE=text NAME=searchNoRecords SIZE=60 VALUE="#searchNoRecords#"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH="600"><TR>
<CFSET searchMonthsOther = 1>
<TD VALIGN=top><INPUT TYPE=radio NAME=searchMonths VALUE="January,February,March,April,May,June,July,August,September,October,November,December"<CFIF searchMonths EQ "January,February,March,April,May,June,July,August,September,October,November,December"> CHECKED<CFSET searchMonthsOther = 0></CFIF>> Full months<P>
	<TT>January<BR>February<BR>March<BR>April<BR>May<BR>June<BR>July<BR>August<BR>September<BR>October<BR>November<BR>December</TD>
<TD VALIGN=top><INPUT TYPE=radio NAME=searchMonths VALUE="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"<CFIF searchMonths EQ "Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"> CHECKED<CFSET searchMonthsOther = 0></CFIF>> Partial months<P>
	<TT>Jan<BR>Feb<BR>Mar<BR>Apr<BR>May<BR>Jun<BR>Jul<BR>Aug<BR>Sep<BR>Oct<BR>Nov<BR>Dec</TD>
<TD VALIGN=top><INPUT TYPE=radio NAME=searchMonths VALUE="01,02,03,04,05,06,07,08,09,10,11,12"<CFIF searchMonths EQ "01,02,03,04,05,06,07,08,09,10,11,12"> CHECKED<CFSET searchMonthsOther = 0></CFIF>> Numbered months<P>
	<TT>01<BR>02<BR>03<BR>04<BR>05<BR>06<BR>07<BR>08<BR>09<BR>10<BR>11<BR>12</TD>
<TD>
<CFIF searchMonthsOther EQ 0>
	<INPUT TYPE=radio NAME=searchMonths VALUE="other"> Other<BR>
	<TT>Jan: <CFINPUT TYPE=text NAME=searchMonths1 SIZE=20><BR>
	Feb: <CFINPUT TYPE=text NAME=searchMonths2 SIZE=20><BR>
	Mar: <CFINPUT TYPE=text NAME=searchMonths3 SIZE=20><BR>
	Apr: <CFINPUT TYPE=text NAME=searchMonths4 SIZE=20><BR>
	May: <CFINPUT TYPE=text NAME=searchMonths5 SIZE=20><BR>
	Jun: <CFINPUT TYPE=text NAME=searchMonths6 SIZE=20><BR>
	Jul: <CFINPUT TYPE=text NAME=searchMonths7 SIZE=20><BR>
	Aug: <CFINPUT TYPE=text NAME=searchMonths8 SIZE=20><BR>
	Sep: <CFINPUT TYPE=text NAME=searchMonths9 SIZE=20><BR>
	Oct: <CFINPUT TYPE=text NAME=searchMonths10 SIZE=20><BR>
	Nov: <CFINPUT TYPE=text NAME=searchMonths11 SIZE=20><BR>
	Dec: <CFINPUT TYPE=text NAME=searchMonths12 SIZE=20></TT>
<CFELSE>
	<INPUT TYPE=radio NAME=searchMonths VALUE="other" CHECKED> Other<BR>
	<TT>Jan: <CFINPUT TYPE=text NAME=searchMonths1 SIZE=20 VALUE="#ListGetAt(searchMonths,1)#"><BR>
	Feb: <CFINPUT TYPE=text NAME=searchMonths2 SIZE=20 VALUE="#ListGetAt(searchMonths,2)#"><BR>
	Mar: <CFINPUT TYPE=text NAME=searchMonths3 SIZE=20 VALUE="#ListGetAt(searchMonths,3)#"><BR>
	Apr: <CFINPUT TYPE=text NAME=searchMonths4 SIZE=20 VALUE="#ListGetAt(searchMonths,4)#"><BR>
	May: <CFINPUT TYPE=text NAME=searchMonths5 SIZE=20 VALUE="#ListGetAt(searchMonths,5)#"><BR>
	Jun: <CFINPUT TYPE=text NAME=searchMonths6 SIZE=20 VALUE="#ListGetAt(searchMonths,6)#"><BR>
	Jul: <CFINPUT TYPE=text NAME=searchMonths7 SIZE=20 VALUE="#ListGetAt(searchMonths,7)#"><BR>
	Aug: <CFINPUT TYPE=text NAME=searchMonths8 SIZE=20 VALUE="#ListGetAt(searchMonths,8)#"><BR>
	Sep: <CFINPUT TYPE=text NAME=searchMonths9 SIZE=20 VALUE="#ListGetAt(searchMonths,9)#"><BR>
	Oct: <CFINPUT TYPE=text NAME=searchMonths10 SIZE=20 VALUE="#ListGetAt(searchMonths,10)#"><BR>
	Nov: <CFINPUT TYPE=text NAME=searchMonths11 SIZE=20 VALUE="#ListGetAt(searchMonths,11)#"><BR>
	Dec: <CFINPUT TYPE=text NAME=searchMonths12 SIZE=20 VALUE="#ListGetAt(searchMonths,12)#"></TT>
</CFIF>
</TD>
</TR></TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">

<P><HR NOSHADE SIZE=3 COLOR=purple WIDTH=400 ALIGN=left><P>

<DL>
<DT>
<B>Search header</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\searchHeader.cfm" VARIABLE="searchHeader">
<CFSET searchHeader = RTrim(searchHeader)>
<DD><TEXTAREA NAME="searchHeader" COLS="60" ROWS="10" WRAP="virtual"><CFOUTPUT>#searchHeader#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Search results header</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\searchResultsHeader.cfm" VARIABLE="searchResultsHeader">
<CFSET searchResultsHeader = RTrim(searchResultsHeader)>
<DD><TEXTAREA NAME="searchResultsHeader" COLS="60" ROWS="10" WRAP="virtual"><CFOUTPUT>#searchResultsHeader#</CFOUTPUT></TEXTAREA>
</DL>

<P>

<INPUT TYPE=reset VALUE=Clear> <INPUT TYPE=submit VALUE="Update Options">
</CFFORM>

</BODY>
</HTML>