
<CFIF getTodaysSellers.RecordCount GT 0>
	<CFMAIL QUERY="getTodaysSellers"
		TO="#sellerFeeEmailCC#"
		FROM="#sellerFeeEmailFromEmail#"
		SUBJECT="#sellerFeeEmailSubjectList#"
		SERVER="#emailServer#">
Seller fee script run. Here is the list of sellers to be processed today:<CFOUTPUT>#firstName# #lastName# (#username#)#email#</CFOUTPUT>

	</CFMAIL>
<CFELSE>
	<CFMAIL TO="#sellerFeeEmailCC#"
		FROM="#sellerFeeEmailFromEmail#"
		SUBJECT="#sellerFeeEmailSubjectList#"
		SERVER="#emailServer#">
Seller fee script run. No sellers were processed today.

	</CFMAIL>
	<CFABORT>
</CFIF>
