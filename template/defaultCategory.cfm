<!--- Emaze Auction version 2.1, 1.04 / Thursday, August 26, 1999 --->
<CFINCLUDE TEMPLATE="../system/indexInfo.cfm">

<CFSET title = "categoryNameX">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD ALIGN=right><CFOUTPUT><FONT SIZE=2 COLOR="#navTableFont#" FACE=arial></CFOUTPUT>&nbsp; <B>Time:</B> </FONT></TD>
<TD><FONT SIZE=2><CFOUTPUT>#LSDateFormat(Now(),"mmmm dd, yyyy")# / #LSTimeFormat(Now(), timeFormatDisplay)# #timeFormatTimeZone#</CFOUTPUT></FONT></TD></TR>
<CFIF categoryID2 NEQ 0>
	<BR><CFOUTPUT>
	<TR><TD ALIGN=right><B><FONT SIZE=2 COLOR="#navTableFont#" FACE=arial>Category: </FONT></B></TD>
	<TD><FONT SIZE=2 FACE=arial><A HREF="#systemURL#/category.cfm?categoryID=#categoryID1#">#categoryName1#</A>
	<CFIF categoryID3 EQ 0>#subCategorySeparator#<B><A HREF="#systemURL#/category.cfm?categoryID=#categoryID2#">#categoryName2#</A></B>
	<CFELSEIF categoryID4 EQ 0>#subCategorySeparator#<A HREF="#systemURL#/category.cfm?categoryID=#categoryID2#">#categoryName2#</A><B>#subCategorySeparator#<A HREF="#systemURL#/category.cfm?categoryID=#categoryID3#">#categoryName3#</A></B>
	<CFELSE>#subCategorySeparator#<A HREF="#systemURL#/category.cfm?categoryID=#categoryID2#">#categoryName2#</A>#subCategorySeparator#<A HREF="#systemURL#/category.cfm?categoryID=#categoryID3#">#categoryName3#</A>#subCategorySeparator#<B><A HREF="#systemURL#/category.cfm?categoryID=#categoryID4#">#categoryName4#</A></B>
	</CFIF>
	</FONT></CFOUTPUT></TD></TR>
</CFIF>
</TABLE>

