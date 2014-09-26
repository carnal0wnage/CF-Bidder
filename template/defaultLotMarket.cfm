<!--- Emaze Auction version 2.1 / Sunday, July 18, 1999 --->
<CFSET title = "Classified Item #lotID#">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<CFINCLUDE TEMPLATE="../category/#categoryID#CategoryInfo.cfm">

<TABLE BORDER=0 CELLSPACING=3 CELLPADDING=2>
<CFOUTPUT>
<TR><TD ALIGN=right><FONT SIZE=2 COLOR="#navTableFont#" FACE=arial><B>Current Time:</B> </FONT></TD>
	<TD><FONT SIZE=2>#LSDateFormat(Now(),"mmmm dd, yyyy")# #LSTimeFormat(Now(),timeFormatDisplay)# #timeFormatTimeZone#</FONT></TD></TR>
<TR><TD ALIGN=right><B><FONT SIZE=2 COLOR="#navTableFont#" FACE=arial>Category: </FONT></TD>
	<TD><FONT SIZE=2 FACE=arial><A HREF="#systemURL#/category.cfm?categoryID=#categoryID1#">#categoryName1#</A>
<CFIF categoryID2 NEQ 0>#subCategorySeparator#<A HREF="#systemURL#/category.cfm?categoryID=#categoryID2#">#categoryName2#</A>
	<CFIF categoryID3 NEQ 0>#subCategorySeparator#<A HREF="#systemURL#/category.cfm?categoryID=#categoryID3#">#categoryName3#</A>
		<CFIF categoryID4 NEQ 0>#subCategorySeparator#<A HREF="#systemURL#/category.cfm?categoryID=#categoryID4#">#categoryName4#</A></CFIF>
	</CFIF>
</CFIF>
</FONT></B></TD></TR>
</CFOUTPUT>
</TABLE>

<P>

<CFIF IsDefined("userID")>
	<CFIF userID NEQ 1>
		<CFQUERY NAME=getSeller DATASOURCE="#EAdatasource#">
			SELECT username, feedbackRating
			FROM Member
			WHERE userID = #userID#
		</CFQUERY>
		<CFIF getSeller.RecordCount EQ 1>
			<P><BLOCKQUOTE><CFOUTPUT>
			Lot posted by seller: <B>#getSeller.username#</B> (<A HREF="#systemURL#/feedback/feedback.cfm?username=#URLEncodedFormat(getSeller.username)#">#getSeller.feedbackRating#</A>)<BR>
			<A HREF="#systemURL#/seller/sellerHome.cfm?username=#URLEncodedFormat(getSeller.username)#">View Seller Homepage</A><BR>
			<A HREF="#systemURL#/feedback/feedback.cfm?username=#URLEncodedFormat(getSeller.username)#">Feedback forum for this user</A>
			</CFOUTPUT><P></BLOCKQUOTE>
		</CFIF>
	</CFIF>
</CFIF>

<TABLE CELLSPACING=0 CELLPADDING=0 WIDTH=600><TR><TD ALIGN=center>
<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=3>
<CFIF lotImage NEQ " " OR lotImageThumbnail NEQ " "><CFSET colspan = 2><CFELSE><CFSET colspan = 1></CFIF>
<CFOUTPUT><TH COLSPAN=#colspan# BGCOLOR="#navBottomTableBg#"><FONT SIZE=4 COLOR="#navTableFont#">#lotName#</CFOUTPUT></FONT></TH>

<TR>
<CFIF lotImage NEQ " " AND lotImageThumbnail NEQ " ">
	<CFOUTPUT><TD BGCOLOR="#navBottomTableBg#" ALIGN=center VALIGN=center>
	<A HREF="#lotImage#"><IMG SRC="#lotImageThumbnail#" ALT="Thumbnail image" BORDER=0></A><P>
	<FONT SIZE=2><A HREF="#lotImage#">Click for<BR>larger image</A></FONT></CFOUTPUT></TD>
