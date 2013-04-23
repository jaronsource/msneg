function formatMoney() {
	var val = $(this).val();
	var num = new Number(val);
	$(this).val(num.toFixed(2));
}

$(function(){
	$(".com_box h3 a.toggle_table").click(
		function(){
				$(this).parent("h3").next("table").toggle();
			}
	);
	$(".customer h4 a").click(
		function(){
				$(this).parent("h4").nextAll("dl").toggle();
			}
	);
	$('.input_money').change(formatMoney);
});