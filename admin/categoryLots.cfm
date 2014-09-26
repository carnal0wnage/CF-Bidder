<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: View Category</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.lotID") AND NOT IsDefined("lotEdit")>
	<H3>Emails successfully sent to the 
	<CFIF Form.bidder EQ "winner"> winning <CFELSE> losing </CFIF> 
	bidders of lot <CFOUTPUT>#Form.lotID#</CFOUTPUT>.</H3>
	<P><HR NOSHADE COLOR=purple><P>
</CFIF>

<CFINCLUDE TEMPLATE="../category/#categoryID#CategoryInfo.cfm">
<FONT COLOR=purple SIZE=5><B><CFOUTPUT>#categoryName#</CFOUTPUT></B></FONT>
<P>

<CFOUTPUT>#systemURL#/category.cfm?categoryID=#categoryID#</CFOUTPUT>
<P>
<CFIF NOT IsDefined("order")><CFSET order = "lotName"></CFIF>
<CFIF NOT IsDefined("lotType")><CFSET lotType = 2></CFIF>
<CFQUERY NAME=getLots DATASOURCE="#EAdatasource#">
	SELECT lotID, lotName, lotOpenDateTime, lotCloseDateTime, lotCloseInactivity,
		lotPublic, lotStatus, lotCloseQueue, lotBidsExist, lotNoBidsStayOpenTimes,
		lotReservePrice, lotReservePriceMet, lotReserveStayOpenTimes, lotViewCount,
		lotQuantity, lotQuantityTaken, lotContactName, lotContactEmail, userID, lotType
	FROM Lot
	WHERE categoryID = #categoryID#
	<CFIF lotType NEQ 2>AND lotType = #lotType#</CFIF>
	ORDER BY #order#
</CFQUERY>

<HR NOSHADE COLOR=purple SIZE=3 WIDTH=500 ALIGN=left>

<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=3><TR>
<TD ROWSPAN=3 BGCOLOR=teal ALIGN=center><B>&nbsp;Order by: </B><BR>
<FONT COLOR=yellow SIZE=2>
	<CFIF order EQ "lotName">name (+)
	<CFELSEIF order EQ "lotName DESC">name (-)
	<CFELSEIF order EQ "lotOpenDateTime">open time (+)
	<CFELSEIF order EQ "lotOpenDateTime DESC">open time (-)
	<CFELSEIF order EQ "lotCloseDateTime">close time (+)
	<CFELSEIF order EQ "lotCloseDateTime DESC">close time (-)
	<CFELSEIF order EQ "lotDateTimeCreated">time created (+)
	<CFELSEIF order EQ "lotDateTimeCreated DESC">time created (-)
	<CFELSEIF order EQ "lotDateTimeLastEdited">last edited (+)
	<CFELSEIF order EQ "lotDateTimeLastEdited DESC">last edited (-)
	<CFELSEIF order EQ "lotViewCount">lot views (+)
	<CFELSEIF order EQ "lotViewCount DESC">lot views (-)	</CFIF>
</FONT></TD>
<TD ALIGN=center BGCOLOR="#99CCCC"><FONT SIZE=2>Name</FONT></TD>
<TD ALIGN=center BGCOLOR="#20A491"><FONT SIZE=2>Opens</FONT></TD>
<TD ALIGN=center BGCOLOR="#99CCCC"><FONT SIZE=2>Closes</FONT></TD>
<TD ALIGN=center BGCOLOR="#20A491"><FONT SIZE=2>Created (ID)</FONT></TD>
<TD ALIGN=center BGCOLOR="#99CCCC"><FONT SIZE=2>Last edited</FONT></TD>
<TD ALIGN=center BGCOLOR="#20A491"><FONT SIZE=2>Lot Views</FONT></TD>
<TD ALIGN=center BGCOLOR="#99CCCC"><FONT SIZE=2>Seller</FONT></TD>
</TR>

