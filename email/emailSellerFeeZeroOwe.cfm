
<CFMAIL QUERY="getFees"
	TO="#email#"
	CC="#sellerFeeEmailCC#"
	FROM="#sellerFeeEmailFromEmail#"
	SUBJECT="#sellerFeeEmailSubjectZeroOwe#"
	SERVER="#emailServer#">
This is an automated email to notify you that your account has not been charged this month. This is because your combined insertion and commission fees did not exceed our minimum charge of #LSCurrencyFormat(sellerFeeMinimumToProcess,"local")#.Your account is processed every 30 days. It will be processed next on #LSDateFormat(sellerFeeProcessDayZeroOwe,"dddd, mmmm dd, yyyy")# .Below are the fees on your lots which have not yet been processed.<CFOUTPUT>Lot ID: #getFees.lotID#Lot Name: #getFees.lotName#Insertion Fee: #LSCurrencyFormat(getFees.insertionFee,"local")#Commission Fee: #LSCurrencyFormat(getFees.commissionFee,"local")#Bold Fee: #LSCurrencyFormat(getFees.boldFee,"local")#Featured Category: #LSCurrencyFormat(getFees.featuredCategoryFee,"local")#Featured Homepage: #LSCurrencyFormat(getFees.featuredHomepageFee,"local")#Total Fees for this lot: #LSCurrencyFormat(Evaluate(getFees.commissionFee + getFees.insertionFee + getFees.boldFee + getFees.featuredCategoryFee + getFees.featuredHomepageFee),"local")##systemURL#/lot.cfm?lotID=#getFees.lotID#-------------------------------------------------</CFOUTPUT>

</CFMAIL>
