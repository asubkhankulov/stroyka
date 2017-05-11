<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^materials/$~ms', $Path, $q)) {
	
	if (isset($_POST['action'])) {

		$name = htmls($_POST['name']);
		$type = htmls($_POST['type_id']);
		$unit = htmls($_POST['unit_id']);
		$m = floatval(str_replace(',','.',htmls($_POST['m'])));
		$m = round($m,2);
		$v = floatval(str_replace(',','.',htmls($_POST['v'])));
		$v = round($v,3);
		
		$price = floatval(str_replace(',','.',htmls($_POST['price'])));
		$price = round($price,2);
		//$price = number_format($price, 2, ',', '');
		$note = htmls($_POST['note']);
		//$id = intval($_POST['id']);
		$id = !isset($_POST['id']) ? 0 : $_POST['id'];
		if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
			if (empty($id)) MySQL::query("INSERT INTO materials (name,type_id,unit_id,price,v,m,note) VALUES ('{$name}','{$type}','{$unit}','{$price}','{$v}','{$m}','{$note}')");
			else MySQL::query("UPDATE materials SET name = '{$name}',type_id = '{$type}',unit_id = '{$unit}',price = '{$price}',note = '{$note}', v = '{$v}', m= '{$m}' WHERE id = '{$id}'");
			//echo 'ok';
			//echo $price;
		}
		else {
			echo 'Нет прав';
		}
		
	
	
	}

	
	
	
	$list_type = MySQL::fetchAllArray('SELECT * FROM materials_types ORDER BY id');
	$list_unit = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');
	
	$result = MySQL::fetchAllArray("SELECT  mat.*, mt.name as type, un.name as unit, vs.name as vendor FROM materials mat 
		INNER JOIN materials_types as mt ON mt.id = mat.type_id
		INNER JOIN units as un ON un.id = mat.unit_id
		LEFT JOIN materials_vendors as mv ON mv.materials_id = mat.id and mv.is_osnownoy = 1 
		LEFT JOIN vendors as vs ON vs.id = mv.vendors_id
		ORDER BY mat.type_id");	
	//var_dump($result);
	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('list_type',$list_type);
	$smarty->assign('list_unit',$list_unit);
	$smarty->assign('INC_PAGE','materials.tpl');
}
elseif(preg_match('~^materials/edit/([0-9]+)/$~ms', $Path, $q)) {

	$id = intval($q[1]);
	
	
	if (isset($_POST['action'])) {

		$res = isset($_POST['vendors']) ? $_POST['vendors'] : array();
		
		MySQL::query("DELETE FROM materials_vendors WHERE materials_id = '{$id}'");
		
		
		foreach ($res as $vid=>$data) {

			$price = floatval(str_replace(',','.',htmls($data['price'])));
			$price = round($price,2);
			$article = htmls($data['article']);
			$osn = isset($data['prior']) ? '1' : '0';
			
			if (isset($data['vkl'])) {
				MySQL::query("INSERT INTO materials_vendors (vendors_id,materials_id,article,price,is_osnownoy) VALUES ('{$vid}','{$id}','{$article}','{$price}','{$osn}')");
			}
			/*
			if (isset($data['vkl']) and !empty($data['vkl']) ) {
				//update
				$mv_id = intval($data['vkl']);
				MySQL::query("UPDATE materials_vendors SET vendors_id = '{$vid}', materials_id = '{$id}', article = '{$article}', price = '{$price}', is_osnownoy = '{$osn}' WHERE id = '{$mv_id}'");
			}
			elseif (isset($data['vkl']) and empty($data['vkl'])) {
				//insert
				MySQL::query("INSERT INTO materials_vendors (vendors_id,materials_id,article,price,is_osnownoy) VALUES ('{$vid}','{$id}','{$article}','{$price}','{$osn}')");
			}
			*/
		}
		
	
	
	}	
	
	
	$list_type = MySQL::fetchAllArray('SELECT * FROM materials_types ORDER BY id');
	$list_unit = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');
	
	$info = MySQL::sql_fetch_array("SELECT mat.*, mt.name as type, un.name as unit FROM materials mat 
		INNER JOIN materials_types as mt ON mt.id = mat.type_id
		INNER JOIN units as un ON un.id = mat.unit_id
		WHERE mat.id = '{$id}'");	
	
	$list = MySQL::fetchAllArray("SELECT vs.name name, vs.id vid, mv.price, mv.id, mv.article, mv.materials_id mid, mv.is_osnownoy
FROM vendors as vs
		LEFT JOIN materials_vendors mv ON mv.vendors_id = vs.id and mv.materials_id = '{$id}'
		ORDER BY vid");	
	
	$smarty->assign('info',$info);
	$smarty->assign('list_type',$list_type);
	$smarty->assign('list_unit',$list_unit);
	
	$smarty->assign('list',$list);
	
	$smarty->assign('INC_PAGE','materials_edit.tpl');
	
	
	
}
//$smarty->assign('console',$Path);






?>