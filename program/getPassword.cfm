<CFSET title = "titleGetPassword">
<CFINCLUDE TEMPLATE="../system/navigate.cfm">

<P>

<CFINCLUDE TEMPLATE="../system/getPasswordOptions.cfm">
<CFQUERY NAME=getPassword DATASOURCE="#EAdatasource#">
	SELECT username, password, email, mothersMaidenName
	FROM Member
	WHERE <CFIF IsDefined("Form.email")>email = '#Form.email#'</CFIF>
	<CFIF IsDefined("Form.username")><CFIF IsDefined("Form.email")> AND </CFIF> username = '#Form.username#'</CFIF> 
	<CFIF IsDefined("Form.mothersMaidenName")>
		<CFIF IsDefined("Form.email") OR IsDefined("Form.username")> AND </CFIF> 
		mothersMaidenName = '#Form.mothersMaidenName#'
	</CFIF>
</CFQUERY>

<CFIF getPassword.RecordCount EQ 0>
	<CFOUTPUT>#getPasswordRecordsZero#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	<CFINCLUDE TEMPLATE="../program/closeCheck.cfm">
	</BODY></HTML><CFABORT>
<CFELSEIF #getPassword.RecordCount# GT 1>
	<CFOUTPUT>#getPasswordRecordsMultiple#</CFOUTPUT>
	<CFINCLUDE TEMPLATE="copyright.cfm">
	<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
	<CFINCLUDE TEMPLATE="../program/closeCheck.cfm">
	</BODY></HTML><CFABORT>
</CFIF>

<CFINCLUDE TEMPLATE="../email/emailPassword.cfm">
<CFOUTPUT>#getPasswordEmailSent#</CFOUTPUT>

<P>
<CFINCLUDE TEMPLATE="closeCheck.cfm">
<CFINCLUDE TEMPLATE="copyright.cfm">
<CFINCLUDE TEMPLATE="../system/pageFooter.cfm">
<P>
</BODY>
</HTML>