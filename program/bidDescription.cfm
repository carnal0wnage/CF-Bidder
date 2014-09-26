<!--- Emaze Auction version 2.1, 1.01 / Saturday, August 14, 1999 --->
<CFSET title = "titleBidDescription">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<CFINCLUDE TEMPLATE="../system/bidReverse.cfm">

<CFIF NOT IsDefined("lotID")>
	<CFOUTPUT>#reverseDescriptionNoLot#</CFOUTPUT>
	<P><BR>
	<CFINCLUDE TEMPLATE="copyright.cfm"><P>
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
	</BODY></HTML><CFABORT>
<CFELSEIF lotID EQ "" OR NOT IsNumeric(lotID)>
	<CFOUTPUT>#reverseDescriptionBaddLot#</CFOUTPUT>
	<P><BR>
	<CFINCLUDE TEMPLATE="copyright.cfm"><P>
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
	</BODY></HTML><CFABORT>
<CFELSEIF NOT IsDefined("username")>
	<CFOUTPUT>#reverseDescriptionNoBidder#</CFOUTPUT>
	<P><BR>
	<CFINCLUDE TEMPLATE="copyright.cfm"><P>
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
	</BODY></HTML><CFABORT>
<CFELSEIF username EQ "">
	<CFOUTPUT>#reverseDescriptionBadBidder#</CFOUTPUT>
	<P><BR>
	<CFINCLUDE TEMPLATE="copyright.cfm"><P>
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
	</BODY></HTML><CFABORT>
</CFIF>

<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">
<H2><FONT FACE=Arial><CFOUTPUT>#lotName#</CFOUTPUT></FONT></H2>

<CFQUERY NAME=getBidDescription DATASOURCE="#EAdatasource#">
	SELECT Bid.bidID, Bid.bidDescription, Bid.bidPrice, Bid.bidQuantity, Member.userID, Member.username
	FROM Bid INNER JOIN Member ON Bid.userID = Member.userID
	WHERE Bid.lotID = #lotID# AND Member.username = '#username#'
</CFQUERY>

<CFIF getBidDescription.RecordCount NEQ 1>
	<CFOUTPUT>#reverseDescriptionBadBid#</CFOUTPUT>
	<P><CFOUTPUT><A HREF="#systemURL#/lot.cfm?lotID=#lotID#">#reverseDescriptionReturnToLot#</A></CFOUTPUT>
	<P><BR>
	<CFINCLUDE TEMPLATE="copyright.cfm"><P>
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
	</BODY></HTML><CFABORT>
<CFELSEIF getBidDescription.bidDescription EQ "" OR getBidDescription.bidDescription EQ " ">
	<CFOUTPUT>#reverseDescriptionBlank#</CFOUTPUT>
	<P><CFOUTPUT><A HREF="#systemURL#/lot.cfm?lotID=#lotID#">#reverseDescriptionReturnToLot#</A></CFOUTPUT>
	<P><BR>
	<CFINCLUDE TEMPLATE="copyright.cfm"><P>
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>
	</BODY></HTML><CFABORT>
</CFIF>

<P>

<CFOUTPUT>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD ALIGN=right>#reverseDescriptionBidder#</TD><TD>#username#</TD></TR>
<TR><TD ALIGN=right>#reverseDescriptionBid#</TD><TD>#LSCurrencyFormat(getBidDescription.bidPrice,"local")#</TD></TR>
<TR><TD ALIGN=right>#reverseDescriptionQuantity#</TD><TD>#getBidDescription.bidQuantity#</TD></TR>
<TR><TD ALIGN=right VALIGN=top>#reverseDescriptionDescription#</TD><TD>#getBidDescription.bidDescription#</TD></TR>
</TABLE>
</CFOUTPUT>

<P>
<CFOUTPUT><A HREF="#systemURL#/lot.cfm?lotID=#lotID#">#reverseDescriptionReturnToLot#</A></CFOUTPUT>
<P>

<CFIF reverseDescriptionLog EQ 1 AND NOT IsDefined("EmazeAuction_master")>
	<CFQUERY NAME=newLog DATASOURCE="#EAdatasource#">
		INSERT INTO BidDescriptionView (lotID, userID, bidID, sellerID, bidDescriptionViewDateTime, IPaddress, hostname)
		VALUES (#lotID#, #getBidDescription.userID#, #userID#, #getBidDescription.bidID#, #CreateODBCDateTime(Now())#, '#CGI.REMOTE_ADDR#',
			<CFIF CGI.REMOTE_HOST EQ "">NULL<CFELSE>'#CGI.REMOTE_HOST#'</CFIF>)
	</CFQUERY>
</CFIF>

<P><BR>
<CFINCLUDE TEMPLATE="copyright.cfm"><P>
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm"><P>

</BODY>
</HTML>