<CFELSEIF lotImage NEQ " ">
	<CFOUTPUT><TD BGCOLOR="#navBottomTableBg#" ALIGN=center VALIGN=center>
	<IMG SRC="#lotImage#" ALT="Lot image" BORDER=0></CFOUTPUT></TD>
</CFIF>
<TD ALIGN=center>
<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><B>Item Status: </B></TD>
<CFIF lotStatus EQ "Open">
	<CFIF DateCompare(Now(),lotOpenDateTime) EQ -1>
		<TD ALIGN="CENTER" BGCOLOR="#FFFFB9"><B>PREVIEW</B></TD>
	<CFELSE>
		<TD BGCOLOR="#CCFFCC" ALIGN=center><B>OPEN</B></TD>
	</CFIF>
<CFELSE><!--- #lotStatus# EQ "Closed" --->
	<TD BGCOLOR="red" ALIGN=center><B>CLOSED</B></TD>
</CFIF>
</TR>

<CFOUTPUT>
<TR BGCOLOR="#navTopTableBg#"><TD ALIGN=right><FONT SIZE=2>Selling Price: </FONT></TD>
	<TD><FONT SIZE=2>#LSCurrencyFormat(lotSellPrice,"local")#</FONT></TD></TR>
<TR BGCOLOR="#navTopTableBg#"><TD ALIGN=right><FONT SIZE=2>Total Quantity: </FONT></TD>
	<TD><FONT SIZE=2>#lotQuantity#</FONT></TD></TR>
<TR BGCOLOR="#navTopTableBg#"><TD ALIGN=right><FONT SIZE=2>Quantity Still Available: </FONT></TD>
	<TD><FONT SIZE=2>#Evaluate(lotQuantity - getLot.lotQuantityTaken)#</FONT></TD></TR>
</CFOUTPUT>

<CFIF lotQuantityMaximum NEQ 0 AND lotQuantityMaximum LT lotQuantity>
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><FONT SIZE=2>Max. Quantity: </FONT></TD>
	<TD><FONT SIZE=2><CFOUTPUT>#lotQuantityMaximum#</CFOUTPUT></FONT></TD></TR>
</CFIF>

<CFIF DateCompare(Now(),lotOpenDateTime) EQ -1>
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><FONT SIZE=2><B>ITEM OPENS:</B> </FONT></TD>
	<TD NOWRAP><FONT SIZE=2><B><CFOUTPUT>#LSDateFormat(lotOpenDateTime, dateFormatDisplay)# / #LSTimeFormat(lotOpenDateTime, timeFormatDisplay)#</CFOUTPUT></B></FONT></TD></TR>
<CFELSE>
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><FONT SIZE=2>Item opens: </FONT></TD>
	<TD NOWRAP><FONT SIZE=2><CFOUTPUT>#LSDateFormat(lotOpenDateTime, dateFormatDisplay)# / #LSTimeFormat(lotOpenDateTime, timeFormatDisplay)#</CFOUTPUT></FONT></TD></TR>
</CFIF>

<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><FONT SIZE=2>Item closes</FONT></TD>
<TD><FONT SIZE=2><CFOUTPUT>#LSDateFormat(lotCloseDateTime, dateFormatDisplay)# / #LSTimeFormat(lotCloseDateTime, timeFormatDisplay)#</CFOUTPUT></FONT></TD></TR>

<CFIF lotStatus EQ "Open" AND DateCompare(Now(),lotOpenDateTime) EQ -1>
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right VALIGN=top><FONT SIZE=2>Time until open: </FONT></TD>
	<CFSET days = DateDiff("d",Now(),lotOpenDateTime)>
	<CFSET hours = DateDiff("h",Now(),lotOpenDateTime) - (24 * days)>
	<CFSET minutes = DateDiff("n",Now(),lotOpenDateTime) - (24 * 60 * days) - (60 * hours)>
	<TD><FONT SIZE=2><CFOUTPUT>#days# days + #hours# hours<BR> + #minutes# minutes</CFOUTPUT></FONT></TD></TR>
