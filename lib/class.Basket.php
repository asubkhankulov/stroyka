<?  
class Basket{  
	static private $_instance = null; 	
												  
	public function __construct(){          
		if (self::$_instance == null){  
			
		}
	} 
		   
	public static function init(){
		$class = __CLASS__;
		if(self::$_instance == null) self::$_instance = new $class();
	}

	// Метод добавляет товар в корзину или удаляет его
	public static function AddToBasket($type, $info, $kol=0) {
		self::init();
		$infos = array();
		$kol = intval($kol);
		$id = intval($info['id']);
		$type = htmls($type);
				
		//unset($_SESSION['basket']);	
		if(!empty($type) && !empty($id)) {			
			$infos['id'] = intval($info['id']);
			$infos['type'] = $type;
			$infos['name'] = htmls($info['name']);
			$infos['price_site'] = floatval($info['price_site']);
			$infos['series_name_path'] = ($type == 'disk') ? htmls($info['series_name_path']) : htmls($info['series_path']);
			$infos['series_id'] = intval($info['series_id']);
			$infos['producer_name_path'] = htmls($info['producer_name_path']);
			$infos['producer_id'] = intval($info['producer_id']);
			$infos['real_kol'] = intval($info['real_kol']);
			$infos['kol'] = intval($kol);
				
			if(empty($_SESSION['basket']['items'][$type][$id]) && $kol > 0 && ($kol <= $infos['real_kol'])) {
				$_SESSION['basket']['items'][$type][$id] = $infos;
			} else {
				if(empty($kol)) {
					unset($_SESSION['basket']['items'][$type][$id]);
				} elseif($kol > 0 && ($kol <= $infos['real_kol'])) {
					$_SESSION['basket']['items'][$type][$id]['kol'] = $kol;
				} elseif($kol > 0 && ($kol > $infos['real_kol'])) {
					$_SESSION['basket']['items'][$type][$id]['kol'] = $infos['real_kol'];
				}
			}	
			foreach($_SESSION['basket']['items'] as $key=>$list) {
				if(empty($list)) {unset($_SESSION['basket']['items'][$key]);}
			}
			
		}		
		self::CheckBasket();
	}
	
	// Метод удаляет товар
	public static function DeleteItems($type, $id) {
		self::init();
		unset($_SESSION['basket']['items'][$type][$id]);
		
		foreach($_SESSION['basket']['items'] as $key=>$list) {
			if(empty($list)) {unset($_SESSION['basket']['items'][$key]);}
		}
		self::CheckBasket();
	}
	
	// Метод добавляет товар в корзину
	public static function CheckBasket() {
		self::init();
		$all_count = 0;
		$all_sum = 0;
		
		if(!empty($_SESSION['basket']['items'])) {
			foreach($_SESSION['basket']['items'] as $type) {
				foreach($type as $value) {
					$kol = intval($value['kol']);
					$price_site = floatval($value['price_site']);
					$all_summ = $kol*$price_site;
					
					$all_count += $kol;
					$all_sum += $all_summ;
				}
			}
			$_SESSION['basket']['all_count'] = $all_count; 
			$_SESSION['basket']['all_count_name'] = decline($all_count, array('позиция','позиции','позиций'));
			$_SESSION['basket']['all_sum'] = $all_sum; 
		} else {
			unset($_SESSION['basket']); 			
		} 
	}
	
