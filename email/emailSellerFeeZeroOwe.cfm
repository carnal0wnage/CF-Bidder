
<CFMAIL QUERY="getFees"
	TO="#email#"
	CC="#sellerFeeEmailCC#"
	FROM="#sellerFeeEmailFromEmail#"
	SUBJECT="#sellerFeeEmailSubjectZeroOwe#"
	SERVER="#emailServer#">
This is an automated email to notify you that your account has not been charged this month. This is because your combined insertion and commission fees did not exceed our minimum charge of #LSCurrencyFormat(sellerFeeMinimumToProcess,"local")#.

</CFMAIL>