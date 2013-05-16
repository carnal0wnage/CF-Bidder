		<cfimage action="read" source="#attfile#" name="myImage">
		<cfif myImage.width gt 500>
			<cfset ImageResize(myImage,500,"")>
		</cfif>
		<cfimage source="#myImage#" action="write" destination="#ExpandPath('/auction/images')#/image_#nid#.jpg" overwrite="yes">

