<?php 
define ('IMAGES_SERVER', 'http://o1.s-shina.ru/image_clear') ;
define ('SHOP_CART_URI', 'http://o1.s-shina.ru') ;
define ('MAIN_SHOP', 'http://www.s-shina.ru') ;
define ('MYSQL_BASE', 1) ; // 1 - запись в базу, 0 - отправка CURL


$CONFIG['left_block'] = array(
	'basket.php',	
	'podbor_tyre.php',	
	'podbor_disk.php',	
	'null.php',	
);

$CONFIG['type_tyre'] = array(
	'winter' => 2,	
	'summer' => 1,	
	'allseason' => 3,	
);
?>