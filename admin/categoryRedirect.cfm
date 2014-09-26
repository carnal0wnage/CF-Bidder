<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF IsDefined("categoryID") AND IsDefined("categoryURL")>
	<CFIF categoryID NEQ 0>
		<CFIF FindNoCase("lotType",categoryURL) EQ 0>
			<CFLOCATION URL="#categoryURL#.cfm?categoryID=#categoryID#&order=lotName">
		<CFELSE>
			<CFLOCATION URL="#ListFirst(categoryURL,"&")#.cfm?categoryID=#categoryID#&order=lotName&lotType=#Right(categoryURL,1)#">
		</CFIF>
	</CFIF>
<CFELSE>
	<CFIF IsDefined("searchOpen")>
		<CFIF searchOpenHH EQ "ALL">
			<CFSET openDateTime = CreateODBCDateTime(CreateDateTime(searchOpenYYYY, searchOpenMM, searchOpenDD, 00, 00, 00))>
			<CFSET openDateTime2 = CreateODBCDateTime(CreateDateTime(searchOpenYYYY, searchOpenMM, searchOpenDD, 23, 59, 59))>
		<CFELSE>
			<CFSET openDateTime = CreateODBCDateTime(CreateDateTime(searchOpenYYYY, searchOpenMM, searchOpenDD, searchOpenHH, 00, 00))>
		</CFIF>
	</CFIF>
	<CFIF IsDefined("searchClose")>
		<CFIF searchCloseHH EQ "ALL">
			<CFSET closeDateTime = CreateODBCDateTime(CreateDateTime(searchCloseYYYY, searchCloseMM, searchCloseDD, 00, 00, 00))>
			<CFSET closeDateTime2 = CreateODBCDateTime(CreateDateTime(searchCloseYYYY, searchCloseMM, searchCloseDD, 23, 59, 59))>
		<CFELSE>
			<CFSET closeDateTime = CreateODBCDateTime(CreateDateTime(searchCloseYYYY, searchCloseMM, searchCloseDD, searchCloseHH, 00, 00))>
		</CFIF>
	</CFIF>

	<CFIF NOT IsDefined("lotStatus")>
		<CFSET lotStatus = "Open,Closed">
	</CFIF>

	<CFIF NOT IsDefined("lotOrderBy")>
		<CFSET lotOrderBy = "lotName">
		<CFSET lotOrderDirection = "ASC">
	</CFIF>

	<CFQUERY NAME=getLots DATASOURCE="#EAdatasource#">
		SELECT lotID
		FROM Lot
		WHERE lotType = 1
			AND (lotID = 0 
		<CFIF ListLen(lotStatus) NEQ 4>
			<CFIF ListFind(lotStatus,"Inactive")>OR lotCloseQueue <= 0</CFIF>
			<CFIF ListFind(lotStatus,"Preview")>OR (lotCloseQueue = 1 AND lotOpenDateTime <= #CreateODBCDateTime(Now())#)</CFIF>
			<CFIF ListFind(lotStatus,"Open")>OR (lotCloseQueue = 1 AND lotOpenDateTime <= #CreateODBCDateTime(Now())#)</CFIF>
			<CFIF ListFind(lotStatus,"Closed")>OR lotCloseQueue > 1</CFIF>
		</CFIF>)
		<CFIF IsDefined("categoryID")>
			<CFIF categoryID NEQ 0>
				AND (categoryID = #ListFirst(categoryID)#
				<CFLOOP INDEX=catCount FROM=2 TO=#ListLen(categoryID)#>
					OR categoryID = #ListGetAt(categoryID,catCount)#
				</CFLOOP>)
			</CFIF>
		</CFIF>
		<CFIF IsDefined("openDateTime")>
			AND (lotID = 0
			<CFIF ListFind(searchOpen,"before")> OR lotOpenDateTime < #openDateTime#</CFIF>
			<CFIF ListFind(searchOpen,"at") AND IsDefined("openDateTime2")> OR (lotOpenDateTime BETWEEN #openDateTime# AND #openDateTime2#)
			  <CFELSEIF ListFind(searchOpen,"at")> OR lotOpenDateTime = #openDateTime#</CFIF>
			<CFIF ListFind(searchOpen,"after")> OR lotOpenDateTime > #openDateTime#</CFIF>)
		</CFIF>
		<CFIF IsDefined("closeDateTime")>
			AND (lotID = 0
			<CFIF ListFind(searchClose,"before")> OR lotCloseDateTime < #closeDateTime#</CFIF>
			<CFIF ListFind(searchClose,"at") AND IsDefined("closeDateTime2")> OR (lotCloseDateTime BETWEEN #closeDateTime# AND #closeDateTime2#)
			  <CFELSEIF ListFind(searchClose,"at")> OR lotCloseDateTime = #closeDateTime#</CFIF>
			<CFIF ListFind(searchClose,"after")> OR lotCloseDateTime > #closeDateTime#</CFIF>)
		</CFIF>
		ORDER BY #lotOrderBy# #lotOrderDirection#
	</CFQUERY>

	<CFIF getLots.RecordCount EQ 0>
		<HTML><HEAD><TITLE>Emaze Auction: Redirect</TITLE></HEAD>
		<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
		<H3>No lots satisfy these requirements.</H3>
		</BODY></HTML><CFABORT>
	</CFIF>

	<CFSET lotID = ValueList(getLots.lotID)>
	<CFIF NOT IsDefined("bidWin")>
		<CFINCLUDE TEMPLATE="lotMenu.cfm">
	<CFELSE>
		<HTML>
		<HEAD><TITLE>Emaze Auction: View Bids</TITLE></HEAD>
		<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

		<H1><FONT COLOR=purple><CFIF bidWin EQ 1>Winning<CFELSE>All</CFIF> Bids</FONT></H1>

		<CFIF bidOrderBy NEQ "name">
			<CFSET order = "#bidOrderBy# #bidOrderDirection#">
		<CFELSEIF bidOrderDirection EQ "ASC">
			<CFSET order = "lastName, firstName">
		<CFELSE>
			<CFSET order = "lastName DESC, firstName DESC">
		</CFIF>

		<CFSET categoryRedirect = 1>
		<CFLOOP QUERY=getLots>
			<CFSET lotID = getLots.lotID>
			<CFIF bidWin EQ 1>
				<CFINCLUDE TEMPLATE="lotWinners.cfm">
			<CFELSE>
				<CFINCLUDE TEMPLATE="lotBids.cfm">
			</CFIF>
			<P><HR NOSHADE SIZE=3 WIDTH=500 COLOR=purple><P>
		</CFLOOP>

		</BODY></HTML>
	</CFIF>
</CFIF>
