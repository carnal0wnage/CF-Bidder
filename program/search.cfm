<!--- Emaze Auction version 2.1, 1.01 / Tuesday, August 24, 1999 --->
<CFSET title = "titleSearch">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<P>

<CFINCLUDE TEMPLATE="../system/searchFields.cfm">
<CFIF NOT IsDefined("Form.first")>
	<CFINCLUDE TEMPLATE="closeCheck.cfm">
	<CFINCLUDE TEMPLATE="../system/searchHeader.cfm">
	<CFOUTPUT><FORM METHOD=post ACTION="#systemURL#/program/search.cfm"></CFOUTPUT>
	<INPUT TYPE=hidden NAME=first VALUE=1>

	<TABLE BORDER=0 CELLSPACING=4 CELLPADDING=2 WIDTH="600">
	<CFIF ListFind(searchFields,"lotName") OR ListFind(searchFields,"lotSummary") OR ListFind(searchFields,"lotDescription") OR ListFind(searchFields,"lotLocation")>
		<TR BGCOLOR="#CDCDCD"><TD ALIGN=right VALIGN=top><CFOUTPUT>#searchTextText#</CFOUTPUT></TD>
		<TD><INPUT TYPE=text NAME=searchText SIZE=43><BR>
		<CFOUTPUT>#searchTextMultiple#</CFOUTPUT></TD></TR>
	</CFIF>
	<CFIF ListFind(searchFields,"lotOpenDateTime")>
		<TR BGCOLOR="#DCDCDC" VALIGN=top><TD ALIGN=right><CFOUTPUT>#searchOpens#</CFOUTPUT></TD><TD>&nbsp;
		<SELECT NAME=searchOpenMM SIZE=1>
			<OPTION VALUE=01<CFIF Month(Now()) EQ 1> SELECTED</CFIF>><CFOUTPUT>#ListFirst(searchMonths)#</CFOUTPUT>
			<OPTION VALUE=02<CFIF Month(Now()) EQ 2> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,2)#</CFOUTPUT>
			<OPTION VALUE=03<CFIF Month(Now()) EQ 3> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,3)#</CFOUTPUT>
			<OPTION VALUE=04<CFIF Month(Now()) EQ 4> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,4)#</CFOUTPUT>
			<OPTION VALUE=05<CFIF Month(Now()) EQ 5> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,5)#</CFOUTPUT>
			<OPTION VALUE=06<CFIF Month(Now()) EQ 6> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,6)#</CFOUTPUT>
			<OPTION VALUE=07<CFIF Month(Now()) EQ 7> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,7)#</CFOUTPUT>
			<OPTION VALUE=08<CFIF Month(Now()) EQ 8> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,8)#</CFOUTPUT>
			<OPTION VALUE=09<CFIF Month(Now()) EQ 9> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,9)#</CFOUTPUT>
			<OPTION VALUE=10<CFIF Month(Now()) EQ 10> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,10)#</CFOUTPUT>
			<OPTION VALUE=11<CFIF Month(Now()) EQ 11> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,11)#</CFOUTPUT>
			<OPTION VALUE=12<CFIF Month(Now()) EQ 12> SELECTED</CFIF>><CFOUTPUT>#ListLast(searchMonths)#</CFOUTPUT>
		</SELECT> 
		<SELECT NAME=searchOpenDD SIZE=1>
			<OPTION VALUE=01<CFIF Day(Now()) EQ 1> SELECTED</CFIF>>01
			<OPTION VALUE=02<CFIF Day(Now()) EQ 2> SELECTED</CFIF>>02
			<OPTION VALUE=03<CFIF Day(Now()) EQ 3> SELECTED</CFIF>>03
			<OPTION VALUE=04<CFIF Day(Now()) EQ 4> SELECTED</CFIF>>04
			<OPTION VALUE=05<CFIF Day(Now()) EQ 5> SELECTED</CFIF>>05
			<OPTION VALUE=06<CFIF Day(Now()) EQ 6> SELECTED</CFIF>>06
			<OPTION VALUE=07<CFIF Day(Now()) EQ 7> SELECTED</CFIF>>07
			<OPTION VALUE=08<CFIF Day(Now()) EQ 8> SELECTED</CFIF>>08
			<OPTION VALUE=09<CFIF Day(Now()) EQ 9> SELECTED</CFIF>>09
			<OPTION VALUE=10<CFIF Day(Now()) EQ 10> SELECTED</CFIF>>10
			<OPTION VALUE=11<CFIF Day(Now()) EQ 11> SELECTED</CFIF>>11
			<OPTION VALUE=12<CFIF Day(Now()) EQ 12> SELECTED</CFIF>>12
			<OPTION VALUE=13<CFIF Day(Now()) EQ 13> SELECTED</CFIF>>13
			<OPTION VALUE=14<CFIF Day(Now()) EQ 14> SELECTED</CFIF>>14
			<OPTION VALUE=15<CFIF Day(Now()) EQ 15> SELECTED</CFIF>>15
			<OPTION VALUE=16<CFIF Day(Now()) EQ 16> SELECTED</CFIF>>16
			<OPTION VALUE=17<CFIF Day(Now()) EQ 17> SELECTED</CFIF>>17
			<OPTION VALUE=18<CFIF Day(Now()) EQ 18> SELECTED</CFIF>>18
			<OPTION VALUE=19<CFIF Day(Now()) EQ 19> SELECTED</CFIF>>19
			<OPTION VALUE=20<CFIF Day(Now()) EQ 20> SELECTED</CFIF>>20
			<OPTION VALUE=21<CFIF Day(Now()) EQ 21> SELECTED</CFIF>>21
			<OPTION VALUE=22<CFIF Day(Now()) EQ 22> SELECTED</CFIF>>22
			<OPTION VALUE=23<CFIF Day(Now()) EQ 23> SELECTED</CFIF>>23
			<OPTION VALUE=24<CFIF Day(Now()) EQ 24> SELECTED</CFIF>>24
			<OPTION VALUE=25<CFIF Day(Now()) EQ 25> SELECTED</CFIF>>25
			<OPTION VALUE=26<CFIF Day(Now()) EQ 26> SELECTED</CFIF>>26
			<OPTION VALUE=27<CFIF Day(Now()) EQ 27> SELECTED</CFIF>>27
			<OPTION VALUE=28<CFIF Day(Now()) EQ 28> SELECTED</CFIF>>28
			<OPTION VALUE=29<CFIF Day(Now()) EQ 29> SELECTED</CFIF>>29
			<OPTION VALUE=30<CFIF Day(Now()) EQ 30> SELECTED</CFIF>>30
			<OPTION VALUE=31<CFIF Day(Now()) EQ 31> SELECTED</CFIF>>31
		</SELECT> 
		<SELECT NAME=searchOpenYYYY SIZE=1>
			<OPTION VALUE=1999<CFIF Year(Now()) EQ 1999> SELECTED</CFIF>>1999
			<OPTION VALUE=2000<CFIF Year(Now()) EQ 2000> SELECTED</CFIF>>2000
			<OPTION VALUE=2001<CFIF Year(Now()) EQ 2001> SELECTED</CFIF>>2001
		</SELECT> 
		<SELECT NAME=searchOpenHH SIZE=1>
			<OPTION VALUE=ALL><CFOUTPUT>#searchAllDay#</CFOUTPUT>
			<OPTION VALUE=00>12:00 am
			<OPTION VALUE=01>01:00 am
			<OPTION VALUE=02>02:00 am
			<OPTION VALUE=03>03:00 am
			<OPTION VALUE=04>04:00 am
			<OPTION VALUE=05>05:00 am
			<OPTION VALUE=06>06:00 am
			<OPTION VALUE=07>07:00 am
			<OPTION VALUE=08>08:00 am
			<OPTION VALUE=09>09:00 am
			<OPTION VALUE=10>10:00 am
			<OPTION VALUE=11>11:00 am
			<OPTION VALUE=12>12:00 pm
			<OPTION VALUE=13>01:00 pm
			<OPTION VALUE=14>02:00 pm
			<OPTION VALUE=15>03:00 pm
			<OPTION VALUE=16>04:00 pm
			<OPTION VALUE=17>05:00 pm
			<OPTION VALUE=18>06:00 pm
			<OPTION VALUE=19>07:00 pm
			<OPTION VALUE=20>08:00 pm
			<OPTION VALUE=21>09:00 pm
			<OPTION VALUE=22>10:00 pm
			<OPTION VALUE=23>11:00 pm
		</SELECT>
		<BR>&nbsp;<FONT SIZE=2>
		<INPUT TYPE=checkbox NAME=searchOpen VALUE=before> <CFOUTPUT>#searchBefore#</CFOUTPUT> &nbsp; 
		<INPUT TYPE=checkbox NAME=searchOpen VALUE=at> <CFOUTPUT>#searchAt#</CFOUTPUT> &nbsp; 
		<INPUT TYPE=checkbox NAME=searchOpen VALUE=after> <CFOUTPUT>#searchAfter#</CFOUTPUT>
		</FONT></TD></TR>
	</CFIF>

	<CFIF ListFind(searchFields,"lotCloseDateTime")>
		<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right><CFOUTPUT>#searchCloses#</CFOUTPUT></TD><TD>&nbsp;
		<SELECT NAME=searchCloseMM SIZE=1>
			<OPTION VALUE=01<CFIF Month(Now()) EQ 1> SELECTED</CFIF>><CFOUTPUT>#ListFirst(searchMonths)#</CFOUTPUT>
			<OPTION VALUE=02<CFIF Month(Now()) EQ 2> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,2)#</CFOUTPUT>
			<OPTION VALUE=03<CFIF Month(Now()) EQ 3> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,3)#</CFOUTPUT>
			<OPTION VALUE=04<CFIF Month(Now()) EQ 4> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,4)#</CFOUTPUT>
			<OPTION VALUE=05<CFIF Month(Now()) EQ 5> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,5)#</CFOUTPUT>
			<OPTION VALUE=06<CFIF Month(Now()) EQ 6> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,6)#</CFOUTPUT>
			<OPTION VALUE=07<CFIF Month(Now()) EQ 7> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,7)#</CFOUTPUT>
			<OPTION VALUE=08<CFIF Month(Now()) EQ 8> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,8)#</CFOUTPUT>
			<OPTION VALUE=09<CFIF Month(Now()) EQ 9> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,9)#</CFOUTPUT>
			<OPTION VALUE=10<CFIF Month(Now()) EQ 10> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,10)#</CFOUTPUT>
			<OPTION VALUE=11<CFIF Month(Now()) EQ 11> SELECTED</CFIF>><CFOUTPUT>#ListGetAt(searchMonths,11)#</CFOUTPUT>
			<OPTION VALUE=12<CFIF Month(Now()) EQ 12> SELECTED</CFIF>><CFOUTPUT>#ListLast(searchMonths)#</CFOUTPUT>
		</SELECT> 
		<SELECT NAME=searchCloseDD SIZE=1>
			<OPTION VALUE=01<CFIF Day(Now()) EQ 1> SELECTED</CFIF>>01
			<OPTION VALUE=02<CFIF Day(Now()) EQ 2> SELECTED</CFIF>>02
			<OPTION VALUE=03<CFIF Day(Now()) EQ 3> SELECTED</CFIF>>03
			<OPTION VALUE=04<CFIF Day(Now()) EQ 4> SELECTED</CFIF>>04
			<OPTION VALUE=05<CFIF Day(Now()) EQ 5> SELECTED</CFIF>>05
			<OPTION VALUE=06<CFIF Day(Now()) EQ 6> SELECTED</CFIF>>06
			<OPTION VALUE=07<CFIF Day(Now()) EQ 7> SELECTED</CFIF>>07
			<OPTION VALUE=08<CFIF Day(Now()) EQ 8> SELECTED</CFIF>>08
			<OPTION VALUE=09<CFIF Day(Now()) EQ 9> SELECTED</CFIF>>09
			<OPTION VALUE=10<CFIF Day(Now()) EQ 10> SELECTED</CFIF>>10
			<OPTION VALUE=11<CFIF Day(Now()) EQ 11> SELECTED</CFIF>>11
			<OPTION VALUE=12<CFIF Day(Now()) EQ 12> SELECTED</CFIF>>12
			<OPTION VALUE=13<CFIF Day(Now()) EQ 13> SELECTED</CFIF>>13
			<OPTION VALUE=14<CFIF Day(Now()) EQ 14> SELECTED</CFIF>>14
			<OPTION VALUE=15<CFIF Day(Now()) EQ 15> SELECTED</CFIF>>15
			<OPTION VALUE=16<CFIF Day(Now()) EQ 16> SELECTED</CFIF>>16
			<OPTION VALUE=17<CFIF Day(Now()) EQ 17> SELECTED</CFIF>>17
			<OPTION VALUE=18<CFIF Day(Now()) EQ 18> SELECTED</CFIF>>18
			<OPTION VALUE=19<CFIF Day(Now()) EQ 19> SELECTED</CFIF>>19
			<OPTION VALUE=20<CFIF Day(Now()) EQ 20> SELECTED</CFIF>>20
			<OPTION VALUE=21<CFIF Day(Now()) EQ 21> SELECTED</CFIF>>21
			<OPTION VALUE=22<CFIF Day(Now()) EQ 22> SELECTED</CFIF>>22
			<OPTION VALUE=23<CFIF Day(Now()) EQ 23> SELECTED</CFIF>>23
			<OPTION VALUE=24<CFIF Day(Now()) EQ 24> SELECTED</CFIF>>24
			<OPTION VALUE=25<CFIF Day(Now()) EQ 25> SELECTED</CFIF>>25
			<OPTION VALUE=26<CFIF Day(Now()) EQ 26> SELECTED</CFIF>>26
			<OPTION VALUE=27<CFIF Day(Now()) EQ 27> SELECTED</CFIF>>27
			<OPTION VALUE=28<CFIF Day(Now()) EQ 28> SELECTED</CFIF>>28
			<OPTION VALUE=29<CFIF Day(Now()) EQ 29> SELECTED</CFIF>>29
			<OPTION VALUE=30<CFIF Day(Now()) EQ 30> SELECTED</CFIF>>30
			<OPTION VALUE=31<CFIF Day(Now()) EQ 31> SELECTED</CFIF>>31
		</SELECT> 
		<SELECT NAME=searchCloseYYYY SIZE=1>
			<OPTION VALUE=1999<CFIF Year(Now()) EQ 1999> SELECTED</CFIF>>1999
			<OPTION VALUE=2000<CFIF Year(Now()) EQ 2000> SELECTED</CFIF>>2000
			<OPTION VALUE=2001<CFIF Year(Now()) EQ 2001> SELECTED</CFIF>>2001
		</SELECT> 
		<SELECT NAME=searchCloseHH SIZE=1>
			<OPTION VALUE=ALL><CFOUTPUT>#searchAllDay#</CFOUTPUT>
			<OPTION VALUE=00>12:00 am
			<OPTION VALUE=01>01:00 am
			<OPTION VALUE=02>02:00 am
			<OPTION VALUE=03>03:00 am
			<OPTION VALUE=04>04:00 am
			<OPTION VALUE=05>05:00 am
			<OPTION VALUE=06>06:00 am
			<OPTION VALUE=07>07:00 am
			<OPTION VALUE=08>08:00 am
			<OPTION VALUE=09>09:00 am
			<OPTION VALUE=10>10:00 am
			<OPTION VALUE=11>11:00 am
			<OPTION VALUE=12>12:00 pm
			<OPTION VALUE=13>01:00 pm
			<OPTION VALUE=14>02:00 pm
			<OPTION VALUE=15>03:00 pm
			<OPTION VALUE=16>04:00 pm
			<OPTION VALUE=17>05:00 pm
			<OPTION VALUE=18>06:00 pm
			<OPTION VALUE=19>07:00 pm
			<OPTION VALUE=20>08:00 pm
			<OPTION VALUE=21>09:00 pm
			<OPTION VALUE=22>10:00 pm
			<OPTION VALUE=23>11:00 pm
		</SELECT>
		<BR>&nbsp;<FONT SIZE=2>
		<INPUT TYPE=checkbox NAME=searchClose VALUE=before> <CFOUTPUT>#searchBefore#</CFOUTPUT> &nbsp; 
		<INPUT TYPE=checkbox NAME=searchClose VALUE=at> <CFOUTPUT>#searchAt#</CFOUTPUT> &nbsp; 
		<INPUT TYPE=checkbox NAME=searchClose VALUE=after> <CFOUTPUT>#searchAfter#</CFOUTPUT>
		</FONT></TD></TR>
	</CFIF>

	<CFIF ListFind(searchFields,"categoryID")>
		<TR BGCOLOR="#CDCDCD"><TD ALIGN=right VALIGN=top><CFOUTPUT>#searchCategory#</CFOUTPUT></TD>
		<CFQUERY NAME=getCategories DATASOURCE="#EAdatasource#">
			SELECT categoryID, categoryName
			FROM Category
			WHERE categoryID > 0
			ORDER BY categoryName
		</CFQUERY>

		<TD>
		<SELECT NAME=categoryID SIZE=6 MULTIPLE>
		<CFOUTPUT QUERY=getCategories>
			<OPTION VALUE=#categoryID#>#categoryName#
		</CFOUTPUT>
		</SELECT>
		</TD></TR>
	</CFIF>

	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") AND FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<TR BGCOLOR="#CDCDCD"><TD ALIGN=right>Item Type: </TD><TD><INPUT TYPE=checkbox NAME=lotType VALUE=1 CHECKED> Auction &nbsp; <INPUT TYPE=checkbox NAME=lotType VALUE=0> Classified &nbsp; <INPUT TYPE=checkbox NAME=lotType VALUE=-1> Procure</TD></TR>
	<CFELSEIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
		<TR BGCOLOR="#CDCDCD"><TD ALIGN=right>Item Type: </TD><TD><INPUT TYPE=checkbox NAME=lotType VALUE=1 CHECKED> Auction &nbsp; <INPUT TYPE=checkbox NAME=lotType VALUE=0> Classified</TD></TR>
	<CFELSEIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<TR BGCOLOR="#CDCDCD"><TD ALIGN=right>Item Type: </TD><TD><INPUT TYPE=checkbox NAME=lotType VALUE=1 CHECKED> Auction &nbsp; <INPUT TYPE=checkbox NAME=lotType VALUE=-1> Procure</TD></TR>
	</CFIF>

	<TR><TD></TD><TD><CFOUTPUT><INPUT TYPE=submit VALUE="#searchButton#"></CFOUTPUT></TD></TR>
	</TABLE>
	</FORM>

	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFINCLUDE TEMPLATE="../system/searchResultsHeader.cfm">

