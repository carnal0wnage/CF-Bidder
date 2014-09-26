<!--- Emaze Auction version 2.1, 1.02 / Sunday, July 18, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Admin Screens</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<H1 ALIGN=center><FONT COLOR=purple>
<CFOUTPUT><IMG ALIGN=left SRC="#systemURL#/images/emazeauction.gif"></CFOUTPUT>
Emaze Auction: Admin Screens</FONT></H1>

<CFSET IamTheMainAdmin = 1>
<CFINCLUDE TEMPLATE="../program/closeCheck.cfm">

<CFQUERY NAME=getNumOpenLots DATASOURCE="#EAdatasource#">
	SELECT Count(lotID) AS openLotCount
	FROM Lot
	WHERE lotCloseQueue = 1 AND lotOpenDateTime <= #CreateODBCDateTime(Now())#
</CFQUERY>

<CFQUERY NAME=getCloseQueue DATASOURCE="#EAdatasource#">
	SELECT Count(lotID) AS closeQueue
	FROM Lot
	WHERE lotCloseQueue = 2
</CFQUERY>

<CENTER>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2>
	<TR><TD BGCOLOR="#FFFFCE" ALIGN=center><FONT SIZE=2># currently open lots: </FONT></TD>
	<TD BGCOLOR="#FFFFCE" ALIGN=center><CFOUTPUT><B>#getNumOpenLots.openLotCount#</B></CFOUTPUT></TD>
	<TD BGCOLOR="#99CCCC" ALIGN=center ROWSPAN=2><FONT SIZE=2>
	<CFIF getCloseQueue.closeQueue EQ 0>(No lots to close at this time)
	<CFELSE><A HREF="lotClose.cfm">Click here to close lots</A></CFIF>
	</FONT></TD></TR>
	<TR><TD BGCOLOR="#FFFFCE" ALIGN=center><FONT SIZE=2># lots waiting to be closed: </FONT></TD>
	<TD BGCOLOR="#FFFFCE" ALIGN=center><CFOUTPUT><B>#getCloseQueue.closeQueue#</B></CFOUTPUT></TD></TR>

<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
	<CFQUERY NAME=getApprovalLots DATASOURCE="#EAdatasource#">
		SELECT Count(lotID) AS countApprovalLots
		FROM Lot
		WHERE lotCloseQueue < 0 AND lotType = 1
	</CFQUERY>
	<TR><TD BGCOLOR="#99CCCC" ALIGN=center><FONT SIZE=2># seller-created lots<BR>waiting to be approved: </FONT></TD>
	<TD BGCOLOR="#99CCCC" ALIGN=center><CFOUTPUT><B>#getApprovalLots.countApprovalLots#</B></CFOUTPUT></TD>
	<TD BGCOLOR="#FFFFCE" ALIGN=center><FONT SIZE=2>
	<CFIF getApprovalLots.countApprovalLots GT 0><A HREF="sellerApproval.cfm">Click here to approve<BR>seller-created lots</A>.
	<CFELSE>(No seller-created lots<BR>to approve at this time.)</CFIF>
	</FONT></TD></TR>
	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
		<CFQUERY NAME=getApprovalLots DATASOURCE="#EAdatasource#">
			SELECT Count(lotID) AS countApprovalLots
			FROM Lot
			WHERE lotCloseQueue < 0 AND lotType = 0
		</CFQUERY>
		<TR><TD BGCOLOR="#FFFFCE" ALIGN=center><FONT SIZE=2># seller-created classified<BR>items waiting to be approved: </FONT></TD>
		<TD BGCOLOR="#FFFFCE" ALIGN=center><CFOUTPUT><B>#getApprovalLots.countApprovalLots#</B></CFOUTPUT></TD>
		<TD BGCOLOR="#99CCCC" ALIGN=center><FONT SIZE=2>
		<CFIF getApprovalLots.countApprovalLots GT 0><A HREF="marketApproval.cfm">Click here to approve<BR>seller-created classified items</A>.
		<CFELSE>No seller-created classified<BR>items to approve at this time.</CFIF>
		</FONT></TD></TR>
	</CFIF>
	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<CFQUERY NAME=getApprovalLots DATASOURCE="#EAdatasource#">
			SELECT Count(lotID) AS countApprovalLots
			FROM Lot
			WHERE lotCloseQueue < 0 AND lotType = -1
		</CFQUERY>
		<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")><CFSET bgcolorLeft = "99CCCC"><CFSET bgcolorRight = "FFFFCE">
		<CFELSE><CFSET bgcolorLeft = "FFFFCE"><CFSET bgcolorRight = "99CCCC"></CFIF>
		<CFOUTPUT><TR><TD BGCOLOR="#bgcolorLeft#" ALIGN=center><FONT SIZE=2>## seller-created procure<BR>items waiting to be approved: </FONT></TD>
		<TD BGCOLOR="#bgcolorLeft#" ALIGN=center><B>#getApprovalLots.countApprovalLots#</B></TD>
		<TD BGCOLOR="#bgcolorRight#" ALIGN=center></CFOUTPUT><FONT SIZE=2>
		<CFIF getApprovalLots.countApprovalLots GT 0><A HREF="procureApproval.cfm">Click here to approve<BR>seller-created procure items</A>.
		<CFELSE>No procurement items<BR>to approve at this time.</CFIF>
		</FONT></TD></TR>
	</CFIF>
