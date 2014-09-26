// banner.js

onload = startBanner;

function showMessage(n, show) {
  var whichEl = (NS4) ? eval("message" + n) :
                        eval("message" + n + ".style");
  whichEl.visibility = (show) ? ((NS4) ? "show" : "visible") :
                                ((NS4) ? "hide" : "hidden");
}

function nextMessage() {
  var fromInd = current;
  current = (fromInd == ar.length - 1) ? 0 : fromInd + 1;
  scrollBanner(fromInd, current);
}

function moveUp() {
  if (NS4) {
    fromEl.top -= increment;
    if (toEl.top - increment <= toElTarget) {
      toEl.top = toElTarget;
      clearInterval(intervalID);
      fromEl.visibility = "hide";
      timeoutID = setTimeout("nextMessage()", pause);
    } else {
      toEl.top -= increment;
    }
  } else {
    fromEl.pixelTop -= increment;
    if (toEl.pixelTop - increment <= toElTarget) {
      toEl.pixelTop = toElTarget;
      clearInterval(intervalID);
      fromEl.visibility = "hidden";
      timeoutID = setTimeout("nextMessage()", pause);
    } else {
      toEl.pixelTop -= increment;
    }
  }
}

function scrollBanner(from, to) {
  if (NS4) {
    fromEl = eval("message" + from);
    toEl = eval("message" + to);
    toEl.top = fromEl.top + bannerHeight;
    toElTarget = fromEl.top;
  } else {
    fromEl = eval("message" + from + ".style");
    toEl = eval("message" + to + ".style");
    toEl.pixelTop = fromEl.pixelTop + bannerHeight;
    toElTarget = fromEl.pixelTop;
  }
  showMessage(to, true); // show the upcoming message
  intervalID = setInterval("moveUp()", interval);
}

function makeIE() {
  // assign the necessary code to a variable
  var text = '<DIV ID="banner" STYLE="position:absolute">';
  for (var i = ar.length - 1; i >= 0; i--) {
    text += '<DIV ID="message' + i + 
            '" STYLE="position:absolute"></DIV>';
  }
  text += '</DIV>';

  // insert the code before the end of the document
  document.body.insertAdjacentHTML("BeforeEnd", text);

  // define the main element's properties
  with (banner.style) {
    width = bannerWidth;
    height = bannerHeight;
    clip = "rect(0 " + bannerWidth + " " + bannerHeight + " 0)";
    backgroundColor = bannerColor;
    pixelLeft = bannerLeft;
    pixelTop = bannerTop;
  }

  // define the child elements' properties
  for (i = 0; i < ar.length; i++) {
    with (eval("message" + i + ".style")) {
      visibility = "hidden";
      pixelLeft = leftPadding;
      pixelTop = topPadding;
      width = bannerWidth - leftPadding;
      backgroundColor = bannerColor;
    }
  }
}

function makeNS() {
  // create the main element
  banner = new Layer(bannerWidth);

  // define the main element's properties
  with (banner) {
    clip.right = bannerWidth;
    clip.bottom = bannerHeight;
    document.bgColor = bannerColor;
    left = bannerLeft;
    top = bannerTop;
    visibility = "show";
  }

  // define the child elements' properties
  for (var i = 0; i < ar.length; i++) {
    // create a child element
    eval("message" + i + " = " + 
         "new Layer(bannerWidth - leftPadding, banner)");
    with(eval("message" + i)) {
      visibility = "hide";
      left = leftPadding;
      top = topPadding;
      document.bgColor = bannerColor;
    }
  }
}

function fillBanner() {
  var whichEl;
  if (NS4) {
    for (var i = 0; i < ar.length; i++) {
      whichEl = eval("message" + i);
      whichEl.document.write(ar[i]);
      whichEl.document.close();
    }
  } else {
    for (var i = 0; i < ar.length; i++) {
      whichEl = eval("message" + i);
      whichEl.innerHTML = ar[i];
    }
  }
}

function startBanner() {
  if (NS4)
    makeNS()
  else
    makeIE();
  fillBanner();
  showMessage(0, true);
  current = 0;
  timeoutID = setTimeout("nextMessage()", pause);
}