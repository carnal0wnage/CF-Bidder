
<CFIF getBidders.RecordCount NEQ 0>
	<CFMAIL	QUERY="getBidders"
		TO="#getBidders.email#"
		FROM="#fromemail#"
		SUBJECT="#Form.subject#"
		SERVER="#emailServer#">
#Form.message#
	</CFMAIL>
</CFIF>