</CFIF>

</TABLE>
</CENTER>

<P>

<TABLE BORDER=1 CELLSPACING=4 CELLPADDING=2>
<TR><TH BGCOLOR=FFFFCE><FONT SIZE=4>Users</FONT></TH>
	<TH BGCOLOR=DCDCDC><FONT SIZE=4>Options</FONT></TH>
	<TH BGCOLOR=C6E2FF COLSPAN=2><FONT SIZE=4>System</FONT></TH></TR>
<TR>
<TD VALIGN=top>
	<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
	<TR BGCOLOR=FFFFCE><TD ALIGN=center><FONT SIZE=2><A HREF=userAgree.cfm>User Agreement</A></FONT></TD></TR>
	<TR BGCOLOR=FFFFCE><TD ALIGN=center><FONT SIZE=2><A HREF=emailsRegister.cfm>Registration Emails</A></FONT></TD></TR>
	<TR BGCOLOR=FFFFCE><TD ALIGN=center><FONT SIZE=2><A HREF=userFields.cfm>Registration Fields</A></FONT></TD></TR>
	<TR BGCOLOR=FFFFCE><TD ALIGN=center><FONT SIZE=2><A HREF=userErrors.cfm>Registration Error Messages</A></FONT></TD></TR>
	<TR BGCOLOR=FFFFCE><TD ALIGN=center><FONT SIZE=2><A HREF=userHeaders.cfm>Add/Edit/Verify Headers</A></FONT></TD></TR>
	<TR BGCOLOR=FFFFCE><TD ALIGN=center><FONT SIZE=2><A HREF=optionsGetPassword.cfm>Get Password Script</A></FONT></TD></TR>
	<TR BGCOLOR=FFFFCE><TD ALIGN=center><FONT SIZE=2><A HREF="userCreate.cfm?userID=1">Edit Master User</A></FONT></TD></TR>
	<TR BGCOLOR=FFFFCE><TD ALIGN=center><FONT SIZE=2><A HREF=userImport.cfm>Import Users</A></FONT></TD></TR>
	</TABLE></TD>
<TD VALIGN=top>
	<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
	<TR BGCOLOR=DCDCDC><TD ALIGN=center><FONT SIZE=2><A HREF=optionsLot.cfm>Create Lot Options</A></FONT></TD></TR>
	<TR BGCOLOR=DCDCDC><TD ALIGN=center><FONT SIZE=2><A HREF=optionsClose.cfm>Closing Options</A></FONT></TD></TR>
	<TR BGCOLOR=DCDCDC><TD ALIGN=center><FONT SIZE=2><A HREF=optionsBid.cfm>Bid Options</A></FONT></TD></TR>
	<TR BGCOLOR=DCDCDC><TD ALIGN=center><FONT SIZE=2><A HREF=optionsSearch.cfm>Search Options</A></FONT></TD></TR>
	<TR BGCOLOR=DCDCDC><TD ALIGN=center><FONT SIZE=2><A HREF=optionsReverse.cfm>Reverse Bids</A></FONT></TD></TR>
	<TR BGCOLOR=DCDCDC><TD ALIGN=center><FONT SIZE=2><A HREF=optionsIcons.cfm>Icon Options</A></FONT></TD></TR>
	<TR BGCOLOR=DCDCDC><TD ALIGN=center><FONT SIZE=2><A HREF=optionsEmailOtherUser.cfm>Email Another User</A></FONT></TD></TR>
	<TR BGCOLOR=DCDCDC><TD ALIGN=center NOWRAP><FONT SIZE=2><A HREF=optionsMailAuction.cfm>Mail Auction to Friend</A></FONT></TD></TR>
	</TABLE></TD>
<TD VALIGN=top>
	<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=categoryCreate.cfm>Create Category</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=templateHome.cfm>Templates</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=navigation.cfm>Navigation Bar</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=titles.cfm>Page Titles</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=helpEdit.cfm>Help Page</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=allPageHeaderFooter.cfm>Header, Footer</A> (all pages)</FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=login.cfm>Login Text, Header</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=listStatusMessages.cfm>List, Status Messages</A></FONT></TD></TR>
	</TABLE></TD>
