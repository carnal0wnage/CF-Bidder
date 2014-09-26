
<CFMAIL	TO="#sellerEmail#"
	FROM="#e_fromemailDailyStatus#"
	SUBJECT="#e_subjectDailyStatus#"
	SERVER="#emailServer#">
#sellerUsername#,This is the daily status email from Emaze Auction. Below is an update on all lots that you have posted.

#dailyStatusEmail#

Thanks for using Emaze Auction. We sincerely appreciate your support.For an update on your items, you can log into your seller homepage anytime at:#systemURL#/seller/sellerIndex.cfm#systemURL#

</CFMAIL>
