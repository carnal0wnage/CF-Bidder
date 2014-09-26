<!--- Emaze Auction version 2.1, 1.02 / Tuesday, June 22, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<CFIF NOT IsDefined("noHeader")>
	<HTML>
	<HEAD><TITLE>Emaze Auction: Lot</TITLE></HEAD>
	<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>
</CFIF>

<CFIF IsDefined("Form.first")>
	<!--- In case fields are blank, set to temporary variable. Replace # and " to avoid errors. --->
	<CFSET lotName_file = Replace(Form.lotName,"##","####","ALL")>
	<CFSET lotName_file = Replace(lotName_file,"""","&quot;","ALL")>

	<CFIF Form.lotSummary EQ "">
		<CFSET lotSummary = " ">
		<CFSET lotSummary_file = "">
	<CFELSE>
		<CFSET lotSummary_file = Replace(Form.lotSummary,"##","####","ALL")>
		<CFSET lotSummary_file = Replace(lotSummary_file,"""","&quot;","ALL")>
	</CFIF>
	<CFIF Form.lotDescription EQ "">
		<CFSET lotDescription = " ">
		<CFSET lotDescription_file = " ">
	<CFELSE>
		<CFSET lotDescription_file = Replace(Form.lotDescription,"##","####","ALL")>
	</CFIF>
	<CFIF Form.lotCloseBasis EQ "time"><CFSET lotCloseInactivity = 0></CFIF>
	<CFIF Form.lotReservePrice NEQ 0 AND Form.lotQuantity NEQ 1>
		<CFSET lotReservePrice = 0>
	</CFIF>

	<!--- Set date/time of create, last edit --->
	<CFSET currentDateTime = CreateODBCDateTime(Now())>

	<!--- Set open date/time --->
	<CFIF IsDefined("Form.openNow")><!--- Just use now --->
		<CFSET lotOpenDateTime = currentDateTime>
	<CFELSE>
		<!--- Translate hour to military time for Cold Fusion --->
		<CFIF Form.openTimeAMPM EQ "AM" AND Form.openTimeHH NEQ 12>
			<CFSET openHour = Form.openTimeHH>
		<CFELSEIF Form.openTimeAMPM EQ "PM" AND Form.openTimeHH NEQ 12>
			<CFSET openHour = Form.openTimeHH + 12>
		<CFELSEIF Form.openTimeAMPM EQ "AM" AND Form.openTimeHH EQ 12>
			<CFSET openHour = 0>
		<CFELSE><!--- Form.openTimeAMPM EQ "PM" AND Form.openTimeHH EQ 12 --->
			<CFSET openHour = 12>
		</CFIF>
		<CFSET lotOpenDateTime = CreateODBCDateTime(CreateDateTime(Form.openDateYYYY, Form.openDateMM, Form.openDateDD, openHour, Form.openTimeMM, 0))>
	</CFIF>

	<!--- Set close date/time --->
	<CFIF Form.closeDayCount NEQ ""><!--- Just add days to opening time --->
		<CFSET lotCloseDateTime = DateAdd("d",Form.closeDayCount,lotOpenDateTime)>
	<CFELSE>
		<!--- Translate hour to military time for Cold Fusion --->
		<CFIF Form.closeTimeAMPM EQ "AM" AND Form.closeTimeHH NEQ 12>
			<CFSET closeHour = Form.closeTimeHH>
		<CFELSEIF Form.closeTimeAMPM EQ "PM" AND Form.closeTimeHH NEQ 12>
			<CFSET closeHour = Form.closeTimeHH + 12>
		<CFELSEIF Form.closeTimeAMPM EQ "AM" AND Form.closeTimeHH EQ 12>
			<CFSET closeHour = 0>
		<CFELSE><!--- Form.closeTimeAMPM EQ "PM" AND Form.closeTimeHH EQ 12 --->
			<CFSET closeHour = 12>
		</CFIF>
		<CFSET lotCloseDateTime = CreateODBCDateTime(CreateDateTime(Form.closeDateYYYY, Form.closeDateMM, Form.closeDateDD, closeHour, Form.closeTimeMM, 0))>
	</CFIF>

	<CFIF Form.lotStatus EQ "Inactive">
		<CFIF IsDefined("Form.oldLotCloseQueue")>
			<CFIF Form.oldLotCloseQueue EQ 0>
				<CFSET lotCloseQueue = 0>
			<CFELSE>
				<CFSET lotCloseQueue = -1>
			</CFIF>
		<CFELSE>
			<CFSET lotCloseQueue = 0>
		</CFIF>
	<CFELSEIF NOT IsDefined("Form.lotID")>
		<CFSET lotCloseQueue = 1>
	<CFELSEIF Form.oldLotCloseQueue EQ 3 AND Form.lotStatus NEQ "Open">
		<CFSET lotCloseQueue = 3>
	<CFELSEIF DateCompare(lotCloseDateTime,currentDateTime) EQ 1>
		<CFSET lotCloseQueue = 1>
	<CFELSE><!--- After closing time. Check inactivity. --->
		<CFQUERY NAME=getLotLastBid DATASOURCE="#EAdatasource#">
			SELECT lastBidDateTime
			FROM Lot
			WHERE lotID = #Form.lotID#
		</CFQUERY>
		<CFIF DateDiff("n",getLotLastBid.lastBidDateTime,Now()) GTE lotCloseInactivity>
			<CFQUERY NAME=checkLotCloseQueue DATASOURCE="#EAdatasource#">
				SELECT lotCloseQueue
				FROM Lot
				WHERE lotID = #Form.lotID#
			</CFQUERY>
			<CFIF checkLotCloseQueue.lotCloseQueue EQ 3>
				<CFSET lotCloseQueue = 3>
			<CFELSE>
				<CFSET lotCloseQueue = 2>
			</CFIF>
		<CFELSE>
			<CFSET lotCloseQueue = 1>
		</CFIF>
	</CFIF>

	<!---
	If file image upload, upload image = "lotimage/filename"
		If previous image in lotimage, check if being used by another lot. If not, delete.
	If URL is same as previous image, image = old image.
	If URL is blank, image = " "
		If previous image in lotimage, check if being used by another lot. If not, delete.
	If URL is default, image = " "
		If previous image in lotimage, check if being used by another lot. If not, delete.
	--->
	<CFIF IsDefined("Form.lotID") AND NOT IsDefined("Form.copy")>
		<CFIF Form.lotImageFileUpload NEQ "" AND
				Find("#systemURL#/lotimage/",Form.oldLotImage,1) NEQ 0>
			<CFSET deleteImage = 1>
		<CFELSEIF Form.lotImage EQ Form.oldLotImage>
			<CFSET lotImage = Form.lotImage>
		<CFELSEIF Form.lotImage EQ "">
			<CFSET lotImage = " ">
			<CFIF Find("#systemURL#/lotimage/",Form.oldLotImage,1) NEQ 0>
				<CFSET deleteImage = 1>
			</CFIF>
		<CFELSE>
			<CFINCLUDE TEMPLATE="../system/lotDefaultImage.cfm">
			<CFIF Form.lotImage EQ "#imageURL#/">
				<CFSET lotImage = " ">
			<CFELSE>
				<CFSET lotImage = Form.lotImage>
				<CFIF #Find("#systemURL#/lotimage/",Form.oldLotImage,1)# NEQ 0>
					<CFSET deleteImage = 1>
				</CFIF>
			</CFIF>
		</CFIF>

		<CFIF IsDefined("deleteImage")>
			<CFSET systemURLlength = Len("#systemURL#/lotImage/")>
			<CFSET oldLotImageFile = Mid(Form.oldLotImage,systemURLlength,50)>
			<CFIF FileExists("#systemPath#\lotimage\#oldLotImageFile#") EQ "YES">
				<CFQUERY NAME=checkImage DATASOURCE="#EAdatasource#">
					SELECT Count(lotID) AS checkCount
					FROM Lot
					WHERE lotImage = '#Form.oldLotImage#'
						OR lotImageThumbnail = '#Form.oldLotImage#'
				</CFQUERY>
				<CFIF checkImage.checkCount EQ 1 AND FileExists("#systemPath#\lotimage\#oldLotImageFile#") EQ "YES">
					<CFFILE ACTION=Delete FILE="#systemPath#\lotimage\#oldLotImageFile#">
				</CFIF>
			</CFIF>
		</CFIF>

		<CFIF Form.lotImageThumbnailFileUpload NEQ "" AND
				Find("#systemURL#/lotimage/",Form.oldLotImageThumbnail,1) NEQ 0>
			<CFSET deleteImageThumbnail = 1>
		<CFELSEIF Form.lotImageThumbnail EQ Form.oldLotImageThumbnail>
			<CFSET lotImageThumbnail = Form.lotImageThumbnail>
		<CFELSEIF Form.lotImage EQ "">
			<CFSET lotImageThumbnail = " ">
			<CFIF Find("#systemURL#/lotimage/",Form.oldLotImageThumbnail,1) NEQ 0>
				<CFSET deleteImageThumbnail = 1>
			</CFIF>
		<CFELSE>
			<CFINCLUDE TEMPLATE="../system/lotDefaultImage.cfm">
			<CFIF Form.lotImageThumbnail EQ "#thumbnailURL#/">
				<CFSET lotImageThumbnail = " ">
			<CFELSE>
				<CFSET lotImageThumbnail = Form.lotImageThumbnail>
				<CFIF Find("#systemURL#/lotimage/",Form.oldLotImageThumbnail,1) NEQ 0>
					<CFSET deleteImageThumbnail = 1>
				</CFIF>
			</CFIF>
		</CFIF>
		<CFIF IsDefined("deleteImageThumbnail")>
			<CFSET systemURLlength = Len("#systemURL#/lotImage/")>
			<CFSET oldLotImageThumbnailFile = Mid(Form.oldLotImageThumbnail,systemURLlength,50)>
			<CFIF FileExists("#systemPath#\lotimage\#oldLotImageThumbnailFile#") EQ "YES">
				<CFQUERY NAME=checkImage DATASOURCE="#EAdatasource#">
					SELECT Count(lotID) AS checkCount
					FROM Lot
					WHERE lotImage = '#Form.oldLotImageThumbnail#'
						OR lotImageThumbnail = '#Form.oldLotImageThumbnail#'
				</CFQUERY>
				<CFIF checkImage.checkCount EQ 1 AND FileExists("#systemPath#\lotimage\#oldLotImageThumbnailFile#") EQ "YES">
					<CFFILE ACTION=Delete FILE="#systemPath#\lotimage\#oldLotImageThumbnailFile#">
				</CFIF>
			</CFIF>
		</CFIF>

		<CFIF Form.lotImageFileUpload NEQ "">
			<CFFILE ACTION=Upload FILEFIELD="lotImageFileUpload"
				DESTINATION="#systemPath#\lotimage\"
				NAMECONFLICT="MakeUnique">
			<CFSET lotImage = "#systemURL#/lotimage/#File.ServerFile#">
		</CFIF>
		<CFIF Form.lotImageThumbnailFileUpload NEQ "">
			<CFFILE ACTION=Upload FILEFIELD="lotImageThumbnailFileUpload"
				DESTINATION="#systemPath#\lotimage\"
				NAMECONFLICT="MakeUnique">
			<CFSET lotImageThumbnail = "#systemURL#/lotimage/#File.ServerFile#">
		</CFIF>

		<CFIF Form.lotOpeningBid NEQ Form.oldLotOpeningBid OR Form.lotBidIncrement NEQ Form.oldLotBidIncrement>
			<CFQUERY NAME=getMinimum DATASOURCE="#EAdatasource#">
				SELECT nextBidMinimum FROM Lot WHERE lotID = #Form.lotID#
			</CFQUERY>
			<CFIF Form.lotOpeningBid NEQ Form.oldLotOpeningBid AND getMinimum.nextBidMinimum EQ Form.oldLotOpeningBid>
				<CFSET nextBidMinimum = Form.lotOpeningBid>
				<CFSET lotHighBid = Form.lotOpeningBid>
			<CFELSEIF Form.lotBidIncrement NEQ Form.oldLotBidIncrement>
				<CFSET nextBidMinimum = getMinimum.nextBidMinimum - Form.oldLotBidIncrement + Form.lotBidIncrement>
			</CFIF>
		</CFIF>

		<CFIF Form.oldLotReservePrice NEQ Form.lotReservePrice OR Form.lotOpeningBid NEQ Form.oldLotOpeningBid>
			<CFIF Form.lotReservePrice EQ 0 OR Form.lotReservePrice LT Form.lotOpeningBid>
				<CFSET lotReservePriceMet = 2>
			<CFELSEIF NOT IsDefined("nextBidMinimum")>
				<CFQUERY NAME=getNextBidMinimum DATASOURCE="#EAdatasource#">
					SELECT nextBidMinimum FROM Lot WHERE lotID = #Form.lotID#
				</CFQUERY>
				<CFIF (Form.templateFile NEQ "defaultLotReverse.cfm" AND lotReservePrice GT getNextBidMinimum.nextBidMinimum)
						OR (Form.templateFile EQ "defaultLotReverse.cfm" AND lotReservePrice LT getNextBidMinimum.nextBidMinimum)>
					<CFSET lotReservePriceMet = 0>
				<CFELSE>
					<CFSET lotReservePriceMet = 1>
				</CFIF>
			<CFELSEIF (Form.templateFile NEQ "defaultLotReverse.cfm" AND lotReservePrice GT nextBidMinimum)
					OR (Form.templateFile EQ "defaultLotReverse.cfm" AND lotReservePrice LT nextBidMinimum)>
				<CFSET lotReservePriceMet = 0>
			<CFELSE>
				<CFSET lotReservePriceMet = 1>
			</CFIF>
		</CFIF>

		<!--- Update lot in database --->
		<CFQUERY NAME=updateLot DATASOURCE="#EAdatasource#">
			UPDATE Lot
			SET lotName = '#Form.lotName#',
				lotQuantity = #Form.lotQuantity#,
				lotQuantityMaximum = #Form.lotQuantityMaximum#,
				lotReservePrice = #lotReservePrice#,
				<CFIF IsDefined("lotReservePriceMet")>lotReservePriceMet = #lotReservePriceMet#,</CFIF>
				lotSellPrice = #Form.lotSellPrice#,
				lotShipping = #Form.lotShipping#,
				lotSummary = '#lotSummary#',
				lotDescription = '#lotDescription#',
				categoryID = #Form.categoryID#,
				templateFile = '#Form.templateFile#',
				lotType = <CFIF Form.templateFile EQ "defaultLotReverse.cfm">-1,<CFELSE>1,</CFIF>
				lotImage = '#lotImage#',
				lotImageThumbnail = '#lotImageThumbnail#',
				lotOpenDateTime = #lotOpenDateTime#,
				lotOpeningBid = #Form.lotOpeningBid#,
				lotBidIncrement = #Form.lotBidIncrement#,
				<CFIF IsDefined("nextBidMinimum")>
					nextBidMinimum = #nextBidMinimum#,
					nextNextBidMinimum = #nextBidMinimum# + #Form.lotBidIncrement#,
					<CFIF IsDefined("lotHighBid")>lotHighBid = #lotHighBid#,</CFIF>
				</CFIF>
				lotCloseBasis = '#Form.lotCloseBasis#',
				lotCloseDateTime = #lotCloseDateTime#,
				lotCloseInactivity = #lotCloseInactivity#,
				lotPublic = #Form.lotPublic#,
				lotStatus = '#Form.lotStatus#',
				lotCloseQueue = #lotCloseQueue#,
				lotLocation = <CFIF Form.lotLocation EQ "">NULL,<CFELSE>'#Form.lotLocation#',</CFIF>
				lotShippingPolicy = <CFIF Form.lotShippingPolicy EQ "">NULL,<CFELSE>'#Form.lotShippingPolicy#',</CFIF>
				lotPaymentMethod = <CFIF Form.lotPaymentMethod EQ "">NULL,<CFELSE>'#Form.lotPaymentMethod#',</CFIF>
				lotContactName = <CFIF Form.lotContactName EQ "">NULL, <CFELSE>'#Form.lotContactName#',</CFIF>
				lotContactEmail = <CFIF Form.lotContactEmail EQ "">NULL, <CFELSE>'#Form.lotContactEmail#',</CFIF>
				lotDateTimeLastEdited = #currentDateTime#,
				lotBold = <CFIF IsDefined("Form.lotBold")>1,<CFELSE>0,</CFIF>
				lotFeaturedCategory = <CFIF IsDefined("Form.lotFeaturedCategory")>1,<CFELSE>0,</CFIF>
				lotFeaturedHomepage = <CFIF IsDefined("Form.lotFeaturedHomepage")>1<CFELSE>0</CFIF>
			WHERE lotID = #Form.lotID#
		</CFQUERY>

		<CFIF Form.oldCategoryID NEQ Form.categoryID AND Form.lotStatus EQ "Open">
			<CFQUERY NAME=decrCatCount DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categoryLotCount = categoryLotCount - 1
				WHERE categoryID = #Form.oldCategoryID#
			</CFQUERY>
			<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
				SELECT categoryID1, categoryID2, categoryID3, categoryID4
				FROM Category
				WHERE categoryID = #Form.oldCategoryID#
			</CFQUERY>
			<CFQUERY NAME=decrCatSubCount DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categorySubLotCount = categorySubLotCount - 1
				WHERE categoryID = <CFIF getCatID.categoryID1 EQ "">0<CFELSE>#getCatID.categoryID1#</CFIF>
					OR categoryID = <CFIF getCatID.categoryID2 EQ "">0<CFELSE>#getCatID.categoryID2#</CFIF>
					OR categoryID = <CFIF getCatID.categoryID3 EQ "">0<CFELSE>#getCatID.categoryID3#</CFIF>
					OR categoryID = <CFIF getCatID.categoryID4 EQ "">0<CFELSE>#getCatID.categoryID4#</CFIF>
			</CFQUERY>

			<CFQUERY NAME=incrCatCount DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categoryLotCount = categoryLotCount + 1
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
				SELECT categoryID1, categoryID2, categoryID3, categoryID4
				FROM Category
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME=incrCatSubCount DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categorySubLotCount = categorySubLotCount - 1
				WHERE categoryID = #getCatID.categoryID1#
					OR categoryID = #getCatID.categoryID2#
					OR categoryID = #getCatID.categoryID3#
					OR categoryID = #getCatID.categoryID4#
			</CFQUERY>

		<CFELSEIF Form.lotStatus EQ "Open" AND Form.oldLotCloseQueue NEQ 1>
			<CFQUERY NAME=incrCatCount DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categoryLotCount = categoryLotCount + 1
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
				SELECT categoryID1, categoryID2, categoryID3, categoryID4
				FROM Category
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME=incrCatSubCount DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categorySubLotCount = categorySubLotCount + 1
				WHERE categoryID = #getCatID.categoryID1#
					OR categoryID = #getCatID.categoryID2#
					OR categoryID = #getCatID.categoryID3#
					OR categoryID = #getCatID.categoryID4#
			</CFQUERY>
		</CFIF>

	<CFELSE><!--- Create new lot --->
		<CFIF lotReservePrice EQ 0><CFSET lotReservePriceMet = 2>
			<CFELSE><CFSET lotReservePriceMet = 0></CFIF>
		<CFSET lotBidsExist = 0>

		<!---
		If file image upload, upload image = "lotimage/filename"
		If url is blank: image = " "
		If url is default: image = " "
		If other, use image = URL
		--->
		<!--- Determine image, thumbnail. Upload image if necessary. --->
		<CFIF Form.lotImageFileUpload NEQ "">
			<CFFILE ACTION=Upload FILEFIELD="lotImageFileUpload"
				DESTINATION="#systemPath#\lotimage\"
				NAMECONFLICT="MakeUnique">
			<CFSET lotImage = "#systemURL#/lotimage/#File.ServerFile#">
		<CFELSEIF Form.lotImage EQ "">
			<CFSET lotImage = " ">
		<CFELSE>
			<CFINCLUDE TEMPLATE="../system/lotDefaultImage.cfm">
			<CFIF Form.lotImage EQ "#imageURL#/">
				<CFSET lotImage = " ">
			<CFELSE>
				<CFSET lotImage = "#Form.lotImage#">
			</CFIF>
		</CFIF>

		<CFIF Form.lotImageThumbnailFileUpload NEQ "">
			<CFFILE ACTION=Upload FILEFIELD="lotImageThumbnailFileUpload"
				DESTINATION="#systemPath#\lotimage\"
				NAMECONFLICT="MakeUnique">
			<CFSET lotImageThumbnail = "#systemURL#/lotimage/#File.ServerFile#">
		<CFELSEIF Form.lotImageThumbnail EQ "">
			<CFSET lotImageThumbnail = " ">
		<CFELSE>
			<CFINCLUDE TEMPLATE="../system/lotDefaultImage.cfm">
			<CFIF Form.lotImageThumbnail EQ "#thumbnailURL#/">
				<CFSET lotImageThumbnail = " ">
			<CFELSE>
				<CFSET lotImageThumbnail = Form.lotImageThumbnail>
			</CFIF>
		</CFIF>

		<CFSET nextNextBidMinimum = Form.lotOpeningBid + Form.lotBidIncrement>

		<!--- Create lot in database --->
		<CFQUERY NAME=insertLot DATASOURCE="#EAdatasource#">
			INSERT INTO Lot (lotName, lotQuantity, lotQuantityMaximum, lotSummary,
				categoryID, templateFile, lotImage, lotImageThumbnail, lotOpenDateTime,
				lotOpeningBid, lotBidIncrement, lotCloseBasis, lotCloseDateTime, lotCloseInactivity,
				lotPublic, lotStatus, lotCloseQueue, lotContactName, lotContactEmail, lotDateTimeCreated,
				lotDateTimeLastEdited, lotDescription, lotReservePrice, lotSellPrice, userID, lotViewCount, 
				lotReservePriceMet, lotReserveStayOpenTimes, lotBidsExist, lotNoBidsStayOpenTimes, lotQuantityTaken,
				lotShipping, nextBidMinimum, nextNextBidMinimum, lastBidDateTime, secondLastBidDateTime, lotBidCount,
				lotHighBid, lotLocation, lotShippingPolicy, lotPaymentMethod, lotBold, lotFeaturedCategory, lotFeaturedHomepage,
				lotType, lotProcureLowBidAutoWins, lotProcureBidAboveOpeningBid, lotProcureBidDescription)
			VALUES ('#Form.lotName#', #Form.lotQuantity#, #Form.lotQuantityMaximum#, '#lotSummary#',
				#Form.categoryID#, '#Form.templateFile#', '#lotImage#', '#lotImageThumbnail#', #lotOpenDateTime#,
				#Form.lotOpeningBid#, #Form.lotBidIncrement#, '#Form.lotCloseBasis#', #lotCloseDateTime#,
				#lotCloseInactivity#, #Form.lotPublic#, '#Form.lotStatus#', #lotCloseQueue#, 
				<CFIF Form.lotContactName EQ "">NULL, <CFELSE>'#Form.lotContactName#',</CFIF>
				<CFIF Form.lotContactEmail EQ "">NULL, <CFELSE>'#Form.lotContactEmail#',</CFIF>
				#currentDateTime#, #currentDateTime#, '#lotDescription#',
				#lotReservePrice#, #Form.lotSellPrice#, 1, 0, #lotReservePriceMet#, 0, 0, 0, 0, #Form.lotShipping#,
				#Form.lotOpeningBid#, #nextNextBidMinimum#, {ts '1998-07-01 00:00:01'}, {ts '1998-01-01 00:00:01'}, 0, #lotOpeningBid#,
				<CFIF Form.lotLocation EQ "">NULL,<CFELSE>'#Form.lotLocation#',</CFIF>
				<CFIF Form.lotShippingPolicy EQ "">NULL,<CFELSE>'#Form.lotShippingPolicy#',</CFIF>
				<CFIF Form.lotPaymentMethod EQ "">NULL,<CFELSE>'#Form.lotPaymentMethod#',</CFIF>
				<CFIF IsDefined("Form.lotBold")>1, <CFELSE>0, </CFIF>
				<CFIF IsDefined("Form.lotFeaturedCategory")>1, <CFELSE>0, </CFIF>
				<CFIF IsDefined("Form.lotFeaturedHomepage")>1<CFELSE>0</CFIF>,
				<CFIF Form.templateFile EQ "defaultLotReverse.cfm">-1,<CFELSE>1,</CFIF>
				1, 0, 0)
		</CFQUERY>

		<CFQUERY NAME=getLotID DATASOURCE="#EAdatasource#">
			SELECT lotID
			FROM Lot
			WHERE lotDateTimeCreated = #currentDateTime#
				AND lotName = '#Form.lotName#'
		</CFQUERY>
		<CFSET lotID = getLotID.lotID>

		<CFIF Form.lotStatus EQ "Open">
			<CFQUERY NAME=updateCatCount DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categoryLotCount = categoryLotCount + 1
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME=getCatID DATASOURCE="#EAdatasource#">
				SELECT categoryID1, categoryID2, categoryID3, categoryID4
				FROM Category
				WHERE categoryID = #Form.categoryID#
			</CFQUERY>
			<CFQUERY NAME=incrCatSubCount DATASOURCE="#EAdatasource#">
				UPDATE Category
				SET categorySubLotCount = categorySubLotCount + 1
				WHERE categoryID = #getCatID.categoryID1#
					OR categoryID = #getCatID.categoryID2#
					OR categoryID = #getCatID.categoryID3#
					OR categoryID = #getCatID.categoryID4#
			</CFQUERY>
		</CFIF>
	</CFIF>

	<CFSET lotOpeningBid = Replace(DecimalFormat(Form.lotOpeningBid), ",", "", "ALL")>
		<CFIF lotOpeningBid LT 1 AND lotOpeningBid NEQ 0><CFSET lotOpeningBid = "0#lotOpeningBid#"></CFIF>
	<CFSET lotShipping = Replace(DecimalFormat(Form.lotShipping), ",", "", "ALL")>
		<CFIF lotShipping LT 1 AND lotShipping NEQ 0><CFSET lotShipping = "0#lotShipping#"></CFIF>
	<CFSET lotReservePrice = Replace(DecimalFormat(lotReservePrice), ",", "", "ALL")>
		<CFIF lotReservePrice LT 1 AND lotReservePrice NEQ 0><CFSET lotReservePrice = "0#lotReservePrice#"></CFIF>
	<CFSET lotSellPrice = Replace(DecimalFormat(Form.lotSellPrice), ",", "", "ALL")>
		<CFIF lotSellPrice LT 1 AND lotSellPrice NEQ 0><CFSET lotSellPrice = "0#lotSellPrice#"></CFIF>
	<CFSET lotBidIncrement = Replace(DecimalFormat(Form.lotBidIncrement), ",", "", "ALL")>
		<CFIF lotBidIncrement LT 1 AND lotBidIncrement NEQ 0><CFSET lotBidIncrement = "0#lotBidIncrement#"></CFIF>
	<CFSET lotLocation_file = Replace(Form.lotLocation,"##","####","ALL")>
		<CFSET lotLocation_file = Replace(lotLocation_file,"""","&quot;","ALL")>
	<CFSET lotShippingPolicy_file = Replace(Form.lotShippingPolicy,"##","####","ALL")>
		<CFSET lotShippingPolicy_file = Replace(lotShippingPolicy_file,"""","&quot;","ALL")>
	<CFSET lotPaymentMethod_file = Replace(Form.lotPaymentMethod,"##","####","ALL")>
		<CFSET lotPaymentMethod_file = Replace(lotPaymentMethod_file,"""","&quot;","ALL")>
	<CFIF NOT IsDefined("userID")><CFSET userID = 1></CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\lot\#lotID#LotInfo.cfm"
		OUTPUT="<CFSET lotName = ""#lotName_file#"">
<CFSET categoryID = #Form.categoryID#>
<CFSET templateFile = ""#Form.templateFile#"">
<CFSET lotImage = ""#lotImage#"">
<CFSET lotImageThumbnail = ""#lotImageThumbnail#"">
<CFSET lotOpenDateTime = ""#lotOpenDateTime#"">
<CFSET lotOpeningBid = #lotOpeningBid#>
<CFSET lotShipping = #lotShipping#>
<CFSET lotReservePrice = #lotReservePrice#>
<CFSET lotSellPrice = #lotSellPrice#>
<CFSET lotCloseBasis = ""#Form.lotCloseBasis#"">
<CFSET lotCloseDateTime = ""#lotCloseDateTime#"">
<CFSET lotCloseInactivity = #lotCloseInactivity#>
<CFSET lotPublic = #Form.lotPublic#>
<CFSET lotStatus = ""#Form.lotStatus#"">
<CFSET lotSummary = ""#lotSummary_file#"">
<CFSET lotContactName = ""#Form.lotContactName#"">
<CFSET lotContactEmail = ""#Form.lotContactEmail#"">
<CFSET lotQuantity = #Form.lotQuantity#>
<CFSET lotQuantityMaximum = #Form.lotQuantityMaximum#>
<CFSET lotBidIncrement = #lotBidIncrement#>
<CFSET lotLocation = ""#lotLocation_file#"">
<CFSET lotShippingPolicy = ""#lotShippingPolicy_file#"">
<CFSET lotPaymentMethod = ""#lotPaymentMethod_file#"">
<CFSET userID = #userID#>">

	<CFSET lotDescription_file = Replace(lotDescription_file, "
", "", "ALL")>
	<CFFILE ACTION=Write FILE="#systemPath#\lot\#lotID#LotDescription.cfm"
		OUTPUT="#lotDescription_file#">

	<CFIF IsDefined("Form.lotID")>
		<H3>Lot <CFOUTPUT><A HREF="###Form.lotID#">#Form.lotID#</A>, <I>#Form.lotName#</I></CFOUTPUT> updated.</H3>
		<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
		<CFSET lotEdit = 1>
		<CFSET order = "lotName">
		<CFINCLUDE TEMPLATE="categoryLots.cfm">
		<CFABORT>
	<CFELSE>
		<FONT SIZE=4>Lot <CFOUTPUT><I>#Form.lotName#</I> created with lotID = #lotID#.</CFOUTPUT></FONT><P>
		<CFOUTPUT><A HREF="../lot.cfm?lotID=#lotID#">View this lot</A>. <A HREF="lotCreate.cfm?lotID=#lotID#">Edit this lot</A>.</CFOUTPUT><BR>
		Below is the full URL to this lot:<BR>
		<CFOUTPUT>#systemURL#/lot.cfm?lotID=#lotID#</CFOUTPUT>
		<H3>You may create another lot below, or switch to another screen.</H3>
		<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
		<CFSET newLot = 1>
	</CFIF>
</CFIF>

<!--- THIS IS WHERE THE LOT FORM BEGINS --->
<CFFORM ACTION=lotCreate.cfm ENCTYPE="multipart/form-data">
<INPUT TYPE=hidden NAME=first VALUE=0>

<CFIF IsDefined("lotID") AND NOT IsDefined("newLot") AND NOT IsDefined("copy")>
	<FONT SIZE=6 COLOR=purple><B>Edit Lot - <CFOUTPUT>#lotID#</CFOUTPUT></B></FONT>
	<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
		SELECT * FROM Lot WHERE lotID = #lotID#
	</CFQUERY>
	<CFOUTPUT>
		<INPUT TYPE=hidden NAME=lotID VALUE=#lotID#>
		<INPUT TYPE=hidden NAME=userID VALUE=#getLot.userID#>
		<INPUT TYPE=hidden NAME=oldCategoryID VALUE="#getLot.categoryID#">
		<INPUT TYPE=hidden NAME=oldLotCloseQueue VALUE="#getLot.lotCloseQueue#">
		<INPUT TYPE=hidden NAME=oldLotImage VALUE="#getLot.lotImage#">
		<INPUT TYPE=hidden NAME=oldLotImageThumbnail VALUE="#getLot.lotImageThumbnail#">
		<INPUT TYPE=hidden NAME=oldLotReservePrice VALUE="#getLot.lotReservePrice#">
		<INPUT TYPE=hidden NAME=oldLotBidIncrement VALUE="#getLot.lotBidIncrement#">
		<INPUT TYPE=hidden NAME=oldLotOpeningBid VALUE="#getLot.lotOpeningBid#">
	</CFOUTPUT>
<CFELSE>
	<FONT SIZE=6 COLOR=purple><B>Create Lot</B></FONT>
	<CFIF IsDefined("copy")>
		<INPUT TYPE=hidden NAME=copy VALUE=1>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">
			SELECT * FROM Lot WHERE lotID = #lotID#
		</CFQUERY>
	</CFIF>
</CFIF>

<CFQUERY NAME=getCategories DATASOURCE="#EAdatasource#">
	SELECT categoryID, categoryName
	FROM Category
	WHERE categoryID > 0
	ORDER BY categoryName
</CFQUERY>
<P>
<CFIF getCategories.RecordCount EQ 0>
	<H3>You must create at least one category before you may create a lot.</H3>
	<CFINCLUDE TEMPLATE="../program/copyright.cfm">
	</BODY></HTML>
	<CFABORT>
</CFIF>

<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFIF getLot.lotStatus EQ "Closed" AND (getLot.lotReservePriceMet EQ 0 OR getLot.lotBidsExist EQ 0)>
		<P><FONT SIZE=4>You may re-open this lot since there were either no bids or the reserve price was not met. To re-open the lot, simply change the closing time <B><I>and</I></B> change the lot status to &quot;<FONT COLOR=blue><B>Open</B></FONT>.&quot; You may also change the closing time. The lot will automatically re-open at the specific opening time.</FONT><P>
	</CFIF>
</CFIF>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2>
<TR><TD ALIGN=right>Name: </TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<TD><CFINPUT TYPE=text NAME=lotName SIZE=40 MAXLENGTH=100 VALUE="#getLot.lotName#" REQUIRED="Yes" MESSAGE="Lot name cannot be blank."></TD></TR>
<CFELSE>
	<TD><CFINPUT TYPE=text NAME=lotName SIZE=40 MAXLENGTH=100 REQUIRED="Yes" MESSAGE="Lot name cannot be blank."></TD></TR>
</CFIF>

<TR><TD ALIGN=right VALIGN=top>Status:</TD>
<TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot") AND NOT IsDefined("copy")>
	<CFIF getLot.lotStatus EQ "Closed" AND (getLot.lotReservePriceMet EQ 0 OR getLot.lotBidsExist EQ 0)>
		<INPUT TYPE=radio NAME=lotStatus VALUE="Open"> Open <FONT SIZE=2 COLOR=blue>(will re-open at designated Open time; Preview until then)</FONT><BR>
		<INPUT TYPE=radio NAME=lotStatus VALUE="Inactive"> Inactive <FONT SIZE=2 COLOR=blue>(will not re-open at Open time until made active)</FONT><BR>
		<INPUT TYPE=radio NAME=lotStatus VALUE="Closed" CHECKED> Auction closed <FONT SIZE=2 COLOR=blue>(completed)</FONT><BR>
	<CFELSEIF getLot.lotStatus EQ "Closed">
		&nbsp;-- &nbsp;Open <FONT SIZE=2 COLOR=blue>(will open at designated Open time; Preview until then)</FONT><BR>
		&nbsp;-- &nbsp;Inactive <FONT SIZE=2 COLOR=blue>(will not open at Open time until made active)</FONT><BR>
		<INPUT TYPE=radio NAME=lotStatus VALUE="Closed" CHECKED> Auction closed <FONT SIZE=2 COLOR=blue>(completed)</FONT>
	<CFELSE>
		<INPUT TYPE=radio NAME=lotStatus VALUE="Open"<CFIF getLot.lotStatus EQ "Open"> CHECKED</CFIF>> Active <FONT SIZE=2 COLOR=blue>(will open at designated Open time; Preview until then)</FONT><BR>
		<INPUT TYPE=radio NAME=lotStatus VALUE="Inactive"<CFIF getLot.lotStatus EQ "Inactive"> CHECKED</CFIF>> Inactive <FONT SIZE=2 COLOR=blue>(will not open at Open time until made active)</FONT><BR>
		&nbsp;-- &nbsp;Auction closed (completed)
	</CFIF>
<CFELSE>
	<INPUT TYPE=radio NAME=lotStatus VALUE="Open" CHECKED> Active <FONT SIZE=2 COLOR=blue>(will open at designated Open time; Preview until then)</FONT><BR>
	<INPUT TYPE=radio NAME=lotStatus VALUE="Inactive"> Inactive <FONT SIZE=2 COLOR=blue>(will not open at Open time until made active)</FONT><BR>
	&nbsp;-- &nbsp;Auction closed <FONT SIZE=2 COLOR=blue>(completed)</FONT>
</CFIF>
</TD></TR>

<CFIF IsDefined("lotID") AND NOT IsDefined("newLot") AND NOT IsDefined("copy")>
	<CFSET lotBold = getLot.lotBold>
	<CFSET lotFeaturedCategory = getLot.lotFeaturedCategory>
	<CFSET lotFeaturedHomepage = getLot.lotFeaturedHomepage>
<CFELSE>
	<CFSET lotBold = 0>
	<CFSET lotFeaturedCategory = 0>
	<CFSET lotFeaturedHomepage = 0>
</CFIF>

<TR><TD ALIGN=right VALIGN=top>Extra Options: </TD>
<TD><INPUT TYPE=checkbox NAME=lotBold VALUE=1<CFIF lotBold EQ 1> CHECKED</CFIF>> Bold auction<BR>
	<INPUT TYPE=checkbox NAME=lotFeaturedCategory VALUE=1<CFIF lotFeaturedCategory EQ 1> CHECKED</CFIF>> Featured auction on category page<BR>
	<INPUT TYPE=checkbox NAME=lotFeaturedHomepage VALUE=1<CFIF lotFeaturedHomepage EQ 1> CHECKED</CFIF>> Featured auction on homepage</TD></TR>
<TR><TD COLSPAN=2>&nbsp;</TD></TR>

<CFIF IsDefined("newLot") OR NOT IsDefined("lotID")>
	<CFINCLUDE TEMPLATE="../system/lotDefault.cfm">
</CFIF>

<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFSET openingTime = #getLot.lotOpenDateTime#>
<CFELSE>
	<!---
	Date starts at hour following current time
	If open on specific day of week, move date to that day of week
	 (If day = day, stay on same day, not next one)
		Elseif add number of days, add days to date
	If open at specific time, set time
		Elseif hours/minutes after current time, add hours and minutes
	Save as a date/time to determine default closing time
	--->
	<CFSET openingTime = #DateAdd("h",1,Now())#>
	<CFSET minuteSubtract = -1 * Minute(openingTime)>
	<CFSET secondSubtract = -1 * Second(openingTime)>
	<CFSET openingTime = DateAdd("n",minuteSubtract,openingTime)>
	<CFSET openingTime = DateAdd("s",secondSubtract,openingTime)>
	<CFSET dayOfWeekNow = DayOfWeek(openingTime)>
	<CFIF openDay EQ "set" AND dayOfWeekNow NEQ openDaySet>
		<CFIF dayOfWeekNow LT openDaySet>
			<CFSET dayDifference = openDaySet - dayOfWeekNow>
		<CFELSEIF dayOfWeekNow GT openDaySet>
			<CFSET dayDifference = (7 - dayOfWeekNow) + openDaySet>
		</CFIF>
		<CFSET openingTime = DateAdd("d",dayDifference,openingTime)>
	<CFELSEIF openDay EQ "add" AND openDayAdd NEQ 0>
		<CFSET openingTime = DateAdd("d",openDayAdd,openingTime)>
	</CFIF>

	<CFIF openHour EQ "set" AND openHourHourSet24 NEQ Hour(openingTime)>
		<CFSET hourAdd = openHourHourSet24 - Hour(openingTime)>
		<CFSET openingTime = DateAdd("h",hourAdd,openingTime)>
	<CFELSEIF openHour EQ "add" AND openHourHourAdd NEQ 0>
		<CFSET openingTime = DateAdd("h",openHourHourAdd,openingTime)>
	</CFIF>

	<CFIF openHour EQ "set" AND openHourMinuteSet NEQ Minute(openingTime)>
		<CFSET minuteAdd = openHourMinuteSet - Minute(openingTime)>
		<CFSET openingTime = DateAdd("n",minuteAdd,openingTime)>
	<CFELSEIF openHour EQ "add" AND openHourMinuteAdd NEQ 0>
		<CFSET openingTime = DateAdd("n",openHourMinuteAdd,openingTime)>
	</CFIF>
</CFIF>

<TR><TD ALIGN=right>Open date/time: </TD>
<TD>
<CFINPUT TYPE=text NAME=openDateMM SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(openingTime,'mm')# REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Open month must be an integer between 1-12."> / 
 <CFINPUT TYPE=text NAME=openDateDD SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(openingTime,'dd')# REQUIRED="Yes" RANGE="1,31" VALIDATE="integer" MESSAGE="Open date must be an integer between 1-31."> / 
 <CFINPUT TYPE=text NAME=openDateYYYY SIZE=4 MAXLENGTH=4 VALUE=#LSDateFormat(openingTime,'yyyy')# REQUIRED="Yes" RANGE="1998,9999" VALIDATE="integer" MESSAGE="Open year is not a valid year."> , 
 <CFINPUT TYPE=text NAME=openTimeHH SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(openingTime,'hh')#
	REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Open hour must be an integer between 1-12."><B>:</B><CFINPUT TYPE=text NAME=openTimeMM SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(openingTime,'mm')#
		REQUIRED="Yes" RANGE="0,59" VALIDATE="integer" MESSAGE="Open minute must be an integer between 0-59."> 

<SELECT NAME=openTimeAMPM SIZE=1>
	<OPTION VALUE=AM<CFIF LSTimeFormat(openingTime,"H") LT 12> SELECTED</CFIF>>AM
	<OPTION VALUE=PM<CFIF LSTimeFormat(openingTime,"H") GTE 12> SELECTED</CFIF>>PM
</SELECT> <FONT SIZE=2 COLOR=blue>(MM/DD/YYYY : HH:MM AM/PM)</FONT></TD></TR>

<TR><TD></TD><TD><INPUT TYPE=checkbox NAME=openNow VALUE=1> Open lot now <FONT SIZE=2 COLOR=blue>(If checked, above date/time is ignored)</FONT></TD></TR>

<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFSET closingTime = getLot.lotCloseDateTime>
<CFELSE>
	<CFSET closingTime = openingTime>
	<CFSET dayOfWeekNow = DayOfWeek(closingTime)>
	<CFIF closeDay EQ "set" AND dayOfWeekNow NEQ closeDaySet>
		<CFIF dayOfWeekNow LT closeDaySet>
			<CFSET dayDifference = closeDaySet - dayOfWeekNow>
		<CFELSEIF dayOfWeekNow GT closeDaySet>
			<CFSET dayDifference = (7 - dayOfWeekNow) + closeDaySet>
		</CFIF>
		<CFSET closingTime = DateAdd("d",dayDifference,closingTime)>
	<CFELSEIF closeDay EQ "add" AND closeDayAdd NEQ 0>
		<CFSET closingTime = DateAdd("d",closeDayAdd,closingTime)>
	</CFIF>

	<CFIF closeHour EQ "set" AND (closeHourHourSet24 NEQ Hour(closingTime))>
		<CFSET hourAdd = closeHourHourSet24 - Hour(closingTime)>
		<CFSET closingTime = DateAdd("h",hourAdd,closingTime)>
	<CFELSEIF closeHour EQ "add" AND closeHourHourAdd NEQ 0>
		<CFSET closingTime = DateAdd("h",closeHourHourAdd,closingTime)>
	</CFIF>

	<CFIF closeHour EQ "set" AND (closeHourMinuteSet NEQ Minute(closingTime))>
		<CFSET minuteAdd = closeHourMinuteSet - Minute(closingTime)>
		<CFSET closingTime = DateAdd("n",minuteAdd,closingTime)>
	<CFELSEIF closeHour EQ "add" AND closeHourMinuteAdd NEQ 0>
		<CFSET closingTime = DateAdd("n",closeHourMinuteAdd,closingTime)>
	</CFIF>
</CFIF>

<TR><TD ALIGN=right>Close date/time: </TD>
<TD>
<CFINPUT TYPE=text NAME=closeDateMM SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(closingTime,'mm')# REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Open month must be an integer between 1-12."> / 
 <CFINPUT TYPE=text NAME=closeDateDD SIZE=2 MAXLENGTH=2 VALUE=#LSDateFormat(closingTime,'dd')# REQUIRED="Yes" RANGE="1,31" VALIDATE="integer" MESSAGE="Open date must be an integer between 1-31."> / 
 <CFINPUT TYPE=text NAME=closeDateYYYY SIZE=4 MAXLENGTH=4 VALUE=#LSDateFormat(closingTime,'yyyy')# REQUIRED="Yes" RANGE="1998,9999" VALIDATE="integer" MESSAGE="Open year is not a valid year."> , 
 <CFINPUT TYPE=text NAME=closeTimeHH SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(closingTime,'hh')#
	REQUIRED="Yes" RANGE="1,12" VALIDATE="integer" MESSAGE="Open hour must be an integer between 1-12."><B>:</B><CFINPUT TYPE=text NAME=closeTimeMM SIZE=2 MAXLENGTH=2 VALUE=#LSTimeFormat(closingTime,'mm')#
		REQUIRED="Yes" RANGE="0,59" VALIDATE="integer" MESSAGE="Open minute must be an integer between 0-59."> 
<SELECT NAME=closeTimeAMPM SIZE=1>
	<OPTION VALUE=AM<CFIF LSTimeFormat(closingTime,"H") LT 12> SELECTED</CFIF>>AM
	<OPTION VALUE=PM<CFIF LSTimeFormat(closingTime,"H") GTE 12> SELECTED</CFIF>>PM
</SELECT> <FONT SIZE=2 COLOR=blue>(MM/DD/YYYY : HH:MM AM/PM)</FONT></TD></TR>

<TR><TD></TD><TD NOWRAP><CFINPUT TYPE=text NAME=closeDayCount SIZE=2 REQUIRED="No" VALIDATE="integer" MESSAGE="Number of days to keep lot open must be an integer."> Close lots X days after opening date/time. <FONT SIZE=2 COLOR=blue>(If not blank, above date is ignored)</FONT></TD></TR>

<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFSET lotCloseBasis = getLot.lotCloseBasis>
</CFIF>

<TR><TD ALIGN=right VALIGN=top>Close Basis: </TD>
<TD><INPUT TYPE=radio NAME=lotCloseBasis VALUE=time<CFIF lotCloseBasis EQ "time"> CHECKED</CFIF>> Time<BR>
	<INPUT TYPE=radio NAME=lotCloseBasis VALUE=timeInactivity<CFIF lotCloseBasis EQ "timeInactivity"> CHECKED</CFIF>> Time + Inactivity
</TD></TR>

<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFSET lotCloseInactivity = getLot.lotCloseInactivity>
</CFIF>
<TR><TD ALIGN=right>Close Inactivity: </TD>
	<TD><CFINPUT TYPE=text NAME=lotCloseInactivity SIZE=3 MAXLENGTH=10 VALUE="#lotCloseInactivity#" REQUIRED="Yes" VALIDATE="integer" MESSAGE="Inactivity must be an integer."> <FONT SIZE=2 COLOR=blue>(in whole minutes)</FONT></TD></TR>

<TR><TD>&nbsp;</TD></TR>

<TR><TD ALIGN=right>Quantity: </TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<TD>&nbsp;&nbsp;<CFINPUT TYPE=text NAME=lotQuantity SIZE=5 VALUE="#getLot.lotQuantity#" REQUIRED="Yes" VALIDATE="integer" MESSAGE="Quantity must a non-blank integer."></TD></TR>
<CFELSE>
	<TD>&nbsp;&nbsp;<CFINPUT TYPE=text NAME=lotQuantity SIZE=5 VALUE=1 REQUIRED="Yes" VALIDATE="integer" MESSAGE="Quantity must a non-blank integer."></TD></TR>
</CFIF>

<TR><TD ALIGN=right>Max. Quantity: </TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<TD>&nbsp;&nbsp;<CFINPUT TYPE=text NAME=lotQuantityMaximum SIZE=5 VALUE="#getLot.lotQuantityMaximum#" REQUIRED="Yes" VALIDATE="integer" MESSAGE="Maximum quantity must be a non-blank integer."> <FONT SIZE=2 COLOR=blue>(0 = unlimited)</FONT></TD></TR>
<CFELSE>
	<TD>&nbsp;&nbsp;<CFINPUT TYPE=text NAME=lotQuantityMaximum SIZE=5 VALUE=0 REQUIRED="Yes" VALIDATE="integer" MESSAGE="Maximum quantity must be a non-blank integer."> <FONT SIZE=2 COLOR=blue>(0 = unlimited)</FONT></TD></TR>
</CFIF>

<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFSET openBid = getLot.lotOpeningBid>
	<CFSET bidIncr = getLot.lotBidIncrement>
	<CFSET reserve = getLot.lotReservePrice>
	<CFSET shipping = getLot.lotShipping>
</CFIF>

<CFSET openBid = Replace(DecimalFormat(openBid), ",", "", "ALL")>
<TR><TD ALIGN=right>Opening bid: </TD>
	<TD>$<CFINPUT TYPE=text NAME=lotOpeningBid SIZE=10 MAXLENGTH=50 VALUE="#openBid#" REQUIRED="Yes" VALIDATE="float" MESSAGE="Opening bid must be a number."></TD></TR>
<CFSET bidIncr = Replace(DecimalFormat(bidIncr), ",", "", "ALL")>
<TR><TD ALIGN=right>Bid Increment: </TD>
	<TD>$<CFINPUT TYPE=text NAME=lotBidIncrement SIZE=10 VALUE="#bidIncr#" RANGE="0.01" REQUIRED="Yes" VALIDATE="float" MESSAGE="Bid increment must be a number."></TD></TR>
<CFSET shipping = Replace(DecimalFormat(shipping), ",", "", "ALL")>
<CFSET reserve = Replace(DecimalFormat(reserve), ",", "", "ALL")>
<TR><TD ALIGN=right>Reserve Price: </TD>
	<TD>$<CFINPUT TYPE=text NAME=lotReservePrice SIZE=10 MAXLENGTH=50 VALUE="#reserve#" REQUIRED="Yes" VALIDATE="float" MESSAGE="Reserve price must be a number."> <FONT SIZE=2 COLOR=blue>(0.00 = none; Applies only if lot quantity = 1.)</FONT></TD></TR>
<TR><TD ALIGN=right>Shipping: </TD>
	<TD>$<CFINPUT TYPE=text NAME=lotShipping SIZE=10 MAXLENGTH=50 VALUE="#shipping#" REQUIRED="Yes" VALIDATE="float" MESSAGE="Shipping fee must be a number."> <FONT SIZE=2 COLOR=blue>(0.00 = none; Not used, but is available)</FONT></TD></TR>
<TR><TD ALIGN=right>Sell Price: </TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFSET lotSellPrice = Replace(DecimalFormat(getLot.lotSellPrice), ",", "", "ALL")>
	<TD>$<CFINPUT TYPE=text NAME=lotSellPrice SIZE=10 MAXLENGTH=50 VALUE="#lotSellPrice#" REQUIRED="Yes" VALIDATE="float" MESSAGE="Sell price must be a number."> <FONT SIZE=2 COLOR=blue>(0.00 = none)</FONT></TD></TR>
<CFELSE>
	<TD>$<CFINPUT TYPE=text NAME=lotSellPrice SIZE=10 MAXLENGTH=50 VALUE="0.00" REQUIRED="Yes" VALIDATE="float" MESSAGE="Sell price must be a number."> <FONT SIZE=2 COLOR=blue>(0.00 = none)</FONT></TD></TR>
</CFIF>

<TR><TD COLSPAN=2 HEIGHT=20>&nbsp;</TD></TR>

<TR><TD ALIGN=right>Category: </TD>
<TD><SELECT NAME=categoryID SIZE=1>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFOUTPUT QUERY="getCategories">
		<OPTION VALUE="#getCategories.categoryID#"<CFIF #getLot.categoryID# EQ #getCategories.categoryID#> SELECTED</CFIF>>#getCategories.categoryName#
	</CFOUTPUT>
<CFELSE>
	<CFOUTPUT QUERY="getCategories">
		<OPTION VALUE="#getCategories.categoryID#">#getCategories.categoryName#
	</CFOUTPUT>
</CFIF>
</SELECT></TD></TR>

<CFQUERY NAME=getTemplates DATASOURCE="#EAdatasource#">
	SELECT templateName, templateFile
	FROM Template
	WHERE templateType = 'lot' OR templateType = 'reverse'
	ORDER BY templateName
</CFQUERY>
<TR><TD ALIGN=right>Template: </TD>
<TD><SELECT NAME=templateFile SIZE=1>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFOUTPUT QUERY=getTemplates>
		<CFIF getLot.templateFile EQ getTemplates.templateFile>
			<OPTION SELECTED VALUE=#getTemplates.templateFile#>#getTemplates.templateName#
		<CFELSE>
			<OPTION VALUE=#getTemplates.templateFile#>#getTemplates.templateName#
		</CFIF>
	</CFOUTPUT>
<CFELSE>
	<CFOUTPUT QUERY=getTemplates><OPTION VALUE=#templateFile#>#templateName#</CFOUTPUT>
</CFIF>
</SELECT></TD></TR>

<TR><TD ALIGN=right VALIGN=top>Public: </TD>
<TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<INPUT TYPE=radio NAME=lotPublic VALUE=1<CFIF #getLot.lotPublic# EQ 1> CHECKED</CFIF>> Public <FONT SIZE=2 COLOR=blue>(all users may bid)</FONT><BR>
	<INPUT TYPE=radio NAME=lotPublic VALUE=0<CFIF #getLot.lotPublic# EQ 0> CHECKED</CFIF>> Private <FONT SIZE=2 COLOR=blue>(users need permission to access lot page)</FONT>
<CFELSE>
	<INPUT TYPE=radio NAME=lotPublic VALUE=1 CHECKED> Public <FONT SIZE=2 COLOR=blue>(all users may bid)</FONT><BR>
	<INPUT TYPE=radio NAME=lotPublic VALUE=0> Private <FONT SIZE=2 COLOR=blue>(users need permission to bid)</FONT>
</CFIF>
</TD></TR>

<CFIF NOT IsDefined("lotID") OR IsDefined("newLot")>
	<CFQUERY NAME=getAdmin DATASOURCE="#EAdatasource#">
		SELECT email, firstName, lastName FROM Member WHERE userID = 1
	</CFQUERY>
</CFIF>

<TR><TD ALIGN=right>Location:</TD><TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFINPUT TYPE=text NAME=lotLocation SIZE=30  MAXLENGTH=50 VALUE="#getLot.lotLocation#">
<CFELSE>
	<CFINPUT TYPE=text NAME=lotLocation SIZE=30 MAXLENGTH=50>
</CFIF>
</TD></TR>

<TR><TD ALIGN=right>Shipping Policy:</TD><TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFINPUT TYPE=text NAME=lotShippingPolicy SIZE=30 VALUE="#getLot.lotShippingPolicy#" MAXLENGTH=100>
<CFELSE>
	<CFINPUT TYPE=text NAME=lotShippingPolicy SIZE=30 MAXLENGTH=100>
</CFIF>
</TD></TR>

<TR><TD ALIGN=right>Payment Method:</TD><TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFINPUT TYPE=text NAME=lotPaymentMethod SIZE=30 MAXLENGTH=100 VALUE="#getLot.lotPaymentMethod#">
<CFELSE>
	<CFINPUT TYPE=text NAME=lotPaymentMethod SIZE=30 MAXLENGTH=100>
</CFIF>
</TD></TR>

<TR><TD ALIGN=right>Contact Name:</TD><TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFINPUT TYPE=text NAME=lotContactName SIZE=30 VALUE="#getLot.lotContactName#">
<CFELSE>
	<CFINPUT TYPE=text NAME=lotContactName SIZE=30 VALUE="#getAdmin.firstName# #getAdmin.lastName#">
</CFIF>
</TD></TR>

<TR><TD ALIGN=right>Contact Email:</TD><TD>
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot")>
	<CFINPUT TYPE=text NAME=lotContactEmail SIZE=30 VALUE="#getLot.lotContactEmail#">
<CFELSE>
	<CFINPUT TYPE=text NAME=lotContactEmail SIZE=30 VALUE="#getAdmin.email#">
</CFIF>
</TD></TR>

<!---
Determine whether to insert image URL or default URL in image and thumbnail field.
If new lot, simply insert default URL.
If editing an existing lot, insert image URL if exists. If not, insert default URL.
Need to get lotDefaultImage.cfm if editing existing lot and image and/or thumbnail is blank.
--->

<TR><TD>&nbsp;</TD></TR>
<TR><TD></TD><TD><FONT SIZE=2 COLOR=blue>If using the lotimage directory, select the image from your computer by<BR>
clicking the &quot;Browse&quot; button. This will upload the image to the server.<BR>
If using an image in another directory, enter the full URL.<BR>
If not using an image, just ignore both fields.

<CFIF IsDefined("newLot") OR NOT IsDefined("lotID")>
	<CFSET lotImage = "#imageURL#/">
	<CFSET lotImageThumbnail = "#thumbnailURL#/">
<CFELSE>
	<BR>If changing an image, simply change the URL or choose an image file to upload.
	<BR>If deleting an image, erase the URL in the URL field.
	<CFIF getLot.lotImage EQ "" OR getLot.lotImage EQ " " OR
			getLot.lotImageThumbnail EQ "" OR getLot.lotImageThumbnail EQ " ">
		<CFINCLUDE TEMPLATE="../system/lotDefaultImage.cfm">
	</CFIF>
	<CFIF getLot.lotImage EQ "" OR getLot.lotImage EQ " ">
		<CFSET lotImage = "#imageURL#/">
	<CFELSE>
		<CFSET lotImage = "#getLot.lotImage#">
	</CFIF>
	<CFIF getLot.lotImageThumbnail EQ "" OR getLot.lotImageThumbnail EQ " ">
		<CFSET lotImageThumbnail = "#thumbnailURL#/">
	<CFELSE>
		<CFSET lotImageThumbnail = getLot.lotImageThumbnail>
	</CFIF>
</CFIF>
</FONT></TD></TR>

<TR><TD ALIGN=right VALIGN=top>Image: </TD><TD>(<FONT SIZE=2 COLOR=green>If uploading, File.</FONT> <FONT SIZE=2 COLOR=red>If other, URL.</FONT> <FONT SIZE=2>If none, ignore.</FONT>)</TD></TR>
<TR><TD NOWRAP ALIGN=right><FONT SIZE=2 COLOR=green>File: </FONT></TD><TD><INPUT TYPE=file NAME=lotImageFileUpload SIZE=35></TD></TR>
<TR><TD NOWRAP ALIGN=right><FONT SIZE=2 COLOR=red>URL: </FONT> </TD><TD><CFINPUT TYPE=text NAME=lotImage SIZE=50 MAXLENGTH=100 VALUE="#lotImage#"></TD></TR>

<TR><TD ALIGN=right VALIGN=top>Thumbnail: </TD><TD>(<FONT SIZE=2 COLOR=green>If uploading, File.</FONT> <FONT SIZE=2 COLOR=red>If other, URL.</FONT> <FONT SIZE=2>If none, ignore.</FONT>)</TD></TR>
<TR><TD NOWRAP ALIGN=right><FONT SIZE=2 COLOR=green>File: </FONT></TD><TD><INPUT TYPE=file NAME=lotImageThumbnailFileUpload SIZE=35></TD></TR>
<TR><TD NOWRAP ALIGN=right><FONT SIZE=2 COLOR=red>URL: </FONT> </TD><TD><CFINPUT TYPE=text NAME=lotImageThumbnail SIZE=50 MAXLENGTH=100 VALUE="#lotImageThumbnail#"></TD></TR>

<TR><TD>&nbsp;</TD></TR>

<TR><TD ALIGN=right VALIGN=top>Summary: </TD>
	<TD><TEXTAREA NAME=lotSummary ROWS=2 COLS=50 WRAP=virtual><CFIF IsDefined("lotID") AND NOT IsDefined("newLot")><CFIF #getLot.lotSummary# NEQ " "><CFOUTPUT>#getLot.lotSummary#</CFOUTPUT></CFIF></CFIF></TEXTAREA></TD></TR>
<TR><TD ALIGN=right VALIGN=top>Description: </TD>
	<TD><TEXTAREA NAME=lotDescription ROWS=10 COLS=60 WRAP=virtual><CFIF IsDefined("lotID") AND NOT IsDefined("newLot")><CFIF #getLot.lotDescription# NEQ " "><CFOUTPUT>#getLot.lotDescription#</CFOUTPUT></CFIF></CFIF></TEXTAREA></TD></TR>
	
<TR><TD BGCOLOR="#CDCDCD">&nbsp;</TD><TD HEIGHT=60 BGCOLOR="#CDCDCD"><INPUT TYPE=reset VALUE=Clear> &nbsp; 
<CFIF IsDefined("lotID") AND NOT IsDefined("newLot") AND NOT IsDefined("copy")>
	<INPUT TYPE=submit VALUE="Edit Lot">
<CFELSE><INPUT TYPE=submit VALUE="Create Lot">
</CFIF>
</TD></TR>
</TABLE>

</CFFORM>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>