<TD VALIGN=top>
	<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=emailsBidding.cfm>Bidding Emails</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=emailsClosing.cfm>Closing Emails</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=emailsDailyStatus.cfm><I>Daily</I> Status Emails</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=emailsReserve.cfm>Reserve Emails</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=bidErrorMessages.cfm>Bid Error Messages</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=system.cfm>System Variables</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2><A HREF=bodytagEdit.cfm>Body tag, date/time</A></FONT></TD></TR>
	<TR BGCOLOR=C6E2FF><TD ALIGN=center><FONT SIZE=2>Lot Archive <!--- <A HREF=unarchive.cfm>Unarchive Lots</A> ---></FONT></TD></TR>
	</TABLE></TD>
</TR>

<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
	<TR><TD COLSPAN=4>
		<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=0 WIDTH=100%><TR ALIGN=center>
		<TH BGCOLOR=lime ROWSPAN=2><FONT SIZE=4>Sellers</FONT></TH>
		<TD><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2 WIDTH=100%><TR BGCOLOR=lime ALIGN=center>
			<TD><FONT SIZE=2><A HREF=sellerOptions.cfm>Options</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerOptionsFees.cfm>Fees</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerOptionsCreate.cfm>Create Lot</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerOptionsEdit.cfm>Edit Lot</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerOptionsBids.cfm>View Bids</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerTitles.cfm>Page Titles</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerEmails.cfm>Emails</A></FONT></TD>
			</TR></TABLE>
		</TD></TR>
		<TR>
		<TD><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2 WIDTH=100%><TR BGCOLOR=lime ALIGN=center>
			<TD><FONT SIZE=2><A HREF=sellerCharge.cfm>Charge</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerHeaders.cfm>Headers</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerUserFields.cfm>Registration Fields</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerUserHeaders.cfm>Registration Headers</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerUserAgree.cfm>User Agreement</A></FONT></TD>
			<TD><FONT SIZE=2><A HREF=sellerEmailsDailyStatus.cfm><I>Daily</I> Status</A></FONT></TD>
			</TR></TABLE>
		</TD></TR>
		</TABLE>
	</TD></TR>

	<CFIF FileExists("#systemPath#\admin\marketHeaders.cfm")>
		<TR><TD COLSPAN=4>
			<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=0 WIDTH=100%>
			<TR><TH ROWSPAN=2 BGCOLOR=lavender><FONT SIZE=4>Classified</FONT></TH>
			<TD><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2 WIDTH=100%><TR BGCOLOR=lavender ALIGN=center>
				<TD><FONT SIZE=2><A HREF=marketOptions.cfm>Options</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=marketOptionsFees.cfm>Fees</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=marketOptionsCreate.cfm>Create Item</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=marketOptionsEdit.cfm>Edit Item</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=marketOptionsBuyers.cfm>View Buyers</A></FONT></TD>
				</TR></TABLE>
			</TD></TR>
			<TR><TD><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2 WIDTH=100%><TR BGCOLOR=lavender ALIGN=center>
				<TD><FONT SIZE=2><A HREF=marketEmails.cfm>Emails</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=marketOptionsBuyForm.cfm>Buying</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=marketBuyErrorMessages.cfm>Buy Error Messages</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=marketHeaders.cfm>Headers</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=marketTitles.cfm>Page Titles</A></FONT></TD>
				</TR></TABLE>
			</TD></TABLE>
		</TD></TR>
	</CFIF>

	<CFIF FileExists("#systemPath#\admin\procureHeaders.cfm")>
		<TR><TD COLSPAN=4>
			<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=0 WIDTH=100%>
			<TR><TH ROWSPAN=2 BGCOLOR=beige><FONT SIZE=4>Procurement</FONT></TH>
			<TD><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2 WIDTH=100%><TR BGCOLOR=beige ALIGN=center>
				<TD><FONT SIZE=2><A HREF=procureOptions.cfm>Options</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureOptionsFees.cfm>Seller/Buyer Fees</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureOptionsFeesBidder.cfm>Bidder Fees</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureOptionsCreate.cfm>Create Item</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureOptionsEdit.cfm>Edit Item</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureOptionsBids.cfm>View Bidders</A></FONT></TD>
				</TR></TABLE>
			</TD></TR>
			<TR><TD><TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2 WIDTH=100%><TR BGCOLOR=beige ALIGN=center>
				<TD><FONT SIZE=2><A HREF=procureEmails.cfm>Seller Emails</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureEmailsBidding.cfm>Bidding Emails</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureEmailsClosing.cfm>Closing Emails</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureBidResult.cfm>Bid Results</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureHeaders.cfm>Headers</A></FONT></TD>
				<TD><FONT SIZE=2><A HREF=procureTitles.cfm>Page Titles</A></FONT></TD>
				</TR></TABLE>
			</TD></TABLE>
		</TD></TR>
	</CFIF>
</CFIF>

