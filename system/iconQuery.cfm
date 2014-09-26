<CFIF ListFind(iconListIndexFields," Member.feedbackRating") EQ 0>
	, <CFOUTPUT>#iconListIndexFields#</CFOUTPUT>
	FROM Lot
<CFELSE>, <CFOUTPUT>#iconListIndexFields#</CFOUTPUT>
	FROM Lot INNER JOIN Member ON Lot.userID = Member.userID
</CFIF>
