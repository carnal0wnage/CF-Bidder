// bannerconfig.js

var NS4 = (document.layers) ? true : false;
var IE4 = (document.all) ? true : false;

var interval = 20;
var increment = 1;
var pause = 750;
var bannerColor = "yellow";
var leftPadding = 13;
var topPadding = 1;

var bannerLeft = (NS4) ? document.images.holdspace.x :
  holdspace.offsetLeft;
var bannerTop = (NS4) ? document.images.holdspace.y :
  holdspace.offsetTop;
var bannerWidth = (NS4) ? document.images.holdspace.width :
  holdspace.width;
var bannerHeight = (NS4) ? document.images.holdspace.height :
  holdspace.height;

var ar = new Array(
  '<A HREF="/js/column1/">Universal JavaScript Rollovers</A> - <I>Rx #1</I>',
  '<A HREF="/js/column2/">Mastering JavaScript Dates</A> - <I>Rx #2</I>',
  '<A HREF="/js/column3/">Rotating Text Banners</A> - <I>Rx #3</I>',
  '<A HREF="/js/column4/">Text Rollovers</A> - <I>Rx #4</I>',
  '<A HREF="/js/column5/">Regular Expressions</A> - <I>Rx #5</I>',
  '<A HREF="/js/column6/">Browser Compatibility</A> - <I>Rx #6</I>',
  '<A HREF="/js/column7/">Window Spawning and Remotes</A> - <I>Rx #7</I>',
  '<A HREF="/js/column8/">Crispy JavaScript Cookies</A> - <I>Rx #8</I>',
  '<A HREF="/js/column9/">The Navigator Event Model</A> - <I>Rx #9</I>',
  '<A HREF="/js/column10/">The Internet Explorer Event Model</A> - <I>Rx #10</I>',
  '<A HREF="/js/column11/">The Cross-Browser Event Model</A> - <I>Rx #11</I>',
  '<A HREF="/js/column12/">JavaScript Selections</A> - <I>Rx #12</I>'
);