<CFIF FileExists("#systemPath#\admin\forumHeaders.cfm")>
	<TR><TD COLSPAN=4>
		<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=0 WIDTH=100%><TR ALIGN=center BGCOLOR=orange>
		<TH><FONT SIZE=4>Forums</FONT></TH>
		<TD><FONT SIZE=2><A HREF=forumCreate.cfm>Create Forum</A></FONT></TD>
		<TD><FONT SIZE=2><A HREF=forumEdit.cfm>Edit/Delete Forum</A></FONT></TD>
		<TD><FONT SIZE=2><A HREF=forumText.cfm>Options/Text</A></FONT></TD>
		<TD><FONT SIZE=2><A HREF=forumHeaders.cfm>Homepage</A></FONT></TD>
		<TD><FONT SIZE=2><A HREF=forumAdmin.cfm>Admin Permissions</A></FONT></TD>
		</TR></TABLE>
	</TD></TR>
</CFIF>

</TABLE>
<P>

<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>
	<CFFORM ACTION=lotMenu.cfm NAME=lotMenuSeller>
	Seller username: <INPUT TYPE=text NAME=username SIZE=15> <INPUT TYPE=submit NAME=lotMenuButton VALUE="Get seller lots">
	</CFFORM>
</CFIF>

<CFFORM ACTION=lotMenu.cfm NAME=lotMenu>
Lot ID: <INPUT TYPE=text NAME=lotID SIZE=8> <INPUT TYPE=submit NAME=lotMenuButton VALUE="Get lot"> (1 or 1,2,3)
</CFFORM>

<CFFORM ACTION=userEdit.cfm NAME=userMenu>
<INPUT TYPE=hidden NAME=orderSearch VALUE=username>
User: <INPUT TYPE=text NAME=userInfo SIZE=20> <INPUT TYPE=submit NAME=button VALUE="Get User"><BR>
<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2><TR BGCOLOR=DCDCDC>
<TD><INPUT TYPE=radio NAME=searchUser VALUE=username CHECKED> Username</TD>
<TD><INPUT TYPE=radio NAME=searchUser VALUE=email> Email</TD>
<TD><INPUT TYPE=radio NAME=searchUser VALUE=firstName> First name</TD>
<TD><INPUT TYPE=radio NAME=searchUser VALUE=lastName> Last name</TD>
<TD><INPUT TYPE=radio NAME=searchUser VALUE=organization>Organization</TD>
</TR></TABLE>
</CFFORM>

<CFSET yesterday = DateAdd("d",-1,Now())>
<CFSET tomorrow = DateAdd("d",1,Now())>

<CFOUTPUT>
<TABLE BORDER=1 CELLSPACING=3 CELLPADDING=2>
<TR><TD><A HREF="categoryRedirect.cfm?&searchOpenMM=#Month(Now())#&searchOpenDD=#Day(Now())#&searchOpenYYYY=#Year(Now())#&searchOpenHH=ALL&searchOpen=at">Lots opening today</A> 
	(<A HREF="categoryRedirect.cfm?&searchOpenMM=#Month(yesterday)#&searchOpenDD=#Day(yesterday)#&searchOpenYYYY=#Year(yesterday)#&searchOpenHH=ALL&searchOpen=at">yesterday</A>) 
	(<A HREF="categoryRedirect.cfm?&searchOpenMM=#Month(tomorrow)#&searchOpenDD=#Day(tomorrow)#&searchOpenYYYY=#Year(tomorrow)#&searchOpenHH=ALL&searchOpen=at">tomorrow</A>)</TD></TR>
<TR BGCOLOR=DCDCDC><TD><A HREF="categoryRedirect.cfm?&searchCloseMM=#Month(Now())#&searchCloseDD=#Day(Now())#&searchCloseYYYY=#Year(Now())#&searchCloseHH=ALL&searchClose=at">Lots closing today</A> 
	(<A HREF="categoryRedirect.cfm?&searchCloseMM=#Month(yesterday)#&searchCloseDD=#Day(yesterday)#&searchCloseYYYY=#Year(yesterday)#&searchCloseHH=ALL&searchClose=at">yesterday</A>) 
	(<A HREF="categoryRedirect.cfm?&searchCloseMM=#Month(tomorrow)#&searchCloseDD=#Day(tomorrow)#&searchCloseYYYY=#Year(tomorrow)#&searchCloseHH=ALL&searchClose=at">tomorrow</A>)</TD></TR>
