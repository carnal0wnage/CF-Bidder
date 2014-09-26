<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 ---><HTML>
<HEAD><TITLE>Emaze Auction: Help!</TITLE></HEAD>
<BODY BGCOLOR=white>

<H1><FONT COLOR=purple>Emaze Auction: Help!</FONT></H1>

<TABLE BORDER=0 CELLSPACING=5 CELLPADDING=0><TR>
<TD VALIGN=top><DL>
<DT><B>General Information</B>
<DD><A HREF="#terminology">Terminology</A><BR>
&nbsp; &nbsp; <A HREF="#terms-admin">Admin</A><BR>
&nbsp; &nbsp; <A HREF="#terms-lot">Lot</A><BR>
&nbsp; &nbsp; <A HREF="#terms-category">Category</A><BR>
&nbsp; &nbsp; <A HREF="#terms-auction">Auction home page</A><BR>
&nbsp; &nbsp; <A HREF="#terms-catHome">Category home page</A><BR>
&nbsp; &nbsp; <A HREF="#terms-template">Template</A><BR>
&nbsp; &nbsp; <A HREF="#terms-bidder">Bidder / User</A><BR>
&nbsp; &nbsp; <A HREF="#terms-bid">Bid</A><BR>
&nbsp; &nbsp; <A HREF="#terms-autobid">Auto-Bid</A><BR>
<A HREF="#url">URLs</A><BR>
<A HREF="#users">Users / Bidders</A><BR>
<A HREF="#bids">Bids</A><BR>
<A HREF="#rules">Rules</A><BR>
<A HREF="#autoemails">Automated Emails</A><BR>
<A HREF="#closingLots">Closing lots</A><BR>
<A HREF="#cookies">Use of Cookies</A><BR>
<A HREF="#javascript">Use of JavaScript</A><BR>
<A HREF="files.html">Files</A> <FONT SIZE=2>(separate html file)</FONT><BR>
<A HREF="database.html">Database setup</A> <FONT SIZE=2>(separate html file)</FONT><BR>
<A HREF="#initializing">What to do upon initializing Emaze Auction</A>
<DT><B><A HREF="#userScreens">User Screens</A></B>
<DD><A HREF="#auction">Auction home page</A><BR>
<A HREF="#category">Category home page</A><BR>
<A HREF="#lot">Lot page</A><BR>
<A HREF="#bidding">Bidding</A><BR>
<A HREF="#search">Search</A><BR>
<A HREF="#newBidder">New Bidder</A><BR>
<A HREF="#editBidder">Edit Bidder</A><BR>
<A HREF="#listAllLots">List All Lots</A><BR>
<A HREF="#bidStatus">Bid Status</A>
</DL></TD>
<TD WIDTH=25>&nbsp;</TD>
<TD VALIGN=top><DL>
<DT><B>Admin Screens</B>
<DD><A HREF="#system">System</A><BR>
<A HREF="#bodytag">Body Tag</A><BR>
<A HREF="#homepage">Homepage</A><BR>
<A HREF="#options">Options</A><BR>
<A HREF="#emails">Emails</A><BR>
&nbsp; &nbsp; <A HREF="#reserve">Reserve</A><BR>
<A HREF="#fields">Fields</A><BR>
<A HREF="#headers">Headers</A><BR>
<A HREF="#closeLots">Close Lots</A><BR>
<A HREF="#categoryHome">Category</A><BR>
&nbsp; &nbsp; <A HREF="#categoryCreate">Create</A><BR>
&nbsp; &nbsp; <A HREF="#categoryDelete">Delete</A><BR>
&nbsp; &nbsp; <A HREF="#categoryEdit">Edit</A><BR>
&nbsp; &nbsp; <A HREF="#lotWinnersAll">Win</A><BR>
&nbsp; &nbsp; <A HREF="#categoryLots">Lots</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotView">View</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotEdit">Edit</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotPrivate">Private</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotCopy">Copy</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotBids">Bids</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotWinners">Winners</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotBidOffline">Offline Bid</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotEmailWinners">Email Winners</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotEmailLosers">Email Losers</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotArchive">Archive</A><BR>
&nbsp; &nbsp; &nbsp; &nbsp; <A HREF="#lotDelete">Delete</A><BR>
<A HREF="#lotCreate">Lot</A> (create)<BR>
<A HREF="#templateHome">Template</A><BR>
&nbsp; &nbsp; <A HREF="#templateCreate">Create</A><BR>
&nbsp; &nbsp; <A HREF="#templateEdit">Edit</A><BR>
&nbsp; &nbsp; <A HREF="#templateDelete">Delete</A><BR>
<A HREF="#unarchive">Unarchive</A><BR>
<A HREF="#userHome">User</A><BR>
&nbsp; &nbsp; <A HREF="#userMaster">Master</A><BR>
&nbsp; &nbsp; <A HREF="#userCreate">Create</A><BR>
&nbsp; &nbsp; <A HREF="#userImport">Import</A><BR>
</DL>
</TD></TR></TABLE>

<P><HR NOSHADE COLOR=purple SIZE=3>
<HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="terminology"></A>Terminology</FONT></H2>
<DL>
<DT><A NAME="terms-admin"></A><I>Admin/Master</I>
<DD>User who has access to the admin screens. At this time, the system supports only a single admin user.
<P>
<DT><A NAME="terms-lot"></A><I>Lot</I>
<DD>What is being auctioned off. Can be a single or multiple quantity. If multiple, you can limit the maximum quantity each bidder may win. A lot can be public, meaning all users may bid on it; or private, where users must be given permission to access that lot.
<P>
<DT><A NAME="terms-category"></A><I>Category</I>
<DD>Each lot belongs to a category. Each category may have up to 3 sub-category levels, providing 4 category levels in all, e.g., Computers : PC : Laptop: Accessories. Please note that most of the Lot options are hidden in the Category section. Each lot is part of a category, so to perform lot actions (other than creating new lots) you must begin with the appropriate category.
<P>
<DT><A NAME="terms-auction"></A><I>Auction home page</I>
<DD>Lists all primary categories (e.g., Computers). Our template lists up to 10 lots which open today, and up to 10 which close today. Provides space for a special message or hot deal, and a form for users to edit their information or check the status of all of their bids. Also includes header and footer options.
<P>
<DT><A NAME="terms-catHome"></A><I>Category home page</I>
<DD>Page for that category. Lists all lots in that category. Our template lists open lots and all lots which have closed in the past 7 days. Lists all categories and sub-categories for the category you are in. Provides space for a special message or hot deal, and a form for users to edit their information or check the status of all of their bids. Also includes header and footer options.
<P>
<DT><A NAME="terms-template"></A><I>Template</I>
<DD>Design for how the auction home page, category home page, or lot page is displayed. We include a single template for each type of page. You may customize these templates or create your own. In the future, we will offer additional templates. In the meantime though, you may use our templates as a reference for your own. The templates are not encrypted, so you have full access to the Cold Fusion code.
<P>
<DT><A NAME="terms-bidder"></A><I>Bidder / User</I>
<DD>Must be registered to bid on a lot. For private auctions, bidders must log in to ensure they have permission. You will notice the terms &quot;user&quot; and &quot;bidder&quot; used interchangably. Users and bidders are the same thing. However, we typically use the term <I>user</I> because Emaze Auction was designed to integrate with Emaze Forums, our discussion forum program. This enables you to maintain a single user database for both programs, enabling bidders to easily join a discussion forum on that lot or on other topics.
<P>
<DT><A NAME="terms-bid"></A><I>Bid</I>
<DD>Bidders bids with their initial bid, desired quantity (if more than 1), whether they will accept partial quanlity or full quantity only (if more than 1). They can also use the auto-bid feature, if Admin permits it.
<P>
<DT><A NAME="terms-autobid"></A><I>Auto-bid</I>
<DD>Admin must enable this feature. Allows users to enter the initial bid and their maximum bid. Emaze Auction will automatically increase their bid the necessary amount to ensure they win at least one quantity. If they will accept only the full quantity, it will stop auto-bidding once they can no longer with the full quantity with their maximum bid. Some auction sites automatically do auto-bidding, but we decided against this to allow Admin to deterine whether to allow this. Our method also allows a bidder to choose their initial bid.
</DL>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="url"></A>URLs</FONT></H2>

<TABLE BORDER=1 CELLSPACING=4 CELLPADDING=2>
<TR><TD>Admin screens</TD>
	<TD NOWRAP>http://www.domain.com/EmazeAuction/admin/index.cfm</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD>Auction home page</TD>
	<TD NOWRAP>http://www.domain.com/EmazeAuction/index.cfm</TD></TR>
