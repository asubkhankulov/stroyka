<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

$list_type = array('Строители', 'Электрики', 'Сантехники', 'Отопление', 'Универсалы', 'Ювелиры');


if(preg_match('~^brigada/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {

		if (!isset($_POST['id'])) {
			MySQL::query(" 
				INSERT INTO brigada (name, tel, note, type, type2) 
					VALUES (
						'".$_POST['name']."',
						'".$_POST['tel']."',
						'".$_POST['note']."',
						'".$_POST['type']."',
						'".($_POST['type2']==$_POST['type']?'':$_POST['type2'])."'
					)
			");
		}
		else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE brigada SET name = '".$_POST['name']."', tel = '".$_POST['tel']."', note = '".$_POST['note']."', type = '".$_POST['type']."', type2 = '".($_POST['type2']==$_POST['type']?'':$_POST['type2'])."' WHERE id = {$id}");			
			
		}

		
	}		
	
	
	$result = MySQL::fetchAllArray('SELECT * FROM brigada ORDER BY name');

	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list_type',$list_type);
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','brigada.tpl');
}
elseif(preg_match('~^brigada/edit/([0-9]+)/$~ms', $Path, $q)) {

	$id = intval($q[1]);
	$info = MySQL::sql_fetch_array("SELECT * FROM brigada WHERE id = '{$id}'");
	
	$smarty->assign('list_type',$list_type);
	$smarty->assign('info',$info);
	$smarty->assign('INC_PAGE','brigada_edit.tpl');
	
	
	
}

//$smarty->assign('console',$Path);






?>