<TR><TD><A HREF="categoryRedirect.cfm?lotStatus=Open">Lots currently open</A></TD></TR>
<TR><TD></TD></TR>
<TR><TD><A HREF="categoryRedirect.cfm?bidWin=1&bidOrderBy=name&bidOrderDirection=ASC&lotStatus=Open">Winning bids on all open lots</A></TD></TR>
<TR BGCOLOR=DCDCDC><TD><A HREF="categoryRedirect.cfm?bidWin=1&bidOrderBy=name&bidOrderDirection=ASC&searchCloseMM=#Month(Now())#&searchCloseDD=#Day(Now())#&searchCloseYYYY=#Year(Now())#&searchCloseHH=ALL&searchClose=at">Winning bids on all lots closing today</A> 
	(<A HREF="categoryRedirect.cfm?bidWin=1&bidOrderBy=name&bidOrderDirection=ASC&searchCloseMM=#Month(yesterday)#&searchCloseDD=#Day(yesterday)#&searchCloseYYYY=#Year(yesterday)#&searchCloseHH=ALL&searchClose=at">yesterday</A>) 
	(<A HREF="categoryRedirect.cfm?bidWin=1&bidOrderBy=name&bidOrderDirection=ASC&searchCloseMM=#Month(tomorrow)#&searchCloseDD=#Day(tomorrow)#&searchCloseYYYY=#Year(tomorrow)#&searchCloseHH=ALL&searchClose=at">tomorrow</A>)</TD></TR>
</TABLE>
</CFOUTPUT>

<CFFORM NAME=deleteAll ACTION=lotsDelete.cfm?RequestTimeOut=500>
<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2><TR><TD>
Delete lots that have been closed for more than X days:<BR>
# Days: <CFINPUT TYPE=text NAME=closeDays SIZE=4 REQUIRED=Yes VALIDATE=integer MESSAGE="You must enter the number of days"> <INPUT TYPE=submit VALUE="Delete Lots"><BR>
&nbsp; &nbsp; Enter <I>YES</I> in this text field to verify your request: <CFINPUT TYPE=text NAME=okDelete SIZE=3 REQUIRED=Yes MESSAGE="You must type YES to verify you want to delete the lots">
</TD></TR></TABLE>
</CFFORM>

<P>

<P>Choosing to view lots will list all options for that lot. Choosing bids will list the bids for those lots instead.<P>

<CFFORM ACTION=categoryRedirect.cfm NAME=viewLotMenu>
<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2>
<TR BGCOLOR="#DCDCDC"><TD ROWSPAN=2 VALIGN=top ALIGN=right>Lot Status: </TD>
<TD><INPUT TYPE=checkbox NAME=lotStatus VALUE=Inactive> Inactive &nbsp;
	<INPUT TYPE=checkbox NAME=lotStatus VALUE=Preview> Preview &nbsp; 
	<INPUT TYPE=checkbox NAME=lotStatus VALUE=Open CHECKED> Open &nbsp; 
	<INPUT TYPE=checkbox NAME=lotStatus VALUE=Closed> Closed &nbsp; 
	<!--- <INPUT TYPE=checkbox NAME=lotStatus VALUE=archived> Archived --->
<TR BGCOLOR="#DCDCDC"><TD><FONT FACE=Arial COLOR=purple>Order by:</FONT> 
<SELECT NAME=lotOrderBy SIZE=1>
	<OPTION VALUE="lotOpenDateTime">Lot Opening Time
	<OPTION VALUE="lotCloseDateTime">Lot Closing Time
	<OPTION VALUE="lotName">Lot Name
	<OPTION VALUE="lotID">Lot ID
	<OPTION VALUE="lotBidCount">Number of Bids
</SELECT> <INPUT TYPE=radio NAME=lotOrderDirection VALUE=ASC CHECKED> Ascending &nbsp;
	<INPUT TYPE=radio NAME=lotOrderDirection VALUE=DESC> Descending 
	</TD></TR>

<TR BGCOLOR="#CDCDCD"><TD ROWSPAN=2 VALIGN=top ALIGN=right>View Bids: </TD>
	<TD><INPUT TYPE=radio NAME=bidWin VALUE=1> Winning Bids Only &nbsp; 
	<INPUT TYPE=radio NAME=bidWin VALUE=0> All Bids</TD>
<TR BGCOLOR="#CDCDCD"><TD><FONT FACE=Arial COLOR=purple>Order by:</FONT> 
<SELECT NAME=bidOrderBy SIZE=1>
	<OPTION VALUE="name">Bidder name
	<OPTION VALUE="username">Bidder username
	<OPTION VALUE="bidDateTime">Bid date/time
	<OPTION VALUE="bidPrice">Current bid
	<OPTION VALUE="bidPriceInitial">Initial Bid
	<OPTION VALUE="bidPriceMaximum">Maximum Bid
	<OPTION VALUE="bidQuantity">Bid Quantity
	<OPTION VALUE="bidQuantityWin">Quantity Won
</SELECT> <INPUT TYPE=radio NAME=bidOrderDirection VALUE=ASC CHECKED> Ascending &nbsp;
	<INPUT TYPE=radio NAME=bidOrderDirection VALUE=DESC> Descending 
	</TD></TR>

