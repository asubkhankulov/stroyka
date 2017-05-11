<?  
class ParserXml{  
	static private $_instance = null; 	
	static public $xml; 
	static public $xml_uri; 
	static public $by_sort; 
	static public $items_all = 0; 
											  
	public function __construct(){          
		if (self::$_instance == null){  
			
		}
	} 
		   
	public static function init(){
		$class = __CLASS__;
		if(self::$_instance == null) self::$_instance = new $class();
	}

	/* Метод загружает xml файл */	
	private static function GetXml() {
		self::init(); 
		if (file_exists(self::$xml_uri)) { 
            self::$xml = simplexml_load_file(self::$xml_uri); 
            return self::$xml;
        }
		return false;
	} 	
	
	/* Метод показывает все атрибуты у тега поиска и его дочерние элементы*/
	public static function getListAll($query, $url, $counter_start = 0, $counter_finish = false, $by_sort = false, $desc = false) {
		self::init();	
		
		self::$xml_uri = $url;
		$xml = self::GetXml();
		if(empty(self::$xml))return false;
		$list = self::$xml->xpath($query);
		
		$count_list = count($list);
		self::$items_all = $count_list;
        $list_all = array();  
         
        if($counter_finish == false)$counter_finish = $count_list;
        if($counter_finish > $count_list)$counter_finish = $count_list;
		
		// Перебираем массив полностью
		for($i=0; $i<$count_list; $i++){				
			foreach($list[$i] as $attributes=>$value) {				
				$atr = each($value); 
				$list_all[$i][$attributes] = $atr['value']; 
			}
		}
		
		if(!empty($by_sort) && !empty($list_all)) {			
			self::$by_sort = trim($by_sort);
			usort($list_all, array("self", "BuildSorter"));		
			
			if(!empty($desc)) {
				krsort($list_all);
				$list_all = array_values($list_all);
			}			
			
		}			
		
		$result = array();		
		for($i=$counter_start; $i<$counter_finish; $i++){
			$result[] = $list_all[$i]; 
		}
		
		return $result;
	} 

	private static function BuildSorter($b,$c) {
		self::init();
		
		if(is_numeric($b[self::$by_sort]) && is_numeric($c[self::$by_sort])){
			$d = floatval($b[self::$by_sort]);
			$f = floatval($c[self::$by_sort]);
			if ($d == $f) {
				return 0;
			}
			return ($d < $f) ? -1 : 1;
		} else {
			return strcasecmp($b[self::$by_sort], $c[self::$by_sort]);
		}
	}	

}
?>