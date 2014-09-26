<OPTION VALUE="">SELECT CARD TYPE
<CFIF ListFind(creditCardTypeList,"Visa")><OPTION VALUE=Visa<CFIF creditCardType EQ "Visa"> SELECTED</CFIF>> Visa</CFIF>
<CFIF ListFind(creditCardTypeList,"MasterCard")><OPTION VALUE=MasterCard<CFIF creditCardType EQ "MasterCard"> SELECTED</CFIF>> MasterCard</CFIF>
<CFIF ListFind(creditCardTypeList,"American Express")><OPTION VALUE="American Express"<CFIF creditCardType EQ "American Express"> SELECTED</CFIF>> American Express</CFIF>
<CFIF ListFind(creditCardTypeList,"Diners Club/Carte Blanche")><OPTION VALUE="Diners Club/Carte Blanche"<CFIF creditCardType EQ "Diners Club/Carte Blanche"> SELECTED</CFIF>> Diners Club/Carte Blanche</CFIF>
<CFIF ListFind(creditCardTypeList,"Discover")><OPTION VALUE=Discover<CFIF creditCardType EQ "Discover"> SELECTED</CFIF>> Discover</CFIF>
<CFIF ListFind(creditCardTypeList,"enRoute")><OPTION VALUE=enRoute<CFIF creditCardType EQ "enRoute"> SELECTED</CFIF>> enRoute</CFIF>
<CFIF ListFind(creditCardTypeList,"JCB")><OPTION VALUE=JCB<CFIF creditCardType EQ "JCB" NEQ 0> SELECTED</CFIF>> JCB</CFIF>