<TR BGCOLOR="#DCDCDC" VALIGN=top><TD ALIGN=right>Lot Opens: </TD><TD>&nbsp;
<SELECT NAME=searchOpenMM SIZE=1>
	<OPTION VALUE=01<CFIF Month(Now()) EQ 1> SELECTED</CFIF>>January
	<OPTION VALUE=02<CFIF Month(Now()) EQ 2> SELECTED</CFIF>>February
	<OPTION VALUE=03<CFIF Month(Now()) EQ 3> SELECTED</CFIF>>March
	<OPTION VALUE=04<CFIF Month(Now()) EQ 4> SELECTED</CFIF>>April
	<OPTION VALUE=05<CFIF Month(Now()) EQ 5> SELECTED</CFIF>>May
	<OPTION VALUE=06<CFIF Month(Now()) EQ 6> SELECTED</CFIF>>June
	<OPTION VALUE=07<CFIF Month(Now()) EQ 7> SELECTED</CFIF>>July
	<OPTION VALUE=08<CFIF Month(Now()) EQ 8> SELECTED</CFIF>>August
	<OPTION VALUE=09<CFIF Month(Now()) EQ 9> SELECTED</CFIF>>September
	<OPTION VALUE=10<CFIF Month(Now()) EQ 10> SELECTED</CFIF>>October
	<OPTION VALUE=11<CFIF Month(Now()) EQ 11> SELECTED</CFIF>>November
	<OPTION VALUE=12<CFIF Month(Now()) EQ 12> SELECTED</CFIF>>December
</SELECT> 
<SELECT NAME=searchOpenDD SIZE=1>
	<OPTION VALUE=1<CFIF Day(Now()) EQ 1> SELECTED</CFIF>>1<OPTION VALUE=2<CFIF Day(Now()) EQ 2> SELECTED</CFIF>>2
	<OPTION VALUE=3<CFIF Day(Now()) EQ 3> SELECTED</CFIF>>3<OPTION VALUE=4<CFIF Day(Now()) EQ 4> SELECTED</CFIF>>4
	<OPTION VALUE=5<CFIF Day(Now()) EQ 5> SELECTED</CFIF>>5<OPTION VALUE=6<CFIF Day(Now()) EQ 6> SELECTED</CFIF>>6
	<OPTION VALUE=7<CFIF Day(Now()) EQ 7> SELECTED</CFIF>>7<OPTION VALUE=8<CFIF Day(Now()) EQ 8> SELECTED</CFIF>>8
	<OPTION VALUE=9<CFIF Day(Now()) EQ 9> SELECTED</CFIF>>9<OPTION VALUE=10<CFIF Day(Now()) EQ 10> SELECTED</CFIF>>10
	<OPTION VALUE=11<CFIF Day(Now()) EQ 11> SELECTED</CFIF>>11<OPTION VALUE=12<CFIF Day(Now()) EQ 12> SELECTED</CFIF>>12
	<OPTION VALUE=13<CFIF Day(Now()) EQ 13> SELECTED</CFIF>>13<OPTION VALUE=14<CFIF Day(Now()) EQ 14> SELECTED</CFIF>>14
	<OPTION VALUE=15<CFIF Day(Now()) EQ 15> SELECTED</CFIF>>15<OPTION VALUE=16<CFIF Day(Now()) EQ 16> SELECTED</CFIF>>16
	<OPTION VALUE=17<CFIF Day(Now()) EQ 17> SELECTED</CFIF>>17<OPTION VALUE=18<CFIF Day(Now()) EQ 18> SELECTED</CFIF>>18
	<OPTION VALUE=19<CFIF Day(Now()) EQ 19> SELECTED</CFIF>>19<OPTION VALUE=20<CFIF Day(Now()) EQ 20> SELECTED</CFIF>>20
	<OPTION VALUE=21<CFIF Day(Now()) EQ 21> SELECTED</CFIF>>21<OPTION VALUE=22<CFIF Day(Now()) EQ 22> SELECTED</CFIF>>22
	<OPTION VALUE=23<CFIF Day(Now()) EQ 23> SELECTED</CFIF>>23<OPTION VALUE=24<CFIF Day(Now()) EQ 24> SELECTED</CFIF>>24
	<OPTION VALUE=25<CFIF Day(Now()) EQ 25> SELECTED</CFIF>>25<OPTION VALUE=26<CFIF Day(Now()) EQ 26> SELECTED</CFIF>>26
	<OPTION VALUE=27<CFIF Day(Now()) EQ 27> SELECTED</CFIF>>27<OPTION VALUE=28<CFIF Day(Now()) EQ 28> SELECTED</CFIF>>28
	<OPTION VALUE=29<CFIF Day(Now()) EQ 29> SELECTED</CFIF>>29<OPTION VALUE=30<CFIF Day(Now()) EQ 30> SELECTED</CFIF>>30
	<OPTION VALUE=31<CFIF Day(Now()) EQ 31> SELECTED</CFIF>>31
</SELECT> 
<SELECT NAME=searchOpenYYYY SIZE=1>
	<OPTION VALUE=1999<CFIF Year(Now()) EQ 1999> SELECTED</CFIF>>1999
	<OPTION VALUE=2000<CFIF Year(Now()) EQ 2000> SELECTED</CFIF>>2000
	<OPTION VALUE=2001<CFIF Year(Now()) EQ 2001> SELECTED</CFIF>>2001
