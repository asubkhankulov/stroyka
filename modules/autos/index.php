<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^autos/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		
		$m = floatval(str_replace(',','.',htmls($_POST['m'])));
		$m = round($m,2);
		$v = floatval(str_replace(',','.',htmls($_POST['v'])));
		$v = round($v,2);		
		
		
		MySQL::query(" 
			INSERT INTO autos (name, v, m, note) 
				VALUES (
					'".$_POST['name']."',
					'".$v."',
					'".$m."',
					'".$_POST['note']."'
				)
		");
		

		
	}		
	
	

	$result = MySQL::fetchAllArray('SELECT * FROM autos ORDER BY id');
	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','autos.tpl');
}
elseif(preg_match('~^doma/step/([0-9]+)/$~ms', $Path, $q)) {
	
	$doma_id = intval($q[1]);
	$tab = 'Коробка';
	
		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			//var_dump($_POST);
			MySQL::query(" 
				INSERT INTO doma_steps (doma_id, step_id, type, note) 
					VALUES (
						'".$doma_id."',
						'".$_POST['step_id']."',
						'".$_POST['type']."',
						'".$_POST['note']."'
					)
			");
			
			$tab = $_POST['type'];
			
		}	
	
	
	$list_steps = MySQL::fetchAllArray('SELECT * FROM step ORDER BY id');
	
	$result = MySQL::fetchAllArray("SELECT ds.*, st.name as name, dt.name as doma FROM doma_steps ds
		INNER JOIN step as st ON st.id = ds.step_id
		INNER JOIN doma_types as dt ON dt.id = ds.doma_id
		WHERE ds.doma_id = {$doma_id}
		ORDER BY ds.type,ds.id");	
	//var_dump($result);
	$info = MySQL::sql_fetch_array("SELECT name FROM doma_types 
		WHERE id = '{$doma_id}'");	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('doma_id',$doma_id);
	$smarty->assign('list',$result);
	$smarty->assign('info',$info);
	$smarty->assign('list_steps',$list_steps);
	$smarty->assign('tab',$tab);
	
	$smarty->assign('INC_PAGE','doma_steps.tpl');	
	
	
}
//$smarty->assign('console',$Path);






?>