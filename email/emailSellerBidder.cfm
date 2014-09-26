
<CFMAIL	QUERY="getBidders"
	TO="#getBidders.email#"
	FROM="#e_fromemailClose# (#checkSeller.firstName# #checkSeller.lastName#)"
	SUBJECT="#Form.subject#"
	SERVER="#emailServer#">
#Form.message#
</CFMAIL>
