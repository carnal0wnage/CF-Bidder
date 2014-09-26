<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<HTML>
<HEAD><TITLE><CFOUTPUT>#indexTitle#</CFOUTPUT> BidFind</TITLE></HEAD>
<BODY BGCOLOR=white>

<CFQUERY NAME=getAllLots DATASOURCE="#EAdatasource#">
	SELECT Lot.lotID, Lot.lotName, Lot.lotOpeningBid, Lot.lotCloseDateTime, Category.categoryName
	FROM Lot INNER JOIN Category ON Lot.categoryID = Category.categoryID
	WHERE Lot.lotStatus = 'Open' AND Lot.lotPublic = 1
	ORDER BY Lot.lotName
</CFQUERY>
<CFOUTPUT QUERY="getAllLots">
<A HREF="#systemURL#/lot.cfm?lotID=#getAllLots.lotID#">#getAllLots.lotName#</A><PRICE>#LSCurrencyFormat(lotOpeningBid,"local")#<CAT>#categoryName#<ENDS>#LSDateFormat(lotCloseDateTime,"MM/DD")#<BR>
</CFOUTPUT>
</BODY>
</HTML>