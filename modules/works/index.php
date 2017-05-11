<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

$list_type = array('Строители', 'Электрики', 'Сантехники', 'Отопление', 'Универсалы', 'Ювелиры');



/* Главная страница со списком клиентов */
if(preg_match('~^works/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		$price = floatval(str_replace(',','.',$_POST['price']));
		$price = round($price,2);		

		if (!isset($_POST['id'])) {
				MySQL::query(" 
			INSERT INTO works (name, unit_id, price, note, type) 
				VALUES (
					'".$_POST['name']."',
					'".$_POST['unit_id']."',
					'".$price."',
					'".$_POST['note']."',
					'".$_POST['type']."'
				)
		");
		} else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE works SET name = '".$_POST['name']."', unit_id = '".$_POST['unit_id']."', price= '".$price."', note = '".$_POST['note']."', type = '".$_POST['type']."' WHERE id = {$id}");			
			
		}		

		
	}		
	
	
	$result = MySQL::fetchAllArray('SELECT wk.*,un.name as unit FROM works wk 
		INNER JOIN units as un ON un.id = wk.unit_id
		ORDER BY name');
	//var_dump($result);
	$list_unit = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');
	
	$smarty->assign('list_type',$list_type);
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list_unit',$list_unit);
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','works.tpl');
}
elseif(preg_match('~^works/edit/([0-9]+)/$~ms', $Path, $q)) {
	
	$id = intval($q[1]);
	$info = MySQL::sql_fetch_array("SELECT * FROM works WHERE id = '{$id}'");
	
	$list_unit_id = MySQL::fetchAll('SELECT id FROM units ORDER BY id');
	$list_unit_name = MySQL::fetchAll('SELECT name FROM units ORDER BY id');
	
	//var_dump($list_unit_name);

	$smarty->assign('list_type',$list_type);
	$smarty->assign('info',$info);
	$smarty->assign('list_unit_id',$list_unit_id);
	$smarty->assign('list_unit_name',$list_unit_name);
	$smarty->assign('INC_PAGE','works_edit.tpl');	
	
}
//$smarty->assign('console',$Path);






?>