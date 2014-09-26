<!--- Emaze Auction version 2.1 / Wednesday, June 2, 1999 ---><!--- Determine default lot closing time
Date starts at hour following current time
If open on specific day of week, move date to that day of week
 (If day = day, stay on same day, not next one)
	Elseif add number of days, add days to date
If open at specific time, set time
	Elseif hours/minutes after current time, add hours and minutes
Save as a date/time to determine default closing time
--->

<CFSET openingTime = DateAdd("h",1,Now())>
<CFSET minuteSubtract = -1 * Minute(openingTime)>
<CFSET secondSubtract = -1 * Second(openingTime)>
<CFSET openingTime = DateAdd("n",minuteSubtract,openingTime)>
<CFSET openingTime = DateAdd("s",secondSubtract,openingTime)>
<CFSET dayOfWeekNow = DayOfWeek(openingTime)>

<CFIF openDay EQ "set" AND dayOfWeekNow NEQ openDaySet>
	<CFIF dayOfWeekNow LT openDaySet>
		<CFSET dayDifference = openDaySet - dayOfWeekNow>
	<CFELSEIF dayOfWeekNow GT openDaySet>
		<CFSET dayDifference = (7 - dayOfWeekNow) + openDaySet>
	</CFIF>
	<CFSET openingTime = DateAdd("d",dayDifference,openingTime)>
<CFELSEIF openDay EQ "add" AND openDayAdd NEQ 0>
	<CFSET openingTime = DateAdd("d",openDayAdd,openingTime)>
</CFIF>

<CFIF openHour EQ "set" AND openHourHourSet24 NEQ Hour(openingTime)>
	<CFSET hourAdd = openHourHourSet24 - Hour(openingTime)>
	<CFSET openingTime = DateAdd("h",hourAdd,openingTime)>
<CFELSEIF openHour EQ "add" AND openHourHourAdd NEQ 0>
	<CFSET openingTime = DateAdd("h",openHourHourAdd,openingTime)>
</CFIF>

<CFIF openHour EQ "set" AND openHourMinuteSet NEQ Minute(openingTime)>
	<CFSET minuteAdd = openHourMinuteSet - Minute(openingTime)>
	<CFSET openingTime = DateAdd("n",minuteAdd,openingTime)>
<CFELSEIF openHour EQ "add" AND openHourMinuteAdd NEQ 0>
	<CFSET openingTime = DateAdd("n",openHourMinuteAdd,openingTime)>
</CFIF>
