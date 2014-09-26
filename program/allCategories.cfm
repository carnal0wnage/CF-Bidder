<!--- Emaze Auction version 2.1 / Friday, July 9, 1999 --->
<CFSET title = "titleCategoryListAll">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<P>

<CFQUERY NAME=getAllCategories DATASOURCE="#EAdatasource#">
	SELECT categoryID, categoryName1, categoryName2, categoryName3, categoryName4, categoryLotCount,
		categoryID1, categoryID2, categoryID3, categoryID4
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>, categoryMarketCount</CFIF>
		<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>, categoryProcureCount</CFIF>
	FROM Category
	ORDER BY categoryName1, categoryName2, categoryName3, categoryName4
</CFQUERY>

<BLOCKQUOTE>
<TABLE BORDER=0 CELLSPACING=3 CELLPADDING=2>
<TR><TH ALIGN=left><FONT SIZE=4>Category</FONT></TH><TH><FONT SIZE=2># Auctions</FONT></TH>
<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")><TH><FONT SIZE=2># Classified</FONT></TH></CFIF>
<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")><TH><FONT SIZE=2># Procure</FONT></TH></CFIF>
</TR>

<CFOUTPUT QUERY="getAllCategories">
	<TR><TD>
	<CFIF categoryID2 EQ 0>
		<FONT SIZE=4><A HREF="#systemURL#/category.cfm?categoryID=#categoryID#">#categoryName1#</A></FONT>
	<CFELSEIF categoryID3 EQ 0>
		&nbsp; &nbsp; &nbsp; <A HREF="#systemURL#/category.cfm?categoryID=#categoryID#">#categoryName2#</A>
	<CFELSEIF categoryID4 EQ 0>
		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#systemURL#/category.cfm?categoryID=#categoryID#">#categoryName3#</A>
	<CFELSE>
		&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#systemURL#/category.cfm?categoryID=#categoryID#">#categoryName4#</A>
	</CFIF>
	</TD>
	<TD ALIGN=center>#categoryLotCount#</TD>
	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")><TD ALIGN=center>#categoryMarketCount#</TD></CFIF>
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")><TD ALIGN=center>#categoryProcureCount#</TD></CFIF>
	</TR>
</CFOUTPUT>
</TABLE>
</BLOCKQUOTE>

<P>
<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
<P>
<CFINCLUDE TEMPLATE="closeCheck.cfm">
</BODY>
</HTML>