	// Метод пишет корзину в базу
	public static function CreateNewCart($data) {
		self::init();					
		$name = htmlspecialchars(trim($data['fio']));     
		$site_url = htmlspecialchars(trim($data['site_url']));     
		$email = htmlspecialchars(trim($data['email']));     
		$phone = htmlspecialchars(trim($data['phone']));     
		$fax = htmlspecialchars(trim($data['fax']));  
		$adress = htmlspecialchars(trim($data['delivery'])); 
		$deliv = (!empty($data['deliv'])) ? htmls($data['deliv']) : "";        
		$deliv_name = (!empty($data['deliv_name'])) ? htmls($data['deliv_name']) : ""; 
		$pay_id = (!empty($data['pay'])) ? intval($data['pay']) : "";        
		$pay = (!empty($data['pay_name'])) ? htmls($data['pay_name']) : "";   		
		$automobile = htmlspecialchars(trim($data['automobile']));        
		$comment = htmlspecialchars(trim($data['comment']));        
		$price = htmlspecialchars(trim($data['all_sum']));  
		$site_id = intval($data['shop_id']);  
		$partner_id = intval($data['partner_id']);               
		$user_ip = htmlspecialchars(trim($data['user_ip'])); 		
		$dostavka =  (!empty($data['dostavka'])) ? htmlspecialchars(trim($data['dostavka'])) : "";  
		$sms =  (!empty($data['sms'])) ? htmlspecialchars(trim($data['sms'])) : "";  
		
		if(!empty($data['shop_percent'])) {
			$shop_percent = trim(htmlspecialchars($data['shop_percent']));                  
			$shop_percent = floatval(str_replace(',', '.', $shop_percent));
			if($shop_percent < 1) $shop_percent = 1;
		} else {
			$shop_percent = 1;
		} 
		
		if(!empty($data['sub'])) {
			$sub = intval($data['sub']);
		} else {
			$sub = 0;
		} 
		
		$pay_1c = '';
		if(!empty($pay)){$pay_1c = " Оплата:".$pay;}	
		$pay_1c_xml = ($pay_id == 5) ? 'Банковский кредит' : $pay;
            
$site_url_for_base = str_replace(array('http://', 'www.'), array('', ''), $site_url);            
$xml ='<site value="'.$site_url_for_base.'">
    <name>'.$name.'</name>
    <email>'.$email.'</email>
    <phone>'.$phone.'</phone>     
    <adress>'.$adress.'</adress> 
    <comment>'.$comment.'</comment>        
    <pay>'.$pay_1c_xml.'</pay>         
    <dostavka>'.$dostavka.'</dostavka>        
    <sms>'.$sms.'</sms>        
    <date>'.date("YmdHis").'</date>';
    
                          
		$result = MySQL::query("  
			INSERT INTO shop_order (name, email, phone, adress, comment, price, date, automobile, fax, user_ip, pay_id, shop_url) 
				VALUES (                         
					'{$name}',
					'{$email}',
					'{$phone}',
					'{$adress}',
					'{$comment}', 
					'{$price}', 
					'".time()."',                         
					'{$automobile}', 
					'{$fax}',                         
					'{$user_ip}', 
					'{$pay_id}',
					'{$site_url_for_base}'                        
					)  
		");
	
		$order_id = intval(MySQL::sql_insert_id());

		preg_match_all('/\{([0-9]+):([0-9]+):(.*?)\}/is', $data['cart'], $out); 
		
		if(!empty($order_id) && !empty($out[1])) {                  
			foreach($out[1] as $key=>$tovar_id){
				$tovar_count = intval($out[2][$key]);  
				$item_type_name = trim($out[3][$key]);  
				$item_type = ($item_type_name == 'tyre') ? '1' : '2';
				$tovar_info = self::GetTovarInfo($tovar_id, $item_type_name); 
				
				if(!empty($tovar_info)) {
					$i_price_site = $tovar_info['price_site'];    
					$i_name = $tovar_info['name'];    
					$i_article = $tovar_info['article'];    
				} else {
					$i_price_site = 0;    
					$i_name = ''; 
					$i_article = '';   
				}  
				
				$order_item_price = $i_price_site; 
				
				if(!empty($tovar_id) && !empty($order_id)) {
					$path = '';   
					
					if($item_type == 1) {
						$path = '/adin/index.php?c_obj=tyre_item&l_obj=&id%5B'.$i_article.'%5D=on';       
					} elseif($item_type == 2) {
						$path = '/adin/index.php?c_obj=disk_item&l_obj=&id%5B'.$i_article.'%5D=on';  
					} 
					$tovar_id_shift = $tovar_id-SHIFT_ID;
					
					$result = MySQL::query("  
						INSERT INTO shop_order_item (order_id, item_type, item_id, number, price, path, name) 
							VALUES (
								'".$order_id."',
								'".$item_type."', 
								'".$tovar_id_shift."',                                     
								'".$tovar_count."',                                
								'".$order_item_price."',                                
								'".$path."',                                
								'".$i_name."'                                
							)
					");   
					
$xml .='
<item>
<name>'.$i_name.'</name>
<article>'.$i_article.'</article>
<price>'.$order_item_price.'</price>
<count>'.$tovar_count.'</count>
</item>';
						  
				}
				
				// Доставка
				if(!empty($deliv)) {
					$query_uslugi = "
						SELECT id, article, name, name_site, price_ac as price, time_id, by_sort, group_id
							FROM uslugi
								WHERE article = '{$deliv}'								            
					"; 
					$now_uslugi = MySQL::sql_fetch_array($query_uslugi);
					if(!empty($now_uslugi['price'])) {
$xml .='	
<item>
	<name>'.$now_uslugi['name_site'].'</name>
	<article>'.$now_uslugi['article'].'</article>
	<price>'.$now_uslugi['price'].'</price>
	<count>1</count>
</item>';
					}
				}




			}
			$xml .='</site>';  
												
		}
		
		MySQL::query("
			UPDATE shop_order
				SET xml = '{$xml}'
				WHERE id = '{$order_id}'                      
		");
		
		return $order_id;              
	}
	
	// Метод выводит информацию о товаре	
	public static function GetTovarInfo($tovar_id, $item_type_name){
		self::init();
		$result = array(
			'price_site'=>0,
			'name'=>'',
			'article'=>'',
		);
		
		$url = SITE_DIR."/data/{$item_type_name}_items.xml";
		$query = "//tovar[@id='{$tovar_id}']";
		
		$list_info = ParserXml::getListAll($query, $url, 0, 0, 'id');		
		if(!empty($list_info[0]['article'])) {
			$result = array(
				'price_site'=>$list_info[0]['price_site'],
				'name'=>$list_info[0]['name'],
				'article'=>$list_info[0]['article'],
			);
		}
		return $result;
	}    
}
?>