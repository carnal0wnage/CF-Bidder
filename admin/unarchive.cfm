<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Unarchive</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first") AND IsDefined("Form.lotID")>
	<CFIF Form.button EQ "Unarchive Lots">
		<CFLOOP INDEX=lotCount LIST="#Form.lotID#">
			<CFIF FileExists("#systemPath#\archive\#lotCount#LotInfo.cfm") EQ "NO"
					OR FileExists("#systemPath#\archive\#lotCount#LotBid.cfm") EQ "NO">
				<CFOUTPUT><B><FONT SIZE=4>Error Occurred - Lot #lotCount#</FONT><BR></CFOUTPUT>
				This lot cannot be unarchived since either the LotInfo.cfm or LotBid.cfm file does not exist.</B>
			<CFELSE>
				<CFOUTPUT><FONT SIZE=4>Beginning to unarchive lot #lotCount#</FONT><BR></CFOUTPUT>
				<CFFILE ACTION=Move SOURCE="#systemPath#\archive\#lotCount#LotInfo.cfm"
					DESTINATION="#systemPath#\lot\#lotCount#LotInfo.cfm">
				<CFFILE ACTION=Move SOURCE="#systemPath#\archive\#lotCount#LotBid.cfm"
					DESTINATION="#systemPath#\lot\#lotCount#LotBid.cfm">
				<CFIF FileExists("#systemPath#\archive\#lotCount#LotEmail.cfm") EQ "YES">
					<CFFILE ACTION=Move SOURCE="#systemPath#\archive\#lotCount#LotEmail.cfm"
						DESTINATION="#systemPath#\lot\#lotCount#LotEmail.cfm">
					<CFINCLUDE TEMPLATE="../lot/#lotCount#LotEmail.cfm">
				<CFELSE>
					<CFSET lotContactName = "Emaze Webmaster">
					<CFSET lotContactEmail = "webmaster@emaze.com">
					<CFFILE ACTION=Write FILE="#systemPath#\lot\#lotCount#LotEmail.cfm"
						OUTPUT="<CFSET lotContactName = ""Emaze Webmaster"">
<CFSET lotContactEmail = ""webmaster@emaze.com"">">
					<CFOUTPUT><I>#lotCount#LotEmail.cfm file not found. Using 'Emaze Webmaster' and webmaster@emaze.com as contact name and email.</I><BR></CFOUTPUT>
				</CFIF>
				<CFIF FileExists("#systemPath#\archive\#lotCount#LotDescription.cfm") EQ "YES">
					<CFFILE ACTION=Move SOURCE="#systemPath#\archive\#lotCount#LotDescription.cfm"
						DESTINATION="#systemPath#\lot\#lotCount#LotDescription.cfm">
					<CFFILE ACTION=Read FILE="#systemPath#\lot\#lotCount#LotDescription.cfm" VARIABLE="lotDescription">
				<CFELSE>
					<CFSET lotDescription = " ">
					<CFFILE ACTION=Write FILE="#systemPath#\lot\#lotCount#LotDescription.cfm" OUTPUT=" ">
					<CFOUTPUT><I>#lotCount#LotDescription.cfm file not found. Creating blank description.</I><BR></CFOUTPUT>
				</CFIF>
			</CFIF>

			<CFINCLUDE TEMPLATE="../lot/#lotCount#LotInfo.cfm">
			<CFINCLUDE TEMPLATE="../lot/#lotCount#LotBid.cfm">
			<CFIF FileExists("#systemPath#\category\#categoryID#CategoryInfo.cfm") EQ "NO">
				<CFQUERY NAME=getCategory MAXROWS=1 DATASOURCE="#EAdatasource#">
					SELECT categoryID, categoryName1
					FROM Category
					WHERE (categoryName2 = '' OR categoryName2 = ' ')
						AND (categoryName3 = '' OR categoryName3 = ' ')
						AND (categoryName4 = '' OR categoryName4 = ' ')
				</CFQUERY>
				<CFQUERY NAME=upLotCount MAXROWS=1 DATASOURCE="#EAdatasource#">
					UPDATE Category
					SET categoryLotCount = categoryLotCount + 1
					WHERE categoryID = #getCategory.categoryID#
				</CFQUERY>
				<CFOUTPUT><I>Category #categoryID# no longer exists. Randomly assigning lot to category #getCategory.categoryID#, #getCategory.categoryName1#.</I><BR></CFOUTPUT>
				<CFSET categoryID = getCategory.categoryID>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#lotCount#LotInfo.cfm"
					OUTPUT="<CFSET categoryID = #getCategory.categoryID#>">
			</CFIF>
			<CFIF FileExists("#systemPath#\template\#templateFile#") EQ "NO">
				<CFIF FileExists("#systemPath#\template\defaultLot.cfm") EQ "YES">
					<CFOUTPUT><I>Template file #templateFile# not found. Assigning lot to defaultLot.cfm template.</I><BR></CFOUTPUT>
					<CFSET templateFile = "defaultLot.cfm">
				<CFELSE>
					<CFQUERY NAME=getTemplate MAXROWS=1 DATASOURCE="#EAdatasource#">
						SELECT templateFile, templateName
						FROM Template
						WHERE templateType = 'lot'
					</CFQUERY>
					<CFOUTPUT><I>Template file #templateFile# file not found. Assigning lot to random template, #getTemplate.templateName# which is #getTemplate.templateFile#</I><BR></CFOUTPUT>
					<CFSET templateFile = getTemplate.templateFile>
				</CFIF>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#lotCount#LotInfo.cfm"
					OUTPUT="<CFSET templateFile = ""#templateFile#"">">
			</CFIF>
			<CFIF NOT IsDefined("lotReservePrice")>
				<CFSET lotReservePrice = 0>
				<CFSET lotSellPrice = 0>
				<CFOUTPUT><I>Reserve price and sell price did not exist. Assigning value of zero for both.</I><BR></CFOUTPUT>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#lotCount#LotInfo.cfm"
					OUTPUT="<CFSET lotReservePrice = ""0.00"">