<TR>
<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotName&lotType=#lotType#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotName+DESC&lotType=#lotType#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#99CCCC" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotOpenDateTime&lotType=#lotType#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotOpenDateTime+DESC&lotType=#lotType#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotCloseDateTime&lotType=#lotType#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotCloseDateTime+DESC&lotType=#lotType#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#99CCCC" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotDateTimeCreated&lotType=#lotType#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotDateTimeCreated+DESC&lotType=#lotType#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotDateTimeLastEdited&lotType=#lotType#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotDateTimeLastEdited+DESC&lotType=#lotType#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#99CCCC" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotViewCount&lotType=#lotType#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotViewCount+DESC&lotType=#lotType#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center><CFOUTPUT><A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotContactName&lotType=#lotType#"><IMG SRC="../images/plus.gif" ALT="+" BORDER=0></A> &nbsp;
	<A HREF="categoryLots.cfm?categoryID=#categoryID#&order=lotContactName+DESC&lotType=#lotType#"><IMG SRC="../images/minus.gif" ALT="-" BORDER=0></A></CFOUTPUT></TD>
</TR>
</TABLE>

<HR NOSHADE COLOR=purple SIZE=3 WIDTH=500 ALIGN=left><P>

<FORM METHOD=post ACTION=lotsDelete.cfm>
<CFOUTPUT><INPUT TYPE=hidden NAME=categoryID VALUE=#categoryID#></CFOUTPUT>

<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2 WIDTH=500>
<TH BGCOLOR="#20A491" ALIGN=center><FONT SIZE=2>Del</FONT></TH>
<TH BGCOLOR="#20A491" WIDTH=100 ALIGN=right>Seller</TH>
<TH BGCOLOR="#20A491" WIDTH=65 ALIGN=right>ID&nbsp;</TH>
<TH BGCOLOR="#20A491" WIDTH=460 ALIGN=left>Lot Name</TH>
<CFSET rowBG = 0>
<CFOUTPUT QUERY="getLots">
	<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
		<CFELSE><TR BGCOLOR="##CDCDCD"><CFSET rowBG = 0></CFIF>
	<TD ALIGN=center><INPUT TYPE=checkbox NAME=deleteLotIDs VALUE=#lotID#></TD>
	<CFIF userID NEQ 0><TD><FONT SIZE=2>#lotContactName#</FONT></TD><CFELSE><TD>&nbsp;</TD></CFIF>
	<TD ALIGN=right VALIGN=top><FONT SIZE=2><A HREF="###lotID#">#lotID#</A>. </FONT></TD>
	<TD><FONT SIZE=2>#lotName#</FONT></TD></TR>
</CFOUTPUT>
</TABLE>
<P>
<INPUT TYPE=submit VALUE="Delete Lots"><BR>
<INPUT TYPE=checkbox NAME=okDelete VALUE=1> <FONT SIZE=2>Must be checked to delete lot(s).</FONT>
</FORM>

<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=500 ALIGN=left><P>

<CFIF lotType EQ 1 OR lotType EQ 2><CFSET lotCreateURL = "lotCreate">
<CFELSEIF lotType EQ 0><CFSET lotCreateURL = "marketCreate">
<CFELSE><CFSET lotCreateURL = "procureCreate">
</CFIF>

