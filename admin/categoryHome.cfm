<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("noHeader")>
	<HTML>
	<HEAD><TITLE>Emaze Auction: Edit Category</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
</CFIF>

<CFQUERY NAME=getCategories DATASOURCE="#EAdatasource#">
	SELECT categoryID, categoryLotCount, categoryViewCount, categoryName,
		categoryName1, categoryName2, categoryName3, categoryName4,
		categoryID1, categoryID2, categoryID3, categoryID4
	FROM Category
	WHERE categoryID > 0
	ORDER BY categoryName1, categoryName2, categoryName3, categoryName4
</CFQUERY>

<CFQUERY NAME=getLotCounts DATASOURCE="#EAdatasource#">
	SELECT Sum(lotViewCount) AS SumLotViewCount, Category.categoryID
	FROM Lot INNER JOIN Category ON Lot.categoryID = Category.categoryID
	GROUP BY Category.categoryID
</CFQUERY>

<CFFORM ACTION=categoryRedirect.cfm NAME=homeCategory>
<INPUT TYPE=hidden NAME=order VALUE=lotName>
<SELECT NAME=categoryID SIZE=1>
<OPTION VALUE=0>SELECT CATEGORY
<CFOUTPUT QUERY=getCategories>
	<OPTION VALUE=#categoryID#>#categoryName#
</CFOUTPUT>
</SELECT> <INPUT TYPE=submit VALUE=go><BR>
<TABLE BORDER=0><TR>
	<TD BGCOLOR=DCDCDC><INPUT TYPE=radio NAME=categoryURL VALUE=categoryCreate CHECKED> <FONT SIZE=2>Edit</FONT></TD>

	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm") OR FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<TD BGCOLOR=DCDCDC><INPUT TYPE=radio NAME=categoryURL VALUE="categoryLots&lotType=1"> <FONT SIZE=2>Lots</FONT></TD>
	<CFELSE>
		<TD BGCOLOR=DCDCDC><INPUT TYPE=radio NAME=categoryURL VALUE="categoryLots&lotType=2"> <FONT SIZE=2>Lots</FONT></TD>	
	</CFIF>
	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
		<TD BGCOLOR=DCDCDC><INPUT TYPE=radio NAME=categoryURL VALUE="categoryLots&lotType=0"> <FONT SIZE=2>Classified</FONT></TD>
	</CFIF>
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<TD BGCOLOR=DCDCDC><INPUT TYPE=radio NAME=categoryURL VALUE="categoryLots&lotType=-1"> <FONT SIZE=2>Procure</FONT></TD>
	</CFIF>
	<TD BGCOLOR=DCDCDC><INPUT TYPE=radio NAME=categoryURL VALUE=categorySummary> <FONT SIZE=2>Lot Summary</FONT></TD>
	<TD BGCOLOR=DCDCDC><INPUT TYPE=radio NAME=categoryURL VALUE=lotWinnersAll> <FONT SIZE=2>Winning Bids</FONT></TD>
	<TD BGCOLOR=DCDCDC><INPUT TYPE=radio NAME=categoryURL VALUE=categoryDelete> <FONT SIZE=2 COLOR=red>Delete</FONT></TD>
</TR></TABLE></CFFORM>

<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
<TH BGCOLOR="purple"><FONT SIZE=2>ID</FONT></TH>
<TH BGCOLOR="#FFFFCE"><FONT SIZE=2>Cat.<BR>Views</FONT></TH>
<TH BGCOLOR="#FFFFCE"><FONT SIZE=2>Lot<BR>Views</FONT></TH>
<TH BGCOLOR="orange"><FONT SIZE=2>Count</FONT></TH>
<TH BGCOLOR="#33FF99" ALIGN=left>Category Name (1 | <FONT COLOR=purple>2</FONT> | <FONT COLOR=red>3</FONT> | <FONT COLOR=green>4</FONT>)</TH>

<CFSET rowBG = 0>
<CFLOOP QUERY=getCategories>
	<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
		<CFELSE><TR BGCOLOR="#CDCDCD"><CFSET rowBG = 0></CFIF>
	<TD ALIGN=center><FONT SIZE=2><CFOUTPUT>#getCategories.categoryID#</CFOUTPUT></FONT></TD>
	<TD ALIGN=center><FONT SIZE=2><CFOUTPUT>#categoryViewCount#</CFOUTPUT></FONT></TD>
	<CFIF ListFind(ValueList(getLotCounts.categoryID),getCategories.categoryID) NEQ 0>
		<CFSET catID = ListFind(ValueList(getLotCounts.categoryID),getCategories.categoryID)>
		<TD ALIGN=center><FONT SIZE=2><CFOUTPUT>#Int(ListGetAt(ValueList(getLotCounts.SumLotViewCount),catID))#</CFOUTPUT></FONT></TD>
	  <CFELSE><TD ALIGN=center><FONT SIZE=2>0</FONT></TD></CFIF>

	<CFOUTPUT>
	<TD ALIGN=center>#categoryLotCount#</TD>
	<TD NOWRAP>#getCategories.categoryName1#
	<CFIF getCategories.categoryID2 NEQ 0>
		#subCategorySeparator#<FONT COLOR=purple>#getCategories.categoryName2#</FONT> 
		<CFIF #getCategories.categoryID3# NEQ 0>
			#subCategorySeparator#<FONT COLOR=red>#getCategories.categoryName3#</FONT> 
			<CFIF #getCategories.categoryID4# NEQ 0>
				#subCategorySeparator#<FONT COLOR=green>#getCategories.categoryName4#</FONT>
			</CFIF>
		</CFIF>
	</CFIF>
	</CFOUTPUT>
	</TD></TR>
</CFLOOP>

</TABLE>

<P>
Here is a quick description of the above headings:
<TABLE BORDER=1 CELLSPACING=3 CELLPADDING=3>
<TR><TD VALIGN=top ALIGN=right>Delete: </TD><TD>Delete category. Must have no lots.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>View: </TD><TD>Number of page views of category homepage. <FONT COLOR=red>|</FONT><BR>
Total page views of lot pages in category.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Edit: </TD><TD>Click to edit category options.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Lots: </TD><TD>Lists all lots in category with various options.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Summ: </TD><TD>Summary of lot statuses.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Win: </TD><TD>List of winning bidders for all lots in category.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Count: </TD><TD>Number of lots in category.</TD></TR>
</TABLE>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>