<CFELSEIF lotStatus EQ "Open" AND DateCompare(Now(),lotOpenDateTime) NEQ -1 AND DateCompare(Now(),lotCloseDateTime) EQ -1>
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right VALIGN=top><FONT SIZE=2>Time remaining: </FONT></TD>
	<CFSET days = DateDiff("d",Now(),lotCloseDateTime)>
	<CFSET hours = DateDiff("h",Now(),lotCloseDateTime) - (24 * days)>
	<CFSET minutes = DateDiff("n",Now(),lotCloseDateTime) - (24 * 60 * days) - (60 * hours)>
	<TD><FONT SIZE=2><CFOUTPUT>#days# days + #hours# hours<BR> + #minutes# minutes</CFOUTPUT></FONT></TD></TR>
<CFELSEIF lotStatus EQ "Open" AND DateCompare(Now(),lotCloseDateTime) NEQ -1>
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right VALIGN=top><FONT SIZE=2><I>Time past closing</I>: </FONT></TD>
	<CFSET days = DateDiff("d",lotCloseDateTime,Now())>
	<CFSET hours = DateDiff("h",lotCloseDateTime,Now()) - (24 * days)>
	<CFSET minutes = DateDiff("n",lotCloseDateTime,Now()) - (24 * 60 * days) - (60 * hours)>
	<TD><FONT SIZE=2><CFOUTPUT>#days# days + #hours# hours<BR> + #minutes# minutes</CFOUTPUT></FONT></TD></TR>
</CFIF>

<CFIF lotLocation NEQ "" AND lotLocation NEQ " ">
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><FONT SIZE=2>Location: </FONT></TD>
	<TD><FONT SIZE=2><CFOUTPUT>#lotLocation#</CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF lotShipping NEQ 0>
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><FONT SIZE=2>Shipping Cost: </FONT></TD>
	<TD><FONT SIZE=2><CFOUTPUT>#lotShipping#</CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF lotShippingPolicy NEQ "" AND lotShippingPolicy NEQ " ">
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><FONT SIZE=2>Shipping Policy: </FONT></TD>
	<TD><FONT SIZE=2><CFOUTPUT>#lotShippingPolicy#</CFOUTPUT></FONT></TD></TR>
</CFIF>
<CFIF lotPaymentMethod NEQ "" AND lotPaymentMethod NEQ " ">
	<CFOUTPUT><TR BGCOLOR="#navTopTableBg#"></CFOUTPUT><TD ALIGN=right><FONT SIZE=2>Payment Method: : </FONT></TD>
	<TD><FONT SIZE=2><CFOUTPUT>#lotPaymentMethod#</CFOUTPUT></FONT></TD></TR>
</CFIF>

<TR BGCOLOR="#CCFFCC"><TD ALIGN=right><B>Item&nbsp;#<CFOUTPUT>#lotID#</B></CFOUTPUT> &nbsp;</TD>
	<TH BGCOLOR="#CCFFCC"><A HREF="#buy">BUY THIS ITEM</A></TH>
</TABLE>
</TD>

<TD VALIGN=middle><CFOUTPUT>
	<A HREF="##buy"><IMG SRC="#systemURL#/images/buttonBuy.gif" ALT="Buy" BORDER=0></A><P>
	<!--- <A HREF="#systemURL#/program/editUser.cfm?watch=1&lotID=#lotID#"><IMG SRC="#systemURL#/images/buttonWatch.gif" ALT="Watch" BORDER=0></A><P> --->
	<A HREF="#systemURL#/program/mailAuction.cfm?lotID=#lotID#"><IMG SRC="#systemURL#/images/buttonFriend.gif" ALT="Mail Item to a Friend" BORDER=0></A><P>
	<A HREF="##description"><IMG SRC="#systemURL#/images/buttonDescription.gif" ALT="Description" BORDER=0></A><P>
</CFOUTPUT></TD>
</TR></TABLE>
</TD></TR></TABLE>
<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR><CFOUTPUT><TD BGCOLOR="#navBottomTableBg#"><A NAME="description"></A>
<FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"></CFOUTPUT><B>&nbsp;Description</B></FONT></TD></TR>
<TR><TD><BR>
<CFIF lotSummary NEQ "" AND lotSummary NEQ " "><CFOUTPUT>#lotSummary#</CFOUTPUT><P></CFIF>
<CFINCLUDE TEMPLATE="../lot/#lotID#LotDescription.cfm"></TD></TR>
</TABLE>

