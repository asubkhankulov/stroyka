<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^vendors/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		if (!isset($_POST['id'])) {
			MySQL::query(" 
				INSERT INTO vendors (name, note, adress, contact, tel, email, ur) 
					VALUES (
						'".htmls($_POST['name'])."',
						'".htmls($_POST['note'])."',
						'".htmls($_POST['adress'])."',
						'".htmls($_POST['contact'])."',
						'".htmls($_POST['tel'])."',
						'".htmls($_POST['email'])."',
						'".htmls($_POST['ur'])."'
					)
			");
		}
		else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE vendors SET name = '".htmls($_POST['name'])."', adress = '".htmls($_POST['adress'])."', contact= '".htmls($_POST['contact'])."', tel = '".htmls($_POST['tel'])."', note = '".htmls($_POST['note'])."', email = '".htmls($_POST['email'])."', ur = '".htmls($_POST['ur'])."' WHERE id = {$id}");			
			
		}
		

		
	}		
	
	

	$result = MySQL::fetchAllArray('SELECT * FROM vendors ORDER BY id');
	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','vendors.tpl');
}
elseif(preg_match('~^vendors/edit/([0-9]+)/$~ms', $Path, $q)) {

	$id = intval($q[1]);
	$info = MySQL::sql_fetch_array("SELECT * FROM vendors WHERE id = '{$id}'");

	$smarty->assign('info',$info);
	$smarty->assign('INC_PAGE','vendors_edit.tpl');
	
	
	
}
//$smarty->assign('console',$Path);






?>