<TABLE WIDTH="600" BORDER=0><TR>
<TD WIDTH="160" VALIGN="TOP" NOWRAP><!--- 1ST COLUMN --->
	<BR>
	<CFOUTPUT><FORM METHOD=post ACTION="#systemURL#/program/search.cfm"></CFOUTPUT>
	<INPUT TYPE=hidden NAME=first VALUE=1>
	<INPUT TYPE=text NAME="searchText" SIZE=15><BR>
	<CFOUTPUT><INPUT TYPE=checkbox NAME=categoryID VALUE="#categoryID#"><FONT SIZE=2>(Only in this Category)<BR>
	<INPUT TYPE=image NAME="search" SRC="#systemURL#/images/buttonSearch.gif" BORDER=0></CFOUTPUT>
	</FORM>

	<P>

	<CFQUERY NAME=getCategories DATASOURCE="#EAdatasource#">
		SELECT categoryID, categoryName1, categoryLotCount, categorySubLotCount
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>, categoryMarketCount, categorySubMarketCount</CFIF>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, categoryProcureCount, categorySubProcureCount</CFIF>
		FROM Category
		WHERE categoryID2 = 0
		ORDER BY categoryName1
	</CFQUERY>

	<CFOUTPUT><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"></CFOUTPUT><B>Categories</B></FONT><BR>
	<CFSET categorySubLotCountTotal = 0>
	<CFSET theCategoryID = categoryID>
	<CFLOOP QUERY=getCategories>
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

		<CFIF categoryID1 NEQ getCategories.categoryID>
			<CFOUTPUT>&nbsp; <A HREF="#systemURL#/category.cfm?categoryID=#getCategories.categoryID#">#getCategories.categoryName1#</A> (#subLotCountTotal#)</CFOUTPUT><BR>
		<CFELSE>
			<CFSET lotCountTotal = getCategories.categoryLotCount>
			<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
				<CFSET lotCountTotal = lotCountTotal + getCategories.categoryMarketCount>
			</CFIF>
			<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
				<CFSET lotCountTotal = lotCountTotal + getCategories.categoryProcureCount>
			</CFIF>
			<CFIF theCategoryID EQ getCategories.categoryID>
				<CFOUTPUT>&nbsp; <B><A HREF="#systemURL#/category.cfm?categoryID=#getCategories.categoryID#">#getCategories.categoryName1#</A></B> (#lotCountTotal#)</CFOUTPUT><BR>
			<CFELSE>
				<CFOUTPUT>&nbsp; <A HREF="#systemURL#/category.cfm?categoryID=#getCategories.categoryID#">#getCategories.categoryName1#</A> (#lotCountTotal#)</CFOUTPUT><BR>
			</CFIF>

			<CFQUERY NAME=getSubCategories DATASOURCE="#EAdatasource#">
				SELECT categoryID, categoryName2, categoryName3, categoryName4, categoryID3, categoryID4, categoryLotCount
				<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>, categoryMarketCount</CFIF>
				<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, categoryProcureCount</CFIF>
				FROM Category
				WHERE categoryID1 = #categoryID1#
					AND categoryID <> #getCategories.categoryID#
				ORDER BY categoryName2, categoryName3, categoryName4
			</CFQUERY>

			<CFOUTPUT QUERY=getSubCategories>
				<CFSET lotCountTotal = categoryLotCount>
				<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
					<CFSET lotCountTotal = lotCountTotal + categoryMarketCount>
				</CFIF>
				<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
					<CFSET lotCountTotal = lotCountTotal + categoryProcureCount>
				</CFIF>

				<CFIF getSubCategories.categoryID3 EQ 0>
					<CFIF theCategoryID EQ getSubCategories.categoryID>
						&nbsp; &nbsp; <B><A HREF="#systemURL#/category.cfm?categoryID=#getSubCategories.categoryID#">#getSubCategories.categoryName2#</A></B> (#lotCountTotal#)<BR>
					<CFELSE>
						&nbsp; &nbsp; <A HREF="#systemURL#/category.cfm?categoryID=#getSubCategories.categoryID#">#getSubCategories.categoryName2#</A> (#lotCountTotal#)<BR>
					</CFIF>
				<CFELSEIF getSubCategories.categoryID4 EQ 0>
					<CFIF theCategoryID EQ getSubCategories.categoryID>
						&nbsp; &nbsp; &nbsp; <B><A HREF="#systemURL#/category.cfm?categoryID=#getSubCategories.categoryID#">#getSubCategories.categoryName3#</A></B> (#lotCountTotal#)<BR>
					<CFELSE>
						&nbsp; &nbsp; &nbsp; <A HREF="#systemURL#/category.cfm?categoryID=#getSubCategories.categoryID#">#getSubCategories.categoryName3#</A> (#lotCountTotal#)<BR>
					</CFIF>
				<CFELSEIF theCategoryID EQ getSubCategories.categoryID>
					&nbsp; &nbsp; &nbsp; &nbsp; <B><A HREF="#systemURL#/category.cfm?categoryID=#getSubCategories.categoryID#">#getSubCategories.categoryName4#</A></B> (#lotCountTotal#)<BR>
				<CFELSE>
					&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#systemURL#/category.cfm?categoryID=#getSubCategories.categoryID#">#getSubCategories.categoryName4#</A> (#lotCountTotal#)<BR>
				</CFIF>
			</CFOUTPUT>
		</CFIF>
	</CFLOOP>
	<FONT SIZE=2><CFOUTPUT><A HREF="#systemURL#/program/allCategories.cfm">all categories...</A> (#categorySubLotCountTotal#)</CFOUTPUT></FONT>

	<P>

	<CFOUTPUT>
	<FORM METHOD=post ACTION="#systemURL#/program/editUser.cfm">
	<INPUT TYPE=hidden NAME=categoryID VALUE="#categoryID#">
	<INPUT TYPE=image NAME=subscribe SRC="#systemURL#/images/buttonSubscribe.gif" BORDER=0>
	<CFIF categoryID4 EQ 0><BR><INPUT TYPE=checkbox NAME=subcategorySubscribe VALUE=1> Sub-categories too</CFIF>
	</CFOUTPUT>
	</FORM>

	<P>

	<TABLE WIDTH=150 CELLSPACING=0 CELLPADDING=0>
	<CFOUTPUT>
	<TR><TD BGCOLOR="#navBottomTableBg#"><DIV ALIGN="Center"><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"><B>#indexSpecial#</B></FONT></DIV></TD></TR>
	<TR><TD BGCOLOR="#navTopTableBg#">
	</CFOUTPUT>
	<CFINCLUDE TEMPLATE="../category/#categoryID#CategorySpecial.cfm">
	<BR><BR>
	</TD></TR></TABLE>
</TD><!--- END OF 1ST COLUMN --->

<TD VALIGN=top><!--- BEGIN 2ND COLUMN --->
	<P>
	<CFINCLUDE TEMPLATE="../category/#categoryID#CategoryHeader.cfm">
	<P>

	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<BR><TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2><TR>
		<CFOUTPUT><TD BGCOLOR="#navBottomTableBg#"><FONT SIZE=2 COLOR="#navTableFont#" FACE="arial"><B><I>Item Type</I>: </B></FONT></TD></CFOUTPUT>
		<TD><FONT SIZE=2 FACE=arial>&nbsp; <A HREF="#auction">Auction</A> &nbsp; | &nbsp; 
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") AND FileExists("#systemPath#\admin\procureHeaders.cfm")>
			<A HREF="#classified">Classified</A> &nbsp; | &nbsp; <A HREF="#procure">Procure</A> 
			<CFSET lotTypeList = "1,0,-1"><CFSET lotTypeColspan = 3>
		<CFELSEIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
			<CFSET lotTypeList = "1,0"><A HREF="#classified">Classified</A>
		<CFELSE><CFSET lotTypeList = "1,-1"><A HREF="#procure">Procure</A></CFIF>
		 &nbsp;	</FONT></TD></TR></TABLE><P>
	<CFELSE>
		<CFSET lotTypeList = "1">
	</CFIF>

	<CFINCLUDE TEMPLATE="../system/iconOptions.cfm">
	<CFSET iconListIndexFields = iconListCategoryFields>
	<CFSET iconListIndex = iconListCategory>

	<!--- Featured Auctions --->
	<CFQUERY NAME=getFeatured DATASOURCE="#EAdatasource#">
		SELECT Lot.lotID, Lot.lotName, Lot.lotBold, Lot.lotHighBid, Lot.lotType
		<CFIF iconListCategoryFields EQ " ">FROM Lot<CFELSE><CFINCLUDE TEMPLATE="../system/iconQuery.cfm"></CFIF>
		WHERE Lot.lotFeaturedCategory = 1
			AND Lot.lotCloseQueue = 1
			AND Lot.lotOpenDateTime <= #CreateODBCDateTime(Now())#
			AND Lot.categoryID = #categoryID#
		ORDER BY Lot.lotType DESC, Lot.lotViewCount
	</CFQUERY>

	<!--- current open auctions --->
	<CFQUERY NAME=getOpening DATASOURCE="#EAdatasource#">
		SELECT Lot.lotName, Lot.lotID, Lot.lotHighBid, Lot.lotBold, Lot.lotType
		<CFIF iconListCategoryFields EQ " ">FROM Lot<CFELSE><CFINCLUDE TEMPLATE="../system/iconQuery.cfm"></CFIF>
		WHERE Lot.lotCloseQueue = 1
			AND Lot.lotOpenDateTime <= #CreateODBCDateTime(Now())#
			AND Lot.categoryID = #categoryID#
		ORDER BY Lot.lotType DESC, Lot.lotOpenDateTime
	</CFQUERY>

	<!--- auctions closed within the past week --->
	<CFQUERY NAME=getClosing DATASOURCE="#EAdatasource#">
		SELECT Lot.lotName, Lot.lotID, Lot.lotHighBid, Lot.lotBold, Lot.lotType
		<CFIF iconListCategoryFields EQ " ">FROM Lot<CFELSE><CFINCLUDE TEMPLATE="../system/iconQuery.cfm"></CFIF>
		WHERE Lot.lotCloseQueue > 1
			AND Lot.lotCloseDateTime >= #CreateODBCDateTime(DateAdd("w",-1,Now()))#
			AND categoryID = #categoryID#
		ORDER BY Lot.lotType DESC, Lot.lotCloseDateTime
	</CFQUERY>

	<!--- Determine which queries returned at least one record --->
	<CFSET getLotQueryList = " ">
	<CFIF getFeatured.RecordCount NEQ 0><CFSET getLotQueryList = ListAppend(getLotQueryList,"getFeatured")></CFIF>
	<CFIF getOpening.RecordCount NEQ 0><CFSET getLotQueryList = ListAppend(getLotQueryList,"getOpening")></CFIF>
	<CFIF getClosing.RecordCount NEQ 0><CFSET getLotQueryList = ListAppend(getLotQueryList,"getClosing")></CFIF>
	<CFSET getLotQueryList = ListRest(getLotQueryList)>

	<!--- For each lot type, for each query, display items of that type --->
	<CFLOOP INDEX=lotTypeIndex LIST="#lotTypeList#">
		<CFIF ListLen(lotTypeList) NEQ 1>
			<CFIF lotTypeIndex NEQ ListFirst(lotTypeList)>
				<CFOUTPUT><P><HR NOSHADE SIZE=4 COLOR="#navTableFont#"><P></CFOUTPUT>
			</CFIF>
			<FONT SIZE=5 FACE=Arial><B>
			<CFIF lotTypeIndex EQ 1><A NAME=auction></A>Auction
			<CFELSEIF lotTypeIndex EQ 0><A NAME=classified></A>Classified
			<CFELSE><A NAME=procure></A>Procurement
			</CFIF>
			</B></FONT>
		</CFIF>

		<CFSET currentLotType = lotTypeIndex>
		<!--- loop thru queries --->
		<CFLOOP INDEX=getLotQueryIndex LIST="#getLotQueryList#">
			<!--- determine if there are any items of the current lotType in the current query --->
			<CFIF getLotQueryIndex EQ "getFeatured">
				<CFSET lotTypeStartRow = ListFind(ValueList(getFeatured.lotType),currentLotType)>
			<CFELSEIF getLotQueryIndex EQ "getOpening">
				<CFSET lotTypeStartRow = ListFind(ValueList(getOpening.lotType),currentLotType)>
			<CFELSE>
				<CFSET lotTypeStartRow = ListFind(ValueList(getClosing.lotType),currentLotType)>
			</CFIF>

			<!--- display the items of the current lotType in the current query --->
			<CFIF lotTypeStartRow NEQ 0>
				<CENTER><TABLE WIDTH=400 BORDER=1 CELLSPACING=2 CELLPADDING=2>
				<CFOUTPUT>
				<TR><TH BGCOLOR="#navBottomTableBg#" COLSPAN=2><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial">
				<CFIF getLotQueryIndex EQ "getFeatured">Featured<CFELSEIF getLotQueryIndex EQ "getOpening">Open</CFIF> 
				<CFIF currentLotType EQ 1>Auction<CFELSEIF currentLotType EQ 0>Classified<CFELSE>Procure</CFIF> 
				Items <CFIF getLotQueryIndex EQ "getClosing">Closed Within The Past Week</CFIF></FONT></TH></TR>
				<TR><TH BGCOLOR="#navTopTableBg#">Name</TH>
				<TH BGCOLOR="#navTopTableBg#"><CFIF currentLotType EQ 0>Price<CFELSE>Bid</CFIF></TH></TR>
				</CFOUTPUT>

				<CFSET rowBG = 0>
				<CFSET currentLotType2 = currentLotType>
				<CFLOOP QUERY="#getLotQueryIndex#" STARTROW="#lotTypeStartRow#">
					<CFIF lotType NEQ currentLotType2><CFBREAK></CFIF>
					<CFIF rowBG EQ 1><TR BGCOLOR="#DCDCDC"><CFSET rowBG = 0><CFELSE><TR><CFSET rowBG = 1></CFIF>
					<CFOUTPUT><TD><FONT SIZE=2><A HREF="lot.cfm?lotID=#lotID#"><CFIF lotBold EQ 1><B>#lotName#</B><CFELSE>#lotName#</CFIF></A></FONT></CFOUTPUT>
					<CFIF iconListCategory NEQ " "><CFINCLUDE TEMPLATE="../system/iconDisplay.cfm"></CFIF></TD>
					<TD NOWRAP><CFOUTPUT><FONT SIZE=2>#LSCurrencyFormat(lotHighBid,"local")#</CFOUTPUT></FONT></TD>
					</TR>
				</CFLOOP>
				</TABLE></CENTER><P>
			</CFIF>
		</CFLOOP>
	</CFLOOP>

	<P>
	<CFINCLUDE TEMPLATE="../category/#categoryID#CategoryFooter.cfm">
	<P>

</TD><!--- END OF 2ND COLUMN --->
</TR></TABLE>

<P>
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
<P>
</BODY>
</HTML>