</SELECT> 
<SELECT NAME=searchOpenHH SIZE=1>
	<OPTION VALUE=ALL>ALL DAY
	<OPTION VALUE=00>12:00 am<OPTION VALUE=01>01:00 am<OPTION VALUE=02>02:00 am
	<OPTION VALUE=03>03:00 am<OPTION VALUE=04>04:00 am<OPTION VALUE=05>05:00 am
	<OPTION VALUE=06>06:00 am<OPTION VALUE=07>07:00 am<OPTION VALUE=08>08:00 am
	<OPTION VALUE=09>09:00 am<OPTION VALUE=10>10:00 am<OPTION VALUE=11>11:00 am
	<OPTION VALUE=12>12:00 pm<OPTION VALUE=13>01:00 pm<OPTION VALUE=14>02:00 pm
	<OPTION VALUE=15>03:00 pm<OPTION VALUE=16>04:00 pm<OPTION VALUE=17>05:00 pm
	<OPTION VALUE=18>06:00 pm<OPTION VALUE=19>07:00 pm<OPTION VALUE=20>08:00 pm
	<OPTION VALUE=21>09:00 pm<OPTION VALUE=22>10:00 pm<OPTION VALUE=23>11:00 pm
</SELECT>
<BR>&nbsp;<FONT SIZE=2>
<INPUT TYPE=checkbox NAME=searchOpen VALUE=before> Before &nbsp; 
<INPUT TYPE=checkbox NAME=searchOpen VALUE=at> On &nbsp; 
<INPUT TYPE=checkbox NAME=searchOpen VALUE=after> After
</FONT></TD></TR>

<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Lot Closes: </TD><TD>&nbsp;
<SELECT NAME=searchCloseMM SIZE=1>
	<OPTION VALUE=01<CFIF Month(Now()) EQ 1> SELECTED</CFIF>>January
	<OPTION VALUE=02<CFIF Month(Now()) EQ 2> SELECTED</CFIF>>February
	<OPTION VALUE=03<CFIF Month(Now()) EQ 3> SELECTED</CFIF>>March
	<OPTION VALUE=04<CFIF Month(Now()) EQ 4> SELECTED</CFIF>>April
	<OPTION VALUE=05<CFIF Month(Now()) EQ 5> SELECTED</CFIF>>May
	<OPTION VALUE=06<CFIF Month(Now()) EQ 6> SELECTED</CFIF>>June
	<OPTION VALUE=07<CFIF Month(Now()) EQ 7> SELECTED</CFIF>>July
	<OPTION VALUE=08<CFIF Month(Now()) EQ 8> SELECTED</CFIF>>August
	<OPTION VALUE=09<CFIF Month(Now()) EQ 9> SELECTED</CFIF>>September
	<OPTION VALUE=10<CFIF Month(Now()) EQ 10> SELECTED</CFIF>>October
	<OPTION VALUE=11<CFIF Month(Now()) EQ 11> SELECTED</CFIF>>November
	<OPTION VALUE=12<CFIF Month(Now()) EQ 12> SELECTED</CFIF>>December
