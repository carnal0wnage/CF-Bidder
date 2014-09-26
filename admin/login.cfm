<!--- Emaze Auction version 2.1, 1.01 / Wednesday, June 16, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">
<HTML>
<HEAD><TITLE>Emaze Auction: Login Header, Footer</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFSET helpContext = "headers">

<CFIF IsDefined("first")>
	<CFSET editUserLoginBad = Replace(Form.editUserLoginBad, """", "&quot;", "ALL")>
	<CFSET editUserLoginBidStatus = Replace(Form.editUserLoginBidStatus, """", "&quot;", "ALL")>
	<CFSET editUserLoginWatch = Replace(Form.editUserLoginWatch, """", "&quot;", "ALL")>
	<CFSET editUserLoginSubscribe = Replace(Form.editUserLoginSubscribe, """", "&quot;", "ALL")>
	<CFSET editUserLoginEdit = Replace(Form.editUserLoginEdit, """", "&quot;", "ALL")>
	<CFSET editUserLoginUsernameText = Replace(Form.editUserLoginUsernameText, """", "&quot;", "ALL")>
	<CFSET editUserLoginUsernameError = Replace(Form.editUserLoginUsernameError, """", "&quot;", "ALL")>
	<CFSET editUserLoginPasswordText = Replace(Form.editUserLoginPasswordText, """", "&quot;", "ALL")>
	<CFSET editUserLoginPasswordError = Replace(Form.editUserLoginPasswordError, """", "&quot;", "ALL")>
	<CFSET editUserLoginButtonSubmit = Replace(Form.editUserLoginButtonSubmit, """", "&quot;", "ALL")>
	<CFSET editUserLoginButtonBidStatus = Replace(Form.editUserLoginButtonBidStatus, """", "&quot;", "ALL")>
	<CFSET editUserLoginButtonSellerHome = Replace(Form.editUserLoginButtonSellerHome, """", "&quot;", "ALL")>
	<CFSET editUserLoginButtonSubscribe = Replace(Form.editUserLoginButtonSubscribe, """", "&quot;", "ALL")>

	<CFSET editUserLoginBad = Replace(editUserLoginBad, "##", "####", "ALL")>
	<CFSET editUserLoginBidStatus = Replace(editUserLoginBidStatus, "##", "####", "ALL")>
	<CFSET editUserLoginWatch = Replace(editUserLoginWatch, "##", "####", "ALL")>
	<CFSET editUserLoginSubscribe = Replace(editUserLoginSubscribe, "##", "####", "ALL")>
	<CFSET editUserLoginEdit = Replace(editUserLoginEdit, "##", "####", "ALL")>
	<CFSET editUserLoginUsernameText = Replace(editUserLoginUsernameText, "##", "####", "ALL")>
	<CFSET editUserLoginUsernameError = Replace(editUserLoginUsernameError, "##", "####", "ALL")>
	<CFSET editUserLoginPasswordText = Replace(editUserLoginPasswordText, "##", "####", "ALL")>
	<CFSET editUserLoginPasswordError = Replace(editUserLoginPasswordError, "##", "####", "ALL")>
	<CFSET editUserLoginButtonSubmit = Replace(editUserLoginButtonSubmit, "##", "####", "ALL")>
	<CFSET editUserLoginButtonBidStatus = Replace(editUserLoginButtonBidStatus, "##", "####", "ALL")>
	<CFSET editUserLoginButtonSellerHome = Replace(editUserLoginButtonSellerHome, "##", "####", "ALL")>
	<CFSET editUserLoginButtonSubscribe = Replace(editUserLoginButtonSubscribe, "##", "####", "ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\editUserLogin.cfm"
		OUTPUT="<CFSET editUserLoginBad = ""#editUserLoginBad#"">
<CFSET editUserLoginBidStatus = ""#editUserLoginBidStatus#"">
<CFSET editUserLoginWatch = ""#editUserLoginWatch#"">
<CFSET editUserLoginSubscribe = ""#editUserLoginSubscribe#"">
<CFSET editUserLoginEdit = ""#editUserLoginEdit#"">
<CFSET editUserLoginUsernameText = ""#editUserLoginUsernameText#"">
<CFSET editUserLoginUsernameError = ""#editUserLoginUsernameError#"">
<CFSET editUserLoginPasswordText = ""#editUserLoginPasswordText#"">
<CFSET editUserLoginPasswordError = ""#editUserLoginPasswordError#"">
<CFSET editUserLoginButtonSubmit = ""#editUserLoginButtonSubmit#"">
<CFSET editUserLoginButtonBidStatus = ""#editUserLoginButtonBidStatus#"">
<CFSET editUserLoginButtonSellerHome = ""#editUserLoginButtonSellerHome#"">
<CFSET editUserLoginButtonSubscribe = ""#editUserLoginButtonSubscribe#"">">

	<CFIF Form.loginHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\loginHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET loginHeader = Replace(Form.loginHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\loginHeader.cfm" OUTPUT="#loginHeader#">
	</CFIF>

	<CFIF Form.loginFooter EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\loginFooter.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET loginFooter = Replace(Form.loginFooter, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\loginFooter.cfm" OUTPUT="#loginFooter#">
	</CFIF>

	<CFIF Form.categorySubscribe EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\categorySubscribe.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET categorySubscribe = Replace(Form.categorySubscribe, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\categorySubscribe.cfm" OUTPUT="#categorySubscribe#">
	</CFIF>

	<CFIF Form.lotWatch EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\lotWatch.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET lotWatch = Replace(Form.lotWatch, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\lotWatch.cfm" OUTPUT="#lotWatch#">
	</CFIF>

	<H3>Login text, header and footer updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Login Text, Header &amp; Footer</B></FONT>

<CFFORM NAME=login ACTION=login.cfm>
<INPUT TYPE=hidden NAME=first VALUE=0>

The edit user screen processes the login for users when they try to edit their user information, view their bid status, subscribe to a category, 
<CFIF FileExists("#systemPath#\admin\sellerHeaders.cfm")>watch an auction, or log into the user's seller homepage.
<CFELSE>or watch an auction.</CFIF> Below you can customize the various text that will appear on the page.

<DL>
<DT><B>Subscribe to category success</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\categorySubscribe.cfm" VARIABLE="categorySubscribe">
<CFSET categorySubscribe = RTrim(categorySubscribe)>
<DD><TEXTAREA NAME="categorySubscribe" COLS=70 ROWS=6 WRAP=off><CFOUTPUT>#categorySubscribe#</CFOUTPUT></TEXTAREA>

<P>

<DT><B>Watch a lot success</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\lotWatch.cfm" VARIABLE="lotWatch">
<CFSET lotWatch = RTrim(lotWatch)>
<DD><TEXTAREA NAME="lotWatch" COLS=70 ROWS=6 WRAP=off><CFOUTPUT>#lotWatch#</CFOUTPUT></TEXTAREA>
</DL>

<P>

<CFINCLUDE TEMPLATE="../system/editUserLogin.cfm">
<TABLE BORDER=1 CELLSPACING=3 CELLPADDING=3>
<TR><TD ALIGN=right>Edit User: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginEdit SIZE=60 VALUE="#editUserLoginEdit#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Bad Login: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginBad SIZE=60 VALUE="#editUserLoginBad#"></TD></TR>
<TR><TD ALIGN=right>Check bid status: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginBidStatus SIZE=60 VALUE="#editUserLoginBidStatus#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Watch an auction: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginWatch SIZE=60 VALUE="#editUserLoginWatch#"></TD></TR>
<TR><TD ALIGN=right>Subscribe to category: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginSubscribe SIZE=60 VALUE="#editUserLoginSubscribe#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Username: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginUsernameText SIZE=30 VALUE="#editUserLoginUsernameText#"></TD></TR>
<TR><TD ALIGN=right>Username blank error: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginUsernameError SIZE=60 VALUE="#editUserLoginUsernameError#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Password: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginPasswordText SIZE=30 VALUE="#editUserLoginPasswordText#"></TD></TR>
<TR><TD ALIGN=right>Password blank error: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginPasswordError SIZE=60 VALUE="#editUserLoginPasswordError#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Submit: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginButtonSubmit SIZE=30 VALUE="#editUserLoginButtonSubmit#"></TD></TR>
<TR><TD ALIGN=right>Bid Status button: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginButtonBidStatus SIZE=30 VALUE="#editUserLoginButtonBidStatus#"></TD></TR>
<TR BGCOLOR="#C6E2FF"><TD ALIGN=right>Seller home button: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginButtonSellerHome SIZE=30 VALUE="#editUserLoginButtonSellerHome#"></TD></TR>
<TR><TD ALIGN=right>Subscribe to category button: </TD><TD><CFINPUT TYPE=text NAME=editUserLoginButtonSubscribe SIZE=30 VALUE="#editUserLoginButtonSubscribe#"></TD></TR>
</TABLE>

<P><INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit NAME=edit VALUE="Update Login"><P>

The login screen is where bidders log in to private lots for which they have permission. This is the header that appears above the login form and the footer that appears below it.
<P>

<DL>
<DT><B>Login screen header</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\loginHeader.cfm" VARIABLE="loginHeader">
<CFSET loginHeader = RTrim(loginHeader)>
<DD><TEXTAREA NAME=loginHeader COLS=60 ROWS=7 WRAP=virtual><CFOUTPUT>#loginHeader#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Login screen footer</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\loginFooter.cfm" VARIABLE="loginFooter">
<CFSET loginFooter = RTrim(loginFooter)>
<DD><TEXTAREA NAME=loginFooter COLS=60 ROWS=7 WRAP=virtual><CFOUTPUT>#loginFooter#</CFOUTPUT></TEXTAREA>
</DL>

<P>

<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit NAME=edit VALUE="Update Login">

</CFFORM>
</BODY>
</HTML>