<?  
class Tyre{  
	static private $_instance = null; 	
	static public $xml; 
	static public $counter_start = 0; 
	static public $counter_finish = false; 
	static public $by_sort = false; 
	static public $desc = false; 
	static public $items_all; 
	static public $config; 
											  
	public function __construct(){          
		if (self::$_instance == null){  
			self::$config = $GLOBALS['CONFIG'];  
		}
	} 
		   
	public static function init(){
		$class = __CLASS__;
		if(self::$_instance == null) self::$_instance = new $class();
	}

	// Метод выводит все данные
	public static function XmlToArray($url, $query, $key) {
		self::init();		
		$result = ParserXml::getListAll($query, $url, self::$counter_start, self::$counter_finish, self::$by_sort, self::$desc);
		self::$items_all[$key] = ParserXml::$items_all;		
		return $result;		
	} 
	
	// конвертирует из 1251 в utf-8
	public static function convert($from, $to, $var) {
		if (is_array($var))
		{
			$new = array();
			foreach ($var as $key => $val)
			{
				$new[convert($from, $to, $key)] = convert($from, $to, $val);
			}
			$var = $new;
		}
		else if (is_string($var))
		{
			$var = iconv($from, $to, $var);
		}
		return $var;
	} 
	
	// Метод выводит всех производителей
	public static function ListProducer($key, $query, $url, $counter_start = 0, $counter_finish = false, $by_sort = '', $desc = false) {
		self::init(); 
		self::$counter_start = $counter_start; 
		self::$counter_finish = $counter_finish; 
		self::$by_sort = $by_sort; 
		self::$desc = $desc; 
	
		$list_items = self::XmlToArray($url, $query, $key);		
		return $list_items;
	} 
	
	// Метод выводит все модели у производителей
	public static function ListModels($key, $query, $url, $counter_start = 0, $counter_finish = false, $by_sort = '', $desc = false) {
		self::init(); 
		self::$counter_start = $counter_start; 
		self::$counter_finish = $counter_finish; 
		self::$by_sort = $by_sort; 
		self::$desc = $desc; 	
		$list_items = self::XmlToArray($url, $query, $key);		
		return $list_items;
	} 
	
	// Метод выводит все товары  у модели
	public static function ListItems($key, $query, $url, $counter_start = 0, $counter_finish = false, $by_sort = '', $desc = false) {
		self::init(); 
		self::$counter_start = $counter_start; 
		self::$counter_finish = $counter_finish; 
		self::$by_sort = $by_sort; 
		self::$desc = $desc; 	
		$list_items = self::XmlToArray($url, $query, $key);		
		return $list_items;
	} 
	
	// Метод выводит все данные по товару
	public static function GetItemInfo($url, $query) {
		self::init();		
		$list_info = self::XmlToArray($url, $query, 'item_info');
		return $list_info;
	} 
	
	// Метод выводит весь список авто
	public static function ListAuto($url, $query, $by_sort) {
		self::init();	
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);
		return $list_info;
	} 
	
	// Метод выводит модели у авто
	public static function ListAutoModel($url, $query, $by_sort) {
		self::init();
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);
		return $list_info;
	} 
	
	// Метод выводит все года у модели
	public static function ListAutoYear($url, $query, $by_sort) {
		self::init();
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);
		return $list_info;
	} 
	
	// Метод выводит все модификации у года
	public static function ListAutoModification($url, $query, $by_sort) {
		self::init();	
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);
		return $list_info;
	} 
	
	// Метод выводит ширину шин
	public static function ListWidth($url, $query, $by_sort) {
		self::init();
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);		
		
		return array('list'=>$list_info, 'all_count' => count($list_info));
	} 
	
	// Метод выводит высоту шин
	public static function ListHeight($url, $query, $by_sort) {
		self::init();
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);	
		$new_list = array();
		if(!empty($list_info)) {
			foreach($list_info as $value) {
				$id = intval($value['height_id']);
				if(empty($id)) continue;
				$new_list[$id] = array(
					'id'=>$id,
					'name'=>$value['height_name'],
				);
			}
			$new_list = array_values($new_list);
		}
		return array('list'=>$new_list, 'all_count' => count($list_info));
	} 
	
	// Метод выводит радиус шин
	public static function ListRadius($url, $query, $by_sort) {
		self::init();
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);	
		$new_list = array();
		if(!empty($list_info)) {
			foreach($list_info as $value) {
				$id = intval($value['radius_id']);
				if(empty($id)) continue;
				$new_list[$id] = array(
					'id'=>$id,
					'name'=>$value['radius_name'],
				);
			}
			$new_list = array_values($new_list);
		}
		return array('list'=>$new_list, 'all_count' => count($list_info));
	} 
	
	// Метод выводит радиус шин
	public static function ListSeasonality($url, $query, $by_sort) {
		self::init();
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);	
		$new_list = array();
		$new_list[0] = array(
			'id'=>0,
			'name'=>'Все',
		);
		
		if(!empty($list_info)) {
			foreach($list_info as $value) {
				$id = intval($value['seasonality_id']);
				if(empty($id)) continue;
				$name = (!empty(self::$config['lang']['ru']['tyre_season'][$id])) ? self::$config['lang']['ru']['tyre_season'][$id] : '';
				$new_list[$id] = array(
					'id'=>$id,
					'name'=>$name,
				);
			}
			$new_list = array_values($new_list);
		}
		return array('list'=>$new_list, 'all_count' => count($list_info));
	} 
	
	// Метод выводит производителей шин
	public static function ListPodborProducer($url, $query, $by_sort) {
		self::init();
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);	
		$new_list = array();
		$new_list[0] = array(
			'id'=>0,
			'name'=>'Все',
		);
		
		if(!empty($list_info)) {
			foreach($list_info as $value) {
				$id = intval($value['producer_id']);
				if(empty($id)) continue;
				$new_list[$id] = array(
					'id'=>$id,
					'name'=>$value['producer_name'],
				);
			}
			$new_list = array_values($new_list);
		}
		return array('list'=>$new_list, 'all_count' => count($list_info));
	} 

}
?>