<!--- Emaze Auction version 2.1 / Tuesday, July 13, 1999 --->
<!---
Get Lot Info
Update Commission Fee
Email Seller
Update lot status
Reduce category count
--->

<CFIF NOT IsDefined("lotID")>
	<HTML><BODY>
	<H2>This is not your beautiful house.</H2>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFQUERY NAME=getLotInfo DATASOURCE="#EAdatasource#">
	SELECT lotContactName, lotContactEmail, lotName, categoryID, userID,
		lotBidsExist, lotCloseQueue, lotNoBidsStayOpenTimes, lotType, lotSellPrice
	FROM Lot
	WHERE lotID = #lotID#
</CFQUERY>

<CFIF getLotInfo.RecordCount EQ 1><CFIF getLotInfo.lotCloseQueue EQ 2 AND getLotInfo.lotType EQ 0>

<CFIF getLotInfo.userID NEQ "" AND getLotInfo.userID NEQ " " AND getLotInfo.userID GT 1>
	<CFIF getLotInfo.lotBidsExist EQ 0>
		<CFQUERY NAME=updateFee DATASOURCE="#EAdatasource#">
			UPDATE Fee
			SET commissionFee = 0,
				commissionFeeFinal = 1
			WHERE lotID = #lotID#
		</CFQUERY>
	<CFELSE>
		<CFINCLUDE TEMPLATE="../systemMarket/marketFeeCommission.cfm">
		<CFQUERY NAME=getSellerLots DATASOURCE="#EAdatasource#">
			SELECT Fee.lotID, Fee.commissionFee, Buy.buyPrice, Buy.buyQuantity, Lot.lotCloseQueue,
				Fee.insertionFee, Fee.boldFee, Fee.featuredCategoryFee, Fee.featuredHomepageFee
			FROM (Buy INNER JOIN Lot ON Buy.lotID = Lot.lotID) INNER JOIN Fee ON Buy.lotID = Fee.lotID
			WHERE Fee.lotID = #lotID#
		</CFQUERY>
		<CFINCLUDE TEMPLATE="../admin/marketCommissionFeeLoop.cfm">
	</CFIF>
</CFIF>

<CFQUERY NAME=getBuyers DATASOURCE="#EAdatasource#">
	SELECT Buy.buyPrice, Buy.buyQuantity, Buy.buyDateTime, Member.username,
		Member.phone, Member.email, Member.firstName, Member.lastName
	FROM Buy INNER JOIN Member ON Buy.userID = Member.userID
	WHERE Buy.lotID = #lotID#
</CFQUERY>

<CFINCLUDE TEMPLATE="../systemMarket/marketEmailOptions.cfm">
<CFINCLUDE TEMPLATE="../systemMarket/marketEmailSubject.cfm">
<CFINCLUDE TEMPLATE="../systemMarket/marketAdminEmail.cfm">
<CFIF marketAdminName NEQ "" AND marketAdminName NEQ " ">
	<CFSET marketAdminEmail = "#marketAdminEmail# (#marketAdminName#)">
</CFIF>

<CFIF marketCloseEmailSeller EQ 1>
	<CFIF marketCloseEmailSellerCCadmin EQ 1>
		<CFSET marketCloseEmailTo = "#getLotInfo.lotContactEmail#,#marketAdminEmail#">
	<CFELSE>
		<CFSET marketCloseEmailTo = getLotInfo.lotContactEmail>
	</CFIF>
	<CFINCLUDE TEMPLATE="../email/emailMarketCloseSeller.cfm">
<CFELSEIF marketCloseEmailSeller EQ 0>
	<CFINCLUDE TEMPLATE="../email/emailMarketCloseSeller.cfm">
</CFIF>

<CFIF marketCloseEmailBuyer EQ 1>
	<CFQUERY NAME=getSeller DATASOURCE="#EAdatasource#">
		SELECT username, phone
		FROM Member
		WHERE userID = #getLotInfo.userID#
	</CFQUERY>
	<CFINCLUDE TEMPLATE="../email/emailMarketCloseBuyer.cfm">
</CFIF>

<CFQUERY NAME=updateCloseLotQueue DATASOURCE="#EAdatasource#">
	UPDATE Lot
	SET lotCloseQueue = <CFIF NOT IsDefined("IamTheAdmin")>3<CFELSE>4</CFIF>
	WHERE lotID = #lotID#
</CFQUERY>

<CFQUERY NAME=updateCatCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categoryMarketCount = categoryMarketCount - 1
	WHERE categoryID = #getLotInfo.categoryID#
</CFQUERY>
<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
	SELECT categoryID1, categoryID2, categoryID3, categoryID4
	FROM Category
	WHERE categoryID = #getLotInfo.categoryID#
</CFQUERY>
<CFQUERY NAME=incrCatSubCount DATASOURCE="#EAdatasource#">
	UPDATE Category
	SET categorySubMarketCount = categorySubMarketCount - 1
	WHERE categoryID = #getCatID.categoryID1#
		OR categoryID = #getCatID.categoryID2#
		OR categoryID = #getCatID.categoryID3#
		OR categoryID = #getCatID.categoryID4#
</CFQUERY>	

</CFIF></CFIF>