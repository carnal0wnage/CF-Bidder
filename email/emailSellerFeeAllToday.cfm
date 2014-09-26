
<CFMAIL QUERY="getAllFeesToday"
	TO="#sellerFeeEmailCC#"
	FROM="#sellerFeeEmailFromEmail#"
	SUBJECT="#sellerFeeEmailSubjectAllToday#"
	SERVER="#emailServer#">
This is a list of all lots that have been processed on #LSDateFormat(paidDateTime,"dddd, mmmm dd, yyyy")#. They are listed in alphabetical order by seller username, then the lot ID.<CFOUTPUT>Seller: #getAllFeesToday.username##getAllFeesToday.firstName# #getAllFeesToday.lastName##getAllFeesToday.email#Lot ID: #getAllFeesToday.lotID#Lot Name: #getAllFeesToday.lotName#Insertion Fee: #LSCurrencyFormat(getFees.insertionFee,"local")#Commission Fee: #LSCurrencyFormat(getFees.commissionFee,"local")#Bold Fee: #LSCurrencyFormat(getFees.boldFee,"local")#Featured Category: #LSCurrencyFormat(getFees.featuredCategoryFee,"local")#Featured Homepage: #LSCurrencyFormat(getFees.featuredHomepageFee,"local")#Total Fees for this lot: #LSCurrencyFormat(Evaluate(getFees.commissionFee + getFees.insertionFee + getFees.boldFee + getFees.featuredCategoryFee + getFees.featuredHomepageFee),"local")#----------------------------------------------</CFOUTPUT>

</CFMAIL>
