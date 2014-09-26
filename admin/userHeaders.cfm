<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">
<HTML>
<HEAD><TITLE>Emaze Auction: Headers / Footer</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>


<CFSET helpContext = "headers">

<CFIF IsDefined("first")>
	<CFIF Form.addUserHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\addUserHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET addUserHeader = Replace(Form.addUserHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\addUserHeader.cfm" OUTPUT="#addUserHeader#">
	</CFIF>

	<CFIF Form.addUserSuccess EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\addUserSuccess.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET addUserSuccess = Replace(Form.addUserSuccess, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\addUserSuccess.cfm" OUTPUT="#addUserSuccess#">
	</CFIF>

	<CFIF Form.addUserVerify EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\addUserVerify.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET addUserVerify = Replace(Form.addUserVerify, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\addUserVerify.cfm" OUTPUT="#addUserVerify#">
	</CFIF>

	<CFIF Form.addUserSuccess2 EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\addUserSuccess2.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET addUserSuccess2 = Replace(Form.addUserSuccess2, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\addUserSuccess2.cfm" OUTPUT="#addUserSuccess2#">
	</CFIF>

	<CFIF Form.verifyReject EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\verifyReject.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET verifyReject = Replace(Form.verifyReject, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\verifyReject.cfm" OUTPUT="#verifyReject#">
	</CFIF>

	<CFIF Form.verifySuccess EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\verifySuccess.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET verifySuccess = Replace(Form.verifySuccess, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\verifySuccess.cfm" OUTPUT="#verifySuccess#">
	</CFIF>

	<CFIF Form.editUserHeader EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\editUserHeader.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET editUserHeader = Replace(Form.editUserHeader, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\editUserHeader.cfm" OUTPUT="#editUserHeader#">
	</CFIF>

	<CFIF Form.editUserSuccess EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\editUserSuccess.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET editUserSuccess = Replace(Form.editUserSuccess, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\editUserSuccess.cfm" OUTPUT="#editUserSuccess#">
	</CFIF>

	<CFIF Form.editUserVerify EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\editUserVerify.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET editUserVerify = Replace(Form.editUserVerify, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\editUserVerify.cfm" OUTPUT="#editUserVerify#">
	</CFIF>

	<CFIF Form.editUserSuccess2 EQ "">
		<CFFILE ACTION=Write FILE="#systemPath#\system\editUserSuccess2.cfm" OUTPUT=" ">
	<CFELSE>
		<CFSET editUserSuccess2 = Replace(Form.editUserSuccess2, "
", "", "ALL")>
		<CFFILE ACTION=Write FILE="#systemPath#\system\editUserSuccess2.cfm" OUTPUT="#editUserSuccess2#">
	</CFIF>

	<H3>User headers updated.</H3>
	<P><HR NOSHADE COLOR=purple SIZE=3 WIDTH=400 ALIGN=left><P>
</CFIF>

<FONT SIZE=6 COLOR=purple><B>Headers / Footer</B></FONT>

<FORM METHOD=post ACTION=userHeaders.cfm>
<INPUT TYPE=hidden NAME=first VALUE=0>

<DL>
<DT><B>Add user screen header</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\addUserHeader.cfm" VARIABLE="addUserHeader">
<CFSET addUserHeader = RTrim(addUserHeader)>
<DD><TEXTAREA NAME="addUserHeader" COLS="60" ROWS="10" WRAP="virtual"><CFOUTPUT>#addUserHeader#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Add user screen success - top</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\addUserSuccess.cfm" VARIABLE="addUserSuccess">
<CFSET addUserSuccess = RTrim(addUserSuccess)>
<DD><TEXTAREA NAME="addUserSuccess" COLS="60" ROWS="10" WRAP="virtual"><CFOUTPUT>#addUserSuccess#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Add user screen verify email (middle)</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\addUserVerify.cfm" VARIABLE="addUserVerify">
<CFSET addUserVerify = RTrim(addUserVerify)>
<DD><TEXTAREA NAME="addUserVerify" COLS="60" ROWS="10" WRAP="virtual"><CFOUTPUT>#addUserVerify#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Add user screen success - bottom</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\addUserSuccess2.cfm" VARIABLE="addUserSuccess2">
<CFSET addUserSuccess2 = RTrim(addUserSuccess2)>
<DD><TEXTAREA NAME="addUserSuccess2" COLS="60" ROWS="10" WRAP="virtual"><CFOUTPUT>#addUserSuccess2#</CFOUTPUT></TEXTAREA>

<P>
<DT><P><HR NOSHADE SIZE=3 COLOR=purple WIDTH=400 ALIGN=left><P>
<B>Verify email screen - not correct</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\verifyReject.cfm" VARIABLE="verifyReject">
<CFSET verifyReject = RTrim(verifyReject)>
<DD><TEXTAREA NAME="verifyReject" COLS="60" ROWS="5" WRAP="virtual"><CFOUTPUT>#verifyReject#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Verify email screen - success!</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\verifySuccess.cfm" VARIABLE="verifySuccess">
<CFSET verifySuccess = RTrim(verifySuccess)>
<DD><TEXTAREA NAME="verifySuccess" COLS="60" ROWS="5" WRAP="virtual"><CFOUTPUT>#verifySuccess#</CFOUTPUT></TEXTAREA>

<P>
<DT><P><HR NOSHADE SIZE=3 COLOR=purple WIDTH=400 ALIGN=left><P>
<B>Edit user screen header</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\editUserHeader.cfm" VARIABLE="editUserHeader">
<CFSET editUserHeader = RTrim(editUserHeader)>
<DD><TEXTAREA NAME="editUserHeader" COLS="60" ROWS="7" WRAP="virtual"><CFOUTPUT>#editUserHeader#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Edit user screen success - top</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\editUserSuccess.cfm" VARIABLE="editUserSuccess">
<CFSET addUserSuccess = RTrim(editUserSuccess)>
<DD><TEXTAREA NAME="editUserSuccess" COLS="60" ROWS="7" WRAP="virtual"><CFOUTPUT>#editUserSuccess#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Edit user screen verify email (middle)</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\editUserVerify.cfm" VARIABLE="editUserVerify">
<CFSET editUserVerify = RTrim(editUserVerify)>
<DD><TEXTAREA NAME="editUserVerify" COLS="60" ROWS="7" WRAP="virtual"><CFOUTPUT>#editUserVerify#</CFOUTPUT></TEXTAREA>
<P>
<DT><B>Edit user screen success - bottom</B>
<CFFILE ACTION=Read FILE="#systemPath#\system\editUserSuccess2.cfm" VARIABLE="editUserSuccess2">
<CFSET editUserSuccess2 = RTrim(editUserSuccess2)>
<DD><TEXTAREA NAME="editUserSuccess2" COLS="60" ROWS="7" WRAP="virtual"><CFOUTPUT>#editUserSuccess2#</CFOUTPUT></TEXTAREA>

</DL>

<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit NAME=edit VALUE="Edit Headers">

</FORM>
</BODY>
</HTML>