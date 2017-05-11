<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^docs/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		$price = floatval(str_replace(',','.',htmls($_POST['price'])));
		$price = round($price,2);
		if (!isset($_POST['id'])) {
			MySQL::query(" 
				INSERT INTO docs (name, price, srok, note) 
					VALUES (
						'".$_POST['name']."',
						'".$price."',
						'".$_POST['srok']."',
						'".$_POST['note']."'
					)
			");
		}
		else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE docs SET name = '".$_POST['name']."', price= '".$price."', srok = '".$_POST['srok']."', note = '".$_POST['note']."' WHERE id = {$id}");			
			
		}

		
	}		
	
	
	$result = MySQL::fetchAllArray('SELECT * FROM docs ORDER BY name');

	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','docs.tpl');
}
elseif(preg_match('~^docs/edit/([0-9]+)/$~ms', $Path, $q)) {

	$id = intval($q[1]);
	$info = MySQL::sql_fetch_array("SELECT * FROM docs WHERE id = '{$id}'");
	
	$smarty->assign('info',$info);
	$smarty->assign('INC_PAGE','docs_edit.tpl');
	
	
	
}

//$smarty->assign('console',$Path);






?>