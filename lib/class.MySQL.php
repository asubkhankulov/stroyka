<? 
class MySQL{  
	static private $_instance = null; 
	static private $db_connect_id; 	
	static private $show_err = true; // ���������� ������
	static public $cache_dir;
	static public $cache_time = 600; // ����� ���� � ��������
	static public $cache_status = false; // ��� �����������
	static public $error_txt = '';
						
	public function __construct(){          
		if (self::$_instance == null){  
			self::$cache_dir = SITE_DIR.'/cache';
		}
	}  
	
	public function __destruct() {
		self::sql_close();
	}
	
	public static function init(){
		$class = __CLASS__;
		if(self::$_instance == null) {
			self::$_instance = new $class();
			self::$db_connect_id = self::SQL();
		}
	}
	
	private static function SQL(){
		ob_start();
		
		self::$db_connect_id = mysql_connect(DB_HOST, DB_USER, DB_PASS);
		mysql_query('SET NAMES utf8');
		
		if (self::$db_connect_id && DB_NAME!="") {
			if (!mysql_select_db(DB_NAME, self::$db_connect_id) ) {  
				mysql_close(self::$db_connect_id);
				return false;
			}
		} 
		
		self::$error_txt = $error_text = trim(strip_tags(ob_get_contents(), '<b>'));
		if(strlen($error_text) > 4){
			self::log_files($error_text, 'error');
		}  
		ob_end_clean();
		return self::$db_connect_id;		
	}
	
	public static function query($query = ''){  
		self::init(); 
		$result = mysql_query($query, self::$db_connect_id);
		
		if (!$result){ 
			$err = self::sql_error();                  
			$error_text = "\n MySQL Error ".$err['code'].": ".htmlspecialchars($err['message']).": query: ".htmlspecialchars($query)."\n";  
			if($err['message'] != '') {
				self::log_files($error_text, 'error');   
			}
			
			if (self::$show_err){  					
				print $error_text;
			} 
			return false;
		} else {                
			return $result;
		}
	}
	
	private static function sql_close() {
		self::init(); 
		if(self::$db_connect_id)
			return mysql_close(self::$db_connect_id);
		else
			return false;
	}
	
	private static function sql_error() {
		self::init(); 
		$result['message'] = mysql_error(self::$db_connect_id);
		$result['code'] = mysql_errno(self::$db_connect_id);
		return $result;
	}
	
	private static function log_files($contents, $type) {
		 $site_dir = SITE_DIR;
		 if(strlen($contents) > 4) {
			$data_now = date('H:i:s');  
			$contents = $data_now.' : '.$contents;
		 
			$file = $site_dir . '/logs/' .date('Y_m_d').'_'.$type.'.log';
			
			file_put_contents($file,$contents,FILE_APPEND);
		 }
	} 

	public static function sql_num_rows($query){
		self::init(); 
		
		if(self::$cache_status) {
			// ��� ����� � ��������������� �������
			$file=md5($query); 
			// ����������� ��������� ������ �� ����					
			$result = self::load_cache($file, self::$cache_time); 
			
			if ($result===false) {
				$res = self::query($query);		
				$result = mysql_num_rows($res);
				// ��������� ������ � ���						
				self::save_cache($file,$result);
			} 	
			
		} else {
			$res = self::query($query);		
			$result = mysql_num_rows($res);
		}

		return $result;
	}

	public static function sql_fetch_row($query) {
		self::init(); 
		if(self::$cache_status) {
			// ��� ����� � ��������������� �������
			$file=md5($query); 
			// ����������� ��������� ������ �� ����					
			$result = self::load_cache($file, self::$cache_time); 
			
			if ($result===false) {
				$res = self::query($query);		
				$result = mysql_fetch_row($res);
				// ��������� ������ � ���						
				self::save_cache($file,$result);
			} 	
			
		} else {
			$res = self::query($query);		
			$result = mysql_fetch_row($res);
		}
		
		return $result;
	}
		
	public static function sql_fetch_assoc($query) {
		self::init(); 
		
		$res = self::query($query);		
		$result = mysql_fetch_assoc($res);
		
		return $result;
	}	
	
	public static function sql_fetch_array($query, $result_type = MYSQL_ASSOC){
		self::init(); 
		
		$res = self::query($query);			
		$result = mysql_fetch_array($res, $result_type);		
	
		
		return $result;
	}
	
	public static function sql_insert_id(){
		self::init();
		return mysql_insert_id(self::$db_connect_id);
	}
		
	public static function fetchAllArray($query, $result_type = MYSQL_ASSOC){
		self::init(); 

		$res = self::query($query);
		$result = array();
		while ($row = mysql_fetch_array($res, $result_type)) {
			$result[] = $row;
		}
		
		return $result;
	} 
	
	public static function fetchAll($query){
		self::init(); 
		
		if(self::$cache_status) {
			// ��� ����� � ��������������� �������
			$file=md5($query); 
			// ����������� ��������� ������ �� ����					
			$result = self::load_cache($file, self::$cache_time); 
			
			if ($result===false) {
				$res = self::query($query);
				$result = array();
				while ($row = mysql_fetch_row($res)) {
					$result[] = $row[0];
				}

				// ��������� ������ � ���						
				self::save_cache($file,$result);
			} 	
			
		} else {
			$res = self::query($query);
			$result = array();
			while ($row = mysql_fetch_row($res)) {
				$result[] = $row[0];
			}
		}
		
		return $result;
	} 

	// ������ ������ � ���
	public static function save_cache($file, $data) {
		self::init(); 		
		if ($fp=fopen(self::$cache_dir.'/'.$file,'w')) {
			flock($fp, LOCK_EX);
			fwrite($fp,serialize($data));
			flock($fp, LOCK_UN);
			fclose($fp);
			return true;
		}
		else {
			return false;
		}
	} 	
	
	// ������ ������ �� ����
	public static function load_cache($file, $expire_time=0) {
		self::init(); 
		
		$fname=self::$cache_dir.'/'.$file;		
		// �������� ������� �����
		if (file_exists($fname)) {
			if ($expire_time) {
				// �������� ������������ �����
				if ((time()-filemtime($fname))>=$expire_time) {
					return false;
				}
			}
			// ��������� ������
			if ($f=fopen($fname,'r')) {
				$tmp=fread($f,filesize($fname));
				fclose($f);
				return (unserialize($tmp));
			}
			else {
				return false;
			}
		}
		else {
			return false;
		}
	} 
}