
<CFMAIL QUERY="getAllFeesToday"
	TO="#sellerFeeEmailCC#"
	FROM="#sellerFeeEmailFromEmail#"
	SUBJECT="#sellerFeeEmailSubjectAllToday#"
	SERVER="#emailServer#">
This is a list of all lots that have been processed on #LSDateFormat(paidDateTime,"dddd, mmmm dd, yyyy")#. They are listed in alphabetical order by seller username, then the lot ID.

</CFMAIL>