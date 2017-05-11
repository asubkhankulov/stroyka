<?
/*
	1 - s-shina.ru
	2 - empire-wheels.ru
	3 - hors-avto.ru
	4 - navigata.ru
	5 - automotivy.ru
*/
class YM {
	static private $_instance = null; 
	static public $market_tyre = array();
	static public $market_disk = array();	
	static public $shop_id = 0;	
	static public $shift_id = 0;	
	
	public function __construct(){          
		if (self::$_instance == null){  
			
		}
	}  
	
	public static function init(){
		$class = __CLASS__;
		if(self::$_instance == null) self::$_instance = new $class();		
	}
	
	public static function CreateData($shop_id){
		self::init();
		if(!empty($shop_id)) {
			self::$shop_id = intval($shop_id);			
			self::$market_tyre = self::MarketGetInfo(1, 'tyre');			
			self::$market_disk = self::MarketGetInfo(2, 'disk');
		}			
	}
	
	public static function MarketGetInfo($type_id = 0, $type_name = '') {
		self::init();
		$sql = '';		
		if(!empty(self::$shop_id) && self::$shop_id != 'all') {
			$sql = " AND ms.id = '".self::$shop_id."' ";		
		} 
		
		$query = "                  
			SELECT mr.*, ms.id as site_id, ms.name as site_name, p.name as producer_name
				FROM market_rules_site mr
				LEFT JOIN market_list_site as ms ON(ms.id = mr.site_id)
				LEFT JOIN {$type_name}_producer as p ON(p.id = mr.producer_id)
					WHERE mr.type_id = '{$type_id}' {$sql}
						ORDER BY mr.type_id, p.name, mr.site_id
		"; 
		$row = MySQL::fetchAllArray($query); 
		return $row;
	}
	
	private function GreateSQLTyre($kol, $type) {
		$sql = '';
		if(empty($kol['min']) && !empty($kol['max'])) {
			$sql = "(ti.{$type} <= '".$kol['max']."')";
		} elseif(!empty($kol['min']) && empty($kol['max'])) {
			$sql = "(ti.{$type} >= '".$kol['min']."')";
		} elseif(!empty($kol['min']) && !empty($kol['max'])) {
			$sql = "(ti.{$type} >= '".$kol['min']."' AND ti.{$type} <= '".$kol['min']."')";
		}
		
		return $sql;
	}
	
	private function GreateSQLDisk($kol, $type) {
		$sql = '';
		if(empty($kol['min']) && !empty($kol['max'])) {
			$sql = "(di.{$type} <= '".$kol['max']."')";
		} elseif(!empty($kol['min']) && empty($kol['max'])) {
			$sql = "(di.{$type} >= '".$kol['min']."')";
		} elseif(!empty($kol['min']) && !empty($kol['max'])) {
			$sql = "(di.{$type} >= '".$kol['min']."' AND di.{$type} <= '".$kol['min']."')";
		}
		
		return $sql;
	}
	
