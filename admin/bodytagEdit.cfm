<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<!---
Writes body tag options to database and creates body tag to be included in pages.

Each color option allows you to choose from a prepared list of colors
in a select list, or to enter another color in the text field. Then just
check the appropriate radio button to indicate which you want to use.

The body background and other tags require the corresponding checkbox
to be checked. The other field is used to add any additional body tag
elements you want.

For each body tag element, we set 2 variables. The first is new the value to
be updated in the database; the second is the text to be included in the
body tag. The first is just the value, while the second includes the body
tag attribute with an equal sign, e.g., TEXT="#textValue#" .

If the text field is chosen over the select field, but the text field is
empty, we insert a blank space into the database and body tag.
--->

<HTML>
<HEAD><TITLE>Emaze Auction: Body Tag</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFFILE ACTION=Write FILE="#systemPath#\Application.cfm"
		OUTPUT="<CFSETTING ENABLECFOUTPUTONLY=""Yes"">
<CFSET systemPath = ""#systemPath#"">
<CFSET systemURL = ""#systemURL#"">
<CFSET EAdatasource = ""#EAdatasource#"">
<CFSET secureSystemURL = ""#secureSystemURL#"">
<CFSET emailServer = ""#emailServer#"">
<CFSET systemDomain = ""#systemDomain#"">
<CFSET encryptionCode = ""#encryptionCode#"">
<CFSET indexTitle = ""#indexTitle#"">
<CFSET dateFormatDisplay = ""#Form.dateFormatDisplay#"">
<CFSET timeFormatTimeZone = ""#Form.timeFormatTimeZone#"">
<CFSET timeFormatDisplay = ""#Form.timeFormatDisplay#"">
<CFSET subCategorySeparator = ""#Form.subCategorySeparator#"">
<CFSET indexTemplate = ""#indexTemplate#"">
<CFSET currentlocale = SetLocale(""#Form.newCurrentLocale#"")>
<CFSETTING ENABLECFOUTPUTONLY=""No"">
">

	<CFIF Form.bodyBgcolorRadio EQ "select">
		<CFSET bodyBgcolor = "BGCOLOR=""#Form.bodyBgcolorSelect#""">
		<CFSET bodyBgcolorDB = Form.bodyBgcolorSelect>
	<CFELSEIF Form.bodyBgcolorRadio EQ "other" AND Form.bodyBgcolorText NEQ "">
		<CFSET bodyBgcolor = "BGCOLOR=""#Form.bodyBgcolorText#""">
		<CFIF Find("##","#Form.bodyBgcolorText#",1) EQ 0>
			<CFSET bodyBgcolorDB = Form.bodyBgcolorText>
		<CFELSE>
			<CFSET bodyBgcolorDB = "###Form.bodyBgcolorText#">
		</CFIF>
	<CFELSE>
		<CFSET bodyBgcolor = "white">
		<CFSET bodyBgcolorDB = "white">
	</CFIF>

	<CFIF Form.bodyTextRadio EQ "select">
		<CFSET bodyText = "TEXT=""#Form.bodyTextSelect#""">
		<CFSET bodyTextDB = Form.bodyTextSelect>
	<CFELSEIF Form.bodyTextRadio EQ "other" AND Form.bodyTextText NEQ "">
		<CFSET bodyText = "TEXT=""#Form.bodyTextText#""">
		<CFIF Find("##","#Form.bodyTextText#",1) EQ 0>
			<CFSET bodyTextDB = Form.bodyTextText>
		<CFELSE>
			<CFSET bodyTextDB = "###Form.bodyTextText#">
		</CFIF>
	<CFELSE>
		<CFSET bodyText = "black">
		<CFSET bodyTextDB = "black">
	</CFIF>

	<CFIF Form.bodyLinkRadio EQ "select">
		<CFSET bodyLink = "LINK=""#Form.bodyLinkSelect#""">
		<CFSET bodyLinkDB = Form.bodyLinkSelect>
	<CFELSEIF Form.bodyLinkRadio EQ "other" AND Form.bodyLinkText NEQ "">
		<CFSET bodyLink = "LINK=""#Form.bodyLinkText#""">
		<CFIF Find("##","#Form.bodyLinkText#",1) EQ 0>
			<CFSET bodyLinkDB = Form.bodyLinkText>
		<CFELSE>
			<CFSET bodyLinkDB = "###Form.bodyLinkText#">
		</CFIF>
	<CFELSE>
		<CFSET bodyLink = "blue">
		<CFSET bodyLinkDB = "blue">
	</CFIF>

	<CFIF Form.bodyAlinkRadio EQ "select">
		<CFSET bodyAlink = "ALINK=""#Form.bodyAlinkSelect#""">
		<CFSET bodyAlinkDB = Form.bodyAlinkSelect>
	<CFELSEIF Form.bodyAlinkRadio EQ "other" AND Form.bodyAlinkText NEQ "">
		<CFSET bodyAlink = "ALINK=""#Form.bodyAlinkText#""">
		<CFIF Find("##","#Form.bodyAlinkText#",1) EQ 0>
			<CFSET bodyAlinkDB = Form.bodyAlinkText>
		<CFELSE>
			<CFSET bodyAlinkDB = "###Form.bodyAlinkText#">
		</CFIF>
	<CFELSE>
		<CFSET bodyAlink = "purple">
		<CFSET bodyAlinkDB = "purple">
	</CFIF>

	<CFIF Form.bodyVlinkRadio EQ "select">
		<CFSET bodyVlink = "VLINK=""#Form.bodyVlinkSelect#""">
		<CFSET bodyVlinkDB = Form.bodyVlinkSelect>
	<CFELSEIF Form.bodyVlinkRadio EQ "other" AND Form.bodyVlinkText NEQ "">
		<CFSET bodyVlink = "VLINK=""#Form.bodyVlinkText#""">
		<CFIF Find("##","#Form.bodyVlinkText#",1) EQ 0>
			<CFSET bodyVlinkDB = Form.bodyVlinkText>
		<CFELSE>
			<CFSET bodyVlinkDB = "###Form.bodyVlinkText#">
		</CFIF>
	<CFELSE>
		<CFSET bodyVlink = "purple">
		<CFSET bodyVlinkDB = "purple">
	</CFIF>

	<CFIF Form.bodyBackground NEQ "" AND Form.bodyBackground NEQ " " AND Form.bodyBackground NEQ "http://">
		<CFSET bodyBackground = "BACKGROUND=""#Form.bodyBackground#""">
		<CFSET bodyBackgroundDB = Form.bodyBackground>
	<CFELSE>
		<CFSET bodyBackground = " ">
		<CFSET bodyBackgroundDB = " ">
	</CFIF>
	
	<CFIF Form.bodyOther NEQ "" AND Form.bodyOther NEQ " ">
		<CFSET bodyOther = Form.bodyOther>
		<CFSET bodyOtherDB = Form.bodyOther>
	<CFELSE>
		<CFSET bodyOther = " ">
		<CFSET bodyOtherDB = " ">
	</CFIF>

	<!--- Write default body tag and default body tag list files. --->
	<CFIF bodyBackground EQ " " AND bodyOther EQ " "><!--- no background, other tags --->
		<CFFILE ACTION=Write FILE="#systemPath#\system\bodytag.cfm"
			OUTPUT="<BODY #bodyBgcolor# #bodyText# #bodyLink# #bodyAlink# #bodyVlink#>">
	<CFELSEIF bodyBackground NEQ " " AND bodyOther NEQ " "><!--- background, other tags --->
		<CFFILE ACTION=Write FILE="#systemPath#\system\bodytag.cfm"
			OUTPUT="<BODY #bodyBgcolor# #bodyBackground# #bodyText# #bodyLink# #bodyAlink# #bodyVlink# #bodyOther#>">
	<CFELSEIF bodyOther EQ " "><!--- background, but no other tags --->
		<CFFILE ACTION=Write FILE="#systemPath#\system\bodytag.cfm"
			OUTPUT="<BODY #bodyBgcolor# #bodyBackground# #bodyText# #bodyLink# #bodyAlink# #bodyVlink#>">
	<CFELSE><!--- bodyBackground EQ " " ---><!--- other tags,but no background --->
		<CFFILE ACTION=Write FILE="#systemPath#\system\bodytag.cfm"
			OUTPUT="<BODY #bodyBgcolor# #bodyText# #bodyLink# #bodyAlink# #bodyVlink# #bodyOther#>">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\system\bodytagList.cfm"
		OUTPUT="<CFSET bodyBgcolor = ""#bodyBgcolorDB#"">
<CFSET bodyBackground = ""#bodyBackgroundDB#"">
<CFSET bodyText = ""#bodyTextDB#"">
<CFSET bodyLink = ""#bodyLinkDB#"">
<CFSET bodyAlink = ""#bodyAlinkDB#"">
<CFSET bodyVlink = ""#bodyVlinkDB#"">
<CFSET bodyOther = ""#bodyOtherDB#"">">

	<CFIF Form.navTopTableBgRadio EQ "select">
		<CFIF Find("##","#Form.navTopTableBgSelect#",1) EQ 0>
			<CFSET navTopTableBg = Form.navTopTableBgSelect>
		<CFELSE>
			<CFSET navTopTableBg = "###Form.navTopTableBgSelect#">
		</CFIF>
	<CFELSEIF Form.navTopTableBgRadio EQ "other" AND Form.navTopTableBgText NEQ "">
		<CFIF Find("##","#Form.navTopTableBgText#",1) EQ 0>
			<CFSET navTopTableBg = Form.navTopTableBgText>
		<CFELSE>
			<CFSET navTopTableBg = "###Form.navTopTableBgText#">
		</CFIF>
	<CFELSE>
		<CFSET navTopTableBg = "##FFFFCE">
	</CFIF>

	<CFIF Form.navBottomTableBgRadio EQ "select">
		<CFIF Find("##","#Form.navBottomTableBgSelect#",1) EQ 0>
			<CFSET navBottomTableBg = Form.navBottomTableBgSelect>
		<CFELSE>
			<CFSET navBottomTableBg = "###Form.navBottomTableBgSelect#">
		</CFIF>
	<CFELSEIF Form.navBottomTableBgRadio EQ "other" AND Form.navBottomTableBgText NEQ "">
		<CFIF Find("##","#Form.navBottomTableBgText#",1) EQ 0>
			<CFSET navBottomTableBg = Form.navBottomTableBgText>
		<CFELSE>
			<CFSET navBottomTableBg = "###Form.navBottomTableBgText#">
		</CFIF>
	<CFELSE>
		<CFSET navBottomTableBg = "##20A491">
	</CFIF>

	<CFIF Form.navTableFontRadio EQ "select">
		<CFSET navTableFont = Form.navTableFontSelect>
	<CFELSEIF Form.navTableFontRadio EQ "other" AND Form.navTableFontText NEQ "">
		<CFIF Find("##","#Form.navTableFontText#",1) EQ 0>
			<CFSET navTableFont = Form.navTableFontText>
		<CFELSE>
			<CFSET navTableFont = "###Form.navTableFontText#">
		</CFIF>
	<CFELSE>
		<CFSET navTableFont = "purple">
	</CFIF>

	<CFFILE ACTION=Write FILE="#systemPath#\system\navTableBg.cfm"
		OUTPUT="<CFSET navTopTableBg = ""#navTopTableBg#"">
<CFSET navBottomTableBg = ""#navBottomTableBg#"">
<CFSET navTableFont = ""#navTableFont#"">">

	<CFINCLUDE TEMPLATE="../Application.cfm">
	<H3>Body tag, navigation options updated.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=400 ALIGN=left COLOR=purple><P>
</CFIF>

<!--- Read list of default body tag values. Save each value as a separate varaible. --->
<CFINCLUDE TEMPLATE="../system/bodytagList.cfm">
<CFINCLUDE TEMPLATE="../system/navTableBg.cfm">

<FONT COLOR=purple SIZE=6><B>Body</B></FONT>
<CFFORM NAME=bodyTagEdit ACTION=bodytagEdit.cfm>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR><TD ALIGN=right>Sub Category Separator: </TD>
	<TD><CFINPUT TYPE=text NAME=subCategorySeparator SIZE=5 VALUE="#subCategorySeparator#"></TD></TR>
<TR BGCOLOR="#DCDCDC"><TD ALIGN=right>Time Zone Display: </TD>
	<TD><CFINPUT TYPE=text NAME=timeFormatTimeZone SIZE=10 VALUE="#timeFormatTimeZone#"></TD></TR>
<TR><TD ALIGN=right VALIGN=top>Date Format: </TD>
	<TD><SELECT NAME=dateFormatDisplay SIZE=1>
	<OPTION VALUE="mm/dd/yy"<CFIF dateFormatDisplay EQ "mm/dd/yy"> SELECTED</CFIF>> mm/dd/yy -- <CFOUTPUT>#LSDateFormat(Now(), "mm/dd/yy")#</CFOUTPUT>
	<OPTION VALUE="mm/dd/yyyy"<CFIF dateFormatDisplay EQ "mm/dd/yyyy"> SELECTED</CFIF>> mm/dd/yyyy -- <CFOUTPUT>#LSDateFormat(Now(), "mm/dd/yyyy")#</CFOUTPUT>
	<OPTION VALUE="mm-dd-yy"<CFIF dateFormatDisplay EQ "mm-dd-yy"> SELECTED</CFIF>> mm-dd-yy -- <CFOUTPUT>#LSDateFormat(Now(), "mm-dd-yy")#</CFOUTPUT>
	<OPTION VALUE="mm-dd-yyyy"<CFIF dateFormatDisplay EQ "mm-dd-yyyy"> SELECTED</CFIF>> mm-dd-yyyy -- <CFOUTPUT>#LSDateFormat(Now(), "mm-dd-yyyy")#</CFOUTPUT>
	<OPTION VALUE="dd/mm/yy"<CFIF dateFormatDisplay EQ "dd/mm/yy"> SELECTED</CFIF>> dd/mm/yy -- <CFOUTPUT>#LSDateFormat(Now(), "dd/mm/yy")#</CFOUTPUT>
	<OPTION VALUE="dd/mm/yyyy"<CFIF dateFormatDisplay EQ "dd/mm/yyyy"> SELECTED</CFIF>> dd/mm/yyyy -- <CFOUTPUT>#LSDateFormat(Now(), "dd/mm/yyyy")#</CFOUTPUT>
	<OPTION VALUE="dd-mm-yy"<CFIF dateFormatDisplay EQ "dd-mm-yy"> SELECTED</CFIF>> dd-mm-yy -- <CFOUTPUT>#LSDateFormat(Now(), "dd-mm-yy")#</CFOUTPUT>
	<OPTION VALUE="dd-mm-yyyy"<CFIF dateFormatDisplay EQ "dd-mm-yyyy"> SELECTED</CFIF>> dd-mm-yyyy -- <CFOUTPUT>#LSDateFormat(Now(), "dd-mm-yyyy")#</CFOUTPUT>
	<OPTION VALUE="mmm dd, yyyy"<CFIF dateFormatDisplay EQ "mmm dd, yyyy"> SELECTED</CFIF>>mmm dd, yyyy -- <CFOUTPUT>#LSDateFormat(Now(), "mmm dd, yyyy")#</CFOUTPUT>
	<OPTION VALUE="mmmm dd, yyyy"<CFIF dateFormatDisplay EQ "mmmm dd, yyyy"> SELECTED</CFIF>>mmmm dd, yyyy -- <CFOUTPUT>#LSDateFormat(Now(), "mmmm dd, yyyy")#</CFOUTPUT>
	</SELECT></TD></TR>
<TR BGCOLOR="#DCDCDC"><TD ALIGN=right>Time Format: </TD>
	<TD><SELECT NAME=timeFormatDisplay SIZE=1>
	<OPTION VALUE="hh:mm:ss tt"<CFIF timeFormatDisplay EQ "hh:mm:ss tt"> SELECTED</CFIF>>hh:mm:ss tt -- <CFOUTPUT>#LSTimeFormat(Now(), "hh:mm:ss tt")#</CFOUTPUT>
	<OPTION VALUE="hh:mm:ss t"<CFIF timeFormatDisplay EQ "hh:mm:ss t"> SELECTED</CFIF>>hh:mm:ss t -- <CFOUTPUT>#LSTimeFormat(Now(), "hh:mm:ss t")#</CFOUTPUT>
	<OPTION VALUE="hh:mm tt"<CFIF timeFormatDisplay EQ "hh:mm tt"> SELECTED</CFIF>>hh:mm tt -- <CFOUTPUT>#LSTimeFormat(Now(), "hh:mm tt")#</CFOUTPUT>
	<OPTION VALUE="hh:mm t"<CFIF timeFormatDisplay EQ "hh:mm t"> SELECTED</CFIF>>hh:mm t -- <CFOUTPUT>#LSTimeFormat(Now(), "hh:mm t")#</CFOUTPUT>
	<OPTION VALUE="h:mm:ss tt"<CFIF timeFormatDisplay EQ "h:mm:ss tt"> SELECTED</CFIF>>h:mm:ss tt -- <CFOUTPUT>#LSTimeFormat(Now(), "h:mm:ss tt")#</CFOUTPUT>
	<OPTION VALUE="h:mm:ss t"<CFIF timeFormatDisplay EQ "h:mm:ss t"> SELECTED</CFIF>>h:mm:ss t -- <CFOUTPUT>#LSTimeFormat(Now(), "h:mm:ss t")#</CFOUTPUT>
	<OPTION VALUE="HH:mm"<CFIF timeFormatDisplay EQ "HH:mm"> SELECTED</CFIF>>HH:mm -- <CFOUTPUT>#LSTimeFormat(Now(), "HH:mm")#</CFOUTPUT>
	<OPTION VALUE="HH:mm:ss"<CFIF timeFormatDisplay EQ "HH:mm:ss"> SELECTED</CFIF>>HH:mm:ss -- <CFOUTPUT>#LSTimeFormat(Now(), "HH:mm:ss")#</CFOUTPUT>
	<OPTION VALUE="H:mm:ss"<CFIF timeFormatDisplay EQ "H:mm:ss"> SELECTED</CFIF>>H:mm:ss -- <CFOUTPUT>#LSTimeFormat(Now(), "H:mm:ss")#</CFOUTPUT>
	<OPTION VALUE="H:mm:ss"<CFIF timeFormatDisplay EQ "H:mm:ss"> SELECTED</CFIF>>H:mm:ss -- <CFOUTPUT>#LSTimeFormat(Now(), "H:mm:ss")#</CFOUTPUT>
	</SELECT></TD></TR>
<TR><TD ALIGN=right VALIGN=top>Local Currency: </TD>
	<TD><SELECT NAME=newCurrentLocale SIZE=1>
	<OPTION VALUE="Dutch (Belgian)"<CFIF GetLocale() EQ "Dutch (Belgian)"> SELECTED</CFIF>>Dutch (Belgian) - BF/BEF
	<OPTION VALUE="Dutch (Standard)"<CFIF GetLocale() EQ "Dutch (Standard)"> SELECTED</CFIF>>Dutch (Standard) - fl/NLG
	<OPTION VALUE="English (Australian)"<CFIF GetLocale() EQ "English (Australian)"> SELECTED</CFIF>>English (Australian) - $/AUD
	<OPTION VALUE="English (Canadian)"<CFIF GetLocale() EQ "English (Canadian)"> SELECTED</CFIF>>English (Canadian) - $/CAD
	<OPTION VALUE="English (New Zealand)"<CFIF GetLocale() EQ "English (New Zealand)"> SELECTED</CFIF>>English (New Zealand) - $/NZD
	<OPTION VALUE="English (UK)"<CFIF GetLocale() EQ "English (UK)"> SELECTED</CFIF>>English (UK) - £/GBP
 	<OPTION VALUE="English (US)"<CFIF GetLocale() EQ "English (US)"> SELECTED</CFIF>>English (US) - $/USD
 	<OPTION VALUE="French (Belgian)"<CFIF GetLocale() EQ "French (Belgian)"> SELECTED</CFIF>>French (Belgian) - FB/BEF
 	<OPTION VALUE="French (Canadian)"<CFIF GetLocale() EQ "French (Canadian)"> SELECTED</CFIF>>French (Canadian) - $/CAD
 	<OPTION VALUE="French (Standard)"<CFIF GetLocale() EQ "French (Standard)"> SELECTED</CFIF>>French (Standard) - F/FRF
 	<OPTION VALUE="French (Swiss)"<CFIF GetLocale() EQ "French (Swiss)"> SELECTED</CFIF>>French (Swiss) - SFr./CHF
 	<OPTION VALUE="German (Austrian)"<CFIF GetLocale() EQ "German (Austrian)"> SELECTED</CFIF>> German (Austrian) - &ouml;/ATS
 	<OPTION VALUE="German (Standard)"<CFIF GetLocale() EQ "German (Standard)"> SELECTED</CFIF>> German (Standard) - DM/DEM
 	<OPTION VALUE="German (Swiss)"<CFIF GetLocale() EQ "German (Swiss)"> SELECTED</CFIF>> German (Swiss) - SFr./CHF
 	<OPTION VALUE="Italian (Standard)"<CFIF GetLocale() EQ "Italian (Standard)"> SELECTED</CFIF>> Italian (Standard) - L./ITL
 	<OPTION VALUE="Italian (Swiss)"<CFIF GetLocale() EQ "Italian (Swiss)"> SELECTED</CFIF>> Italian (Swiss) - SFr./CHF
 	<OPTION VALUE="Norwegian (Bokmal)"<CFIF GetLocale() EQ "Norwegian (Bokmal)"> SELECTED</CFIF>> Norwegian (Bokmal) - kr/NOK
 	<OPTION VALUE="Norwegian (Nynorsk)"<CFIF GetLocale() EQ "Norwegian (Nynorsk)"> SELECTED</CFIF>> Norwegian (Nynorsk) - kr/NOK
 	<OPTION VALUE="Portuguese (Brazilian)"<CFIF GetLocale() EQ "Portuguese (Brazilian)"> SELECTED</CFIF>> Portuguese (Brazilian) - R$/BRC
 	<OPTION VALUE="Portuguese (Standard)"<CFIF GetLocale() EQ "Portuguese (Standard)"> SELECTED</CFIF>> Portuguese (Standard) - /R$/BRC
 	<OPTION VALUE="Spanish (Mexican)"<CFIF GetLocale() EQ "Spanish (Mexican)"> SELECTED</CFIF>> Spanish (Mexican) - /$/MXN
 	<OPTION VALUE="Spanish (Modern)"<CFIF GetLocale() EQ "Spanish (Modern)"> SELECTED</CFIF>> Spanish (Modern) - Pts/ESP
 	<OPTION VALUE="Spanish (Standard)"<CFIF GetLocale() EQ "Spanish (Standard)"> SELECTED</CFIF>> Spanish (Standard) - Pts/ESP
 	<OPTION VALUE="Swedish"<CFIF GetLocale() EQ "Swedish"> SELECTED</CFIF>> Swedish - kr/SEK
	</SELECT></TD></TR>
</TABLE>

<P><BR>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0>
<TR BGCOLOR="#DCDCDC"><TD ALIGN=right>Bgcolor: </TD>
<TD><INPUT TYPE=radio NAME=bodyBgcolorRadio VALUE=select> <SELECT NAME=bodyBgcolorSelect SIZE=1>
<OPTION VALUE=black>black<OPTION VALUE=blue>blue<OPTION VALUE=cyan>cyan
<OPTION VALUE=gray>gray<OPTION VALUE=green>green<OPTION VALUE=navy>navy
<OPTION VALUE=olive>olive<OPTION VALUE=orange>orange<OPTION VALUE=purple>purple<OPTION VALUE=red>red<OPTION VALUE=silver>silver
<OPTION VALUE=teal>teal<OPTION VALUE=white SELECTED>white<OPTION VALUE=yellow>yellow
</SELECT></TD>
<TR BGCOLOR="#DCDCDC"><TD>&nbsp;</TD>
<TD><INPUT TYPE=radio NAME=bodyBgcolorRadio VALUE=other CHECKED> <CFOUTPUT><INPUT TYPE=text NAME=bodyBgcolorText VALUE="#bodyBgcolor#" SIZE=15></CFOUTPUT></TD></TR>

<TR><TD ALIGN=right>Text: </TD>
<TD><INPUT TYPE=radio NAME=bodyTextRadio VALUE=select> <SELECT NAME=bodyTextSelect SIZE=1>
<OPTION VALUE=black SELECTED>black<OPTION VALUE=blue>blue<OPTION VALUE=cyan>cyan
<OPTION VALUE=gray>gray<OPTION VALUE=green>green<OPTION VALUE=navy>navy
<OPTION VALUE=olive>olive<OPTION VALUE=orange>orange<OPTION VALUE=purple>purple<OPTION VALUE=red>red<OPTION VALUE=silver>silver
<OPTION VALUE=teal>teal<OPTION VALUE=white>white<OPTION VALUE=yellow>yellow
</SELECT></TD>
<TR><TD>&nbsp;</TD>
<TD><INPUT TYPE=radio NAME=bodyTextRadio VALUE=other CHECKED> <CFOUTPUT><INPUT TYPE=text NAME=bodyTextText SIZE=15 VALUE="#bodyText#"></CFOUTPUT></TD></TR>

<TR BGCOLOR="#DCDCDC"><TD ALIGN=right>Link: </TD>
<TD><INPUT TYPE=radio NAME=bodyLinkRadio VALUE=select> <SELECT NAME=bodyLinkSelect SIZE=1>
<OPTION VALUE=black>black<OPTION VALUE=blue SELECTED>blue<OPTION VALUE=cyan>cyan
<OPTION VALUE=gray>gray<OPTION VALUE=green>green<OPTION VALUE=navy>navy
<OPTION VALUE=olive>olive<OPTION VALUE=orange>orange<OPTION VALUE=purple>purple<OPTION VALUE=red>red<OPTION VALUE=silver>silver
<OPTION VALUE=teal>teal<OPTION VALUE=white>white<OPTION VALUE=yellow>yellow
</SELECT></TD>
<TR BGCOLOR="#DCDCDC"><TD>&nbsp;</TD>
<TD><INPUT TYPE=radio NAME=bodyLinkRadio VALUE=other CHECKED> <CFOUTPUT><INPUT TYPE=text NAME=bodyLinkText SIZE=15 VALUE="#bodyLink#"></CFOUTPUT></TD></TR>

<TR><TD ALIGN=right>Alink: </TD>
<TD><INPUT TYPE=radio NAME=bodyALinkRadio VALUE=select> <SELECT NAME=bodyALinkSelect SIZE=1>
<OPTION VALUE=black>black<OPTION VALUE=blue>blue<OPTION VALUE=cyan>cyan
<OPTION VALUE=gray>gray<OPTION VALUE=green>green<OPTION VALUE=navy>navy
<OPTION VALUE=olive>olive<OPTION VALUE=orange>orange<OPTION VALUE=purple SELECTED>purple
<OPTION VALUE=red>red<OPTION VALUE=silver>silver
<OPTION VALUE=teal>teal<OPTION VALUE=white>white<OPTION VALUE=yellow>yellow
</SELECT></TD>
<TR><TD>&nbsp;</TD>
<TD><INPUT TYPE=radio NAME=bodyALinkRadio VALUE=other CHECKED> <CFOUTPUT><INPUT TYPE=text NAME=bodyAlinkText SIZE=15 VALUE="#bodyAlink#"></CFOUTPUT></TD></TR>

<TR BGCOLOR="#DCDCDC"><TD ALIGN=right>Vlink: </TD>
<TD><INPUT TYPE=radio NAME=bodyVLinkRadio VALUE=select> <SELECT NAME=bodyVLinkSelect SIZE=1>
<OPTION VALUE=black>black<OPTION VALUE=blue>blue<OPTION VALUE=cyan>cyan
<OPTION VALUE=gray>gray<OPTION VALUE=green>green<OPTION VALUE=navy>navy
<OPTION VALUE=olive>olive<OPTION VALUE=orange>orange<OPTION VALUE=purple SELECTED>purple
<OPTION VALUE=red>red<OPTION VALUE=silver>silver
<OPTION VALUE=teal>teal<OPTION VALUE=white>white<OPTION VALUE=yellow>yellow
</SELECT></TD>
<TR BGCOLOR="#DCDCDC"><TD>&nbsp;</TD>
<TD><INPUT TYPE=radio NAME=bodyVLinkRadio VALUE=other CHECKED> <CFOUTPUT><INPUT TYPE=text NAME=bodyVlinkText SIZE=15 VALUE="#bodyVlink#"></CFOUTPUT></TD></TR>

<TR><TD ALIGN=right VALIGN=top>Background: </TD>
<TD>
<CFIF bodyBackground EQ "" OR bodyBackground EQ " ">
	<INPUT TYPE=text NAME=bodyBackground SIZE=35 VALUE="http://">
<CFELSE><CFOUTPUT><INPUT TYPE=text NAME=bodyBackground SIZE=35 VALUE="#bodyBackground#"></CFOUTPUT>
</CFIF> <FONT SIZE=2 COLOR=blue>(full URL)</FONT></TD></TR>

<TR><TD ALIGN=right VALIGN=top>Other tags: </TD>
<TD><!--- Because bodyOther is last value in list, it may be read as a hard return --->
<CFIF bodyOther EQ "" OR bodyOther EQ " " OR bodyOther EQ "
" OR Asc(bodyOther) EQ 32>
	<INPUT TYPE=text NAME=bodyOther SIZE=35>
<CFELSE><CFOUTPUT><INPUT TYPE=text NAME=bodyOther SIZE=35 VALUE="#bodyOther#"></CFOUTPUT>
</CFIF> <FONT SIZE=2 COLOR=blue>(full options)</FONT></TD></TR>
</TABLE>

<P><HR NOSHADE SIZE=3 WIDTH=400 ALIGN=left COLOR=purple><P>

<H1><FONT COLOR=purple>Navigation bar</FONT></H1>

<TABLE BORDER=1 CELLSPACING=3 CELLPADDING=2>
<TR BGCOLOR="#DCDCDC"><TD COLSPAN=2>Table bgcolor in top of navigation table: </TD></TR>
<TR BGCOLOR="#DCDCDC"><CFOUTPUT><TD BGCOLOR="#navTopTableBg#" WIDTH=150>&nbsp;</TD></CFOUTPUT>
<TD><INPUT TYPE=radio NAME=navTopTableBgRadio VALUE=select> <SELECT NAME=navTopTableBgSelect SIZE=1>
<OPTION VALUE="#FFFFCE" SELECTED>#FFFFCE
<OPTION VALUE=black>black<OPTION VALUE=blue>blue<OPTION VALUE=cyan>cyan
<OPTION VALUE=gray>gray<OPTION VALUE=green>green<OPTION VALUE=navy>navy
<OPTION VALUE=olive>olive<OPTION VALUE=orange>orange<OPTION VALUE=purple>purple
<OPTION VALUE=red>red<OPTION VALUE=silver>silver
<OPTION VALUE=teal>teal<OPTION VALUE=white>white<OPTION VALUE=yellow>yellow
</SELECT><BR>
<INPUT TYPE=radio NAME=navTopTableBgRadio VALUE=other CHECKED> <CFOUTPUT><INPUT TYPE=text NAME=navTopTableBgText SIZE=15 VALUE="#navTopTableBg#"></CFOUTPUT></TD></TR>

<TR><TD COLSPAN=2>Table bgcolor in bottom of navigation table: </TD></TR>
<TR><CFOUTPUT><TD BGCOLOR="#navBottomTableBg#" WIDTH=150>&nbsp;</TD></CFOUTPUT>
<TD><INPUT TYPE=radio NAME=navBottomTableBgRadio VALUE=select> <SELECT NAME=navBottomTableBgSelect SIZE=1>
<OPTION VALUE="#20A491" SELECTED>#20A491
<OPTION VALUE=black>black<OPTION VALUE=blue>blue<OPTION VALUE=cyan>cyan
<OPTION VALUE=gray>gray<OPTION VALUE=green>green<OPTION VALUE=navy>navy
<OPTION VALUE=olive>olive<OPTION VALUE=orange>orange<OPTION VALUE=purple>purple
<OPTION VALUE=red>red<OPTION VALUE=silver>silver
<OPTION VALUE=teal>teal<OPTION VALUE=white>white<OPTION VALUE=yellow>yellow
</SELECT><BR>
<INPUT TYPE=radio NAME=navBottomTableBgRadio VALUE=other CHECKED> <CFOUTPUT><INPUT TYPE=text NAME=navBottomTableBgText SIZE=15 VALUE="#navBottomTableBg#"></CFOUTPUT></TD></TR>

<TR BGCOLOR="#DCDCDC"><TD COLSPAN=2>Title font color in navigation table</TD></TR>
<TR BGCOLOR="#DCDCDC"><CFOUTPUT><TD BGCOLOR="#navTopTableBg#" WIDTH=150><FONT COLOR="#navTableFont#" SIZE=2><B>Time:</B></FONT></TD></CFOUTPUT>
<TD ROWSPAN=2><INPUT TYPE=radio NAME=navTableFontRadio VALUE=select> <SELECT NAME=navTableFontSelect SIZE=1>
<OPTION VALUE=black>black<OPTION VALUE=blue>blue<OPTION VALUE=cyan>cyan
<OPTION VALUE=gray>gray<OPTION VALUE=green>green<OPTION VALUE=navy>navy
<OPTION VALUE=olive>olive<OPTION VALUE=orange>orange<OPTION VALUE=purple SELECTED>purple
<OPTION VALUE=red>red<OPTION VALUE=silver>silver
<OPTION VALUE=teal>teal<OPTION VALUE=white>white<OPTION VALUE=yellow>yellow
</SELECT><BR>
<INPUT TYPE=radio NAME=navTableFontRadio VALUE=other CHECKED> <CFOUTPUT><INPUT TYPE=text NAME=navTableFontText SIZE=15 VALUE="#navTableFont#"></CFOUTPUT></TD></TD></TR>
<TR><CFOUTPUT><TD BGCOLOR="#navBottomTableBg#" WIDTH=150><FONT COLOR="#navTableFont#"><B>TEXT</B></FONT></TD></CFOUTPUT></TR>
</TABLE>

<P>

<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit NAME=edit VALUE="Edit Body Tag">
</CFFORM>

<P><HR NOSHADE SIZE=3 WIDTH=400 ALIGN=left COLOR=purple><P>

Below are some brief descriptions of the above body tag terms. All colors may be expressed as names (e.g., &quot;purple&quot;) or as RGB codes (e.g., &quot;#FF00FF&quot;).
<P>
<TABLE BORDER=1 CELLSPACING=2 CELLPADDING=2 WIDTH=500>
<TH>Term</TH><TH>Definition</TH>
<TR><TD VALIGN=top>bgcolor: </TD><TD>Background color. This is a solid color, normally white.</TD></TR>
<TR><TD>text: </TD><TD>Color of normal text, i.e., not links or text within &lt;FONT COLOR&gt; tags. Normally black.</TD></TR>
<TR><TD>link: </TD><TD>Color of link that has not yet been clicked on. Typically blue.</TD></TR>
<TR><TD>alink: </TD><TD>Color of link while you are clicking it. Normally purple.</TD></TR>
<TR><TD>vlink: </TD><TD>Color of link after you have clicked on it, usually purple.</TD></TR>
<TR><TD>background: </TD><TD>Background image used instead of bgcolor (when background image is found). Use the full URL.</TD></TR>
<TR><TD>other: </TD><TD>Body tags can have some additional options, such as margin settings. Just enter the full settings.</TD></TR>
</TABLE>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>