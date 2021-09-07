	use sales;
	SELECT COUNT(*), SUM(dealer_cost), SUM(price_sold), SUM(price_list) FROM sales_2016 WHERE model_name='Accord' AND sales_type='used';
