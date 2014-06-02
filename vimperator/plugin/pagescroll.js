function pageScroll(time,lines) {
	alert("called pageScroll("+time+", "+lines+")");
	window.content.window.scrollBy(0,lines);
	scrollDelay = window.setTimeout('pageScroll('+time+', '+lines+')',time);
}

function stopScrolling() {
	clearTimeout(scrollDelay);
}
