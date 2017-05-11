<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

$list_type = array('Погрузочно-Разгрузочные', 'Транспортные', 'Монтажные');


if(preg_match('~^uslugi/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {

		if (!isset($_POST['id'])) {
			MySQL::query(" 
				INSERT INTO uslugi (name, type) 
					VALUES (
						'".$_POST['name']."',
						'".$_POST['type']."'
					)
			");
		}
		else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE uslugi SET name = '".$_POST['name']."', type = '".$_POST['type']."' WHERE id = {$id}");			
			
		}

		
	}		
	
	
	$result = MySQL::fetchAllArray('SELECT * FROM uslugi ORDER BY name');

	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list_type',$list_type);
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','uslugi.tpl');
}
elseif(preg_match('~^uslugi/edit/([0-9]+)/$~ms', $Path, $q)) {

	$id = intval($q[1]);
	$info = MySQL::sql_fetch_array("SELECT * FROM uslugi WHERE id = '{$id}'");
	
	$smarty->assign('list_type',$list_type);
	$smarty->assign('info',$info);
	$smarty->assign('INC_PAGE','uslugi_edit.tpl');
	
	
	
}

//$smarty->assign('console',$Path);






?>