<CFIF NOT IsDefined("title")><CFSET title = "">
<CFELSEIF title NEQ "" AND Find(" ",title) EQ 0 AND Find("!",title) EQ 0 AND Find("/",title) EQ 0>
	<CFIF Left(title,5) EQ "forum" AND IsDefined(title)><CFSET title = Evaluate(title)>
	<CFELSEIF Left(title,7) EQ "procure"><CFINCLUDE TEMPLATE="../systemProcure/procurePageTitles.cfm">
	<CFELSEIF Left(title,6) EQ "market"><CFINCLUDE TEMPLATE="../systemMarket/marketPageTitles.cfm">
	<CFELSEIF Left(title,6) EQ "seller"><CFINCLUDE TEMPLATE="../systemSeller/sellerPageTitles.cfm">
	<CFELSEIF Find(" ", title) EQ 0><CFINCLUDE TEMPLATE="pageTitles.cfm">
	</CFIF>
</CFIF>

<HTML>
<HEAD><TITLE><CFOUTPUT>#indexTitle# #title#</CFOUTPUT></TITLE></HEAD>
<CFINCLUDE TEMPLATE="bodytag.cfm">

<CFINCLUDE TEMPLATE="pageHeader.cfm">
<CFINCLUDE TEMPLATE="navTableBg.cfm">

<CFIF NOT IsDefined("indexLogo") OR IsDefined("categoryID")>
	<CFSET indexLogoLocation = -1>
<CFELSEIF indexLogo NEQ "" AND indexLogo NEQ " " AND indexLogoLocation EQ 0>
	<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH=600><TR><TD ALIGN=center>
	<CFOUTPUT><IMG SRC="#indexLogo#"></CFOUTPUT>
	</TD></TR></TABLE>
</CFIF>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 WIDTH=600>
<TR><TD ALIGN=center><CFINCLUDE TEMPLATE="navigateLinks.cfm"></TD></TR>
<CFIF indexLogoLocation GTE 1>
	<TR><TD ALIGN=center><CFOUTPUT><IMG SRC="#indexLogo#"></CFOUTPUT></TD></TR>
</CFIF>
<CFIF indexLogoLocation NEQ 2>
	<TR><CFOUTPUT><TD ALIGN=center BGCOLOR="#navBottomTableBg#"><FONT SIZE=5 COLOR="#navTableFont#" FACE="arial"><B>#title#</B></FONT></TD></CFOUTPUT></TR>
</CFIF>
</TABLE>
<P>