<CFIF IsDefined("Form.searchOpen")>
	<CFIF Form.searchOpenHH EQ "ALL">
		<CFSET openDateTime = CreateODBCDateTime(CreateDateTime(Form.searchOpenYYYY, Form.searchOpenMM, Form.searchOpenDD, 00, 00, 00))>
		<CFSET openDateTime2 = CreateODBCDateTime(CreateDateTime(Form.searchOpenYYYY, Form.searchOpenMM, Form.searchOpenDD, 23, 59, 59))>
	<CFELSE>
		<CFSET openDateTime = CreateODBCDateTime(CreateDateTime(Form.searchOpenYYYY, Form.searchOpenMM, Form.searchOpenDD, Form.searchOpenHH, 00, 00))>
	</CFIF>
</CFIF>
<CFIF IsDefined("Form.searchClose")>
	<CFIF Form.searchCloseHH EQ "ALL">
		<CFSET closeDateTime = CreateODBCDateTime(CreateDateTime(Form.searchCloseYYYY, Form.searchCloseMM, Form.searchCloseDD, 00, 00, 00))>
		<CFSET closeDateTime2 = CreateODBCDateTime(CreateDateTime(Form.searchCloseYYYY, Form.searchCloseMM, Form.searchCloseDD, 23, 59, 59))>
	<CFELSE>
		<CFSET closeDateTime = CreateODBCDateTime(CreateDateTime(Form.searchCloseYYYY, Form.searchCloseMM, Form.searchCloseDD, Form.searchCloseHH, 00, 00))>
	</CFIF>
