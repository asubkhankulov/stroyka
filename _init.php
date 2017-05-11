<?php
    error_reporting(E_ALL & ~E_NOTICE);
    //error_reporting(E_NONE);
    //var_dump(setlocale(LC_CTYPE,'ru_RU'));
    //set_time_limit(0);
    define ('SITE_DIR',$_SERVER['DOCUMENT_ROOT']);

    //include_once( SITE_DIR.'/conf/main_settings.php'); 
    include_once( SITE_DIR.'/conf/global_settings.php'); 
    //include_once( SITE_DIR.'/conf/urlreplacements.php'); 
	include_once (SITE_DIR.'/conf/mysql_settings.php');
		
    //include_once( SITE_DIR.'/inc/lib.php');     
    include_once( SITE_DIR.'/lib/lib_utf8.php');      
    include_once( SITE_DIR.'/lib/class.Controller.php');
    include_once( SITE_DIR.'/lib/class.MySQL.php');
    
    //include_once( SITE_DIR.'/inc/class.ParserXml.php');
	
	include_once( SITE_DIR.'/smarty/Smarty.class.php');    
    $smarty = new Smarty;   
	if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {          
        define ('TPL_URL', SITE_DIR.'/templates/'.TPL_ADMIN_NAME) ; 
        define ('TPL_DIR_NAMES', TPL_ADMIN_NAME) ;
		$smarty->compile_dir  = SITE_DIR.'/smarty/template_c_admin/';
		
    } else {
        define ('TPL_URL', SITE_DIR.'/templates/'.TPL_NAME) ; 
        define ('TPL_DIR_NAMES', TPL_NAME) ;
		$smarty->compile_dir  = SITE_DIR.'/smarty/template_c/';        
    }   
	$smarty->template_dir = TPL_URL.'/';
	$smarty->config_dir   = SITE_DIR.'/smarty/template_configs/';
    $smarty->cache_dir    = SITE_DIR.'/smarty/template_cache/'; 
    
    /*
     * Восстановление пароля
     */
    if (isset($_GET['recovery'])) {
    	if (strlen($_GET['recovery']) == 32) {
    		$result = MySQL::sql_fetch_array('SELECT id,login_mail FROM b2b_users WHERE recovery_hash = "'.htmls($_GET['recovery']).'"  LIMIT 1');
    		if (!empty($result)) {
    			$new_pass = generatePassword();
    			MySQL::query('UPDATE b2b_users SET pass = "'.md5($new_pass).'", last_recovery = "2000-01-01 00:00:00", recovery_hash = "" WHERE id = "'.$result['id'].'" LIMIT 1');
				require_once($_SERVER['DOCUMENT_ROOT'].'/lib/class.FreakMailer.php');  
				$mailer = new FreakMailer(); 
				
				// Устанавливаем тему письма
				$mailer->Subject = 'Ваши данные для входа в ';
				$mailer->CharSet = 'UTF-8';
				
				$mailer->Body = nl2br("Здравствуйте!\n Логин: ".$result['login_mail']."\nПароль: $new_pass\n\nС уважением,Администрация\n");
				$mailer->isHTML(true);						
				$mailer->AddAddress($result['login_mail']);
				$mailer->Send();
				$mailer->ClearAddresses();
				unset($new_pass);
				$smarty->assign('recovery','ok');
    		}
    		else {
    			$smarty->assign('recovery','fail');
    		}
    	}
    }
    
?>
