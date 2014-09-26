<CFPARAM NAME="getCheckList.lotID" DEFAULT=1>
<CFSET e_subjectReserveExtended = "Reserve price not met for lot #getCheckList.lotID# - Closing time extended">
<CFSET e_subjectReserveExtendedCode = "Reserve price not met for lot ##getCheckList.lotID## - Closing time extended">
<CFPARAM NAME="lotID" DEFAULT=1>
<CFSET e_subjectReserveNotExtended = "Reserve price not met for lot #lotID#">
<CFSET e_subjectReserveNotExtendedCode = "Reserve price not met for lot ##lotID##">
<CFSET e_subjectReserveMet = "Emaze Auction - Reserve Price Met for Lot 1">
<CFSET e_subjectReserveMetCode = "Emaze Auction - Reserve Price Met for Lot 1">
<CFSET e_subjectReserveNotMet = "Emaze Auction - Lot #lotID# has closed, Reserve price not met">
<CFSET e_subjectReserveNotMetCode = "Emaze Auction - Lot ##lotID## has closed, Reserve price not met">
<CFSET e_subjectReserveMetLoser = "Emaze Auction - Reserve Price Met">
<CFSET e_subjectReserveExtWinner = "Emaze Auction - Reserve Price Not Met">
<CFSET e_subjectReserveExtLoser = "Emaze Auction - Reserve Price Not Met">
<CFSET e_subjectReserveCloseWinner = "Emaze Auction - Reserve Price Not Met">
<CFSET e_subjectReserveCloseLoser = "Emaze Auction - Reserve Price Not Met">
