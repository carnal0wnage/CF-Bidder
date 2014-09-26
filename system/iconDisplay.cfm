<CFOUTPUT>
<CFIF ListFind(iconListIndex,"pic")><CFIF lotImage NEQ "" AND lotImage NEQ " "><IMG SRC="#systemURL#/images/pic.gif" WIDTH=22 HEIGHT=14></CFIF></CFIF>
<CFIF ListFind(iconListIndex,"multiple")><CFIF lotQuantity GT 1><IMG SRC="#systemURL#/images/multiple.gif" WIDTH=25 HEIGHT=14></CFIF></CFIF>
<CFIF ListFind(iconListIndex,"openingsoon")><CFIF DateDiff("h",lotOpenDateTime,Now()) LTE iconLotOpenDateTimeSoon><IMG SRC="#systemURL#/images/openingsoon.gif" WIDTH=16 HEIGHT=14></CFIF></CFIF>
<CFIF ListFind(iconListIndex,"closingsoon")><CFIF DateDiff("h",Now(),lotCloseDateTime) LTE iconLotCloseDateTimeSoon><IMG SRC="#systemURL#/images/closingsoon.gif" WIDTH=15 HEIGHT=14></CFIF></CFIF>
<CFIF ListFind(iconListIndex,"bids") OR ListFind(iconListIndex,"nobids") OR ListFind(iconListIndex,"hot")>
	<CFIF ListFind(iconListIndex,"nobids") AND lotBidCount EQ 0><IMG SRC="#systemURL#/images/nobids.gif" WIDTH=16 HEIGHT=14>
	<CFELSEIF ListFind(iconListIndex,"bids") AND lotBidCount GT 0><IMG SRC="#systemURL#/images/bids.gif" WIDTH=16 HEIGHT=14></CFIF>
	<CFIF ListFind(iconListIndex,"hot") AND lotBidCount GTE iconLotBidCountHot><IMG SRC="#systemURL#/images/hot.gif" WIDTH=17 HEIGHT=14></CFIF>
</CFIF>
<CFIF ListFind(iconListIndex,"reservemet") OR ListFind(iconListIndex,"reservenotmet")>
	<CFIF ListFind(iconListIndex,"reservemet") AND lotReservePriceMet EQ 1><IMG SRC="#systemURL#/images/reservemet.gif" WIDTH=18 HEIGHT=14>
	<CFELSEIF ListFind(iconListIndex,"reservenotmet") AND lotReservePriceMet EQ 0><IMG SRC="#systemURL#/images/reservenotmet.gif" WIDTH=15 HEIGHT=14></CFIF>
</CFIF>
<CFIF ListFind(iconListIndex,"positiverating") OR ListFind(iconListIndex,"negativerating")>
	<CFIF ListFind(iconListIndex,"positiverating") AND feedbackRating GT 0><IMG SRC="#systemURL#/images/positiverating.gif" WIDTH=18 HEIGHT=14>
	<CFELSEIF ListFind(iconListIndex,"negativerating") AND feedbackRating LT 0><IMG SRC="#systemURL#/images/negativerating.gif" WIDTH=18 HEIGHT=14></CFIF>
</CFIF>
</CFOUTPUT>
