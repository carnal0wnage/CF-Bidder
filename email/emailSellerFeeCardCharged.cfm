
<CFMAIL QUERY="getFees"
	TO="#email#"
	CC="#sellerFeeEmailCC#"
	FROM="#sellerFeeEmailFromEmail#"
	SUBJECT="#sellerFeeEmailSubjectCardCharged#"
	SERVER="#emailServer#">
This is an automated email to notify you that your credit card has been charged #LSCurrencyFormat(processAmount,"local")# for your insertion and commission fees on the lots listed below.
<CFIF processAmount LT totalFees>
You will notice that amount processed is less than the total fees for the lots below. This is because of the initial #LSCurrencyFormat(sellerFeeMinimumToProcess,"local")# charged to your credit card after your initial #LSCurrencyFormat(sellerFeeCredit,"local")# free credit.
</CFIF>
Your account is processed every 30 days. It will be processed next on #LSDateFormat(sellerFeeProcessDaySuccess,"dddd, mmmm dd, yyyy")# .

<CFOUTPUT>Lot ID: #getFees.lotID#
Lot Name: #getFees.lotName#

Insertion Fee: #LSCurrencyFormat(getFees.insertionFee,"local")#
Commission Fee: #LSCurrencyFormat(getFees.commissionFee,"local")#
Bold Fee: #LSCurrencyFormat(getFees.boldFee,"local")#
Featured Category: #LSCurrencyFormat(getFees.featuredCategoryFee,"local")#
Featured Homepage: #LSCurrencyFormat(getFees.featuredHomepageFee,"local")#

Total Fees for this lot: #LSCurrencyFormat(Evaluate(getFees.commissionFee + getFees.insertionFee + getFees.boldFee + getFees.featuredCategoryFee + getFees.featuredHomepageFee),"local")#

#systemURL#/lot.cfm?lotID=#getFees.lotID#

-------------------------------------------------

</CFOUTPUT>

</CFMAIL>