</CFIF>

<CFQUERY NAME=searchLots DATASOURCE="#EAdatasource#">
	SELECT lotID, lotName, lotSummary
	FROM Lot
	WHERE lotCloseQueue = 1 AND lotPublic = 1
	<CFIF IsDefined("Form.searchText")>
		<CFIF Form.searchText NEQ "">
			AND (lotID = 0
			<CFIF ListFind(searchFields,"lotName")> OR lotName LIKE '%#ListFirst(Form.searchText)#%'</CFIF>
			<CFIF ListFind(searchFields,"lotSummary")> OR lotSummary LIKE '%#ListFirst(Form.searchText)#%'</CFIF>
			<CFIF ListFind(searchFields,"lotDescription")> OR lotDescription LIKE '%#ListFirst(Form.searchText)#%'</CFIF>
			<CFIF ListFind(searchFields,"lotLocation")> OR lotLocation LIKE '%#ListFirst(Form.searchText)#%'</CFIF>
			<CFLOOP INDEX=search FROM=2 TO=#ListLen(Form.searchText)#>
				<CFIF ListFind(searchFields,"lotName")> OR lotName LIKE '%#ListGetAt(Form.searchText,search)#%'</CFIF>
				<CFIF ListFind(searchFields,"lotSummary")> OR lotSummary LIKE '%#ListGetAt(Form.searchText,search)#%'</CFIF>
				<CFIF ListFind(searchFields,"lotDescription")> OR lotDescription LIKE '%#ListGetAt(Form.searchText,search)#%'</CFIF>
				<CFIF ListFind(searchFields,"lotLocation")> OR lotLocation LIKE '%#ListGetAt(Form.searchText,search)#%'</CFIF>
			</CFLOOP>)
		</CFIF>
	</CFIF>
	<CFIF IsDefined("openDateTime")>
		AND (lotID = 0
		<CFIF ListFind(Form.searchOpen,"before")> OR lotOpenDateTime < #openDateTime#</CFIF>
		<CFIF ListFind(Form.searchOpen,"at")> OR lotOpenDateTime = #openDateTime#</CFIF>
		<CFIF ListFind(Form.searchOpen,"after")> OR lotOpenDateTime > #openDateTime#</CFIF>
		<CFIF IsDefined("openDateTime2")>OR lotOpenDateTime BETWEEN #openDateTime# AND #openDateTime2#</CFIF>)
	</CFIF>
	<CFIF IsDefined("closeDateTime")>
		AND (lotID = 0
		<CFIF ListFind(Form.searchClose,"before")> OR lotCloseDateTime < #closeDateTime#</CFIF>
		<CFIF ListFind(Form.searchClose,"at")> OR lotCloseDateTime = #closeDateTime#</CFIF>
		<CFIF ListFind(Form.searchClose,"after")> OR lotCloseDateTime > #closeDateTime#</CFIF>
		<CFIF IsDefined("closeDateTime2")>OR lotCloseDateTime BETWEEN #closeDateTime# AND #closeDateTime2#</CFIF>)
	</CFIF>
	<CFIF IsDefined("Form.categoryID")>AND categoryID IN (#Form.categoryID#)</CFIF>
	<CFIF IsDefined("Form.lotType")>AND lotType IN (#Form.lotType#)</CFIF>
	ORDER BY lotName
</CFQUERY>

<CFIF searchLots.RecordCount EQ 0>
	<CFOUTPUT>#searchNoRecords#</CFOUTPUT>
<CFELSE>
	<CFOUTPUT QUERY="searchLots">
		<A HREF="#systemURL#/lot.cfm?lotID=#searchLots.lotID#">#searchLots.lotID#</A>. #searchLots.lotName#<BR>
	</CFOUTPUT>
</CFIF>

<P>
<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
</BODY>
</HTML>