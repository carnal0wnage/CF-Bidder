<CFIF Form.e_fromnameNewsletter NEQ "" AND Form.e_fromnameNewsletter NEQ " ">
	<CFSET e_fromemailNewsletter = "#Form.e_fromemailNewsletter# (#Form.e_fromnameNewsletter#)">
</CFIF>

<CFMAIL	QUERY="getSubscribers"
	TO="#getSubscribers.email#"
	FROM="#e_fromemailNewsletter#"
	SUBJECT="#Form.e_subjectNewsletter#"
	SERVER="#emailServer#">
#Form.message#
</CFMAIL>
