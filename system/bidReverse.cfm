<CFSET reverseLowBidAutoWins = 1>
<CFSET reverseBidAboveOpeningBid = 1>
<CFSET reverseBidDescription = 1>
<CFSET reverseBidDescriptionDisplay = 1>
<CFSET reverseBidDisplayAllBids = 1>
<CFSET reverseBidTextBidMinimum = "Minimum Bid: ">
<CFSET reverseBidTextBidDescription = "Description: ">
<CFSET reverseBidDescriptionCheckboxSame = 1>
<CFSET reverseBidDescriptionCheckboxText = "<FONT SIZE=2>Check to keep existing description (if updating existing bid)</FONT>">

<CFSET reversebadBidPriceHigh = "Your bid was greater than the maximum bid necessary to win at least one quantity. Please enter a valid bid.">
<CFSET reverseBadBidPriceMaximumHigh = "Your maximum bid was greater than the maximum bid necessary to win at least one quantity. Please enter a valid bid.">
<CFSET reverseBidLogicOrder = "Bid.bidPriceMaximum, Bid.bidQuantity DESC, Bid.bidEditDateTime">
<CFSET reverseBadUpdateBidPriceMore = "Your bid is greater than your previous bid. You may not raise an existing bid.">
<CFSET reverseBadBidPriceMaximumEmpty = "You checked the auto-bid checkbox, but did not enter a minimum bid. Please enter a minimum bid.">
<CFSET reverseBadUpdateBidPriceMaximumMore = "Your minimum bid is greater than your previous minimum bid. You may not raise an existing bid.">
<CFSET reverseBadBidPriceMaximumIncrement = "Your minimum bid did not meet the required increment. Each bid must be in listed increment amounts.">

<CFPARAM NAME=getLot.nextBidMinimum DEFAULT=0>
<CFPARAM NAME=getLot.nextNextBidMinimum DEFAULT=0>
<CFSET reverseBidTextBidError = "The minimum acceptable bid is #LSCurrencyFormat(getLot.nextBidMinimum,'local')#">
<CFSET reverseBidTextBidMaximumError = "Minimum bid must be at least #LSCurrencyFormat(getLot.nextNextBidMinimum,'local')#">
<CFSET reverseBidTextBidError_file = "The minimum acceptable bid is ##LSCurrencyFormat(getLot.nextBidMinimum,'local')##">
<CFSET reverseBidTextBidMaximumError_file = "Minimum bid must be at least ##LSCurrencyFormat(getLot.nextNextBidMinimum,'local')##">

<CFSET reverseDescriptionNoLot = "<H3>No lot was specified.</H3>">
<CFSET reverseDescriptionBaddLot = "<H3>This is not a valid lot.</H3>">
<CFSET reverseDescriptionNoBidder = "<H3>No bidder was specified.</H3>">
<CFSET reverseDescriptionBadBidder = "<H3>This is not a valid bidder.</H3>">
<CFSET reverseDescriptionBadBid = "<H3>This is not a valid bid.</H3>">
<CFSET reverseDescriptionReturnToLot = "Return to lot page.">
<CFSET reverseDescriptionBlank = "<H3>The description for this bid is blank.</H3>">
<CFSET reverseDescriptionBidder = "Bidder: ">
<CFSET reverseDescriptionBid = "Bid: ">
<CFSET reverseDescriptionQuantity = "Quantity: ">
<CFSET reverseDescriptionDescription = "Description: ">
<CFSET reverseDescriptionLog = 1>
