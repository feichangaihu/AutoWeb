// 获取所有的页面统计数据
function getParams(form) {
	// 构造参数
	var tmp = {};
	if(form){
		for ( var i = 0; i < form.elements.length; i++) {
			var e = form.elements[i];
			if(e.name != ''){
				tmp[form.elements[i].name] = form.elements[i].value;				
			}
		}
	}
	tmp.rand = Math.random();
	return tmp;
}