<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: User Agreement</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF Form.userAgreement EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\userAgreement.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET userAgreement = Replace(Form.userAgreement, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\userAgreement.cfm" OUTPUT="#userAgreement#">
	</CFIF>

	<CFIF Form.userAgreementText EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\userAgreementText.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET userAgreementText = Replace(Form.userAgreementText, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\userAgreementText.cfm" OUTPUT="#userAgreementText#">
	</CFIF>

	<CFIF Form.userAgreementAccept EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\userAgreementAccept.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET userAgreementAccept = Replace(Form.userAgreementAccept, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\userAgreementAccept.cfm" OUTPUT="#userAgreementAccept#">
	</CFIF>

	<CFIF Form.userAgreementReject EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\userAgreementReject.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET userAgreementReject = Replace(Form.userAgreementReject, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\userAgreementReject.cfm" OUTPUT="#userAgreementReject#">
	</CFIF>

	<H3>User agreement updated.</H3>
	<HR NOSHADE SIZE=3 WIDTH=500 ALIGN=left>
</CFIF>

<H1><FONT COLOR=purple>User Agreement</FONT></H1>

<FORM METHOD=post ACTION=userAgree.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<B><FONT SIZE=4>HTML version for site:</FONT></B><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\userAgreement.cfm" VARIABLE="userAgreement">
<CFSET userAgreement = RTrim(userAgreement)>
<TEXTAREA NAME=userAgreement ROWS=15 COLS=60 WRAP=virtual><CFOUTPUT>#userAgreement#</CFOUTPUT></TEXTAREA>

<P>

<B><FONT SIZE=4>Text version for email:</FONT></B><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\userAgreementText.cfm" VARIABLE="userAgreementText">
<CFSET userAgreementText = RTrim(userAgreementText)>
<TEXTAREA NAME=userAgreementText ROWS=15 COLS=60 WRAP=virtual><CFOUTPUT>#userAgreementText#</CFOUTPUT></TEXTAREA>

<P>

<B><FONT SIZE=4>Message when user agreement is accepted:</FONT></B><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\userAgreementAccept.cfm" VARIABLE="userAgreementAccept">
<CFSET userAgreementAccept = RTrim(userAgreementAccept)>
<TEXTAREA NAME=userAgreementAccept ROWS=10 COLS=60 WRAP=virtual><CFOUTPUT>#userAgreementAccept#</CFOUTPUT></TEXTAREA>

<P>

<B><FONT SIZE=4>Message when user agreement is rejected:</FONT></B><BR>
<CFFILE ACTION=Read FILE="#systemPath#\system\userAgreementReject.cfm" VARIABLE="userAgreementReject">
<CFSET userAgreementReject = RTrim(userAgreementReject)>
<TEXTAREA NAME=userAgreementReject ROWS=10 COLS=60 WRAP=virtual><CFOUTPUT>#userAgreementReject#</CFOUTPUT></TEXTAREA>

<P>

<UL><INPUT TYPE=submit VALUE="Update User Agreement"></UL>
</FORM>

</body>
</html>