</SELECT> 
<SELECT NAME=searchCloseDD SIZE=1>
	<OPTION VALUE=1<CFIF Day(Now()) EQ 1> SELECTED</CFIF>>1<OPTION VALUE=2<CFIF Day(Now()) EQ 2> SELECTED</CFIF>>2
	<OPTION VALUE=3<CFIF Day(Now()) EQ 3> SELECTED</CFIF>>3<OPTION VALUE=4<CFIF Day(Now()) EQ 4> SELECTED</CFIF>>4
	<OPTION VALUE=5<CFIF Day(Now()) EQ 5> SELECTED</CFIF>>5<OPTION VALUE=6<CFIF Day(Now()) EQ 6> SELECTED</CFIF>>6
	<OPTION VALUE=7<CFIF Day(Now()) EQ 7> SELECTED</CFIF>>7<OPTION VALUE=8<CFIF Day(Now()) EQ 8> SELECTED</CFIF>>8
	<OPTION VALUE=9<CFIF Day(Now()) EQ 9> SELECTED</CFIF>>9<OPTION VALUE=10<CFIF Day(Now()) EQ 10> SELECTED</CFIF>>10
	<OPTION VALUE=11<CFIF Day(Now()) EQ 11> SELECTED</CFIF>>11<OPTION VALUE=12<CFIF Day(Now()) EQ 12> SELECTED</CFIF>>12
	<OPTION VALUE=13<CFIF Day(Now()) EQ 13> SELECTED</CFIF>>13<OPTION VALUE=14<CFIF Day(Now()) EQ 14> SELECTED</CFIF>>14
	<OPTION VALUE=15<CFIF Day(Now()) EQ 15> SELECTED</CFIF>>15<OPTION VALUE=16<CFIF Day(Now()) EQ 16> SELECTED</CFIF>>16
	<OPTION VALUE=17<CFIF Day(Now()) EQ 17> SELECTED</CFIF>>17<OPTION VALUE=18<CFIF Day(Now()) EQ 18> SELECTED</CFIF>>18
	<OPTION VALUE=19<CFIF Day(Now()) EQ 19> SELECTED</CFIF>>19<OPTION VALUE=20<CFIF Day(Now()) EQ 20> SELECTED</CFIF>>20
	<OPTION VALUE=21<CFIF Day(Now()) EQ 21> SELECTED</CFIF>>21<OPTION VALUE=22<CFIF Day(Now()) EQ 22> SELECTED</CFIF>>22
	<OPTION VALUE=23<CFIF Day(Now()) EQ 23> SELECTED</CFIF>>23<OPTION VALUE=24<CFIF Day(Now()) EQ 24> SELECTED</CFIF>>24
	<OPTION VALUE=25<CFIF Day(Now()) EQ 25> SELECTED</CFIF>>25<OPTION VALUE=26<CFIF Day(Now()) EQ 26> SELECTED</CFIF>>26
	<OPTION VALUE=27<CFIF Day(Now()) EQ 27> SELECTED</CFIF>>27<OPTION VALUE=28<CFIF Day(Now()) EQ 28> SELECTED</CFIF>>28
	<OPTION VALUE=29<CFIF Day(Now()) EQ 29> SELECTED</CFIF>>29<OPTION VALUE=30<CFIF Day(Now()) EQ 30> SELECTED</CFIF>>30
	<OPTION VALUE=31<CFIF Day(Now()) EQ 31> SELECTED</CFIF>>31
</SELECT> 
<SELECT NAME=searchCloseYYYY SIZE=1>
	<OPTION VALUE=1999<CFIF Year(Now()) EQ 1999> SELECTED</CFIF>>1999
	<OPTION VALUE=2000<CFIF Year(Now()) EQ 2000> SELECTED</CFIF>>2000
	<OPTION VALUE=2001<CFIF Year(Now()) EQ 2001> SELECTED</CFIF>>2001
</SELECT> 
<SELECT NAME=searchCloseHH SIZE=1>
	<OPTION VALUE=ALL>ALL DAY
	<OPTION VALUE=00>12:00 am<OPTION VALUE=01>01:00 am<OPTION VALUE=02>02:00 am
	<OPTION VALUE=03>03:00 am<OPTION VALUE=04>04:00 am<OPTION VALUE=05>05:00 am
	<OPTION VALUE=06>06:00 am<OPTION VALUE=07>07:00 am<OPTION VALUE=08>08:00 am
	<OPTION VALUE=09>09:00 am<OPTION VALUE=10>10:00 am<OPTION VALUE=11>11:00 am
	<OPTION VALUE=12>12:00 pm<OPTION VALUE=13>01:00 pm<OPTION VALUE=14>02:00 pm
	<OPTION VALUE=15>03:00 pm<OPTION VALUE=16>04:00 pm<OPTION VALUE=17>05:00 pm
	<OPTION VALUE=18>06:00 pm<OPTION VALUE=19>07:00 pm<OPTION VALUE=20>08:00 pm
	<OPTION VALUE=21>09:00 pm<OPTION VALUE=22>10:00 pm<OPTION VALUE=23>11:00 pm
</SELECT>
<BR>&nbsp;<FONT SIZE=2>
<INPUT TYPE=checkbox NAME=searchClose VALUE=before> Before &nbsp; 
<INPUT TYPE=checkbox NAME=searchClose VALUE=at> On &nbsp; 
<INPUT TYPE=checkbox NAME=searchClose VALUE=after> After
</FONT></TD></TR>

<CFQUERY NAME=getCategory DATASOURCE="#EAdatasource#">
	SELECT categoryID, categoryName
	FROM Category
</CFQUERY>

<TR BGCOLOR="#DCDCDC"><TD ALIGN=right VALIGN=top>Category: </TD><TD>
<SELECT NAME=categoryID SIZE=6 MULTIPLE>
<CFOUTPUT><OPTION VALUE=0 SELECTED>-- SELECT ALL CATEGORIES --</CFOUTPUT>
<CFOUTPUT QUERY=getCategory>
	<OPTION VALUE=#categoryID#>#categoryName#
</CFOUTPUT>
</SELECT>
</TD></TR>
<TR BGCOLOR=purple><TD HEIGHT=40 ALIGN=center><FONT COLOR=yellow FACE=Arial>Emaze!</FONT></TD>
	<TD>&nbsp; <INPUT TYPE=submit NAME=lotMenuButton VALUE="Submit Lot Query"></TD></TR>
</TABLE>
</CFFORM>

<P>
<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>