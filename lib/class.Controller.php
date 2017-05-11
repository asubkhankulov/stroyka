<?  
class Controller{  
        static private $_instance = null; 
        static public  $smarty;        
        static public  $db;  
        static public  $db2;  
        static public  $module_path;  
        static public  $module_do;  
        static public  $module_parametr;  
                               
        public function __construct(){          
            if (self::$_instance == null){  
//                self::$smarty = $GLOBALS['smarty'];
//                self::$db = $GLOBALS['db']; 
//                self::$db = $GLOBALS['db2']; 
            }
        } 
               
        public static function init(){
            $class = __CLASS__;
            if(self::$_instance == null) self::$_instance = new $class();
        } 
        
        // Метод определяет модуль из ссылки
        public static function ViewModuleName() {
            self::init(); 
            
            // Находим модуль
            if(!empty($_REQUEST['path'])) {  
                $parse_module = explode('/', $_REQUEST['path']); 
                preg_match('~([^\.]+)~msi', htmls($parse_module[0]), $pmod);  
                
                if(!empty($parse_module[1])) {
                    preg_match('~([^\.]+)~msi', htmls($parse_module[1]), $pmod2);  
                    self::$module_do = strtolower($pmod2[1]);                      
                }
                
                if(!empty($parse_module[2])) {
                    preg_match('~([^\.]+)~msi', htmls($parse_module[2]), $pmod3);  
                    self::$module_parametr = strtolower($pmod3[1]);                      
                }
                
                if(!empty($pmod[1])) {
                    self::$module_path = strtolower($pmod[1]);                      
                } else {
                    self::$module_path = 'no_find';       
                }   
                $_REQUEST['full_url'] = $_REQUEST['path'];              
                
            } else {
                $parse_module = array(MODULE_DEFAULT.'.'.SET_URL); 
                self::$module_path = MODULE_DEFAULT; 
                $_REQUEST['full_url'] = MODULE_DEFAULT.'/';   
            }      
            /*
            // Проверка расширения файла              
            $last_url = $parse_module[count($parse_module)-1];
            preg_match('~([^\.]+)\.?(.*?)$~msi', htmls($last_url), $uri);    
            
            if((empty($uri[2]) || $uri[2] != SET_URL) && !empty($uri[1])) {                   
                $parse_module[count($parse_module)-1] = $uri[1].'.'.SET_URL;   
                $redirect_url = join('/', $parse_module);                 
                Header("Location: /".$redirect_url); 
                die;
            } 
            */
           
            // Ищем папку с модулем
            if (!file_exists(SITE_DIR.'/modules/'.self::$module_path.'/index.php') && self::$module_path != 'exit') {  
                self::$module_path = 'no_find';    
            } 
            
            $_REQUEST['module_path'] = self::$module_path;              
            $_REQUEST['module_do'] = self::$module_do; 
            $_REQUEST['parametr_1'] = self::$module_parametr; 
            
            
        }          
        
}
?>