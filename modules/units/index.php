<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^units/$~ms', $Path, $q)) {
	
	if (isset($_POST['action'])) {

		$data = explode("\n",$_POST['text']);

		foreach ( $data as $id=>$txt ) {

			$name = trim($txt);

			if ( !empty($name) ) {
				MySQL::query("INSERT INTO units (name) VALUES ('{$name}')");
			}
		}
		
		
		
	}

	
	
	
	$result = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');
	//var_dump($result);
	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','units.tpl');
}

//$smarty->assign('console',$Path);






?>