<BR CLEAR=all><P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2 WIDTH=600><TR><CFOUTPUT><TD BGCOLOR="#navBottomTableBg#"></CFOUTPUT>
<A NAME="buyers"></A><CFOUTPUT><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"></CFOUTPUT><B>Buyers</B></FONT>
</TD></TR></TABLE>

<P>

<CFIF DateCompare(Now(),lotOpenDateTime) EQ -1>
	<CFOUTPUT><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"></CFOUTPUT><B>This lot is not yet open.</B></FONT>
<CFELSE>
	<CFQUERY NAME=getBuys DATASOURCE="#EAdatasource#">
		SELECT Member.username, Member.feedbackRating, Buy.buyQuantity, Buy.buyDateTime
		FROM Buy INNER JOIN Member ON Buy.userID = Member.userID
		WHERE Buy.lotID = #lotID#
		ORDER BY Buy.buyDateTime DESC
	</CFQUERY>

	<CFIF getBuys.RecordCount EQ 0>
		<CFOUTPUT><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"></CFOUTPUT><B>There are no buyers for this classified item.</B></FONT>
	<CFELSE>
		<TABLE BORDER=1 CELLSPACING=5 CELLPADDING=2>
		<TR><CFOUTPUT>
		<TH BGCOLOR="#navTopTableBg#">Buyer</TH>
		<TH BGCOLOR="#navTopTableBg#">##</TH>
		<TH BGCOLOR="#navTopTableBg#">Date / Time</TH>
		</CFOUTPUT></TR>

		<CFSET rowBG = 0>
		<CFOUTPUT QUERY=getBuys>
			<CFIF rowBG EQ 1><TR BGCOLOR="DCDCDC"><CFSET rowBG = 0><CFELSE><TR><CFSET rowBG = 1></CFIF>
			<TD>#username# (<A HREF="#systemURL#/feedback/feedback.cfm?username=#URLEncodedFormat(username)#">#feedbackRating#</A>)</TD>
			<TD ALIGN=center>#buyQuantity#</TD>
			<TD>#LSDateFormat(buyDateTime, dateFormatDisplay)# #LSTimeFormat(buyDateTime, timeFormatDisplay)#</TD>
			</TR>
		</CFOUTPUT>
		</TABLE>
	</CFIF>
</CFIF>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2 WIDTH=600><TR><CFOUTPUT><TD BGCOLOR="#navBottomTableBg#"></CFOUTPUT>
<A NAME="buy"></A><CFOUTPUT><FONT SIZE=4 COLOR="#navTableFont#" FACE="arial"></CFOUTPUT><B>Buy this item</B></FONT>
</TD></TR></TABLE>
<P>
<CFIF lotStatus EQ "Open">
	<CFIF DateCompare(Now(),lotOpenDateTime) EQ -1>
		<CFOUTPUT><FONT COLOR="#navTableFont#" SIZE=4 FACE="arial"><B>This classified item is not yet open for buying. It opens on #LSDateFormat(lotOpenDateTime, dateFormatDisplay)# at #LSTimeFormat(lotOpenDateTime, timeFormatDisplay)# #timeFormatTimeZone#.</B></FONT></CFOUTPUT>
	<CFELSEIF getLot.lotQuantityTaken GTE lotQuantity>
		<FONT COLOR="#navTableFont#" SIZE=4 FACE="arial"><B>This classified item is closed as the full quantity available has already been purchased.</B></FONT>
	<CFELSE>
		<CFINCLUDE TEMPLATE="../program/buyForm.cfm">
	</CFIF>
<CFELSE><!--- lotStatus EQ "Closed" --->
	<CFOUTPUT><FONT COLOR="#navTableFont#" FACE="arial" SIZE=4></CFOUTPUT><B>This classified item is closed. No additional buyers are permitted.</B></FONT>
</CFIF>

<P>
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
<P>
</BODY>
</HTML>