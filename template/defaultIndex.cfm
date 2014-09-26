<!--- Emaze Auction version 2.1, 1.01 / Thursday, July 22, 1999 --->
<CFINCLUDE TEMPLATE="../system/indexInfo.cfm">

<CFSET title = "indexBanner">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<TABLE WIDTH="600" BORDER=0><TR>
<TD WIDTH="160" VALIGN="TOP" NOWRAP><!--- 1ST COLUMN --->
	<BR>
	<CFOUTPUT><FORM METHOD=post ACTION="#systemURL#/program/search.cfm"></CFOUTPUT>
	<INPUT TYPE=hidden NAME=first VALUE=1>
	<INPUT TYPE=text NAME="searchText" SIZE=15><BR>
	<CFOUTPUT><INPUT TYPE=image NAME="search" SRC="#systemURL#/images/buttonSearch.gif" BORDER=0></CFOUTPUT>
	</FORM>

	<P>

	<CFQUERY NAME=getCategories DATASOURCE="#EAdatasource#">
		SELECT categoryID, categoryName1, categorySubLotCount
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>, categorySubMarketCount</CFIF>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, categorySubProcureCount</CFIF>
		FROM Category
		WHERE categoryID2 = 0
		ORDER BY categoryName1
	</CFQUERY>

	<CFOUTPUT><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"></CFOUTPUT><B>Categories</B></FONT><BR>
	<CFSET categorySubLotCountTotal = 0>

	<CFOUTPUT QUERY=getCategories>
		<CFSET subLotCountTotal = categorySubLotCount>
		<CFSET categorySubLotCountTotal = categorySubLotCountTotal + categorySubLotCount>
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
			<CFSET subLotCountTotal = subLotCountTotal + categorySubMarketCount>
			<CFSET categorySubLotCountTotal = categorySubLotCountTotal + categorySubMarketCount>
		</CFIF>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
			<CFSET subLotCountTotal = subLotCountTotal + categorySubProcureCount>
			<CFSET categorySubLotCountTotal = categorySubLotCountTotal + categorySubProcureCount>
		</CFIF>
		  <A HREF="#systemURL#/category.cfm?categoryID=#categoryID#">#categoryName1#</A> (#subLotCountTotal#)<BR>
	</CFOUTPUT>
	<FONT SIZE=2><CFOUTPUT><A HREF="#systemURL#/program/allCategories.cfm">all categories...</A> (#categorySubLotCountTotal#)</CFOUTPUT></FONT>

	<P>

	<CFOUTPUT>
	<FORM NAME=lot ACTION="#systemURL#/lot.cfm">
	<FONT COLOR="#navTableFont#" FACE="arial"><B>Lot: </B></FONT><INPUT TYPE=text NAME="lotID" SIZE=5>
	<INPUT TYPE=image NAME=go SRC="#systemURL#/images/go.gif" HEIGHT=25 WIDTH=32 ALIGN=absbottom BORDER=0>
	</CFOUTPUT>
	</FORM>

	<P>

	<TABLE WIDTH="160" CELLSPACING="0" CELLPADDING="0">
	<CFOUTPUT>
	<TR><TD BGCOLOR="#navBottomTableBg#" ALIGN=center><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"><B>#indexSpecial#</B></FONT></TD></TR>
	<TR><TD BGCOLOR="#navTopTableBg#"><BR>
	</CFOUTPUT>
	<CFINCLUDE TEMPLATE="../system/indexSpecial.cfm">
	<BR><BR>
	</TD></TR></TABLE>

	<P>

	<TABLE CELLSPACING=0 CELLPADDING=0 WIDTH="160">
	<CFOUTPUT>
	<TR><TD BGCOLOR="#navBottomTableBg#" ALIGN=center><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"><B>#indexUser#</B></FONT></TD></TR>
	<TR><TD BGCOLOR="#navTopTableBg#" ALIGN=center NOWRAP>
		<FORM METHOD=post ACTION="#systemURL#/program/editUser.cfm">
	</CFOUTPUT>
	<CFIF IsDefined("Cookie.EmazeAuction_user")>
		<INPUT TYPE=checkbox NAME=useCookie VALUE=1 CHECKED> Use my cookie<P>
	</CFIF>
	<FONT FACE="Arial" SIZE="2"><STRONG>Username:</STRONG></FONT><BR> 
	<INPUT TYPE=text NAME=username SIZE=15><BR>
	<FONT FACE="Arial" SIZE="2"><STRONG>Password:</STRONG></FONT><BR>
	<INPUT TYPE=password NAME=password SIZE=15><BR>
	<CFOUTPUT>
	<INPUT TYPE=image NAME=bidStatus SRC="#systemURL#/images/buttonBidStatus.gif" BORDER=0 VSPACE=5><BR>
	<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
		<INPUT TYPE=image NAME=sellerHome SRC="#systemURL#/images/buttonSeller.gif"  BORDER=0 VSPACE=3>
	</CFIF>
	</CFOUTPUT>
	</FORM>	
	</TD></TR></TABLE>
</TD><!--- END OF 1ST COLUMN --->

<TD VALIGN=top><!--- BEGIN 2ND COLUMN --->
	<TABLE WIDTH=100% CELLSPACING=0 CELLPADDING=0><TR><TD ALIGN=right>
	<CFOUTPUT>
	<FONT SIZE=2 COLOR="#navTableFont#">  <B>Time:</B> </FONT>
	<FONT SIZE=2>#LSDateFormat(Now(),"mmmm dd, yyyy")# / #LSTimeFormat(Now(), timeFormatDisplay)# #timeFormatTimeZone#</FONT>
	</CFOUTPUT>
	</TD></TR></TABLE>

	<P>
	<CFINCLUDE TEMPLATE="../system/indexHeader.cfm">
	<P>

	<CFINCLUDE TEMPLATE="../system/iconOptions.cfm">
	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<CFSET lotTypeColspan = 3>
	<CFELSE><CFSET lotTypeColspan = 2></CFIF>

	<!--- Featured Auctions --->
	<CFQUERY NAME=getFeatured DATASOURCE="#EAdatasource#" MAXROWS="10">
		SELECT Lot.lotID, Lot.lotName, Lot.lotBold, Lot.lotHighBid, Lot.lotType
		<CFIF iconListIndexFields EQ " "> FROM Lot<CFELSE><CFINCLUDE TEMPLATE="../system/iconQuery.cfm"></CFIF>
		WHERE Lot.lotFeaturedHomepage = 1
			AND Lot.lotCloseQueue = 1
			AND Lot.lotOpenDateTime <= #CreateODBCDateTime(Now())#
		ORDER BY Lot.lotViewCount, Lot.lotType DESC
	</CFQUERY>

	<CFIF getFeatured.RecordCount NEQ 0>
		<CENTER><TABLE WIDTH=400 BORDER=1 CELLSPACING=2 CELLPADDING=2>
		<CFOUTPUT>
			<TR><TH BGCOLOR="#navBottomTableBg#" COLSPAN=#lotTypeColspan#><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial">Featured Items</FONT></TH></TR>
			<TR><TH BGCOLOR="#navTopTableBg#">Name</TH>
			<CFIF NOT FileExists("#systemPath#\admin\marketHeaders.cfm") AND NOT FileExists("#systemPath#\admin\procureHeaders.cfm")>
				<TH BGCOLOR="#navTopTableBg#">Bid</TH>
			<CFELSEIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Bid/Price</FONT></TH>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Type</FONT></TH>
			<CFELSE><!--- FileExists("#systemPath#\admin\procureHeaders.cfm") --->
				<TH BGCOLOR="#navTopTableBg#">Bid</TH>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Type</FONT></TH>
			</CFIF>
			</TR>
		</CFOUTPUT>

		<CFSET rowBG = 0>
		<CFLOOP QUERY=getFeatured>
			<CFIF rowBG EQ 1><TR BGCOLOR="#DCDCDC"><CFSET rowBG = 0><CFELSE><TR><CFSET rowBG = 1></CFIF>
			<CFOUTPUT><TD><FONT SIZE=2><A HREF="lot.cfm?lotID=#lotID#"><CFIF lotBold EQ 1><B>#lotName#</B><CFELSE>#lotName#</CFIF></A></FONT></CFOUTPUT>
			<CFIF iconListIndex NEQ " "><CFINCLUDE TEMPLATE="../system/iconDisplay.cfm"></CFIF></TD>
			<TD NOWRAP><FONT SIZE=2><CFOUTPUT>#LSCurrencyFormat(lotHighBid,"local")#</CFOUTPUT></FONT></TD>
			<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm")>
				<TD NOWRAP><FONT SIZE=2><CFIF lotType EQ 1>Auction<CFELSEIF lotType EQ 0>Classified<CFELSE>Procure</CFIF></FONT></TD>
			</CFIF>
			</TR>
		</CFLOOP>
		<CFIF getFeatured.RecordCount EQ 10>
			<CFOUTPUT><TR><TD BGCOLOR="#navTopTableBg#" COLSPAN=2><FONT SIZE=2><A HREF="#systemURL#/program/list.cfm?featured=1">all featured lots...</A></FONT></TD></TR></CFOUTPUT>
		</CFIF>
		</TABLE></CENTER>
	</CFIF>
	<!--- end of Featured Auctions --->

	<P>
	<CFINCLUDE TEMPLATE="../system/indexMiddle.cfm">
	<P>

	<!--- beginning of auctions opening today --->
	<CFSET lotDateTime1 = CreateODBCDateTime(CreateDateTime(Year(Now()), Month(Now()), Day(Now()), 00, 00, 00))>
	<CFSET lotDateTime2 = CreateODBCDateTime(CreateDateTime(Year(Now()), Month(Now()), Day(Now()), 23, 59, 59))>
	<CFQUERY NAME=getOpening DATASOURCE="#EAdatasource#" MAXROWS="7">
		SELECT Lot.lotName, Lot.lotID, Lot.lotHighBid, Lot.lotBold, Lot.lotType
		<CFIF iconListIndexFields EQ " ">FROM Lot<CFELSE><CFINCLUDE TEMPLATE="../system/iconQuery.cfm"></CFIF>
		WHERE Lot.lotCloseQueue = 1
			AND Lot.lotOpenDateTime BETWEEN #lotDateTime1# AND #lotDateTime2#
		ORDER BY Lot.lotOpenDateTime, Lot.lotType DESC
	</CFQUERY>

	<CFIF getOpening.RecordCount GT 0>
		<CENTER><TABLE WIDTH=400 BORDER=1 CELLSPACING=2 CELLPADDING=2>
		<CFOUTPUT>
			<TR><TH BGCOLOR="#navBottomTableBg#" COLSPAN=#lotTypeColspan#><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial">Items Opening Today</FONT></TH></TR>
			<TR><TH BGCOLOR="#navTopTableBg#">Name</TH>
			<CFIF NOT FileExists("#systemPath#\admin\marketHeaders.cfm") AND NOT FileExists("#systemPath#\admin\procureHeaders.cfm")>
				<TH BGCOLOR="#navTopTableBg#">Bid</TH>
			<CFELSEIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Bid/Price</FONT></TH>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Type</FONT></TH>
			<CFELSE><!--- FileExists("#systemPath#\admin\procureHeaders.cfm") --->
				<TH BGCOLOR="#navTopTableBg#">Bid</TH>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Type</FONT></TH>
			</CFIF>
			</TR>
		</CFOUTPUT>

		<CFSET rowBG = 0>
		<CFLOOP QUERY=getOpening>
			<CFIF rowBG EQ 1><TR BGCOLOR="#DCDCDC"><CFSET rowBG = 0><CFELSE><TR><CFSET rowBG = 1></CFIF>
			<CFOUTPUT><TD><FONT SIZE=2><A HREF="lot.cfm?lotID=#lotID#"><CFIF lotBold EQ 1><B>#lotName#</B><CFELSE>#lotName#</CFIF></A></FONT></CFOUTPUT>
			<CFIF iconListIndex NEQ " "><CFINCLUDE TEMPLATE="../system/iconDisplay.cfm"></CFIF></TD>
			<TD NOWRAP><FONT SIZE=2><CFOUTPUT>#LSCurrencyFormat(lotHighBid,"local")#</CFOUTPUT></FONT></TD>
			<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm")>
				<TD NOWRAP><FONT SIZE=2><CFIF lotType EQ 1>Auction<CFELSEIF lotType EQ 0>Classified<CFELSE>Procure</CFIF></FONT></TD>
			</CFIF>
			</TR>
		</CFLOOP>
		<CFIF getOpening.RecordCount EQ 7>
			<CFOUTPUT><TR><TD BGCOLOR="#navTopTableBg#" COLSPAN=2><FONT SIZE=2><A HREF="#systemURL#/program/list.cfm?opening=1">all lots opening today...</A></FONT></TD></TR></CFOUTPUT>
		</CFIF>
		</TABLE></CENTER>
		<P>
	</CFIF>
	<!--- end of auctions opening today --->

	<P>
	<CFINCLUDE TEMPLATE="../system/indexFooter.cfm">
	<P>

	<!--- beginning of auctions closing today --->
	<CFQUERY NAME=getClosing DATASOURCE="#EAdatasource#" MAXROWS="7">
		SELECT Lot.lotName, Lot.lotID, Lot.lotHighBid, Lot.lotBold, Lot.lotType
		<CFIF iconListIndexFields EQ " ">FROM Lot<CFELSE><CFINCLUDE TEMPLATE="../system/iconQuery.cfm"></CFIF>
		WHERE Lot.lotCloseQueue = 1
			AND Lot.lotCloseDateTime BETWEEN #lotDateTime1# AND #lotDateTime2#
		ORDER BY Lot.lotCloseDateTime, Lot.lotType DESC
	</CFQUERY>

	<CFIF getClosing.RecordCount GT 0>
		<CENTER><TABLE WIDTH=400 BORDER=1 CELLSPACING=2 CELLPADDING=2>
		<CFOUTPUT>
			<TR><TH BGCOLOR="#navBottomTableBg#" COLSPAN=#lotTypeColspan#><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial">Items Closing Today</FONT></TH></TR>
			<TR><TH BGCOLOR="#navTopTableBg#">Name</TH>
			<CFIF NOT FileExists("#systemPath#\admin\marketHeaders.cfm") AND NOT FileExists("#systemPath#\admin\procureHeaders.cfm")>
				<TH BGCOLOR="#navTopTableBg#">Bid</TH>
			<CFELSEIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Bid/Price</FONT></TH>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Type</FONT></TH>
			<CFELSE><!--- FileExists("#systemPath#\admin\procureHeaders.cfm") --->
				<TH BGCOLOR="#navTopTableBg#">Bid</TH>
				<TH BGCOLOR="#navTopTableBg#"><FONT SIZE=2>Type</FONT></TH>
			</CFIF>
			</TR>
		</CFOUTPUT>

		<CFSET rowBG = 0>
		<CFLOOP QUERY=getClosing>
			<CFIF rowBG EQ 1><TR BGCOLOR="#DCDCDC"><CFSET rowBG = 0><CFELSE><TR><CFSET rowBG = 1></CFIF>
			<CFOUTPUT><TD><FONT SIZE=2><A HREF="lot.cfm?lotID=#lotID#"><CFIF lotBold EQ 1><B>#lotName#</B><CFELSE>#lotName#</CFIF></A></FONT></CFOUTPUT>
			<CFIF iconListIndex NEQ " "><CFINCLUDE TEMPLATE="../system/iconDisplay.cfm"></CFIF></TD>
			<TD NOWRAP><FONT SIZE=2><CFOUTPUT>#LSCurrencyFormat(lotHighBid,"local")#</CFOUTPUT></FONT></TD>
			<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm")>
				<TD NOWRAP><FONT SIZE=2><CFIF lotType EQ 1>Auction<CFELSEIF lotType EQ 0>Classified<CFELSE>Procure</CFIF></FONT></TD>
			</CFIF>
			</TR>
		</CFLOOP>
		<CFIF getClosing.RecordCount EQ 7>
			<CFOUTPUT><TR><TD BGCOLOR="#navTopTableBg#" COLSPAN=2><FONT SIZE=2><A HREF="#systemURL#/program/list.cfm?closing=1">all lots closing today...</A></FONT></TD></TR></CFOUTPUT>
		</CFIF>
		</TABLE></CENTER>
		<P>
	</CFIF>
	<!--- end of auctions closing today --->

</TD><!--- END OF 2ND COLUMN --->
</TR></TABLE>

<P>
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
<P>
</BODY>
</HTML>