	public function ListProducerItems($type_id, $site_id, $producer_id, $kol, $kol_cnt, $kol_udal, $sql_qwery = '') {
		self::init(); 
		$kol_sql = array();
		$row = array();
		
		if(!empty($type_id)) {
			switch ($type_id) { 
				case '1':
					$sql = 'AND (ti.kol < 0 AND ti.kol_cnt < 0 AND ti.udal_sklad < 0)';
					
					$sql_kol = self::GreateSQLTyre($kol, 'kol');
					$sql_kol_cnt= self::GreateSQLTyre($kol_cnt, 'kol_cnt');
					$sql_kol_udal = self::GreateSQLTyre($kol_udal, 'udal_sklad');
				break;
				
				case '2':
					$sql = 'AND (di.kol < 0 AND di.kol_cnt < 0 AND di.udal_sklad < 0)';
					
					$sql_kol = self::GreateSQLDisk($kol, 'kol');
					$sql_kol_cnt= self::GreateSQLDisk($kol_cnt, 'kol_cnt');
					$sql_kol_udal = self::GreateSQLDisk($kol_udal, 'udal_sklad');
				break;
			}
		}
		
		if(!empty($sql_kol)) {$kol_sql[] = $sql_kol;}
		if(!empty($sql_kol_cnt)) {$kol_sql[] = $sql_kol_cnt;}
		if(!empty($sql_kol_udal)) {$kol_sql[] = $sql_kol_udal;}
		
		if(!empty($kol_sql)) {
			$sql = " AND (".join(' OR ', $kol_sql).") {$sql_qwery}";
		} else {
			$sql = $sql_qwery;
			
			return false;
		}
		//html_dump($sql);
		//die;
		
		if(!empty($type_id)) {
			switch ($type_id) {    
				case '1':				
					$query = "
						SELECT 
							IF(ti.id > 0, ti.id+".self::$shift_id.", 0) as id,
							ti.id as tovar_id, 
							ti.article, 
							ti.name, 
							ti.seasonality_id, 
							ti.seasonality_id as season, 
							IF(ti.kol > 4, '>4', ti.kol) as kol_site,
							ti.kol, 
							ti.kol as real_kol,
							ti.kol_cnt, 
							ti.udal_sklad, 
							ti.price,  
							ti.price_site,  
							ti.price_udsklad,  
							ti.price_nav,  
							til.name as index_loading, 
							til.name as loading_name, 
							til.id as loading_id,
							tis.name as index_speed,
							tis.id as speed_id, 
							tis.name as speed_name,							
							tw.name as width, 
							tw.id as width_id, 
							tw.name as width_name,
							th.name as height,
							th.id as height_id, 
							th.name as height_name,
							tr.name as radius, 
							tr.id as radius_id, 
							tr.name as radius_name,
							ti.runflat, 
							ti.v, 
							ti.m, 
							ti.presence_site,
							tys.id as series_id,  
							tys.name_path as series_path, 
							tys.name as series, 
							tys.valuta as series_valuta,   
							tys.img_n AS series_img,
							tys.name as series_name, 
							tys.name_rus as series_name_rus,
							tys.hit_orders as hit_orders_model,
							tp.id as producer_id, 
							tp.name as producer, 
							tp.name_path as producer_path,							
							tp.name as producer_name, 
							tp.name_rus, 
							tp.hit_orders, 
							tp.name_path as producer_name_path, 
							IF(tys.name LIKE '%шип%', 'true', 'false') as shipy
							
								FROM tyre_item ti  
								LEFT JOIN tyre_series tys ON(tys.id = ti.series_id)           
								LEFT JOIN tyre_index_loading til ON(til.id = ti.index_loading_id)           
								LEFT JOIN tyre_index_speed tis ON(tis.id = ti.index_speed_id)           
								LEFT JOIN tyre_width tw ON(tw.id = ti.width_id)           
								LEFT JOIN tyre_height th ON(th.id = ti.height_id)           
								LEFT JOIN tyre_radius tr ON(tr.id = ti.radius_id)           
								LEFT JOIN tyre_producer tp ON(tp.id = tys.producer_id)           
									WHERE ti.article NOT LIKE 'nc%' AND ti.article NOT LIKE 'nk%' AND ti.seasonality_id > 0  AND tp.id = '{$producer_id}'
									{$sql}
									ORDER BY ti.series_id, tw.name, th.name, tr.name                       
					"; 
					$row = MySQL::fetchAllArray($query); 					
				break;
				
				case '2':				
					$query = "
						SELECT 
							IF(di.id > 0, di.id+".self::$shift_id.", 0) as id,
							di.id as tovar_id, 
							di.article, 
							di.width_id,
							di.name, 
							di.radius_id, 
							di.boltnum_id, 
							di.boltdistance_id, 
							IF(di.kol > 4, '>4', di.kol) as kol_site,
							di.kol, 
							di.kol as real_kol,
							di.kol_cnt,
							di.et_id,
							di.udal_sklad,          
							di.price, 
							di.price_site,  
							di.price_udsklad,  
							di.price_nav,  
							di.dia,  
							di.m,  
							di.v,  
							di.material_id AS material,
							di.presence_site,							
							ds.name as series, 
							ds.name_path as name_path, 
							ds.id as series_id, 
							ds.valuta AS series_valuta,  
							ds.img_n AS series_img, 
							ds.name as series_name, 
							ds.name_rus as series_name_rus, 
							ds.name_path as series_name_path,
							ds.hit_orders as hit_orders_model,
							dp.name as producer, 
							dp.name_path as producer_path, 
							dp.id as producer_id,
							dp.name as producer_name, 
							dp.name_rus, 
							dp.name_path as producer_name_path, 
							dp.hit_orders,
							dw.name as width, 
							dw.name as width_name, 
							dr.name as radius_name,
							dr.name as radius, 
							dbt.name as boltnum,
							dbt.name as boltnum_name,
							dbd.name as boltdistance, 
							dbd.name as boltdistance_name,
							det.name as et,
							det.name as et_name,
							dm.name_path as material_name_path, 							
							dm.name as material_name
								FROM disk_item di
								LEFT JOIN disk_series ds ON(ds.id = di.series_id)
								LEFT JOIN disk_producer dp ON(dp.id = ds.producer_id)
								LEFT JOIN disk_width dw ON(dw.id = di.width_id) 
								LEFT JOIN disk_radius dr ON(dr.id = di.radius_id)             
								LEFT JOIN disk_boltnum dbt ON(dbt.id = di.boltnum_id)             
								LEFT JOIN disk_boltdistance dbd ON(dbd.id = di.boltdistance_id)  
								LEFT JOIN disk_et det ON(det.id = di.et_id)             
								LEFT JOIN disk_material dm ON(dm.id = di.material_id)             
								WHERE di.article NOT LIKE 'nc%' AND di.article NOT LIKE 'nk%' AND dp.id = '{$producer_id}'
									{$sql}
								ORDER BY di.series_id, dw.name, dr.name          
					";
					$row = MySQL::fetchAllArray($query); 		
				break;
			}
			//html_dump($row);
			return $row;
		}
		
	}
	
	public function CheckNum($str) {
		self::init(); 
		$min = 0;
		$max = 0;
				
		if(preg_match('~^([0-9]+)-([0-9]+)$~msi', $str, $q)){
			$min = $q[1];
			$max = $q[2];
		} elseif(preg_match('~^([0-9]+)$~msi', $str, $q)){
			$min = $q[1];
			$max = (!empty($min)) ? 0 : 0 ;
		} 
		return $result = array('min'=>$min, 'max'=>$max);
	}		
}
?>