<TR><TD VALIGN=top ROWSPAN=2>Category home page</TD>
	<TD NOWRAP>http://www.domain.com/EmazeAuction/category.cfm?categoryID=#categoryID#</TD></TR>
	<TR><TD ALIGN=center><FONT COLOR=blue>Where #cateogryID# equals the ID of that category</FONT></TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ROWSPAN=2>Lot</TD>
	<TD NOWRAP>http://www.domain.com/EmazeAuction/lot.cfm?lotID=#lotID#</TD></TR>
	<TR BGCOLOR="#CDCDCD"><TD ALIGN=center><FONT COLOR=blue>Where #lotID# equals the ID of that lot</FONT></TD></TR>
</TABLE>

<P>

<TABLE BORDER=1 CELLSPACING=4 CELLPADDING=2>
<TH COLSPAN=2 BGCOLOR="#20A491">Other URLs for bidders</TH>
<TR><TD>New Bidder</TD><TD>http://www.domain.com/program/user.cfm</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD>Edit bidder</TD><TD>http://www.domain.com/program/editUser.cfm</TD></TR>
<TR><TD>Help</TD><TD>http://www.domain.com/program/help.cfm</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD>List all lots</TD><TD>http://www.domain.com/program/list.cfm</TD></TR>
<TR><TD>Bid status</TD><TD>http://www.domain.com/program/status.cfm</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD ROWSPAN=2 VALIGN=top>Bid form</TD>
	<TD>http://www.domain.com/program/bidForm.cfm</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD><FONT COLOR=blue>URL to include the bid form for each lot. Necessary when creating<BR>new templates or making the bid form a separate page.</FONT></TD></TR>
</TABLE>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="users"></A>Users / Bidders</FONT></H2>

To be able to bid on a lot, a user must first register. This means choosing a username and password. Emaze Auction provides a bunch of user fields which you can choose whether each user must complete. All fields are optional, with the exception of username and password. Optional fields include email address, first name, last name, organization, phone number, and the typical  address fields.
<P>
Some auction sites use the email address as the username. You are welcome to do thisj, but it will require some minor customization if you do not also ask users to enter their email address separately. This is because Emaze Auction addresses all emails to the user's email address. So it would be necessary to either ask them to complete the email field as well, send the emails to their username, or copy the username to the email address field when creating the user. Of course, this applies only if you will be using the system to send automated emails. (For more information on automated emails, see the <A HREF="#autoemails">Automated Emails</A> section below.)

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="bids"></A>Bids</FONT></H2>

The form for users to bid on a lot is at the bottom of the lot page. Of course, you are welcome to place the bid form on a separate page. This would require creating a separate .cfm page which includes the <I>EmazeAuction/program/bidForm.cfm</I> page, which creates the bid form. The bid form contains the following fields:
<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR><TD VALIGN=top>Username, password</TD>
	<TD>Fields to enter their unique username and password. If these are not correct, Emaze Auction will ask the user to re-enter their username and password before it will allow the user to bid.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top>Cookie checkbox</TD>
	<TD>If Emaze Auction detects the user's cookie, it will give the user the option of bidding with the cookie, rather than entering the username and password. The username and password fields are still displayed though in case the user happens to be at a computer of another user. Before allowing the user to bid, Emaze Auction will check that the cookie is valid. If not, the user will be asked to enter their username and password instead.</TD></TR>
