
<CFMAIL QUERY="getBadSellers"
	TO="#sellerFeeEmailCC#"
	FROM="#sellerFeeEmailFromEmail#"
	SUBJECT="#sellerFeeEmailSubjectCardDeclined#"
	SERVER="#emailServer#">
Below is a list of sellers whose credit cards were rejected #LSDateFormat(Now(),"dddd, mmmm dd, yyyy")# . They will be processed again in 5 days.

</CFMAIL>