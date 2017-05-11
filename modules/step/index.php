<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();


if(preg_match('~^step/$~ms', $Path, $q)) {
	
		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			if (!isset($_POST['id'])) {
				MySQL::query(" 
					INSERT INTO step (name, type, note) 
						VALUES (
							'".$_POST['name']."',
							'".$_POST['type']."',
							'".$_POST['note']."'
						)
				");
			}
			else {
				$id = intval($_POST['id']);
				MySQL::query("UPDATE step SET name = '".$_POST['name']."', type = '".$_POST['type']."', note = '".$_POST['note']."' WHERE id = {$id}");			
				
			}
		}
	
	
	
	$list = MySQL::fetchAllArray("SELECT st.*,(SELECT count(*) FROM step_works where step_id = st.id) as works FROM step st	ORDER BY st.type DESC,st.name");
		//$list = MySQL::fetchAllArray("SELECT * FROM step ORDER BY id");
	
	$smarty->assign('steps_name', array("Не выбрано","Коробка","Внутренние","Внешние","Сети","Благоустройство","Документация"));
	$smarty->assign('steps_val', array("","Коробка","Внутренние","Внешние","Сети","Благоустройство","Документация"));
	
	
	//$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$list);
	$smarty->assign('INC_PAGE','step.tpl');
}
elseif(preg_match('~^step/edit/([0-9]+)/$~ms', $Path, $q)) {
		
	$id = intval($q[1]);
	$info = MySQL::sql_fetch_array("SELECT * FROM step WHERE id = '{$id}'");

	$smarty->assign('steps_name', array("Не выбрано","Коробка","Внутренние","Внешние","Сети","Благоустройство","Документация"));
	$smarty->assign('steps_val', array("","Коробка","Внутренние","Внешние","Сети","Благоустройство","Документация"));
	
	$smarty->assign('info',$info);
	$smarty->assign('INC_PAGE','step_edit.tpl');		

}
elseif(preg_match('~^step/works/([0-9]+)/$~ms', $Path, $q)) {

		$step_id = intval($q[1]);

		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			//var_dump($_POST);
			MySQL::query(" 
				INSERT INTO step_works (step_id, work_id, note) 
					VALUES (
						'".$step_id."',
						'".$_POST['work_id']."',
						'".$_POST['note']."'
					)
			");
			
		}		
		
		
		
		$list = MySQL::fetchAllArray("SELECT st.*,wk.name as work,wk.id as work_id, un.name as unit, wk.price, (SELECT count(*) from works_materials where works_materials.step_id = st.step_id and works_materials.work_id = st.work_id) as matkol FROM step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN units as un ON un.id = wk.unit_id
		WHERE step_id = '{$step_id}' 
		ORDER BY st.sort");
		//	INNER JOIN units as un ON un.id = st.unit_id
		
		$info = MySQL::sql_fetch_array("SELECT st.name FROM step st 
			WHERE st.id = '{$step_id}'
			ORDER BY st.id");
			
		$list_unit = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');			
		$list_works = MySQL::fetchAllArray('SELECT * FROM works ORDER BY name');			
			
			//var_dump($info);
		
		$smarty->assign('list',$list);
		$smarty->assign('list_unit',$list_unit);
		$smarty->assign('list_works',$list_works);
		$smarty->assign('info',$info);
		$smarty->assign('step',$step_id);
		$smarty->assign('INC_PAGE','step_works.tpl');		
}
elseif(preg_match('~^step/materials/([0-9]+)/([0-9]+)/$~ms', $Path, $q)) {

		$work_id = intval($q[1]);
		$step_id = intval($q[2]);

		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			//var_dump($_POST);
			MySQL::query(" 
				INSERT INTO works_materials (work_id, step_id, material_id) 
					VALUES (
						'".$work_id."',
						'".$step_id."',
						'".$_POST['material_id']."'
					)
			");
			
		}		
		
		
		
		$info = MySQL::sql_fetch_array("SELECT st.name,wk.name as work FROM step st 
	LEFT JOIN step_works as sw ON sw.step_id = st.id
	LEFT JOIN works as wk ON wk.id = sw.work_id
WHERE sw.step_id = '{$step_id}' and sw.work_id = '{$work_id}'
ORDER BY st.id");

		
		$list = MySQL::fetchAllArray("SELECT wm.*, ma.* FROM works_materials wm 
			INNER JOIN materials as ma ON ma.id = wm.material_id
			WHERE wm.work_id = '{$work_id}' and wm.step_id = '{$step_id}'
			ORDER BY wm.id");

		$list_materials = MySQL::fetchAllArray("SELECT mat.*, un.name as unit FROM materials mat 
				INNER JOIN units as un ON un.id = mat.unit_id
		ORDER BY mat.id");
			
			//var_dump($info);
		
		$smarty->assign('list',$list);
		$smarty->assign('list_materials',$list_materials);
		$smarty->assign('info',$info);
		$smarty->assign('work_id',$work_id);
		$smarty->assign('step_id',$step_id);
		$smarty->assign('INC_PAGE','works_materials.tpl');		
}
//var_dump($Path);
//$smarty->assign('console',$Path);






?>