<CFSET lotSellPrice = ""0.00"">">
			</CFIF>
			<CFIF NOT IsDefined("lotReservePriceMet")>
				<CFIF lotReservePrice EQ 0><CFSET lotReservePriceMet = 2>
					<CFELSE><CFSET lotReservePriceMet = 0></CFIF>
				<CFFILE ACTION=Append FILE="#systemPath#\lot\#lotCount#LotBid.cfm"
					OUTPUT="<CFSET lotReservePriceMet = #lotReservePriceMet#>
<CFSET lotBidsExist = 0>">
			</CFIF>

			<!--- Create lot in database --->
			<CFSET currentDateTime = CreateODBCDateTime(Now())>
			<CFIF lotSummary EQ ""><CFSET lotSummary EQ " "></CFIF>
			<CFIF NOT IsDefined("lotQuantityTaken")><CFSET lotQuantityTaken = 0></CFIF>
			<CFFILE ACTION=Read FILE="#systemPath#\lot\#lotCount#LotDescription.cfm" VARIABLE="lotDescription">
			<CFQUERY NAME=insertLot DATASOURCE="#EAdatasource#">
				INSERT INTO Lot (lotID, lotName, lotQuantity, lotQuantityMaximum, lotSummary,
					categoryID, templateFile, lotImage, lotImageThumbnail, lotOpenDateTime,
					lotOpeningBid, lotBidIncrement, lotCloseBasis, lotCloseDateTime,
					lotCloseInactivity, lotPublic, lotStatus, lotCloseQueue, lotContactName, lotContactEmail,
					lotDateTimeCreated, lotDateTimeLastEdited, lotDescription, lotReservePrice,
					lotSellPrice, userID, lotViewCount, lotReservePriceMet, lotReserveStayOpenTimes, lotBidsExist, lotNoBidsStayOpenTimes,
					nextBidMinimum, nextNextBidMinimum, lastBidDateTime, secondLastBidDateTime, lotQuantityTaken)
				VALUES (#lotCount#, '#lotName#', #lotQuantity#, #lotQuantityMaximum#, '#lotSummary# ',
					#categoryID#, '#templateFile#', '#lotImage#', '#lotImageThumbnail#', #lotOpenDateTime#,
					#lotOpeningBid#, #lotBidIncrement#, '#lotCloseBasis#', #lotCloseDateTime#,
					#lotCloseInactivity#, #lotPublic#, 'Inactive', 0, '#lotContactName#',
					'#lotContactEmail#', #currentDateTime#, #currentDateTime#, '#lotDescription#',
					#lotReservePrice#, #lotSellPrice#, 0, 0, #lotReservePriceMet#, 0, 0, 0,
					#nextBidMinimum#, #nextNextBidMinimum#, #lastBidDateTime#, #secondLastBidDateTime#, #lotQuantityTaken#)
			</CFQUERY>
			<FONT SIZE=2>Re-inserted lot information into the database.</FONT><BR>

			<CFIF FileExists("#systemPath#\archive\#lotCount#LotBidding.cfm") EQ "YES">
				<CFFILE ACTION=Read FILE="#systemPath#\archive\#lotCount#LotBidding.cfm" VARIABLE="biddingList">
				<CFSET numBids = ListLen(biddingList,"
")>
				<CFLOOP INDEX=bidCount FROM=2 TO=#numBids#>
					<CFSET bidInfo = ListGetAt(biddingList,bidCount,"
")>
					<CFSET bidQuantityWin = Replace(ListGetAt(bidInfo,13,","),"
", "", "ALL")>
					<CFQUERY NAME=insertBid DATASOURCE="#EAdatasource#">
						INSERT INTO Bid (bidID, userID, lotID, bidPrice, bidWin, 
							bidQuantity, bidFullQuantityOnly, bidDateTime, bidEditDateTime,
							bidAuto, bidPriceMaximum, bidPriceInitial, bidQuantityWin)
						VALUES (#ListGetAt(bidInfo,1,",")#, #ListGetAt(bidInfo,4,",")#, #ListGetAt(bidInfo,10,",")#, #ListGetAt(bidInfo,5,",")#, #ListGetAt(bidInfo,11,",")#,
							#ListGetAt(bidInfo,6,",")#, #ListGetAt(bidInfo,9,",")#, {ts '#ListGetAt(bidInfo,2,",")#'}, {ts '#ListGetAt(bidInfo,3,",")#'},
							#ListGetAt(bidInfo,7,",")#, #ListGetAt(bidInfo,8,",")#, #ListGetAt(bidInfo,12,",")#, #bidQuantityWin#)
					</CFQUERY>
				</CFLOOP>
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#LotBidding.cfm">
				<CFOUTPUT><FONT SIZE=2>Re-inserted #numBids# bids for this lot into the database.</FONT><BR></CFOUTPUT>
			</CFIF>

			<CFIF FileExists("#systemPath#\archive\#lotCount#LotPrivateUser.cfm") EQ "YES">
				<CFINCLUDE TEMPLATE="../archive/#lotCount#LotPrivateUser.cfm">
				<CFLOOP INDEX=userCount LIST="#userID#">
					<CFQUERY NAME=private DATASOURCE="#EAdatasource#">
						INSERT INTO PrivateLotUser (userID, lotID)
						VALUES (#userCount#, #lotCount#)
					</CFQUERY>
				</CFLOOP>
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#LotPrivateUser.cfm">
				<FONT SIZE=2>Re-inserted users with permission to this private lot into the database.</FONT><BR>
			</CFIF>

			<CFOUTPUT><FONT SIZE=4 COLOR=blue><B>Lot #lotCount# unarchived.</B></FONT><P></CFOUTPUT>
		</CFLOOP>
	<CFELSEIF IsDefined("Form.okDelete")><!--- AND Form.buton EQ "Delete Lots" --->
		<CFLOOP INDEX=lotCount LIST="#Form.lotID#">
			<CFIF FileExists("#systemPath#\archive\#lotCount#LotInfo.cfm") EQ "YES">
				<CFINCLUDE TEMPLATE="../archive\#lotCount#LotInfo.cfm">
				<CFSET systemURLlength = Len("#systemURL#/lotImage/")>
				<CFIF lotImage NEQ " ">
					<CFSET lotImageFile = Mid("#lotImage#",systemURLlength,50)>
					<CFIF FileExists("#systemPath#\lotimage\#lotImageFile#") EQ "YES">
						<CFQUERY NAME=checkImage DATASOURCE="#EAdatasource#">
							SELECT Count(lotID) AS checkCount
							FROM Lot
							WHERE lotImage = '#lotImage#'
						</CFQUERY>
						<CFIF checkImage.checkCount EQ 0 AND FileExists("#systemPath#\lotimage\#lotImageFile#") EQ "YES">
							<CFFILE ACTION=Delete FILE="#systemPath#\lotimage\#lotImageFile#">
							<CFSET deletedImage = 1>
						</CFIF>
					</CFIF>
				</CFIF>
				<CFIF lotImageThumbnail NEQ " ">
					<CFSET lotImageFileThumbnail = Mid("#lotImage#",systemURLlength,50)>
					<CFIF FileExists("#systemPath#\lotimage\#lotImageFileThumbnail#") EQ "YES">
						<CFQUERY NAME=checkImage DATASOURCE="#EAdatasource#">
							SELECT Count(lotID) AS checkCount
							FROM Lot
							WHERE lotImage = '#lotImageThumbnail#'
						</CFQUERY>
						<CFIF checkImage.checkCount EQ 0 AND FileExists("#systemPath#\lotimage\#lotImageFileThumbnail#") EQ "YES">
							<CFFILE ACTION=Delete FILE="#systemPath#\lotimage\#lotImageFileThumbnail#">
							<CFSET deletedThumbnail = 1>
						</CFIF>
					</CFIF>
				</CFIF>
			</CFIF>

			<CFIF FileExists("#systemPath#\archive\#lotCount#LotInfo.cfm") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#LotInfo.cfm">
			</CFIF>
			<CFIF FileExists("#systemPath#\archive\#lotCount#LotBid.cfm") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#LotBid.cfm">
			</CFIF>
			<CFIF FileExists("#systemPath#\archive\#lotCount#LotEmail.cfm") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#LotEmail.cfm">
			</CFIF>
			<CFIF FileExists("#systemPath#\archive\#lotCount#LotDescription.cfm") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#LotDescription.cfm">
			</CFIF>
			<CFIF FileExists("#systemPath#\archive\#lotCount#lotBidding.cfm") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#lotBidding.cfm">
			</CFIF>
			<CFIF FileExists("#systemPath#\archive\#lotCount#LotBidding.cfm") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#LotBidding.cfm">
			</CFIF>
			<CFIF FileExists("#systemPath#\archive\#lotCount#LotPrivateUser.cfm") EQ "YES">
				<CFFILE ACTION=Delete FILE="#systemPath#\archive\#lotCount#LotPrivateUser.cfm">
			</CFIF>

			<CFOUTPUT>Lot #lotCount# deleted.<BR></CFOUTPUT>
			<CFIF IsDefined("deletedImage")>
				<CFOUTPUT><FONT SIZE=2>&nbsp; &nbsp; Image <I>#lotImageFile#</I> deleted from lotimage directory since it was not being used by any other lots.</FONT><BR></CFOUTPUT>
			</CFIF>
			<CFIF IsDefined("deletedThumbnail")>
				<CFOUTPUT><FONT SIZE=2>&nbsp; &nbsp; Image <I>#lotImageFileThumbnail#</I> deleted from lotimage directory since it was not being used by any other lots.<BR></FONT></CFOUTPUT>
			</CFIF>
		</CFLOOP>
	</CFIF>
<CFELSEIF IsDefined("lotID")>
	<CFIF FileExists("#systemPath#\archive\#lotID#LotInfo.cfm") EQ "NO"
			OR FileExists("#systemPath#\archive\#lotID#LotBid.cfm") EQ "NO">
		<CFOUTPUT><H2>Error Occurred - Lot #lotID#</H2></CFOUTPUT>
		<H3>This lot cannot be viewed because either the LotInfo.cfm or LotBid.cfm file necessary to view this lot does not exist.</H3>
		</BODY></HTML>
		<CFABORT>
	</CFIF>

	<CFINCLUDE TEMPLATE="../archive/#lotID#LotInfo.cfm">
	<CFINCLUDE TEMPLATE="../archive/#lotID#LotBid.cfm">

	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH=600><TR><TD ALIGN=center>
	<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
	<CFIF lotImage NEQ " " OR lotImageThumbnail NEQ " ">
		<TH COLSPAN=2 BGCOLOR="#20A491">
	<CFELSE><TH BGCOLOR="#20A491">
	</CFIF>
	<FONT SIZE=4><CFOUTPUT>#lotName#</CFOUTPUT></FONT></TH>

	<TR>
	<CFIF lotImage NEQ " " AND lotImageThumbnail NEQ " ">
		<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center>
		<CFOUTPUT><A HREF="#lotImage#"><IMG SRC="#lotImageThumbnail#" ALT="Thumbnail image" BORDER=0></A></CFOUTPUT></TD>
	<CFELSEIF lotImage NEQ " ">
		<TD BGCOLOR="#20A491" ALIGN=center VALIGN=center>
		<CFOUTPUT><IMG SRC="#lotImage#" ALT="Lot image" BORDER=0></CFOUTPUT></TD>
	</CFIF>
	
	<TD><TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2>
	<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><B>Auction Status: </B></TD>
		<TD BGCOLOR="yellow" ALIGN=center>ARCHIVED</TD></TR>
	<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><FONT SIZE=2>Starting bid: </FONT></TD>
		<TD><FONT SIZE=2><CFOUTPUT>#LSCurrencyFormat(lotOpeningBid,"local")#</CFOUTPUT></FONT></TD></TR>
	<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><FONT SIZE=2>Bid increments: </FONT></TD>
		<TD><FONT SIZE=2><CFOUTPUT>#LSCurrencyFormat(lotBidIncrement,"local")#</CFOUTPUT></FONT></TD></TR>
	<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><FONT SIZE=2>Quantity Available: </FONT></TD>
		<TD><FONT SIZE=2><CFOUTPUT>#lotQuantity#</CFOUTPUT></FONT></TD></TR>
	<CFIF lotQuantityMaximum NEQ 0 AND lotQuantityMaximum LT #lotQuantity#>
		<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><FONT SIZE=2>Max. Quantity: </FONT></TD>
		<TD><FONT SIZE=2><CFOUTPUT>#lotQuantityMaximum#</CFOUTPUT></FONT></TD></TR>
	</CFIF>
	<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><FONT SIZE=2>Auction opens: </FONT></TD>
	<TD NOWRAP><FONT SIZE=2><CFOUTPUT>#LSDateFormat(lotOpenDateTime, "mm-dd-yyyy")# / #LSTimeFormat(lotOpenDateTime)#</CFOUTPUT></FONT></TD></TR>
	<CFIF lotCloseBasis EQ "time" OR #lotCloseInactivity# EQ 0>
		<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><FONT SIZE=2>Auction closes</FONT></TD>
		<TD><FONT SIZE=2><CFOUTPUT>#LSDateFormat(lotCloseDateTime, "mm-dd-yyyy")# / #LSTimeFormat(lotCloseDateTime)#</CFOUTPUT></FONT></TD></TR>
	<CFELSE>
		<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><FONT SIZE=2>Auction closes<BR> (at or after)</FONT></TD>
		<TD><FONT SIZE=2><CFOUTPUT>#LSDateFormat(lotCloseDateTime, "mm-dd-yyyy")# / #LSTimeFormat(lotCloseDateTime)#<BR> (or #lotCloseInactivity# minutes after last bid)</CFOUTPUT></FONT></TD></TR>
	</CFIF>
	<TR BGCOLOR="#FFFFCE"><TD ALIGN=right VALIGN=top><FONT SIZE=2>Time remaining</FONT></TD>
		<TD><FONT SIZE=2>(none)</FONT></TD></TR>
	<TR BGCOLOR="#FFFFCE"><TD ALIGN=right><FONT SIZE=2>Time last bid received: </TD>
	<CFIF DateCompare(lastBidDateTime,lotOpenDateTime) EQ 1>
		<TD><FONT SIZE=2><CFOUTPUT>#LSDateFormat(lastBidDateTime, "mm-dd-yyyy")# / #LSTimeFormat(lastBidDateTime)#</CFOUTPUT></FONT></TD></TR>
	<CFELSE>
		<TD><FONT SIZE=2>(No current bids)</FONT></TD></TR>
	</CFIF>
	<CFIF NOT IsDefined("lotReservePriceMet")><CFSET lotReservePriceMet = 2></CFIF>
	<CFIF lotReservePriceMet NEQ 2>
		<TR BGCOLOR="#FFFFCE"><TD ALIGN=right NOWRAP><FONT SIZE=2>Reserve Price: </TD>
		<CFIF lotReservePriceMet EQ 1>
			<TD BGCOLOR="#7CFC00"><FONT SIZE=2>Has been met!</FONT></TD></TR>
		<CFELSE>
			<TD BGCOLOR="yellow"><FONT SIZE=2>Not yet met.</FONT></TD></TR>
		</CFIF>
	</CFIF>
	<TR BGCOLOR="#FFFFCE"><TD ALIGN=right NOWRAP><FONT SIZE=2><B>Minimum winning bid: </B></TD>
		<TD><FONT SIZE=2><B><CFOUTPUT>#LSCurrencyFormat(nextBidMinimum,"local")#</CFOUTPUT></B></FONT></TD></TR>
	<TR BGCOLOR=yellow><TD ALIGN=right>Lot #<CFOUTPUT>#lotID#</CFOUTPUT> &nbsp;</TD>
		<TH>BID ON THIS LOT</TH></TR>
	</TABLE></TD></TR>
	</TABLE></TD></TR>
	</TABLE>
	<P>
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
	<TR><TD BGCOLOR="#20A491"><FONT SIZE=4><B>&nbsp;Description</B></FONT></TD></TR>
	<TR><TD><BR>
	<CFIF FileExists("#systemPath#\archive\#lotID#LotDescription.cfm") EQ "YES">
		<CFINCLUDE TEMPLATE="../archive/#lotID#LotDescription.cfm">
	<CFELSE>
		<H3>Error Occurred - The lot description file is not available.</H3>
	</CFIF>
	</TD></TR></TABLE>
	</HTML></BODY><CFABORT>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Unarchive</B></FONT>
<P>To unarchive the lot(s), check the checkbox next to that lot ID and then click the &quot;Unarchive Lots&quot; button at the bottom of the screen. To delete the lot(s), check the checkbox for the lot, check the checkbox at the bottom of the screen indicating it is ok to delete, and then click the &quot;Delete Lots&quot; button. To view the lot, click the lot ID link. <FONT SIZE=2>(Please do not try to unarchive or delete more than 5 lots at a time to avoid the system from timing out.)</FONT>

<CFDIRECTORY ACTION=List DIRECTORY="#systemPath#\archive" NAME="getArchivedLots" SORT="name ASC">
<CFIF getArchivedLots.RecordCount LTE 3>
	<H3>There are no archived lots at this time.</H3>
	</BODY></HTML><CFABORT>
</CFIF>

<CFSET lotinfoLength = 11>
<CFSET lotbidLength = 10>
<CFSET rowBG = 0>

<FORM METHOD=post ACTION=unarchive.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
<TH BGCOLOR="#20A491">?</TH>
<TH BGCOLOR="#20A491"><FONT SIZE=2>ID</FONT></TH>
<TH BGCOLOR="#20A491" ALIGN=left>Lot Name</TH>
<TH BGCOLOR="#20A491" ALIGN=left><FONT SIZE=2>Date Archived</FONT></TH>

<CFLOOP QUERY=getArchivedLots>
	<CFIF Find("LotBid.cfm",name,1) NEQ 0>
		<CFSET lotID = Left(name,Evaluate(Len(name) - 10))>
		<CFINCLUDE TEMPLATE="../archive/#lotID#LotBid.cfm">
		<CFIF rowBG EQ 0><TR><CFSET rowBG = 1>
			<CFELSE><TR BGCOLOR="#CDCDCD"><CFSET rowBG = 0></CFIF>
		<TD ALIGN=center><CFOUTPUT><INPUT TYPE=checkbox NAME=lotID VALUE=#lotID#></CFOUTPUT></TD>
		<TD ALIGN=right><CFOUTPUT><FONT SIZE=2><A HREF="unarchive.cfm?lotID=#lotID#">#lotID#</A>.</FONT></CFOUTPUT></TD>
		<TD><CFOUTPUT><FONT SIZE=2>#lotName#</FONT></CFOUTPUT></TD>
		<CFIF IsDefined("dateArchived")>
			<CFIF dateArchived NEQ "previousLot">
				<TD VALIGN=top><CFOUTPUT><FONT SIZE=2>#LSDateFormat(dateArchived, "mmm-dd-yyyy")#</FONT></CFOUTPUT></TD>
				<CFSET dateArchived = "previousLot">
			<CFELSE><TD>&nbsp;</TD>
			</CFIF>
		<CFELSE><TD>&nbsp;</TD>
		</CFIF>
		</TR>
	</CFIF>
</CFLOOP>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=5 CELLPADDING=5><TR>
<TD VALIGN=top BGCOLOR="#20A491"><INPUT TYPE=submit NAME=button VALUE="Unarchive Lots"></TD>
<TD VALIGN=top BGCOLOR="#DCDCDC"><INPUT TYPE=submit NAME=button VALUE="Delete Lots"><BR>
	<INPUT TYPE=checkbox NAME=okDelete VALUE=1> Must be checked to delete lots.</TD>
</TR></TABLE>
</FORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>