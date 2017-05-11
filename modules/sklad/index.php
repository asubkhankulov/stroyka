<?

if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^sklad/$~ms', $Path, $q)) {

	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST);
		MySQL::query(" 
			INSERT INTO mesto (name, note, type) 
				VALUES (
					'".$_POST['name']."',
					'".$_POST['note']."',
					'1'
				)
		");
		
		
	}
	
	$list = MySQL::fetchAllArray('SELECT mt.*,(SELECT count(*) FROM uchastok where mesto_id = mt.id) as kol FROM mesto mt WHERE mt.type = 1 ORDER BY name');

	//$smarty->assign('today',date('d.m.Y',time()));
	$smarty->assign('list',$list);

	$smarty->assign('INC_PAGE','sklad.tpl');

}
elseif(preg_match('~^sklad/([0-9]+)/$~ms', $Path, $q)) {

	$mesto_id = intval($q[1]);

	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		$s = floatval(htmls($_POST['s']));
		$s = round($s,2);
		$d = floatval(htmls($_POST['d']));
		$d = round($d,2);
		$shir = floatval(htmls($_POST['shir']));
		$shir = round($shir,2); 
		if (!isset($_POST['id'])) {		
			MySQL::query(" 
				INSERT INTO uchastok (name, mesto_id, s, d, shir, septik, voda, note, type) 
					VALUES (
						'".$_POST['name']."',
						'".$mesto_id."',
						'".$s."',
						'".$d."',
						'".$shir."',
						'".$_POST['septik']."',
						'".$_POST['voda']."',
						'".$_POST['note']."',
						'1'
					)
			");
		}
		else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE uchastok SET name = '".$_POST['name']."', mesto_id= '".$mesto_id."', note = '".$_POST['note']."'
			WHERE id = {$id}");			
			
		}
		
		
	}	
		
	
	$info = MySQL::sql_fetch_array("SELECT id,name FROM mesto WHERE id = '{$mesto_id}'");
		
	$list = MySQL::fetchAllArray('SELECT * FROM uchastok WHERE mesto_id = '.$mesto_id.' ORDER BY id');			
		
		//var_dump(stripos(' =999999.9\"+%2f**%2fuNiOn%2f**%2faLl+%2f**%2fsElEcT   ','union'));
	
	$smarty->assign('list',$list);
	$smarty->assign('info',$info);
	$smarty->assign('INC_PAGE','sklad_uchastki.tpl');	 	
}
elseif(preg_match('~^sklad/edit/([0-9]+)/$~ms', $Path, $q)) {
	
	$id = intval($q[1]);
	
	$info = MySQL::sql_fetch_array("SELECT * FROM uchastok WHERE id = '{$id}'");
	

	$smarty->assign('info',$info);
	$smarty->assign('INC_PAGE','sklad_uchastki_edit.tpl');	 	
}






?>