<?  
class Disk extends Tyre { 

	// Метод выводит 
	public static function ListPCD($url, $query, $by_sort) {
		self::init();
		self::$by_sort = $by_sort; 
		$list_info = self::XmlToArray($url, $query, $by_sort);
		$new_list = array();
		$new_list[0] = array(
			'boltnum_id'=>0,
			'boltdistance_id'=>0,
			'pcd'=>'Все',
		);	
		$new_list = array_merge($new_list, $list_info);
		return array('list'=>$new_list, 'all_count' => 0);
	} 
	
	// Метод выводит высоту
	public static function ListWidth($url, $query, $by_sort) {
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
				$id = intval($value['width_id']);
				if(empty($id)) continue;
				$new_list[$id] = array(
					'id'=>$id,
					'name'=>$value['width_name'],
				);
			}
			$new_list = array_values($new_list);
		}
		return array('list'=>$new_list, 'all_count' => count($list_info));
	} 
	
	// Метод выводит
	public static function ListPodborRadius($url, $query, $by_sort) {
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
	
	// Метод выводит
	public static function ListPodborET($url, $query, $by_sort) {
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
				$id = intval($value['et_id']);
				if(empty($id)) continue;
				$new_list[$id] = array(
					'id'=>$id,
					'name'=>$value['et_name'],
				);
			}
			$new_list = array_values($new_list);
		}
		return array('list'=>$new_list, 'all_count' => count($list_info));
	} 
	
	// Метод выводит
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