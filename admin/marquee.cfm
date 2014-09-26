<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 --->
<CFINCLUDE TEMPLATE="security.cfm">

<HTML>
<HEAD><TITLE>Emaze Auction: Scrolling Marquee Banner</TITLE></HEAD>
<BODY BGCOLOR=white TEXT=black LINK=blue VLINK=blue ALINK=purple>

<CFIF IsDefined("Form.first")>
	<CFIF Form.lotID1 EQ "">
		<CFSET lotIDList = 0>
		<CFIF Form.linkURL1 EQ "" OR Form.linkURL1 EQ "#systemURL#/" OR Form.linkText1 EQ ""><CFSET linkURL1 = " "><CFSET linkText1 = " ">
			<CFIF nonLinkText1 NEQ ""><CFSET configLinkList = "  '#nonLinkText1#'"></CFIF>
		<CFELSE><CFSET configLinkList = "  '<A HREF=""#linkURL1#"">#linkText1#</A> #nonLinkText1#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = Form.lotID1>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID1#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>1. Lot #Form.lotID1# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL1 = "#systemURL#/lot.cfm?lotID=#lotID1#"><CFSET linkText1 = "#getLot.lotName#">
			<CFSET configLinkList = "  '<A HREF=""#linkURL1#"">#linkText1#</A> #nonLinkText1#'">
		</CFIF>
	</CFIF>

	<!--- 
	<CFLOOP INDEX=loopCount FROM=2 TO=12>
		<CFIF #loopCount# EQ 2>
			<CFSET lotID = #Form.lotID2#>
			<CFSET linkURL = "#Form.linkURL2#">
			<CFSET linkText = "#Form.linkText2#">
			<CFSET nonLinkText = "#Form.nonLinkText1#">
		</CFIF>
	</CFLOOP>
	--->

	<CFIF Form.lotID2 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL2 EQ "" OR Form.linkURL2 EQ "#systemURL#/" OR Form.linkText2 EQ ""><CFSET linkURL2 = " "><CFSET linkText2 = " ">
			<CFIF nonLinkText2 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText2#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL2#"">#linkText2#</A> #nonLinkText2#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID2)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID2#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>2. Lot #Form.lotID2# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL2 = "#systemURL#/lot.cfm?lotID=#lotID2#"><CFSET linkText2 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL2#"">#linkText2#</A> #nonLinkText2#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID3 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL3 EQ "" OR Form.linkURL3 EQ "#systemURL#/" OR Form.linkText3 EQ ""><CFSET linkURL3 = " "><CFSET linkText3 = " ">
			<CFIF nonLinkText3 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText3#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL3#"">#linkText3#</A> #nonLinkText3#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID3)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID3#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>3. Lot #Form.lotID3# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL3 = "#systemURL#/lot.cfm?lotID=#lotID3#"><CFSET linkText3 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL3#"">#linkText3#</A> #nonLinkText3#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID4 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL4 EQ "" OR Form.linkURL4 EQ "#systemURL#/" OR Form.linkText4 EQ ""><CFSET linkURL4 = " "><CFSET linkText4 = " ">
			<CFIF nonLinkText4 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText4#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL4#"">#linkText4#</A> #nonLinkText4#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID4)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID4#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>4. Lot #Form.lotID4# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL4 = "#systemURL#/lot.cfm?lotID=#lotID4#"><CFSET linkText4 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL4#"">#linkText4#</A> #nonLinkText4#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID5 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL5 EQ "" OR Form.linkURL5 EQ "#systemURL#/" OR Form.linkText5 EQ ""><CFSET linkURL5 = " "><CFSET linkText5 = " ">
			<CFIF nonLinkText5 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText5#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL5#"">#linkText5#</A> #nonLinkText5#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID5)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID5#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>5. Lot #Form.lotID5# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL5 = "#systemURL#/lot.cfm?lotID=#lotID5#"><CFSET linkText5 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL5#"">#linkText5#</A> #nonLinkText5#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID6 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL6 EQ "" OR Form.linkURL6 EQ "#systemURL#/" OR Form.linkText6 EQ ""><CFSET linkURL6 = " "><CFSET linkText6 = " ">
			<CFIF nonLinkText6 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText6#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL6#"">#linkText6#</A> #nonLinkText6#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID6)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID6#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>6. Lot #Form.lotID6# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL6 = "#systemURL#/lot.cfm?lotID=#lotID6#"><CFSET linkText6 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL6#"">#linkText6#</A> #nonLinkText6#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID7 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL7 EQ "" OR Form.linkURL7 EQ "#systemURL#/" OR Form.linkText7 EQ ""><CFSET linkURL7 = " "><CFSET linkText7 = " ">
			<CFIF nonLinkText7 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText7#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL7#"">#linkText7#</A> #nonLinkText7#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID7)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID7#</CFQUERY>
		<CFIF #getLot.RecordCount# NEQ 1><CFOUTPUT>7. Lot #Form.lotID7# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL7 = "#systemURL#/lot.cfm?lotID=#lotID7#"><CFSET linkText7 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL7#"">#linkText7#</A> #nonLinkText7#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID8 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL8 EQ "" OR Form.linkURL8 EQ "#systemURL#/" OR Form.linkText8 EQ ""><CFSET linkURL8 = " "><CFSET linkText8 = " ">
			<CFIF nonLinkText8 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText8#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL8#"">#linkText8#</A> #nonLinkText8#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID8)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID8#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>8. Lot #Form.lotID8# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL8 = "#systemURL#/lot.cfm?lotID=#lotID8#"><CFSET linkText8 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL8#"">#linkText8#</A> #nonLinkText8#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID9 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL9 EQ "" OR Form.linkURL9 EQ "#systemURL#/" OR Form.linkText9 EQ ""><CFSET linkURL9 = " "><CFSET linkText9 = " ">
			<CFIF nonLinkText9 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText9#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL9#"">#linkText9#</A> #nonLinkText9#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID9)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID9#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>9. Lot #Form.lotID9# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL9 = "#systemURL#/lot.cfm?lotID=#lotID9#"><CFSET linkText9 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL9#"">#linkText9#</A> #nonLinkText9#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID10 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL10 EQ "" OR Form.linkURL10 EQ "#systemURL#/" OR Form.linkText10 EQ ""><CFSET linkURL10 = " "><CFSET linkText10 = " ">
			<CFIF nonLinkText10 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText10#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL10#"">#linkText10#</A> #nonLinkText10#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID10)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID10#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>10. Lot #Form.lotID10# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL10 = "#systemURL#/lot.cfm?lotID=#lotID10#"><CFSET linkText10 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL10#"">#linkText10#</A> #nonLinkText10#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID11 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL11 EQ "" OR Form.linkURL11 EQ "#systemURL#/" OR Form.linkText11 EQ ""><CFSET linkURL11 = " "><CFSET linkText11 = " ">
			<CFIF nonLinkText11 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText11#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL11#"">#linkText11#</A> #nonLinkText11#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID11)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID11#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>11. Lot #Form.lotID11# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL11 = "#systemURL#/lot.cfm?lotID=#lotID11#"><CFSET linkText11 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL11#"">#linkText11#</A> #nonLinkText11#'">
		</CFIF>
	</CFIF>

	<CFIF Form.lotID12 EQ "">
		<CFSET lotIDList = ListAppend(lotIDList,0)>
		<CFIF Form.linkURL12 EQ "" OR Form.linkURL12 EQ "#systemURL#/" OR Form.linkText12 EQ ""><CFSET linkURL12 = " "><CFSET linkText12 = " ">
			<CFIF nonLinkText12 NEQ ""><CFSET configLinkList = "#configLinkList#,
  '#nonLinkText12#'"></CFIF>
		<CFELSE><CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL12#"">#linkText12#</A> #nonLinkText12#'"></CFIF>
	<CFELSE>
		<CFSET lotIDList = ListAppend(lotIDList,lotID12)>
		<CFQUERY NAME=getLot DATASOURCE="#EAdatasource#">SELECT lotName FROM Lot WHERE lotID = #Form.lotID12#</CFQUERY>
		<CFIF getLot.RecordCount NEQ 1><CFOUTPUT>12. Lot #Form.lotID12# does not exist.</CFOUTPUT><CFABORT>
		<CFELSE>
			<CFSET linkURL12 = "#systemURL#/lot.cfm?lotID=#lotID12#"><CFSET linkText12 = "#getLot.lotName#">
			<CFSET configLinkList = "#configLinkList#,
  '<A HREF=""#linkURL12#"">#linkText12#</A> #nonLinkText12#'">
		</CFIF>
	</CFIF>

	<CFSET bannerColor = Replace(Form.bannerColor,"##","####","ALL")>
	<CFSET bannerColor = Replace(Form.bannerColor,"""","","ALL")>
	<CFIF Form.nonLinkText1 EQ ""><CFSET nonLinkText1 = " "></CFIF>
	<CFIF Form.nonLinkText2 EQ ""><CFSET nonLinkText2 = " "></CFIF>
	<CFIF Form.nonLinkText3 EQ ""><CFSET nonLinkText3 = " "></CFIF>
	<CFIF Form.nonLinkText4 EQ ""><CFSET nonLinkText4 = " "></CFIF>
	<CFIF Form.nonLinkText5 EQ ""><CFSET nonLinkText5 = " "></CFIF>
	<CFIF Form.nonLinkText6 EQ ""><CFSET nonLinkText6 = " "></CFIF>
	<CFIF Form.nonLinkText7 EQ ""><CFSET nonLinkText7 = " "></CFIF>
	<CFIF Form.nonLinkText8 EQ ""><CFSET nonLinkText8 = " "></CFIF>
	<CFIF Form.nonLinkText9 EQ ""><CFSET nonLinkText9 = " "></CFIF>
	<CFIF Form.nonLinkText10 EQ ""><CFSET nonLinkText10 = " "></CFIF>
	<CFIF Form.nonLinkText11 EQ ""><CFSET nonLinkText11 = " "></CFIF>
	<CFIF Form.nonLinkText12 EQ ""><CFSET nonLinkText12 = " "></CFIF>

	<CFSET linkURL1 = Replace(linkURL1,"##","####","ALL")><CFSET linkText1 = Replace(linkText1,"##","####","ALL")><CFSET nonLinkText1 = Replace(nonLinkText1,"##","####","ALL")><CFSET linkText1 = Replace(linkText1,"""","&quot;","ALL")><CFSET nonLinkText1 = Replace(nonLinkText1,"""","&quot;","ALL")>
	<CFSET linkURL2 = Replace(linkURL2,"##","####","ALL")><CFSET linkText2 = Replace(linkText2,"##","####","ALL")><CFSET nonLinkText2 = Replace(nonLinkText2,"##","####","ALL")><CFSET linkText2 = Replace(linkText2,"""","&quot;","ALL")><CFSET nonLinkText2 = Replace(nonLinkText2,"""","&quot;","ALL")>
	<CFSET linkURL3 = Replace(linkURL3,"##","####","ALL")><CFSET linkText3 = Replace(linkText3,"##","####","ALL")><CFSET nonLinkText3 = Replace(nonLinkText3,"##","####","ALL")><CFSET linkText3 = Replace(linkText3,"""","&quot;","ALL")><CFSET nonLinkText3 = Replace(nonLinkText3,"""","&quot;","ALL")>
	<CFSET linkURL4 = Replace(linkURL4,"##","####","ALL")><CFSET linkText4 = Replace(linkText4,"##","####","ALL")><CFSET nonLinkText4 = Replace(nonLinkText4,"##","####","ALL")><CFSET linkText4 = Replace(linkText4,"""","&quot;","ALL")><CFSET nonLinkText4 = Replace(nonLinkText4,"""","&quot;","ALL")>
	<CFSET linkURL5 = Replace(linkURL5,"##","####","ALL")><CFSET linkText5 = Replace(linkText5,"##","####","ALL")><CFSET nonLinkText5 = Replace(nonLinkText5,"##","####","ALL")><CFSET linkText5 = Replace(linkText5,"""","&quot;","ALL")><CFSET nonLinkText5 = Replace(nonLinkText5,"""","&quot;","ALL")>
	<CFSET linkURL6 = Replace(linkURL6,"##","####","ALL")><CFSET linkText6 = Replace(linkText6,"##","####","ALL")><CFSET nonLinkText6 = Replace(nonLinkText6,"##","####","ALL")><CFSET linkText6 = Replace(linkText6,"""","&quot;","ALL")><CFSET nonLinkText6 = Replace(nonLinkText6,"""","&quot;","ALL")>
	<CFSET linkURL7 = Replace(linkURL7,"##","####","ALL")><CFSET linkText7 = Replace(linkText7,"##","####","ALL")><CFSET nonLinkText7 = Replace(nonLinkText7,"##","####","ALL")><CFSET linkText7 = Replace(linkText7,"""","&quot;","ALL")><CFSET nonLinkText7 = Replace(nonLinkText7,"""","&quot;","ALL")>
	<CFSET linkURL8 = Replace(linkURL8,"##","####","ALL")><CFSET linkText8 = Replace(linkText8,"##","####","ALL")><CFSET nonLinkText8 = Replace(nonLinkText8,"##","####","ALL")><CFSET linkText8 = Replace(linkText8,"""","&quot;","ALL")><CFSET nonLinkText8 = Replace(nonLinkText8,"""","&quot;","ALL")>
	<CFSET linkURL9 = Replace(linkURL9,"##","####","ALL")><CFSET linkText9 = Replace(linkText9,"##","####","ALL")><CFSET nonLinkText9 = Replace(nonLinkText9,"##","####","ALL")><CFSET linkText9 = Replace(linkText9,"""","&quot;","ALL")><CFSET nonLinkText9 = Replace(nonLinkText9,"""","&quot;","ALL")>
	<CFSET linkURL10 = Replace(linkURL10,"##","####","ALL")><CFSET linkText10 = Replace(linkText10,"##","####","ALL")><CFSET nonLinkText10 = Replace(nonLinkText10,"##","####","ALL")><CFSET linkText10 = Replace(linkText10,"""","&quot;","ALL")><CFSET nonLinkText10 = Replace(nonLinkText10,"""","&quot;","ALL")>
	<CFSET linkURL11 = Replace(linkURL11,"##","####","ALL")><CFSET linkText11 = Replace(linkText11,"##","####","ALL")><CFSET nonLinkText11 = Replace(nonLinkText11,"##","####","ALL")><CFSET linkText11 = Replace(linkText11,"""","&quot;","ALL")><CFSET nonLinkText11 = Replace(nonLinkText11,"""","&quot;","ALL")>
	<CFSET linkURL12 = Replace(linkURL12,"##","####","ALL")><CFSET linkText12 = Replace(linkText12,"##","####","ALL")><CFSET nonLinkText12 = Replace(nonLinkText12,"##","####","ALL")><CFSET linkText12 = Replace(linkText12,"""","&quot;","ALL")><CFSET nonLinkText12 = Replace(nonLinkText12,"""","&quot;","ALL")>

	<CFFILE ACTION=Write FILE="#systemPath#\system\marqueeFields.cfm"
		OUTPUT="<CFSET interval = #interval#>
<CFSET increment = #increment#>
<CFSET pause = #pause#>
<CFSET bannerColor = ""#bannerColor#"">
<CFSET leftPadding = #leftPadding#>
<CFSET topPadding = #topPadding#>

<CFSET lotIDList = ""#lotIDList#"">
<CFSET linkURL1 = ""#linkURL1#""><CFSET linkText1 = ""#linkText1#""><CFSET nonLinkText1 = ""#nonLinkText1#"">
<CFSET linkURL2 = ""#linkURL2#""><CFSET linkText2 = ""#linkText2#""><CFSET nonLinkText2 = ""#nonLinkText2#"">
<CFSET linkURL3 = ""#linkURL3#""><CFSET linkText3 = ""#linkText3#""><CFSET nonLinkText3 = ""#nonLinkText3#"">
<CFSET linkURL4 = ""#linkURL4#""><CFSET linkText4 = ""#linkText4#""><CFSET nonLinkText4 = ""#nonLinkText4#"">
<CFSET linkURL5 = ""#linkURL5#""><CFSET linkText5 = ""#linkText5#""><CFSET nonLinkText5 = ""#nonLinkText5#"">
<CFSET linkURL6 = ""#linkURL6#""><CFSET linkText6 = ""#linkText6#""><CFSET nonLinkText6 = ""#nonLinkText6#"">
<CFSET linkURL7 = ""#linkURL7#""><CFSET linkText7 = ""#linkText7#""><CFSET nonLinkText7 = ""#nonLinkText7#"">
<CFSET linkURL8 = ""#linkURL8#""><CFSET linkText8 = ""#linkText8#""><CFSET nonLinkText8 = ""#nonLinkText8#"">
<CFSET linkURL9 = ""#linkURL9#""><CFSET linkText9 = ""#linkText9#""><CFSET nonLinkText9 = ""#nonLinkText9#"">
<CFSET linkURL10 = ""#linkURL10#""><CFSET linkText10 = ""#linkText10#""><CFSET nonLinkText10 = ""#nonLinkText10#"">
<CFSET linkURL11 = ""#linkURL11#""><CFSET linkText11 = ""#linkText11#""><CFSET nonLinkText11 = ""#nonLinkText11#"">
<CFSET linkURL12 = ""#linkURL12#""><CFSET linkText12 = ""#linkText12#""><CFSET nonLinkText12 = ""#nonLinkText12#"">
">

	<CFSET configLinkList = Replace(configLinkList,"##","####","ALL")>
	<CFFILE ACTION=Write FILE="#systemPath#\system\bannerconfig.js"
		OUTPUT="// bannerconfig.js

var NS4 = (document.layers) ? true : false;
var IE4 = (document.all) ? true : false;

var interval = #Form.interval#;
var increment = #Form.increment#;
var pause = #Form.pause#;
var bannerColor = ""#Form.bannerColor#"";
var leftPadding = #Form.leftPadding#;
var topPadding = #Form.topPadding#;

var bannerLeft = (NS4) ? document.images.holdspace.x :
  holdspace.offsetLeft;
var bannerTop = (NS4) ? document.images.holdspace.y :
  holdspace.offsetTop;
var bannerWidth = (NS4) ? document.images.holdspace.width :
  holdspace.width;
var bannerHeight = (NS4) ? document.images.holdspace.height :
  holdspace.height;

var ar = new Array(
#configLinkList#
);
">

	<H3>Scrolling banner fields updated.</H3>
	<P><HR NOSHADE SIZE=3 WIDTH=500 ALIGN=left>
</CFIF>

<H1>Scrolling Marquee Banner</H1>

You can have up to 12 links. For each link, you can either specify the lotID or the link URL and name. If you specify the lotID, the system automatically inserts the URL and lot name. You can also specify text to appear after the link. We automatically insert a space to separate them. Do not use any single quotes (') since this will screw up how the system separates each component.
<P>
Please note this scrolling banner uses JavaScript and dynamic HTML. It is pretty cool, but requires Netscape 4 or IE 4 (or greater). For older browsers, it can cause some pretty weird effects if the browser does not know what the page layout will be. So if possible, always specify the height and width of your image tags, or make sure they will show up.
<P>

<P><HR NOSHADE SIZE=3 COLOR=purple ALIGN=left WIDTH=500><P>

To display the banner, add the following text to the page:

<PRE>&lt;IMG SRC=&quot;blank.gif&quot; BORDER=0 NAME=&quot;holdspace&quot; ID="&quot;oldspace&quot; WIDTH=&quot;400&quot; HEIGHT=&quot;21&quot; STYLE=&quot;visibility:hidden; position:relative;&quot;&gt;</PRE>

You can set the height and width to whatever you want. The marquee works by displaying itself over an image, in this case called blank.gif . Users who have browsers that do not support JavaScript or dynamic HTML will see the image instead.

<P>

Then somewhere in the file after the above statement, add the following:

<PRE>
&lt;SCRIPT LANGUAGE=&quot;JavaScript1.2&quot;&gt;
&lt;!--
	if (navigator.appVersion.indexOf(&quot;MSIE 4.0; Macintosh;&quot;) == -1) {
	  with (document) {
	    write(&quot;&lt;SCRIPT LANGUAGE='JavaScript1.2' SRC='system/bannerconfig.js'&gt;&quot;);
	    write(&quot;&lt;\/SCRIPT&gt;&quot;);
	    write(&quot;&lt;SCRIPT LANGUAGE='JavaScript1.2' SRC='system/banner.js'&gt;&quot;);
	    write(&quot;&lt;\/SCRIPT&gt;&quot;);
	  }
	}
	//--&gt;
&lt;/SCRIPT&gt;
</PRE>

Please note the relative path, 'system/bannerconfig.js' and 'system/banner.js' . The path is from the location of the URL the file. So if you are calling this from the template/defaultLot.cfm page to display on the homepage, you should not use a &quot;../&quot; since the system recognizes the URL as index.cfm in the main directory.

<P><HR NOSHADE SIZE=3 COLOR=purple ALIGN=left WIDTH=500><P>

<CFINCLUDE TEMPLATE="../system/marqueeFields.cfm">
<CFFORM ACTION=marquee.cfm NAME=banner>
<INPUT TYPE=hidden NAME=first VALUE=1>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=5>
<TR><TD ALIGN=right>Interval: </TD><TD><CFINPUT TYPE=text NAME=interval SIZE=5 VALUE="#interval#" REQUIRED=Yes MESSAGE="You must enter the interval"></TD>
	<TD ROWSPAN=3 WIDTH=15 BGCOLOR="#DCDCDC">&nbsp;</TD>
	<TD ALIGN=right BGCOLOR="#DCDCDC">Banner Color: </TD><TD BGCOLOR="#DCDCDC"><CFINPUT TYPE=text NAME=bannerColor SIZE=15 VALUE="#bannerColor#" REQUIRED=Yes MESSAGE="You must enter the banner color"></TD></TR>
<TR><TD ALIGN=right BGCOLOR="#DCDCDC">Increment: </TD><TD BGCOLOR="#DCDCDC"><CFINPUT TYPE=text NAME=increment SIZE=5 VALUE="#increment#" REQUIRED=Yes MESSAGE="You must enter the increment"></TD>
	<TD ALIGN=right>Left Padding: </TD><TD><CFINPUT TYPE=text NAME=leftPadding SIZE=5 VALUE="#leftPadding#" REQUIRED=Yes MESSAGE="You must enter the left padding"></TD></TR>
<TR><TD ALIGN=right>Pause: </TD><TD><CFINPUT TYPE=text NAME=pause SIZE=5 VALUE="#pause#" REQUIRED=Yes MESSAGE="You must enter the pause."></TD>
	<TD ALIGN=right BGCOLOR="#DCDCDC">Top Padding: </TD><TD BGCOLOR="#DCDCDC"><CFINPUT TYPE=text NAME=topPadding SIZE=5 VALUE="#topPadding#" REQUIRED=Yes MESSAGE="You must enter the top padding"></TD></TR>
</TABLE>

<P>

<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=3>
<TR><TH BGCOLOR=red>#</TH>
	<TH BGCOLOR=yellow>Lot ID</TH>
	<TH BGCOLOR=purple>URL</TH>
	<TH BGCOLOR=teal>Linked Text</TH>
	<TH BGCOLOR=orange><FONT SIZE=2>Non-Linked Text</FONT></TH>
</TR>

<TR><TH>1</TH>
	<TD><INPUT TYPE=text NAME=lotID1 SIZE=5<CFIF #ListGetAt(lotIDList,1)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,1)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL1 SIZE=35<CFIF #linkURL1# NEQ " "> VALUE="#linkURL1#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText1 size=25<CFIF #linkText1# NEQ " "><CFOUTPUT> VALUE="#linkText1#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText1 size=10<CFIF #nonLinkText1# NEQ " "><CFOUTPUT> VALUE="#nonLinkText1#"</CFOUTPUT></CFIF>></TD></TR>
<TR BGCOLOR="#CDCDCD"><TH>2</TH>
	<TD><INPUT TYPE=text NAME=lotID2 SIZE=5<CFIF #ListGetAt(lotIDList,2)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,2)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL2 SIZE=35<CFIF #linkURL2# NEQ " "> VALUE="#linkURL2#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText2 size=25<CFIF #linkText2# NEQ " "><CFOUTPUT> VALUE="#linkText2#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText2 size=10<CFIF #nonLinkText2# NEQ " "><CFOUTPUT> VALUE="#nonLinkText2#"</CFOUTPUT></CFIF>></TD></TR>
<TR><TH>3</TH>
	<TD><INPUT TYPE=text NAME=lotID3 SIZE=5<CFIF #ListGetAt(lotIDList,3)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,3)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL3 SIZE=35<CFIF #linkURL3# NEQ " "> VALUE="#linkURL3#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText3 size=25<CFIF #linkText3# NEQ " "><CFOUTPUT> VALUE="#linkText3#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText3 size=10<CFIF #nonLinkText3# NEQ " "><CFOUTPUT> VALUE="#nonLinkText3#"</CFOUTPUT></CFIF>></TD></TR>
<TR BGCOLOR="#CDCDCD"><TH>4</TH>
	<TD><INPUT TYPE=text NAME=lotID4 SIZE=5<CFIF #ListGetAt(lotIDList,4)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,4)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL4 SIZE=35<CFIF #linkURL4# NEQ " "> VALUE="#linkURL4#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText4 size=25<CFIF #linkText4# NEQ " "><CFOUTPUT> VALUE="#linkText4#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText4 size=10<CFIF #nonLinkText4# NEQ " "><CFOUTPUT> VALUE="#nonLinkText4#"</CFOUTPUT></CFIF>></TD></TR>
<TR><TH>5</TH>
	<TD><INPUT TYPE=text NAME=lotID5 SIZE=5<CFIF #ListGetAt(lotIDList,5)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,5)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL5 SIZE=35<CFIF #linkURL5# NEQ " "> VALUE="#linkURL5#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText5 size=25<CFIF #linkText5# NEQ " "><CFOUTPUT> VALUE="#linkText5#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText5 size=10<CFIF #nonLinkText5# NEQ " "><CFOUTPUT> VALUE="#nonLinkText5#"</CFOUTPUT></CFIF>></TD></TR>
<TR BGCOLOR="#CDCDCD"><TH>6</TH>
	<TD><INPUT TYPE=text NAME=lotID6 SIZE=5<CFIF #ListGetAt(lotIDList,6)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,6)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL6 SIZE=35<CFIF #linkURL6# NEQ " "> VALUE="#linkURL6#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText6 size=25<CFIF #linkText6# NEQ " "><CFOUTPUT> VALUE="#linkText6#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText6 size=10<CFIF #nonLinkText6# NEQ " "><CFOUTPUT> VALUE="#nonLinkText6#"</CFOUTPUT></CFIF>></TD></TR>
<TR><TH>7</TH>
	<TD><INPUT TYPE=text NAME=lotID7 SIZE=5<CFIF #ListGetAt(lotIDList,7)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,7)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL7 SIZE=35<CFIF #linkURL7# NEQ " "> VALUE="#linkURL7#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText7 size=25<CFIF #linkText7# NEQ " "><CFOUTPUT> VALUE="#linkText7#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText7 size=10<CFIF #nonLinkText7# NEQ " "><CFOUTPUT> VALUE="#nonLinkText7#"</CFOUTPUT></CFIF>></TD></TR>
<TR BGCOLOR="#CDCDCD"><TH>8</TH>
	<TD><INPUT TYPE=text NAME=lotID8 SIZE=5<CFIF #ListGetAt(lotIDList,8)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,8)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL8 SIZE=35<CFIF #linkURL8# NEQ " "> VALUE="#linkURL8#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText8 size=25<CFIF #linkText8# NEQ " "><CFOUTPUT> VALUE="#linkText8#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText8 size=10<CFIF #nonLinkText8# NEQ " "><CFOUTPUT> VALUE="#nonLinkText8#"</CFOUTPUT></CFIF>></TD></TR>
<TR><TH>9</TH>
	<TD><INPUT TYPE=text NAME=lotID9 SIZE=5<CFIF #ListGetAt(lotIDList,9)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,9)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL9 SIZE=35<CFIF #linkURL9# NEQ " "> VALUE="#linkURL9#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText9 size=25<CFIF #linkText9# NEQ " "><CFOUTPUT> VALUE="#linkText9#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText9 size=10<CFIF #nonLinkText9# NEQ " "><CFOUTPUT> VALUE="#nonLinkText9#"</CFOUTPUT></CFIF>></TD></TR>
<TR BGCOLOR="#CDCDCD"><TH>10</TH>
	<TD><INPUT TYPE=text NAME=lotID10 SIZE=5<CFIF #ListGetAt(lotIDList,10)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,10)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL10 SIZE=35<CFIF #linkURL10# NEQ " "> VALUE="#linkURL10#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText10 size=25<CFIF #linkText10# NEQ " "><CFOUTPUT> VALUE="#linkText10#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText10 size=10<CFIF #nonLinkText10# NEQ " "><CFOUTPUT> VALUE="#nonLinkText10#"</CFOUTPUT></CFIF>></TD></TR>
<TR><TH>11</TH>
	<TD><INPUT TYPE=text NAME=lotID11 SIZE=5<CFIF #ListGetAt(lotIDList,11)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,11)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL11 SIZE=35<CFIF #linkURL11# NEQ " "> VALUE="#linkURL11#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText11 size=25<CFIF #linkText11# NEQ " "><CFOUTPUT> VALUE="#linkText11#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText11 size=10<CFIF #nonLinkText11# NEQ " "><CFOUTPUT> VALUE="#nonLinkText11#"</CFOUTPUT></CFIF>></TD></TR>
<TR BGCOLOR="#CDCDCD"><TH>12</TH>
	<TD><INPUT TYPE=text NAME=lotID12 SIZE=5<CFIF #ListGetAt(lotIDList,12)# NEQ 0><CFOUTPUT> VALUE=#ListGetAt(lotIDList,12)#</CFOUTPUT></CFIF>></TD>
	<TD><CFOUTPUT><INPUT TYPE=text NAME=linkURL12 SIZE=35<CFIF #linkURL12# NEQ " "> VALUE="#linkURL12#"<CFELSE> VALUE="#systemURL#/"</CFIF>></CFOUTPUT></TD>
	<TD><INPUT TYPE=text NAME=linkText12 size=25<CFIF #linkText12# NEQ " "><CFOUTPUT> VALUE="#linkText12#"</CFOUTPUT></CFIF>></TD>
	<TD><INPUT TYPE=text NAME=nonLinkText12 size=10<CFIF #nonLinkText12# NEQ " "><CFOUTPUT> VALUE="#nonLinkText12#"</CFOUTPUT></CFIF>></TD></TR>
</TABLE>

<P>
<P>
<INPUT TYPE=reset VALUE=Clear> &nbsp; <INPUT TYPE=submit VALUE=Submit>
</CFFORM>

<CFINCLUDE TEMPLATE="../program/copyright.cfm">
</BODY>
</HTML>