<TR><TD VALIGN=top>Bid</TD><TD>User's initial bid. This field will automatically contain the lowest bid which will win a quantity of at least 1.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top>Quantity</TD><TD>Quantity user is bidding on. This field will only appear if the lot quantity is greater than 1 <I>and</I> the maximum quantity the user may win is greater than 1. </TD></TR>
<TR><TD VALIGN=top>Accept full quantity only</TD><TD>Checkbox which allows user to declare that they are only willing to accept the full quantity they have bid on. If checked, Emaze Auction will allow the user to win the lot only if the user can win the full chosen quantity with the bid. This checkbox also appears only if the user may bid on multiple quantities. </TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top>Auto-bid</TD><TD>This checkbox is displayed only if Admin allows users to auto-bid. If the user checks this checkbox, Emaze Auction will automatically increment the user's bid  to ensure a winning bid up to the maximum bid. (This is currently an all-or-nothing option, but it could easily be changed so that certain lots allow auto-bids, while others do not.) </TD></TR>
<TR><TD VALIGN=top>Maximum bid</TD><TD>This field will only appear if auto-bid is enabled. This is the user's maximum price, and is thus the price at which Emaze Auction will stop incrementing the user's bid to ensure a winning bid.</TD></TR>
</TABLE>
<P><B>
Note about bid increments: </B> The bid increment is the minimum amount by which a bid must be greater than a previous bid. You may choose to make the bid increment simply the minimum bid increment or a required increment multiple. If the bid increment is merely the minimum, then the bid will be accepted as long as the bid is greater than the previous bid plus the bid increment. For instance, if the previous bid was $5.00 and the bid increment is $1.00, then any bid over $6.00 will be accepted. If the user bids $6.25, then the next required bid must be at least $7.25.
<P>
If the bid increment is a required increment multiple, then all bids must be greater than the previous bid by the bid increment or a multiple thereof. In our previous example, the bid of $6.00 would be accepted, but the bid of $6.25 would not since $1.25 is not a multiple of the $1.00 bid increment. (It isn't. We checked on our calculator just in case.) However, the user could bid $7.00 or even $8.00.

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="rules"></A>Rules</FONT></H2>

Here are the rules that determine who wins the bidding for a lot. These rules apply for all lots.
<OL>
<LI>An earlier bid will beat a later bid of the same price.
<LI>Users may not delete their bids once they are submitted. Admin does have the ability to delete a bid though.
<LI>Users may edit their bids to increase the price of change the quantity.
<LI>When a user updates his/her bid, or if their bid is automatically increased using the auto-bid feature, the bid is still considered to be from the date/time of the original bid. Thus, that bidder will still beat a later bid of the same price. In other words, updating a bid does not affect its status as an earlier bid.
<LI>The Admin specifies when an auction opens and closes. Admin can also choose for the auction to not close at the specified time if new bids are still there is active bidding. Admin may specify an inactivity period. If a bid is submitted during this time, the period is extended. For example, if inactivity period is 5 minutes, the auction will remain open until 4 minutes and 59 seconds after the previous bid (or bid update), even if past the closing time.
</OL>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="autoemails"></A>Automated Emails</FONT></H2>

Emaze Auction can be set up to automatically send emails on the following occassions:
<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR><TD VALIGN=top>Lot closed</TD><TD>Emails lot contact person to notify them the auction has closed. Option to include winning bidder information in email.</TD></TR>
<TR><TD VALIGN=top>Winner</TD><TD>Notify lot winners they won the bidding for that lot.</TD></TR>
<TR><TD VALIGN=top>Loser</TD><TD>You did not win the bidding for this lot.</TD></TR>
<TR><TD VALIGN=top>Before close</TD><TD>You no longer have a winning bid, but the auction is still open.</TD></TR>
<TR><TD VALIGN=top>Losing Now Wins Again</TD><TD>Your previously losing bid is now a winning bid again. This typically happens when a previuosly-winning bidder would not accept a partial quantity.</TD></TR>
<TR><TD VALIGN=top>Losing Quantity</TD><TD>You will no longer win the full quantity you requested, but the auction is still open.</TD></TR>
<TR><TD VALIGN=top>Auto-bid</TD><TD>Your bid has automatically be increased using the auto-bid feature.</TD></TR>
</TABLE>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="closingLots"></A>Closing Lots</FONT></H2>

Closing lots in Emaze Auction is a 2 step process:
<OL>
<LI>Update the lot status so that users do not mistakenly believe the lot is still open to bidding.
<LI>Send the necessary emails to the contact person for that lot, and to all winners and losers who requested to be notified (assuming Admin permits the automated emails).
</OL>

The two components are separated because Cold Fusion is not inherently designed to create applications which require actions to be performed at a specific time. The Enterprise version of Cold Fusion (which costs $1000) offers a Scheduler in the Administrator, which enables you to automatically run a Cold Fusion script at a designated time or interval. Other than the Scheduler though, it is not possible to say, &quot;Close the lot at 5:00 PM.&quot; and have Cold Fusion just do it. So we had to hack it for our purposes.
<P>
Emaze Auction maintains 2 lists:
<UL>
<LI>Lots which are currently open
<LI>Lots which are closed, but the emails still need to be sent
</UL>
<P>
Every time a page is loaded by a user, Emaze Auctions checks whether any open lots need to be closed. If so, Emaze Auction adds the lot(s) to the queue of closed lots waiting to have the emails sent. This is a simple script that will not significantly affect user's experience or place undue burden on the server. Emaze Auction does not automatically send the emails because that takes additional time, and would affect the user's experience. (This is because Cold Fusion does not allow you to send HTML to the browser while the page is still being processed.)
<P>
If you have the Enterprise version of Cold Fusion, or are hosted your site with an ISP that uses the Enterprise version, you have access to the Scheduler via the Cold Fusion Administrator. The Scheduler enables you to run a script without requiring a user to wait while it executes. Most ISPs will allow you to run a simple script through the Scheduler. However, if your ISP is wary of doing this, feel free to have them contact us at <A HREF="mailto:sales@emaze.com">sales@emaze.com</A> and we will be happy to assure that the script will not place undue burden on their server.
<P>
<FONT SIZE=4>The script that you should run via the Scheduler is:<BR>
&nbsp; &nbsp; &nbsp; <I>http://www.domain.com/program/scheduler.cfm</I></FONT>
<P>
If you have lots which close at all hours, we recommend running the script every hour. However, if your lots tend to close at the same times, you can set up the script to run only at those times. If you are using the inactivity setting, such that an auction will remain open past the closing time as long as there is still active bidding, be sure to run the script after the closing time, e.g., 30 minutes. This will provide enough time for most auctions to actually close.
<P>
If you do not have access to the Scheduler, either because you are not fortunate (and wealthy) enough to have the Enterprise version of Cold Fusion or because your ISP will not allow you to use the Scheduler, all is not lost. Emaze Auction can still send the emails automatically. When Emaze Auction checks whether any lots need to be closed, if the scheduler is <I>not</I> being used and no lots need to be closed at that time, it will send the automated emails for one lot in the queue. This ensures that each user will not endure a long delay.
<P>
In the <i>Options</I> section of the Emaze Auction Admin screens, you are asked to designate whether you are using the Cold Fusion Scheduler. If you are not, then you can choose to either have Emaze Auction send the automated emails or choose to send them manually. (Manually does not mean that you must send the email to each user individually. Rather, the Admin screens provide a button for each lot to automatically send the emails to the winners and/or losers if the emails have not already been sent.

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="cookies"></A>Use of Cookies</FONT></H2>

Emaze Auction uses three types of cookies, only the first of which is required. The last two are completely optional.
<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR><TD ALIGN=right VALIGN=top>EmazeAuction_master </TD><TD>Temporary cookie used only for the Emaze Auction admin screens to ensure that only the Master user may access these screens.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD ALIGN=right VALIGN=top>EmazeAuction_user </TD><TD>Temporary cookie for users who have bid on a lot during that browser session. This enables them to bid on additional lots without entering their username and password each time. This cookie will automatically expire when the browser is closed. Admin may decide whether to implement this cookie.</TD></TR>
<TR><TD ALIGN=right VALIGN=top>EmazeAuction_login </TD><TD>Permanent cookie for users who choose the automatic login via cookie option. This enables them to bid on lots without entering their username and password everytime they come to your site, including between sessions. Admin may decide whether to implement this cookie and users may decide whether to use it.</TD></TR>
</TABLE>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="javascript"></A>Use of JavaScript</FONT></H2>

Emaze Auction utilizes client-side JavaScript to move some of the processing from the server to the client. JavaScript is used extensively in the forms to ensure that all fields are properly completed. This is much more efficient than submitting a form, only to have the server send back an error message that either a required field is not completed, or the field does not contain the proper type of data. Because it is done using JavaScript, the user will not be permitted to submit the bid until the form is completely properly.
<P>
JavaScript is used extensively in the Admin screens. However, it is also used in various parts of the user interface, primarily on the bid form for the following purposes:
<UL>
<LI>Ensure the user enters their username and password if they are not using a cookie.
<LI>Ensure the user enters a bid as a number value, the bid is at least the minimum bid necessary to win at least 1 quantity, and the bid is at least greater than the previous bid by the bid increment.
<LI>Ensure the user enters a quantity as a number and that the quantity is less than or equal to the maximum quantity allowed.
<LI>When using the auto-bid feature, ensure the user enters a maximum bid which is at least one bid increment greater than their initial bid.
</UL>
Please note that Emaze Auction uses JavaScript only via Cold Fusion's integrated JavaScript functionality for web forms. While we are not currently aware of any browser or platform incompatibilities in Cold Fusion's JavaScript code, we recommend that users be using at least Netscape Navigator 3 or Microsoft Internet Explorer 3. Regardless, Emaze Auction incorporates server-side checks for these tests as well. However, use of client-side JavaScript can reduce stress on the server for those users who have a browser which supports these JavaScript features.

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="initializing"></A>What to do upon initializing Emaze Auction</FONT></H2>

After initializing Emaze Auction, you are ready to start setting up your auctions. Here is a simple list of things you will probably want to do to begin. Each contains a link to the description below. Please note that you
should take a few minutes to familiarize yourself with how Emaze Auction works before doing this. We recommend reading the General Information, basically everything above this section.

<OL>
<LI><B>Change the master password</B>, and username if desired.  (<A HREF="#master">link</A>)
<LI>Determine which cookies bidders may use. (<A HREF="#system">link</A>)
<LI>Edit the homepage options. (<A HREF="#homepage">link</A>)
<LI>Determine which emails will be sent automatically upon closing a lot. (<A HREF="#options">link</A>)
<LI>Designate whether you are using the Cold Fusion Scheduler. (<A HREF="#closingLots">link</A>)
<LI>Choose the default opening and closing times for new lots. (<A HREF="#options">link</A>)
<LI>Edit the email options, including from name and email address, and the subject and message for the automated emails.  (<A HREF="#emails">link</A>)
<LI>Create the various categories and sub-categories for your auction site. This must be done before creating the lots. (<A HREF="#categoryCreate">link</A>)
<LI>Create lots. This should be done only after creating at least one category.  (<A HREF="#lotCreate">link</A>)
<LI>Determine which fields users will be asked to enter when creating new users. (<A HREF="#fields">link</A>)
<LI>Determine which automatic emails users may request. (<A HREF="#fields">link</A>)
<LI>Determine whether users may use the auto-bid feature. (<A HREF="#fields">link</A>)
</OL>

<P><HR NOSHADE COLOR=purple SIZE=3><HR NOSHADE COLOR=purple SIZE=3><P>

<H1><FONT COLOR=purple><A NAME="userScreens"></A>User Screens</FONT></H1>

This section simply lists the help information included in the <I>EmazeAuction/program/help.cfm</I> file for users. It is here as a backup and to make it easier for you to view the user help information without switching files. The user help file is <I>not</I> encrypted, so you are welcome to customize it.

<DL>
<DT><A NAME="auction"></A><FONT SIZE=4 COLOR=purple><B>Auction Home</B></FONT>
<DD>This is the home page for the auction system. It contains a list of all primary categories as well as links to the category home pages. It also contains a list of lots which are opening and closing today.
<P>
<DT><A NAME="category"></A><FONT SIZE=4 COLOR=purple><B>Category Home</B></FONT>
<DD>The category home page contains a list of all lots in that category, including lots that are currently open, lots that will be opening soon, and lots which have closed in the past 7 days. Like the auction home page, it also contains a list of all categories in the auction system. However, in addition to the list of primary categories, the category home page contains a list of all subcategories within the primary category.
<P>
<DT><A NAME="lot"></A><FONT SIZE=4 COLOR=purple><B>Lot page</B></FONT>
<DD>The lot page contains all of the lot information, including open and close, quantity, initial bid, minimum bid increment, description, and any images. It also contains the current bidding information, including the minimum bid necessary to win at least one quantity of the lot and the current list of winning bidders. At the bottom of the page is the form to submit your own bid for the lot.
<P>
<DT><A NAME="bidding"></A><FONT COLOR=purple SIZE=4><B>Bidding</B></FONT>
<DD>To bid on a lot, submit the form at the bottom of the lot page. Here is an explanation of the bidding process:
	<OL>
	<LI>Enter your username and password, or if you are bidding via cookie, make sure the checkbox is checked.
	<LI>Enter your bid. The default value in the text field will be the minimum bid necessary to win at least one quantity of the lot. The system will not permit you to submit a losing bid.
	<LI>If necessary, enter the quantity you would like to bid on. The field will not appear if there is only a single quantity in the lot, or if each bidder is limited to winning a single unit. Please note that your total bid is your bid price times the quantity you requested.
	<LI>If you may bid on more than one quantity and you choose to do, you may choose the option of accepting only the full quantity. In other words, if you cannot win the full quantity you requested with your bid, you are not interested in winning the lot at all. If you want to accept only the full quantity, check the checkbox.
	<LI>If permitted, you may choose to use the auto-bid feature. To use this feature, check the checkbox to verify this and then enter the maximum bid you are willing to make on this lot. The maximum bid must be at least one bid increment greater than your initial bid.
	<P>
	When each new bid is submitted, the system will ensure you still have a winning bid. If you do not, it will raise your bid to maintain your winning status. If you will accept only the full quantity, the system will raise your bid sufficiently to win the full quantity. If it cannot win the full quantity even with the maximum bid, it will stop bidding for you. If you chose to accept a partial quantity, the system will raise your bid to win as many units as you can until your maximum bid.
	</OL>
	<P>
	If you have already bid on a lot, you can update your bid, i.e., change the bid price or quantity, by submitting a new bid. The system will check your username, determine that you have already bid for this lot, and update your bid accordingly.
	<P>
	Here are the rules that determine who wins the bidding for a lot. These rules apply for all lots.
	<OL>
	<LI>An earlier bid will beat a later bid of the same price.
	<LI>Users may not delete their bids once they are submitted.
	<LI>Users may edit their bids to increase the price of change the quantity.
	<LI>When a user updates his/her bid, or if their bid is automatically increased using the auto-bid feature, the bid is still considered to be from the date/time of the original bid. Thus, that bidder will still beat a later bid of the same price. In other words, updating a bid does not affect its status as an earlier bid.
	<LI>Each lot has a designated closing date/time. However, the lot may also have an inactivity period which will keep that lot open past the designated closing time as long as there is still active bidding. If a bid is submitted during this time, the period is extended. For example, if inactivity period is 5 minutes, the auction will remain open until 4 minutes and 59 seconds after the previous bid, even if past the closing time. If the lot has an inactivity period during which bidding will remain open past the closing time, it will be listed with the closing time in the table at the top of the lot page.
	</OL>
<P>
<DT><A NAME="search"></A><FONT COLOR=purple SIZE=4><B>Search</B></FONT>
<DD>Users may search lots by category name, lot name, lot summary, lot description, open time, and close time. If the lot name, lot summary, and/or lot description checkbox is checked, a single text field will appear for all three. However, only the appropriate fields are searched. If entering multiple terms, separate them with a comma. If the category name option is checked, the list of categories will appear in a select box. They may choose multiple categories as well as one or none. If the open time and close time options are checked, the user may choose the opening time by month, date and year. For both times, they may choose whether to search lots before, after, or at the designated time. 
<P>
<DT><A NAME="newBidder"></A><FONT COLOR=purple SIZE=4><B>New Bidder</B></FONT>
<DD>To be able to bid on a lot, you must register as a bidder. This means choosing a username and password, and also completing the other fields. Your username must be unique. If it is already being used by another bidder, the system will ask you to choose another username. Your password must also be entered twice to verify you entered it correctly. If the password is not verified properly, the system will ask you to re-enter the password.
<P>
<DT><A NAME="editBidder"></A><FONT COLOR=purple SIZE=4><B>Edit Bidder</B></FONT>
<DD>Edit your user information. This is the same screen you used to add yourself as a bidder. You may change your username, but it must be unique. If you would like to change your password, enter your new password and verify it.
	<P>
	There is a form for you to edit your information on the auction home page and category home pages. Simply enter your username and password, and then click on the <I>Edit</I> button. Or if you are using a cookie, make sure the cookie checkbox is checked. If your username and/or password are not correct, the system will ask you to re-enter them. From the lot page, if you click on the <I>Edit Bidder</I> link, the system will first present a form for you to enter your username and password.
<P>
<DT><A NAME="listAllLots"></A><FONT COLOR=purple SIZE=4><B>List All Lots</B></FONT>
<DD>Lists all lots that are currently open in every category of the auction. The lots are listed in alphabetical order by category name, and then by lot name. The lot ID will link to the lot page. Next to each category name will be a <I>go</I> which links to the category home page. Please note that if the auction system contains many lots, this could be a very long page.
<P>
<DT><A NAME="bidStatus"></A><FONT COLOR=purple SIZE=4><B>Bid Status</B></FONT>
<DD>Check the status of all your bids. This page will list your bids for all lots, and tell you whether it is a winning bid or a non-winning bid. It will also provide a link to that lot so that you may update your bid (assuming the lot is still open).
	<P>
	There is a form for you to check the status of your bids on the auction home page and category home pages. Simply enter your username and password, and then click on the <I>Bid Status</I> button. Or if you are using a cookie, make sure the cookie checkbox is checked. If your username and/or password are not correct, the system will ask you to re-enter them. From the lot page, if you click on the <I>Bid Status</I> link, the system will first present a form for you to enter your username and password.
</DL>

<P><HR NOSHADE COLOR=purple SIZE=3><HR NOSHADE COLOR=purple SIZE=3><P>

<H1><FONT COLOR=purple>Admin Screens</FONT></H1>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="system"></A>System</FONT></H2>

The system options are the basic system paths, URLs and other settings used to run Emaze Auction. These include the same values you entered upon initializing Emaze Auction. To change any of the settings, you must check the checkbox for the change to take effect. (This does not apply to the two cookie checkboxes.)
<P>
The domain name is the domain name and extension or the IP address. It is used to write a permanent cookie for users who choose the automatic login via cookie option. The domain name is also used for temporary cookies to ensure other servers cannot read them. If you are entering a domain name, be sure to include a period (.) before the domain name, e.g., &quot;.emaze.com&quot; . However, if you are entering an IP address, do <I>not</I> include the period, e.g., &quot;127.0.0.1&quot; .
<P>
<DL>
<DT><B>Full path to Emaze Auction directory</B>
<DD>This is the path to the EmazeAuction directory, or whatever you named it. The path is from your server's root directory, e.g. c:\WebSite\htdocs\EmazeAuction. There should be no trailing slash at the end.
<P>
<DT><B>URL to Emaze Auction directory</B>
<DD>This is the URL to the EmazeAuction directory, or whatever you named it. It should be the full URL, e.g., http://www.yourdomain.com/EmazeAuction . There should be no trailing slash at the end.
<P>
<DT><B>Cold Fusion datasource of database</B>
<DD>This is the name of the Cold Fusion datasource as determined in the Cold Fusion Administrator.
<P>
<DT><B>Email server for sending emails</B>
<DD>This is the mail server to use when sending emails from Emaze Auction.
<P>
<DT><B>Logout URL</B>
<DD>This is the URL where Admin is sent after logging out of the Emaze Auction admin screens. Logging out deletes the cookie from the admin's browser. There is currently no logout feature for normal users.
<P>
<DT><B>Allow automatic bidder login via permanent cookie</B>
<DD>This enables users to bid on lots without entering their username and password. The permanent cookie stores the bidder's unique ID and username. Both are harmless without the proper password. (If the user changes his/her username, Emaze Auction will update the cookie with the new username.)
<P>
<DT><B>Use temporary cookie</B>
<DD>This enables bidders to submit multiple bids without re-entering username and password after first bid. This is a temporary cookie that is automatically deleted when the browser session ends.
<P>
<DT><B>Domain name (for cookie login: domain.extension)</B>
<DD>The domain name ensures that only your server can read users' cookies. The domain name should be simply &quot;domain.com,&quot; e.g., emaze.com .
</DL>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="bodytag"></A>Body Tag</FONT></H2>

Choose the settings for the body tag used throughout all of the screens in the user interface. The navigation bar options are for the background colors used in the navigation bar table as well as the font color. They are used in the navigation bar, specials table, and user options tables. For all of the colors, either choose from the existing list of colors from the select list, or enter a color in the text field. Be sure to check the appropriate radio button to signal which option you are choosing. After you choose a color, the next time you reload the screen, it will be listed in the text portion. Below is a description of the body tag elements:
<P>
<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH=500>
<TH>Term</TH><TH>Definition</TH>
<TR><TD VALIGN=top>bgcolor: </TD><TD>Background color. This is a solid color, normally white.</TD></TR>
<TR><TD>text: </TD><TD>Color of normal text, i.e., not links or text within &lt;FONT COLOR&gt; tags. Normally black.</TD></TR>
<TR><TD>link: </TD><TD>Color of link that has not yet been clicked on. Typically blue.</TD></TR>
<TR><TD>alink: </TD><TD>Color of link while you are clicking it. Normally purple.</TD></TR>
<TR><TD>vlink: </TD><TD>Color of link after you have clicked on it, usually purple.</TD></TR>
<TR><TD>background: </TD><TD>Background image used instead of bgcolor (when background image is found). Use the full URL.</TD></TR>
<TR><TD>other: </TD><TD>Body tags can have some additional options, such as margin settings. Just enter the full settings.</TD></TR>
</TABLE>


<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="homepage"></A>Homepage</FONT></H2>

The homepage contains several fields which can be used in the template for the auction home page. If you create your own template, you are welcome to use these fields as well. This screen is also where you designate which template to use for the auction home page.
<P>
<DL>
<DT><B>Home page template</B>
<DD>The home page template that is included with Emaze Auction is the default option. Simply choose the template you wish to use from the select list. Only templates which have been designated as auction home page templates are displayed. (All templates are designated as being for the auction home page, category home page, or lot page.) Please note that this is the only option on this page for which you must check the checkbox to change the setting.
<P>
<DT><B>Title</B>
<DD>Determines the title in the HTML header of the auction home page, which appears at the top of the browser window.
<P>
<DT><B>Banner</B>
<DD>Text at the top of the auction homepage.
<P>
<DT><B>User</B>
<DD>The auction and category home pages contain a table on the left side of the page for users to edit their information or check the status of all of their bids. This section determines the text at the top of that table.
<P>
<DT><B>Special</B>
<DD>The templates for the auction and category home pages contain a table on the left side of the page for daily/weekly/whenever specials, or just a message. The text field determines the title at the top of the table, and the textarea is the actual message.
<P>
<DT><B>Header</B>
<DD>Header of page which appears before table of auctions opening today.
<P>
<DT><B>Middle</B>
<DD>Middle of page which appears between table of auctions opening today and table of auctions closing today.
<P>
<DT><B>Footer</B>
<DD>Footer which appears after the table of auctions closing today.
</DL>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="options"></A>Options</FONT></H2>

This screen has 4 components: automatic emails, scheduler, default options for new lots, search options, and options for extending lot closing times if the reserve price is not met or there are no bids on the lot.
<P>
There are 4 types of emails that Emaze Auction can automatically send upon closing an auction:
<UL TYPE=disc>
<LI>Email lot contact person to notify that auction has closed
<LI>Include list of winning bidders in email to lot contact person
<LI>Email winning bidders (who choose option)
<LI>Email losing bidders (who choose option)
</UL>
<P>
If you have the Enterprise version of Cold Fusion, or are hosting your site on an ISP which has the Enterprise version, we highly recommend you use the Cold Fusion Scheduling engine to send the automated emails. For more information on the Cold Fusion Scheduling engine, please refer to the <A HREF="#autoemails">Automated Emails</A> section of this Help file. Please note that if you check this option but do not actually implement it, the automated emails will never get sent unless you send them manually by clicking on the &quot;Close Lots&quot; link in the Admin screens.
<P>
<I>No Bids</I>:<BR>
If no bids are received on a lot, you have the option of automatically extending the lot's closing time. This option is chosen on an all-or-nothing basis: it is either on for all lots or on for no lots. If a lot has no bids at its closing time, the system will check whether it should be extended. You may choose to extend the lot closing time by X hours or days, where you choose X and whether it is hours or days. You can also choose how many times to automatically extend the closing time for each lot. To use this option, you must check the checkbox. Otherwise, it is ignored. There is also an option to automatically email the lot contact person at closing time that there are no bids for the lot.
<P>
<I>Opening bid, Bid increment, and Shipping</I>:<BR>
Determine the default opening bid and bid increment for new lots. You may also choose whether the bid increment is a minimum or mandatory multiple. If choosing the mandatory multiple, check the checkbox. Enforcing increment means a bid must be greater than the previous bid by the bid increment, or a multiple of the bid increment. Not enforcing means any bid is accepted as long as it is greater than the previous bid by at least the bid increment.
<P>
The default shipping fee is for adding shipping and handling fees to a lot, regardless of the amount of the winning bid(s). Please note that we have not enabled this field. We have simply included it in response to customer requests. We do not automatically add the shipping fee to bids and the shipping fee is not included in our default lot template. But it is there in case you want to use it.
<P>
<I>Reserve Price</I>:<BR>
The reserve price is the price at which the seller (or you) is not willing to sell the lot, even to the highest bidder. The reserve price is not displayed, but the default lot template will tell bidders whether the reserve price has been met on lots with a reserve price. For now, the reserve price applies only to lots with a single quantity. There are many options available in conjunction with the reserve price, but most are for when the reserve price is not met. When the reserve price is met, you have the option of sending an automatic email to the lot contact person to notify them.
<P>
When the reserve price is not met, you may send an email to the lot contact person to notify them. You may also choose to automatically extend the lot closing time. Just as with the option to extend the closing time for lots with no bid, you may choose to extend the lot closing time by X hours or days, where you choose X and whether it is hours or days. You can also choose how many times to automatically extend the closing time for each lot. To use this option, you must check the checkbox. Otherwise, it is ignored. If the lot closing time is extended, you may also choose to send emails to the current winning and losing bidders to notify them that the closing time has been extended. (You may customize these emails in the Emails Reserve page.)
<P>
When the reserve price is not met and the lot is closed, you may choose which email to send to bidders. For the &quot;winning&quot; bidders, i.e., the bidders who would have won if their bid had met the reserve price, you may choose to not send any emails; send the reserve &quot;winner&quot; email which notifies them that they had a winning bid, but they did not win since it did not meet the reserve price; or send the normal email sent to bidders who did not win the lot. For losing bidders, you can choose to not send an email; send the reserve loser email, which notifies the bidder that although they did not have a winning bid, the lot was not sold as the reserve price was not met; or send the normal email sent to bidders who did not win the lot.
<P>
<I>Images and Thumbnails</I>:<BR>
The default URL for images and thumbnails is for images that you do not want to upload to the server. When you create lots, you have the option of uploading an image directly to the <I>EmazeAuction/lotimage</I> directory or entering the URL to the image. The URL is useful if the image is already somewhere on the Web. This is the default URL for the image and thumbnail. You will not need them though if you will simply be uploading images. The URLs should not have a trailing slash (/) at the end as they will be included automatically.
<P>
<I>Opening time, Closing time</I><BR>
The default lot opening and closing times are used when creating a new lot. This allows you to determine what the default times will be, i.e., the values that appear in the form fields when you create a new lot. You are always able to change the time anyway, but we have tried to make your life a little easier by enabling you to choose the default values as well.
<P>
For both the default lot opening and closing times, you can choose the day and time at which the lot opens/closes. For the day, you can choose a default day or specify a certain number of days after the appropriate date. For the opening date, the specified number of days is from the current day (i.e., the day you create the lot). For the closing date, the number of days is counted from the default opening date.
<P>
The default time can be a designated time or you can specify a time that X hours and Y minutes after the appropriate time. For the opening time, the specified number of hours and minutes is from the current time (i.e., the time you create the lot). For the closing time, the time is counted from the default opening time.
<P>
<I>Search Options</I><BR>
These are the search options available to bidders. You may choose category name, lot name, lot summary, lot description, open time, and close time. If the lot name, lot summary, and/or lot description checkbox is checked, a single text field will appear for all three. However, only the appropriate fields are searched. Bidders may enter multiple search terms, separated by a comma.
<P>
If the category name option is checked, the list of categories will appear in a select box. They may choose multiple categories as well as one or none. If the open time and close time options are checked, the user may choose the opening time by month, date and year. For both times, they may choose whether to search lots before, after, or at the designated time.

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="emails"></A>Emails</FONT></H2>

This page contains the options for the automated emails. These include the from name, from email address, whether to include the URL to the lot in the email, and the subject and body of the various types of emails.
<P>
For the from name and from email address, you may choose to use the same name and email address for all lots, or use the name and email address of the contact person for that lot. Just select the appropriate radio button, and enter the name or email address when choosing to use the same field for all emails. Each email will automatically include the lot name and the appropriate bidding information. The emails include:
<UL>
<LI>Winner -- You won the bidding.
<LI>Loser -- You lost the bidding.
<LI>Before Close -- Your current (or maximum) bid is no longer a winning bid.
<LI>Losing Quantity -- You will not win the full quantity you requested with your current bid.
<LI>Losing Bid Wins Again -- Your previously losing bid is now a winning bid again. This typically happens when a previuosly-winning bidder would not accept a partial quantity.
<LI>Auto Bid -- Your bid has automatically be increased via the auto-bid feature.
<P>
<LI>Verify Email -- This is the email sent to new users if you choose the option that their email address must be verified. Users must click on the URL sent in the email to verify they have a valid email address. (This option is covered in the &quot;Fields&quot; screen.) Unlike the other emails, you also choose who the email is from and the reply-to address. This is because the email is not associated with any particular lot.
</UL>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="reserve">Emails Reserve</A></FONT></H2>

This screen contains the four emails associated with reserve price. Each email will automatically include the lot name and the appropriate bidding information.
<UL>
<LI>Reserve Price Met - Loser (sent to losing bidders to notify them that the reserve price has now been met)
<LI>Closing Time Extended - Winner (winning bid, but still less than reserve price)
<LI>Closing Time Extended - Loser (losing bid, but winning bid less than reserve price)
<LI>Lot Closed - Winner (winning bid, but still less than reserve price)
<LI>Lot Closed - Loser (losing bid, but winning bid less than reserve price)
</UL>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="fields">Fields</A></FONT></H2>

This screen is where you designate which fields users are requested to enter when adding themselves to the user database; whether they may use the auto-bid feature; and the automated emails they may request. Please note that while there are 5 types of automated emails, users only have 4 choices. That is because the <I>Before Close</I> email option determine whether both the <I>Before Close</I> and <I>Losing Quantity</I> emails are sent. The <I>Losing Quantity</I> email is sent only if the user chose the <I>Before Close</I> option and checked the option to accept only the full quantity they requested.
<P>
You may choose to verify the email address of new users by sending them an email with a unique URL. The user must then click on the URL from the email or copy the URL to a webbrowser. The URL is simply http://www.domain.com/program/verify.cfm?UniqueID . We generate a unique ID for each user. If the user does not verify their email address, they will not be permitted to bid. If they do try to bid, the system will reject their bid, notify them that they must first verify their email address, and will also automatically re-send the verification email. The email address of users created by admin do not need to be verified.

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="headers"></A>Headers</FONT></H2>

This screen is where you customize the headers for the add user, edit user, search, search results, and login screens. There is also a login footer component, but we still called this screen &quot;Headers&quot; anyway. To customize the headers, just make the changes and click on the &quot;Edit User Headers&quot; button.
<P>
The add user header appears at the top of the screen where users add themselves to the user database as a new bidder. The edit user screen appears at the top of the page when users edit their user information. The search header appears at the top of the screen when users enter their search criteria. The searh results header appears at the top of the screen for the search results.
<P>
For the login screen, the login form is automatically included between the header and footer. This is simply a nicely-formatted table asking for the interviewer's username and password. The login screen is currently used only for users logging into private lots.

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="closeLots"></A>Close Lots</FONT></H2>

Click this button to close all lots. It will first check to see which lots need to be closed, and will then close all of the lots. Closing lots typically involves simply sending the closing emails. To avoid the system from timing out, i.e., continuing so long that the server cancels the script, the script closes a few lots and then re-calls itself. This reloads the script and starts the timer again. This script does the same thing as the Scheduler script.

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="categoryHome"></A>Category</FONT></H2>

The category screen is the entry screen to edit and delete categories, as well as to perform all lot action other than creating new lots. The screen lists all categories, and their subcategories, in alphabetical order and contains an <I>edit</I> link to edit that category. It also includes:
<UL>
<LI>ID - ID of the category
<LI>Del - Delete checkbox if the category can be deleted
<LI>Views (1) - The number of times the category home page has been viewed
<LI>Views (2) - The total number of times the lots in that category have been viewed
<LI>Count - Count of the number of lots in each category
</UL>
<P>
If the category contains any lots, there will be a <I>Lots</I> link to view a list of all lots in that category, and perform the following functions for each lot: view, edit, determine private bidders, copy, view all bids, view winning bids, email winners, email losers, archive, and delete. There is also a <I>Win</I> link to view the winning bidders for all lots in that category.
<P>
<DL>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="categoryCreate"></A>Create</B></FONT>
<DD>To create a new category, you must choose a category name, designate which category the new category is a subcategory of, and choose the template to use when displaying that category. You may also enter a description, header, footer, and special message. The description is not currently used, but it was included for you to potentially use on the auction home page or category home page. The header, footer and special message are currently used in the default category template, but you can use them in any tmeplate you create as well.
<P>
There are 4 category levels. The new category can be a new category, i.e., a level 1 category, or it can be a sub-category or an existing category. The existing category can be level 1, 2 or 3. To designate the new category as a level 1 category, i.e., it is not a sub-category of an existing category, select &quot;NEW (SEPARATE) CATEGORY&quot; in the sub-category select list.
<P>
The new category name must be unique for that category level. A category name may be used more than once if they are not both level 1 categories or are subcategories of different categories. For instance, both of the following categories are acceptable:
<P>
Computers: Books<BR>
Fiction: Books
<P>
If the name is not acceptible, Emaze Auction will ask you to choose another name for that category.
<P>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="categoryDelete"></A>Delete</B></FONT>
<DD>To be permitted to delete a category, the category must contain no lots and it must not have any subcategories. Categories which satisfy these permissions will have a checkbox on the left side. To delete the category, check the checkbox, check the checkbox below the <I>Delete</I> button to verify your request, and then click the <I>Delete</I> button.
<P>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="categoryEdit"></A>Edit</B></FONT>
<DD>To edit a category, click the <I>Edit</I> link. You may edit all category fields except for the subcategory setting. If you change the category name, Emaze Auction will ensure the name is acceptable before updating the name. If you would like to &quot;move&quot; the category to a different category, you must create a new category and then delete the original.
<P>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotWinnersAll"></A>Win</B></FONT>
<DD>To view the list of winners on all lots in the category, click the <I>Win</I> link. The bids are initially listed in alphabetical order by lot name. However, you may re-order them by open time, close time, lotID, and time the lot was last edited. The list includes the lotID, lot name, bid amount, number of units the bidder won, the full name of the winning bidders, a link to the bidder's email address, and the current status of the lot. The lotID links to the full winners screen for the lot, which includes more information about the winning bidders.
<P>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="categoryLots"></A>Lots</B></FONT>
<DD>Viewing the list of lots in a category will display a screen which includes the lots and the options available for each. The category name and URL to the home page for that category are also included at the top of the page.
<P>
The lots are initially listed in alphabetical order, but you may order them in either ascending or descending order by name, open date/time, close date/time, date created, date last edited, or the number of times the lot has been viewed. Just choose the field by which you want to order the lots, and then click on either the plus (+) or minus (-) image. The lots are listed in the appropriate order at the top of the page, with a link to that lot in the page below.
<P>
At the top of the page are the following tables which summarize the lots. They list the appropriate options and the applicable lotIDs, with a link to the lot information in the page below.
<UL>
<LI>Summary of lot status - Inactive, preview, open, closing (waiting to be closed) and closed.
<LI>Summary of lot reserve price - Reserve price met, reserve price not met, and the number of times the lot has been extended.
<LI>Summary of lot bids - No bids, and the number of times the lot has been extended.
</UL>
<P>
Each lot lists the lot ID, lot name, URL to that lot, status, open date/time, close date/time, how many times that lot has been viewed, and whether the lot has any bids. If the lot has been extended due to no bids, it will list the number of times the lot has been extended in parantheses. If the lot has a reserve price, it will also display whether the reserve price has been met, and how many times the lot has been extended because the reserve price has not been met.
<P>
The following options are available for each lot: view lot, edit lot, determine private bidders, copy, view all bids, view winning bids, submit an offline bid, email winners, email losers, archive, and delete. All option are displayed, but only those options which are applicable for each lot may be chosen. Each option is described in more detail below.
<P>
<DL>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotView"></A>View</B></FONT>
	<DD>View the lot as users would see it. If the lot is open, the lot will display in the proper mode: Preview, Open, or Closed. If the lot is inactive, this is the only way to view the lot, i.e., as the Admin user. This option is available for all lots.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotEdit"></A>Edit</B></FONT>
	<DD>Edit all options of the lot. This presents the same screen that you used to create a new lot, except that you are now editing that lot. After editing the lot, Emaze Auction will reload this screen. This option is available for all lots.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotPrivate"></A>Private</B></FONT>
	<DD>This option is available only to lots which have been designated as private. For private auctions, this enables you to grant users permission to that lot. Upon clicking on the link you will be presented with a list of users who have permission for this lot and a form to add new users. The interface to choose users is the same interface used to choose users to edit. To revoke permission for a user, click the checkbox next to their name, and then click on the <I>Remove Users</I> button. The checkbox below the button must be checked to verify your request.
	<P>
	For new users, you may choose the users by userID, username, or name; or search for the users by last name, first name, organization, username, or email address. You will then be presented with a list of users that satisfy the search. Simply check the users grant them permission for this lot.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotCopy"></A>Copy</B></FONT>
	<DD>This enables you to copy the lot fields to create a new lot. This option is available for all lots. The theory here is that it is likely you will have multiple auctions in succession for the same product, i.e., the bidding closes for one and then opens for the next. This enables you to save the original lot information to avoid deleting the bids. When you click on the <I>Copy</I> link, Emaze Auction will display the <I>Create new lot</I> page, but with the values for that lot filled in. It is similar to editing a lot, except that you are creating a new lot.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotBids"></A>Bids</B></FONT>
	<DD>View all bids for that lot, including winning and losing bids. The bids are initially listed in chronological order, i.e., the order in which the bids were submitted. However, you may re-order them in either ascending or descending order by name, date/time, current bid, quantity, whether it is  a winning bid, whether they are using the auto-bid feature, the initial bid, or the maximum bid. The current bid and maximum bid apply to bidders who used the auto-bid feature. The user's name is linked to their email address. There is also a link to edit each user's information (not their bid).
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotWinners"></A>Winners</B></FONT>
	<DD>View winning bids for the lot. This option is available during the auction as well as after the auction has closed. The bids are initially listed in chronological order, i.e., the order in which the bids were submitted. However, you may re-order them by name, bid price, quantity, or date/time of the bid. The table contains a link to a list of the user's full information below. The list includes the user's email address, phone number, address, organization, and a link to edit the user's information.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotBidOffline"></A>Offline Bid</B></FONT>
	<DD>This enables you to submit a bid for a lot on behalf of a bidder. It is the same form that normal bidders complete except that you can enter the full date/time of the bid. Because an earlier bid beats a later bid of the same price, the date/time of the bid is very important. For now, you need to use the bidder's username and password.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotEmailWinners"></A>Email Winners</B></FONT>
	<DD>Send the <I>automated</I> email to all winners of the lot who chose to be notified. This option enables you to send the email if you choose not to send it automatically upon closing the lot. It also enables you to customize the message for the lot rather than use the default winning message. You may also choose to send the email to all winners regardless of their individual email options.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotEmailLosers"></A>Email Losers</B></FONT>
	<DD>Send the <I>automated</I> email to all losers of the lot who chose to be notified. This option enables you to send the email if you choose not to send it automatically upon closing the lot. It also enables you to customize the message for the lot rather than use the default losing message. You may also choose to send the email to all losers regardless of their individual email options.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotArchive"></A>Archive</B></FONT>
	<DD>Archives a lot, including all bids, related files and database fields. For lots which are closed and done, this enables you to save all information for that lot, yet get the information out of the database. This will make the database quicker by reducing the number of bids it must search through. All information is archived to text files in the <I>EmazeForums/archive/</I> directory.
	<P>
	Archiving a lot means it will no longer be displayed on the category page. For all intensive purposes, it will be deleted. All information will be available in the text files though in case you ever need them. Emaze Auction will ask you to verify your request before archiving the lot.
	<P>
	<DT><B><FONT SIZE=4 COLOR=purple><A NAME="lotDelete"></A>Delete</B></FONT>
	<DD>Deletes a lot, including all bids, related files and database fields. We don't really recommend doing this unless you hate the thought of archiving the lot. However, we have provided the functionality. And don't worry about clicking it accidently -- Emaze Auction will ask you to verify your request before deleting the lot.
</DL>
</DL>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="lotCreate"></A>Lot (create)</FONT></H2>

The form for creating a lot may seem a bit overwhelming at first, but it has a pretty quick learning-curve. Of course, it will always be ugly. We will explain each field in the order in which they appear.
<P>

<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR><TD VALIGN=top ALIGN=right>Name: </TD><TD>The name of the lot. This can be anything you want, and it does not need to be unique. It cannot be blank though.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Status: </TD><TD>Determines whether the lot will open at the specified time. If active, the lot will be in preview mode until it opens. If inactive, the lot will not be listed. Users will not even know the lot exists.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Open date/time: </TD><TD>The date and time when the auction will open, assuming its status is active. Enter the 2-digit month, 2-digit date, 4-digit year, 2-digit hour, 2-digit minutes, and select AM or PM. The default time is based on the default time options from the <I>Options</I> screen. If you want to open the lot immediately, you can also just check the <I>Open lot now</I> checkbox. This will ignore the above time and just use the current time instead.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Close date/time: </TD><TD>The date and time when the auction will close. Enter the 2-digit month, 2-digit date, 4-digit year, 2-digit hour, 2-digit minutes, and select AM or PM. The default time is based on the default time options from the <I>Options</I> screen. If you would prefer to close the lot at the same time X days later, simply enter the value for X in the text field on the following line. Doing so will ignore the above closing time. Please note that you can still use this option even if you check the <I>Open lot now</I> checkbox.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Close basis: </TD><TD>All lots are closed at the designated time. However, you may also choose an inactivity setting. This means that the lot will remain option as long as there are active bids within the activity time period. For instance, if the inactivity setting is 5 minutes, the lot will remain option indefinitely past the designated close time as long as each new bid is within 5 minutes (4 minutes and 59 seconds, actually) of the previous bid. To enable the inactivity feature, select the appropriate radio button.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Inactivity: </TD><TD>Number of whole minutes the lot will remain open past the closing time if the next bid is within X minutes of the previous bid. In the default lot template, this setting is displayed for users.</TD></TR>
</TABLE>
<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR><TD VALIGN=top ALIGN=right>Quantity: </TD><TD>The quantity available in this lot.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Max. Quantity: </TD><TD>The maximum quantity a bidder may bid on, and thus win. A value of 0 (zero) or a number greater than or equal to the actual quantity means there is no limit. If the lot only has one quantity, this field is not used.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Opening bid: </TD><TD>This is the minimum opening bid you will allow for this lot. The bid can be greater than the opening bid though.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Bid increment: </TD><TD>The minimum amount by which a bid must be greater than a previous bid. This does not necessarily apply to lots which have multiple quantities where the same bid can be used by multiple bidders as long as they are all winning bids.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Reserve Price: </TD><TD>The price at which you are not willing to sell the lot, even to the highest bidder. The reserve price is not displayed, but the default lot template will tell bidders whether the reserve price has been met on lots with a reserve price. For now, the reserve price applies only to lots with a single quantity.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Shipping: </TD><TD>This is the shipping/handling price that will be added onto each winning bid for the lot. Please note that we do not actually do anything with this field yet. It is there in case you want to display it with the lot information or automatically add it to the winning bid.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Sell Price: </TD><TD>The price at which you are willing to sell the product outright. Some auction sites like to give bidders the option of simply buying the product at a set price. The sell price is not displayed in the default lot template, but you can add should you decide to use it.</TD></TR>
</TABLE>
<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Category: </TD><TD>Select from the list of all categories, including all sub-categories.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Template: </TD><TD>Select which template is used to display this lot. Only lot templates are listed.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Public: </TD><TD>Public lots are open to all bidders. Users must be given permission for all private lots, and they must log in to ensure they have permission. Private lots are not listed on the default category home page. Users are given permission for private lots via the <I>Category</I> section described above.</TD></TR>
<TR><TD VALIGN=top ALIGN=right>Contact name: </TD><TD>The name of the person who will be emailed when the lot is closed. Depending on the email setting, this is also the name that is used for the automated emails. This can also be used to display on the lot page for more information.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Contact email: </TD><TD>The email address of the person who will be emailed when the lot is closed. Depending on the email setting, this is also the reply-to email address that is used for the automated emails. This can also be used to display on the lot page for more information.</TD></TR>
</TABLE>
<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR><TD VALIGN=top ALIGN=right>Image: </TD><TD>You may choose an image to display with this lot. We have provided a <I>lotimage/</I> directory specifically for your lot images (thus the name). You may also enter the full URL to an image if you do not wish to upload it or it is already somewhere on the Web. To upload an image to the lotimage directory, select the image from your computer by clicking the &quot;Browse&quot; button. This will upload the image to the server when you create the lot. If using an image in another directory, enter the full URL in the text field <I>below</I> the field with the &quot;Browse&quot; button. If not using an image, just ignore both fields. </TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Thumbnail: </TD><TD>A thumbnail image is a smaller version of an image. This is useful if the real lot image is either too big for the page or too big a file. The thumbnail image will be displayed on the lot page, but will link to the full image. The thumbnails options are the same as the normal image options above.</TD></TR>
</TABLE>
<P>
<TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 WIDTH=600>
<TR><TD VALIGN=top ALIGN=right>Summary: </TD><TD>A short summary of the lot. This field is not used in the default templates, but could be used in your own templates. It is intended for the auction or category home pages, but could also provide a quick summary at the top of the lot page. May contain HTML and even Cold Fusion tags.</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD VALIGN=top ALIGN=right>Description: </TD><TD>Full description of the lot. Can be as long as you want and can contain HTML and even Cold Fusion tags. </TD></TR>
</TABLE>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="templateHome">Template</A></FONT></H2>

This screen enables you to add new templates, delete old templates, and edit existing templates. Please note that this screen does not help you actually create templates, but rather to add them to the auction system so you may use them.
<P>
There are 3 types of templates: auction, category, and lot. These are for the auction home page, category home page, and lot page, respectively. You may use a different template for each category and lot. (Technically, you can only choose a single home page template, but it would not be difficult to offer a different auction home page to various users.) There are 3 default templates that are included with Emaze Auction:
<P>
<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=3>
<TH BGCOLOR="#20A491">Name</TH>
<TH BGCOLOR="#20A491">File</TH>
<TH BGCOLOR="#20A491">Type</TH>
<TR><TD>Default Auction Home Page</TD><TD>defaultIndex.cfm</TD><TD>auction</TD></TR>
<TR BGCOLOR="#CDCDCD"><TD>Default Category Home Page</TD><TD>defaultCategory.cfm</TD><TD>category</TD></TR>
<TR><TD>Default Lot Page</TD><TD>defaultLot.cfm</TD><TD>lot</TD></TR>
</TABLE>
<P>
In the future, we will offer additional templates. In the meantime though, you may use our templates as a reference for your own. The templates are not encrypted, so you have full access to the Cold Fusion code. Templates are listed in alphabetical order by template type, and then template order. So all auction home page templates are listed in alphabetical order, then all category home page templates, and finally all lot templates.
<P>
<DL>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="templateCreate"></A>Create</FONT></B>
<DD>You may create as many templates as you want. After creating your new template, i.e., the actual Cold Fusion page, place the .cfm page in the <I>EmazeAuction/template/</I> directory. (If the file is not already in the directory though, Emaze Auction will give you the opportunity to upload it via your web browser.)
<P>
To add the new template, you must enter a unique name for the template, the name of the file (which also must be unique) and then select the type of template it is (auction, category, or lot). The template name is used to select the template to use when creating/editing a category or lot, or selecting the template for the auction home page. The type of template determines which templates are displayed when choosing the template, e.g., only lot templates are displayed on the lot page. You may choose any file and template names you want except for the 3 default names.
<P>
After entering the template name, file name, and template type, click on the <I>Create</I> button. If the file name or template name is already being used, Emaze Auction will ask you to choose another name. Otherwise, it will add the template to the system. It will also check whether the template file exists in the <I>EmazeAuction/template/</I> directory. If not, it will allow you to upload it.
<P>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="templateEdit"></A>Edit</FONT></B>
<DD>To edit a template you have created, click on the template name. You cannot edit a default template. Editing a template enables you to change the template name, file name, or template type. Simply enter a new filename or new template name, or change the template type, and click on the submit button. If you changed the template name or file name, Emaze Auction will check that your new name is unique. If not, it will ask you to choose another name.
<P>
If you are changing the filename of a template which is being used by many categories or lots, the change may take a few seconds to implement. So be patient. Emaze Auction will also check whether the new file exists in the template directory. If it does not exist, but the original file does exist, it will ask you whether it should rename the file to the new name. If the original file does not exist, you will be given an opportunity to upload the new template file.
<P>
Please note that if you change a template type, Emaze Auction will <I>not</I> warn you if tha template is being used. So if changing the template type, be sure that you are still using that template properly.
<P>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="templateDelete"></A>Delete</FONT></B>
<DD>You may only delete templates which are not currently being used. Thus, only templates which may be deleted will have the delete checkbox in the first column. You also cannot delete the default templates. To delete a template(s), check the checkbox next to the template(s) you wish to delete, check the checkbox below the <I>Delete</I> button to verify your delete request, and then click on the button.
<P>
This will not delete the actual template file(s) in the template directory. It will only remove the template(s) from the Emaze Auction list of templates. If you want to delete the actual template file(s) as well, check the checbox at the bottom of the page before clicking on the <I>Delete</I> button. Emaze Auction will then check to see whether the template file(s) exist, and then delete it if it does.
</DL>

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="unarchive"></A>Unarchive</FONT></H2>

You may archive lots for which you want to save the information, but want to remove from the database. This includes all information about the lot as well as all bids for that lot. Unarchiving a lot returns it to the database. To unarchive the lot(s), check the checkbox next to that lot ID and then click the &quot;Unarchive Lots&quot; button at the bottom of the screen. To delete the lot(s), check the checkbox for the lot, check the checkbox at the bottom of the screen indicating it is ok to delete, and then click the &quot;Delete Lots&quot; button. To view the lot, click the lot ID link. (Please do not try to unarchive or delete more than 5 lots at a time to avoid the system from timing out.)

<P><HR NOSHADE COLOR=purple SIZE=3><P>

<H2><FONT COLOR=purple><A NAME="userHome"></A>User</FONT></H2>

The interface in this screen depends on the number of users in the user database. The Edit User screen is split into 2 vertical frames. The left frame will contain the list of users you wish to edit, and the right frame will contain the form to actually edit the user information. The right frame initially contains some help information until you choose to edit a user.
<P>
If there are less than 100 users in the user database, Emaze Auction presents 3 select lists: userID, username, and name (last, first). Simply choose the users you would like to edit from any or all the three select lists, then click on the <I>Edit Users</I> button. Choosing by userID is useful if you recently imported a list of users as their userIDs will be in numerical order. Do not worry about choosing the same user more than once as Emaze Auction will only list the user once.
<P>
&nbsp; &nbsp; &nbsp; If more than 100 users, Emaze Auction will present 3 select lists: userID range (by 100), username range (by letter), and last name range (by letter). Choose the range of users by highlighting any or all options in the three select lists, and then click on the <I>List Users</I> button.
<P>
For both types of searches, you can choose the order in which you want the users to be listed: userID, username, last name, or first name. You can also choose to search for the user(s) you wish to edit by searching based on first name, last name, username, email address, or organization. If you are looking to edit a specific user or all users from a specific organization, this can be much easier than scrolling through the whole list.
<P>
Emaze Auction will then output a list of users which meet your criteria in a table. For each user, it will list the useID, username, last name and first name. To edit a user, click on the userID. This will bring up that user's information in the right frame, where you can edit it. After editing the user's information, click on the <I>Edit User</I> button and Emaze Auction will update the information and return a message that the information was updated.
<P>
&nbsp; &nbsp; &nbsp; If you change the username or password, Emaze Auction will also check that the new username is not already taken, or that the password was verified properly. Please note that the password field is blank. You cannot actually view the password for that person. But there is no need to enter a new password unless you want to change it. Submitting the form with both password fields blank will simply not change the password.
<P>
There is also a checkbox next to each user which allows you to delete that user from the user database. For each user you want to delete, check the checkbox next to that name and then click on the <I>Delete Users</I> button at the bottom of the table. You must also check the checkbox below the buttons to delete the users.
<P>
&nbsp; &nbsp; &nbsp; If you delete a user who has posted messages to any forum, Emaze Auction will update the message to that of a message posted by an anon user so that the user's name and email address are still available when the messages posted by that user are displayed.
<P>
<DL>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="userMaster"></A>Master</FONT></B>
<DD>This enables you to edit the information for Master, i.e., the Admin user. Rather than find the Master user like a normal user, we have added a link to the Admin Table of Contents to make it much easier. For security purposes, the automated login via cookie option does not work for the Admin screens.
<P>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="userCreate"></A>Create</FONT></B>
<DD>To create a new user, you must enter at least a username and password. The password must be entered twice to verify it was entered correctly. You can also choose to enter the first name, last name, email address, or any of the other user fields.
<P>
After entering the user information, click on the <I>Create User</I> button to add the user to the database. Emaze Auction will check that the username is not already taken. If the username is already being used, it will ask you to choose another username. Emaze Auction will also verify that the password was entered the same both times. If not, it will ask you to re-enter the password. If all is well, the screen will reload with a blank add user form, telling you that the user has been added and enabling you to add another user.
<P>
<DT><B><FONT SIZE=4 COLOR=purple><A NAME="userImport"></A>Import</FONT></B>
<DD>You can import users via a comma-delimited text file. The text file may contain any of the user fields, including:
<P>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0><TR>
<TD VALIGN=top><UL>
<LI>Username
<LI>Password
<LI>First Name
<LI>Last Name
<LI>Email
<LI>Organization
<LI>Phone
</UL></TD>
<TD WIDTH=25>&nbsp;</TD>
<TD VALIGN=top><UL>
<LI>Address
<LI>Address2 (2nd line)
<LI>City
<LI>State / Province
<LI>Zip Code
<LI>Country
</UL></TD>
</TR></TABLE>
<P>
You need to enter the path to the text file being imported and then choose the order in which the fields appear in the text file. The fields can be in any order. The file must contain at least one field. Many databases add the field names at the top of the file. So you can choose to either delete the first line manually or tell Emaze Auction to ignore the first line of the text file when importing the users.
<P>
If the username is included in the list, Emaze Auction will only add those records which have unique usernames. It will return a list of users which were not added though.
</DL>

<P><HR NOSHADE COLOR=purple SIZE=3><HR NOSHADE COLOR=purple SIZE=3>
Copyright &copy; 1998, Emaze Software Corporation<BR>
<A HREF="http://www.emaze.com">http://www.emaze.com</A> / <A HREF="mailto:sales@emaze.com">sales@emaze.com</A> / <A HREF="mailto:support@emaze.com">support@emaze.com</A>

<P>
</BODY>
</HTML>