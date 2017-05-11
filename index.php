<?
    header("Last-Modified: " . gmdate("D, d M Y H:i:s"). " GMT");       
    session_start(); 
    ob_start();      
    include('_init.php');
    
    //echo md5('9104404572');
    
    Controller::ViewModuleName();      
    define ('MODULE_PATH', $_REQUEST['module_path']) ;
    define ('MODULE_DOP', $_REQUEST['module_do']) ;
   // $module_name = htmls($_REQUEST['module_path']);
    //$module_do = htmls($_REQUEST['module_do']);   
    
    $Path = $_REQUEST['full_url'];

    //html_dump($Path);
    
    
     // Разлогиниваемся
    if(MODULE_PATH == 'exit') {
    	session_destroy();
        Header('Location: /'); 
        die;           
    }    
    
    include(SITE_DIR.'/modules/'.MODULE_PATH.'/index.php');

    if(MODULE_PATH == 'no_find') {
    	exit;
    }

    
    
    

    if(!empty($_SESSION['login'])) {

		/*
		 * Проверка на новые сообщения
		 */
    	/*
    	if(!empty($_SESSION['is_admin'])) {
	    	$msg = MySQL::sql_fetch_array("SELECT count(*) cnt FROM msg WHERE is_viewed = 0 and to_admin = 1");
    	}
    	else {
    		$msg = MySQL::sql_fetch_array("SELECT count(*) cnt FROM msg WHERE is_viewed = 0 and to_user_id = ".$_SESSION['userid']);
    		$balans = MySQL::sql_fetch_array("SELECT SUM(tranzaction) itogo FROM billing WHERE user_id = '".$_SESSION['userid']."'");
    		$inf_balance = !empty($balans) ? $balans['itogo'] : '0';
    		$smarty->assign('inf_balance',number_format($inf_balance, 2, '.', ' '));  
    		
    	}
	    $smarty->assign('msg',$msg['cnt']);     
    	*/
    	
    	
    	$smarty->display(TPL_URL.'/index.tpl');              
    }  
?>