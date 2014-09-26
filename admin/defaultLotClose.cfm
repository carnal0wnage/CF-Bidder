<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 ---><!--- Determine default lot closing time --->
<CFSET closingTime = openingTime>
<CFSET dayOfWeekNow = DayOfWeek(closingTime)>

<CFIF closeDay EQ "set" AND dayOfWeekNow NEQ closeDaySet>
	<CFIF dayOfWeekNow LT closeDaySet>
		<CFSET dayDifference = closeDaySet - dayOfWeekNow>
	<CFELSEIF dayOfWeekNow GT closeDaySet>
		<CFSET dayDifference = (7 - dayOfWeekNow) + closeDaySet>
	</CFIF>
	<CFSET closingTime = DateAdd("d",dayDifference,closingTime)>
<CFELSEIF closeDay EQ "add" AND closeDayAdd NEQ 0>
	<CFSET closingTime = DateAdd("d",closeDayAdd,closingTime)>
</CFIF>

<CFIF closeHour EQ "set" AND (closeHourHourSet24 NEQ Hour(closingTime))>
	<CFSET hourAdd = closeHourHourSet24 - Hour(closingTime)>
	<CFSET closingTime = DateAdd("h",hourAdd,closingTime)>
<CFELSEIF closeHour EQ "add" AND closeHourHourAdd NEQ 0>
	<CFSET closingTime = DateAdd("h",closeHourHourAdd,closingTime)>
</CFIF>

<CFIF closeHour EQ "set" AND (closeHourMinuteSet NEQ Minute(closingTime))>
	<CFSET minuteAdd = closeHourMinuteSet - Minute(closingTime)>
	<CFSET closingTime = DateAdd("n",minuteAdd,closingTime)>
<CFELSEIF closeHour EQ "add" AND closeHourMinuteAdd NEQ 0>
	<CFSET closingTime = DateAdd("n",closeHourMinuteAdd,closingTime)>
</CFIF>
