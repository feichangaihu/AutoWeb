function tip(node, msg, ok){
	var bgc = ok ? "green" : "yellow";
	var c = ok ? "blue" : "#ff0011";
	$(node).text(msg).css({
		color : c,
		background : bgc
	}).show().fadeOut(2000);
}