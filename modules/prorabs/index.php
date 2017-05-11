<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^prorabs/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST);
		$pass = (!strlen($_POST['pass'])) ? uniqid() : $_POST['pass'];
		MySQL::query(" 
			INSERT INTO b2b_users (login, login_name, login_tel, pass, status, note) 
				VALUES (
					'".$_POST['login']."',
					'".$_POST['name']."',
					'".$_POST['tel']."',
					'".md5($pass)."',
					'1',
					'".$_POST['note']."'
				)
		");
		

		
	}		
	
	
	$result = MySQL::fetchAllArray('SELECT pr.login_name as name, pr.id, pr.login_tel as tel, pos.name as poselok, uc.name as works FROM b2b_users pr 
		LEFT JOIN stroyka as str ON str.prorab_id = pr.id 
		LEFT JOIN uchastok as uc ON uc.id = str.uchastok_id
		LEFT JOIN mesto as pos ON pos.id = uc.mesto_id
		WHERE pr.status = 1
		ORDER BY name');
	//var_dump($result);
	//$list_unit = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');
	
	
	$smarty->assign('cnt_sum',count($result));
	//$smarty->assign('list_unit',$list_unit);
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','prorabs.tpl');
}

//$smarty->assign('console',$Path);






?>