<DL>
<CFOUTPUT QUERY="getLots">
	<DT><A NAME=#lotID#></A><B>#lotID#. #lotName#</B><BR>
	<CFIF #userID# NEQ 0><I>Seller</I>: #lotContactName# (<A HREF="mailto:#lotContactEmail#">#lotContactEmail#</A>)<BR></CFIF>
	<FONT SIZE=2>#systemURL#/lot.cfm?lotID=#lotID#</FONT>
	<DD><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=1>
	<TR><TD BGCOLOR="lime" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="../lot.cfm?lotID=#lotID#">View</A>&nbsp;</FONT></TD>
	 <TD BGCOLOR="aqua" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="#lotCreateURL#.cfm?lotID=#lotID#">Edit</A>&nbsp;</FONT></TD>
	<TD BGCOLOR="orange" ALIGN=center><FONT SIZE=2>&nbsp;<CFIF lotPublic EQ 0><A HREF="lotPrivate.cfm?lotID=#lotID#">Private</A><CFELSE>Private</CFIF>&nbsp;</FONT></TD>
	<TD BGCOLOR="##CCCCFF" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="#lotCreateURL#.cfm?copy=1&lotID=#lotID#">Copy</A>&nbsp;</FONT></TD>
	<TD BGCOLOR="##33FF99" ALIGN=center><FONT SIZE=2>&nbsp;<CFIF lotType EQ 0>Bids<CFELSE><A HREF="lotBids.cfm?lotID=#lotID#&order=bidID">Bids</A></CFIF>&nbsp;</FONT></TD>
	<TD BGCOLOR="##99CCCC" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="#secureSystemURL#/admin/lotWinners.cfm?lotID=#lotID#&order=bidID"><CFIF lotType EQ 0>Buyers<CFELSE>Winners</CFIF></A>&nbsp;</FONT></TD>
	<TD BGCOLOR="##CCFFFF" ALIGN=center><FONT SIZE=2><CFIF lotType EQ 1 OR lotType EQ 2><A HREF=lotBidOffline.cfm?lotID=#lotID#>Offline Bid</A><CFELSEIF lotType EQ 0>Offline Buy<CFELSE>Offline Bid</CFIF></FONT></TD>
	</TR>

	<TR><TD ALIGN=right>Status: </TD><TD COLSPAN=5>#lotStatus#
	<CFIF lotStatus EQ "Open" AND DateCompare(lotOpenDateTime,Now()) EQ 1> (<I>Preview</I>)</CFIF></TD>
		<TD BGCOLOR="##7FFFD4" ALIGN=center><FONT SIZE=2>&nbsp;<A HREF="lotEmail.cfm?bidder=winner&lotID=#lotID#">Email Winners</A>&nbsp;</FONT></TD></TR>
	<TR><TD ALIGN=right>Open: </TD><TD COLSPAN=5>#LSDateFormat("#lotOpenDateTime#", "mm-dd-yyyy")# / #LSTimeFormat("#lotOpenDateTime#")#</TD>
		<TD ALIGN=center BGCOLOR="##CCCC99"><FONT SIZE=2>&nbsp;<A HREF="lotEmail.cfm?bidder=loser&lotID=#lotID#">Email Losers</A>&nbsp;</FONT></TD></TR>
	<TR><TD ALIGN=right>Close: </TD><TD COLSPAN=5>#LSDateFormat("#lotCloseDateTime#", "mm-dd-yyyy")# / #LSTimeFormat("#lotCloseDateTime#")#</TD>
		<TD ALIGN=center BGCOLOR="yellow"><FONT SIZE=2>Archive
		<!--- <CFIF lotStatus NEQ "Open"><A HREF="lotArchive.cfm?categoryID=#categoryID#&lotID=#lotID#">Archive</A>
		<CFELSE>Archive</CFIF>---> </FONT></TD></TR>
	<TR><TD ALIGN=right>Viewed: </TD><TD COLSPAN=2>#lotViewCount#</TD>
		<TD ALIGN=right>Bids: </TD><TD COLSPAN=2>
		<CFIF lotBidsExist EQ 1>yes<CFELSE>no</CFIF>
		<CFIF lotNoBidsStayOpenTimes NEQ 0> (#lotNoBidsStayOpenTimes#)</CFIF></TD>
		<TD ALIGN=center BGCOLOR="red"><FONT SIZE=2><A HREF="lotDelete.cfm?categoryID=#categoryID#&lotID=#lotID#">Delete</A></FONT></TD></TR>
	<TR><TD ALIGN=right>## Taken: </TD><TD COLSPAN=2>
		<CFIF lotQuantityTaken NEQ "">#lotQuantityTaken#<CFELSE>0</CFIF> / #lotQuantity#</TD>
		<TD ALIGN=right>Reserve: </TD><TD COLSPAN=2>
		<CFIF lotReservePriceMet EQ 0>not met<CFELSEIF lotReservePriceMet EQ 1>met<CFELSE>N/A</CFIF>
		<CFIF lotReserveStayOpenTimes NEQ 0> (#lotReserveStayOpenTimes#)</CFIF></TD></TR>
	</TABLE>
	<HR NOSHADE COLOR=purple ALIGN=left WIDTH=400>
</CFOUTPUT>
</DL>

<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>