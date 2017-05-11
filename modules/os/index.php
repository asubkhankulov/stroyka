<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^os/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST);
		$price = floatval(str_replace(',','.',$_POST['price']));
		$price = round($price,2);		

		if (!isset($_POST['id'])) {
			MySQL::query(" 
				INSERT INTO osnovnye_sredstva (name, uchastok_id, price, kol, note, user_id) 
					VALUES (
						'".$_POST['name']."',
						'".$_POST['uchastok_id']."',
						'".$price."',
						'".$_POST['kol']."',
						'".$_POST['note']."',
						'".$_SESSION['userid']."'
					)
			");
		}
		else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE osnovnye_sredstva SET name = '".$_POST['name']."', uchastok_id = '".$_POST['uchastok_id']."', price= '".$price."', kol = '".$_POST['kol']."', note = '".$_POST['note']."', user_id = '".$_SESSION['userid']."' WHERE id = {$id}");			
			
		}		
		

		

		
	}		
	
	

	$result = MySQL::fetchAllArray('SELECT os.*,uch.name as uchastok, pos.name as poselok, usr.login_name as user FROM osnovnye_sredstva os
			LEFT JOIN uchastok as uch ON uch.id = os.uchastok_id
			LEFT JOIN mesto as pos ON pos.id = uch.mesto_id
			LEFT JOIN b2b_users as usr ON usr.id = os.user_id
	 ORDER BY pos.id,uch.name');

	$mesta = MySQL::fetchAllArray('SELECT uch.id, uch.name as uchastok, pos.name as poselok FROM uchastok uch
			INNER JOIN mesto as pos ON pos.id = uch.mesto_id
	 ORDER BY pos.id,uch.name');
	
	
	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('list_mesto',$mesta);
	$smarty->assign('INC_PAGE','os.tpl');
}
elseif(preg_match('~^os/edit/([0-9]+)/$~ms', $Path, $q)) {

	$id = intval($q[1]);
	$info = MySQL::sql_fetch_array("SELECT * FROM osnovnye_sredstva WHERE id = '{$id}'");
	$mesta = MySQL::fetchAllArray('SELECT uch.id, uch.name as uchastok, pos.name as poselok FROM uchastok uch
			INNER JOIN mesto as pos ON pos.id = uch.mesto_id
	 ORDER BY pos.id,uch.name');	
	
	$smarty->assign('info',$info);
	$smarty->assign('list_mesto',$mesta);
	$smarty->assign('INC_PAGE','os_edit.tpl');
	
	
	
}
//$smarty->assign('console',$Path);






?>