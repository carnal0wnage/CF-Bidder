<!--- Emaze Auction version 2.1, 1.03 / Tuessday, July 5, 1999 --->
<CFINCLUDE TEMPLATE="../system/mailAuctionOptions.cfm">

<CFSET title = "titleMailAuction">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<CFIF NOT IsDefined("lotID")>
	<CFOUTPUT>#mailAuctionNoLot#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF IsNumeric("#lotID#") EQ "False">
	<CFOUTPUT>#mailAuctionBlankLot#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<P>

<CFINCLUDE TEMPLATE="../lot/#lotID#LotInfo.cfm">

<CFIF IsDefined("Form.first")>
	<CFIF Form.username EQ "" OR Form.username EQ " ">
		<CFOUTPUT>#mailAuctionBlankUsername#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>	
	<CFELSEIF Form.password EQ "" OR Form.password EQ " ">
		<CFOUTPUT>#mailAuctionBlankPassword#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>	
	<CFELSEIF Form.recipientEmail EQ "" OR Form.recipientEmail EQ " ">
		<CFOUTPUT>#mailAuctionBlankRecipient#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>	
	<CFELSEIF Find("@",Form.recipientEmail) EQ 0 OR Find(".",Form.recipientEmail) EQ 0>
		<CFOUTPUT>#mailAuctionBadRecipient#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>	
	</CFIF>

	<CFQUERY NAME=getSender DATASOURCE="#EAdatasource#">
		SELECT password, firstName, lastName, email, userStatus
		FROM Member
		WHERE username = '#Form.username#'
	</CFQUERY>
	<CFIF getSender.RecordCount NEQ 1>
		<CFOUTPUT>#mailAuctionBadLogin#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>	
	<CFELSEIF Form.password NEQ Decrypt(getSender.password,encryptionCode)>
		<CFOUTPUT>#mailAuctionBadLogin#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>
	<CFELSEIF getSender.userStatus NEQ 1>
		<CFOUTPUT>#mailAuctionBadStatus#</CFOUTPUT>
		<CFINCLUDE TEMPLATE="copyright.cfm">
		<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
		</BODY></HTML><CFABORT>	
	</CFIF>

	<CFIF mailAuctionCCSender EQ 1 AND IsDefined("Form.ccSender") AND getSender.email NEQ "" AND getSender.email NEQ " ">
		<CFSET emailTo = "#Form.recipientEmail#,#getSender.email#">
	<CFELSE>
		<CFSET emailTo = Form.recipientEmail>
	</CFIF>

	<CFIF mailAuctionSubjectFixed EQ 1>
		<CFSET subject = mailAuctionSubjectDefault>
	<CFELSEIF Form.subject EQ "">
		<CFSET subject = mailAuctionSubjectDefault>
	</CFIF>

	<CFINCLUDE TEMPLATE="../email/emailMailAuction.cfm">
	<CFINCLUDE TEMPLATE="../system/mailAuctionSuccess.cfm">

	<P>

	<CFFILE ACTION=Read FILE="#systemPath#\system\mailAuctionTop.cfm" VARIABLE="mailAuctionTop">
	<CFFILE ACTION=Read FILE="#systemPath#\system\mailAuctionBottom.cfm" VARIABLE="mailAuctionBottom">

	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH=600>
	<CFOUTPUT>
	<TR><TD ALIGN=right>#mailAuctionRecipient#</TD><TD>#Form.recipientEmail#</TD></TR>
	<TR><TD ALIGN=right>#mailAuctionSubject#</TD><TD>#subject#</TD></TR>
	<TR><TD ALIGN=right VALIGN=top>#mailAuctionMessage#</TD><TD>
	<CFIF mailAuctionTop NEQ " ">#Replace(mailAuctionTop, "
", "<BR>", "ALL")#</CFIF>
	#Form.message#
	<CFIF mailAuctionBottom NEQ " ">#Replace(mailAuctionBottom, "
", "<BR>", "ALL")#</CFIF>
	</TD></TR>
	</CFOUTPUT>
	</TABLE>

	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFINCLUDE TEMPLATE="../system/mailAuctionHeader.cfm">

<CFFORM ACTION="#systemURL#/program/mailAuction.cfm?lotID=#lotID#" NAME=mailAuction>
<INPUT TYPE=hidden NAME=first VALUE=1>
<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD ALIGN=right><CFOUTPUT>#mailAuctionUsername#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME=username SIZE=20 REQUIRED=Yes MESSAGE="#mailAuctionBlankUsername#"></TD></TR>
<TR><TD ALIGN=right><CFOUTPUT>#mailAuctionPassword#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=password NAME=password SIZE=20 REQUIRED=Yes MESSAGE="#mailAuctionBlankPassword#"></TD></TR>
<TR><TD ALIGN=right><CFOUTPUT>#mailAuctionRecipient#</CFOUTPUT></TD>
	<TD><CFINPUT TYPE=text NAME=recipientEmail SIZE=40 REQUIRED=Yes MESSAGE="#mailAuctionBlankRecipient#"></TD></TR>
<CFIF mailAuctionCCSender EQ 1>
	<TR><TD></TD><TD><INPUT TYPE=checkbox NAME=ccSender VALUE=1> <CFOUTPUT>#mailAuctionCCSenderText#</CFOUTPUT></TD></TR>
</CFIF>

<TR><TD>&nbsp;</TD></TR>

<TR><TD ALIGN=right><CFOUTPUT>#mailAuctionSubject#</CFOUTPUT></TD>
<CFIF mailAuctionSubjectFixed EQ 0>
	<TD><CFINPUT TYPE=text NAME=subject SIZE=40 MESSAGE="#mailAuctionSubjectDefault#"></TD></TR>
<CFELSE>
	<TD><CFOUTPUT>#mailAuctionSubjectDefault#</CFOUTPUT></TD></TR>
</CFIF>

<TR><TD ALIGN=right VALIGN=top><CFOUTPUT>#mailAuctionMessage#</CFOUTPUT></TD>
	<TD><TEXTAREA NAME=message ROWS=15 COLS=55 WRAP=virtual><CFINCLUDE TEMPLATE="../system/mailAuctionDefault.cfm"></TEXTAREA></TD></TR>
<TR HEIGHT=40><TD></TD><TD VALIGN=bottom>
<CFIF mailAuctionButtonReset NEQ ""><CFOUTPUT><INPUT TYPE=reset VALUE="#mailAuctionButtonReset#"></CFOUTPUT></CFIF>
<CFIF mailAuctionPreviewOption EQ -1>
	<CFOUTPUT><INPUT TYPE=submit NAME=mailAuctionSubmit VALUE="#mailAuctionButtonSubmit#"></CFOUTPUT> &nbsp; 
<CFELSEIF mailAuctionPreviewOption EQ 0>
	<CFOUTPUT><INPUT TYPE=submit NAME=mailAuctionSubmit VALUE="#mailAuctionButtonPreview#"> &nbsp; <INPUT TYPE=submit NAME=mailAuctionSubmit VALUE="#mailAuctionButtonSubmit#"></CFOUTPUT>
<CFELSE>
	<CFOUTPUT><INPUT TYPE=submit NAME=mailAuctionSubmit VALUE="#mailAuctionButtonPreview#"></CFOUTPUT>
</CFIF>
</TD></TR>
</TABLE>
</CFFORM>
<P>
<CFINCLUDE TEMPLATE="../system/mailAuctionFooter.cfm">

<P>
<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
<CFINCLUDE TEMPLATE="closeCheck.cfm">

</BODY>
</HTML>