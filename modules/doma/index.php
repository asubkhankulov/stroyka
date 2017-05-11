<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком клиентов */
if(preg_match('~^doma/$~ms', $Path, $q)) {
	
	/*
	 * Прилетели данные из формы 
	 */
	if (isset($_POST['action'])) {
		if (!isset($_POST['id'])) {
			MySQL::query(" 
				INSERT INTO doma_types (name, type, note) 
					VALUES (
						'".$_POST['name']."',
						'".$_POST['type']."',
						'".$_POST['note']."'
					)
			");
		}
		else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE doma_types SET name = '".$_POST['name']."', type = '".$_POST['type']."', note = '".$_POST['note']."' WHERE id = {$id}");			
			
		}

		
	}		
	
	$result = MySQL::fetchAllArray('SELECT dt.*,(SELECT count(*) FROM doma_steps where doma_id = dt.id) as steps FROM doma_types dt ORDER BY name');
	//var_dump($result);
	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('INC_PAGE','doma.tpl');
}
elseif(preg_match('~^doma/step/([0-9]+)/$~ms', $Path, $q)) {
	//добавление этапа к постройке
	$doma_id = intval($q[1]);
	$tab = '';
	
		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			//var_dump($_POST);
			$result = MySQL::query(" 
				INSERT INTO doma_steps (doma_id, step_id, type, note) 
					VALUES (
						'".$doma_id."',
						'".$_POST['step_id']."',
						'".$_POST['type']."',
						'".$_POST['note']."'
					)
			");
			$step_id = $_POST['step_id'];
			if ($result) {
				//copy all works from step to dom
				$result = MySQL::sql_fetch_array("SELECT count(work_id) cnt FROM step_works WHERE step_id = '{$step_id}'");
				if (!empty($result) and !empty($result['cnt'])) {
						MySQL::query(" 
							INSERT INTO doma_step_works (doma_id, step_id, work_id, sort) 
								SELECT '".$doma_id."','".$step_id."',work_id, sort FROM step_works WHERE step_id = '{$step_id}'");
					
					/*
					foreach ($result as $tmp=>$data) {
						MySQL::query(" 
							INSERT INTO doma_step_works (doma_id, step_id, work_id) 
								VALUES (
									'".$doma_id."',
									'".$step_id."',
									'".$data['work_id']."'
								)
						");
					}
					*/
				}
				//copy all materials from works to works step dom
				$result = MySQL::sql_fetch_array("SELECT count(dsw.work_id) cnt FROM works_materials wm 
					LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id
					WHERE wm.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}'
				");			
				if (!empty($result) and !empty($result['cnt'])) {
					MySQL::query(" 
						INSERT INTO doma_works_materials (doma_id, step_id, work_id, material_id) 
							SELECT '".$doma_id."','".$step_id."', dsw.work_id, wm.material_id FROM works_materials wm 
					LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id
					WHERE wm.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}'");
				}
			}
				
			$tab = $_POST['type'];
			
		}	
	
	
	$list_steps = MySQL::fetchAllArray('SELECT * FROM step ORDER BY type');
	//var_dump($list_steps);
	
	$result = MySQL::fetchAllArray("SELECT ds.*, st.name as name, dt.name as doma, st.type as step_type,
(SELECT sum(wk.price*dsw.v_work) FROM doma_step_works dsw 
			LEFT JOIN works as wk ON wk.id = dsw.work_id
		WHERE dsw.step_id = ds.step_id and dsw.doma_id = ds.doma_id GROUP BY dsw.step_id) as price_summ,
(SELECT sum(dsw.days) FROM doma_step_works dsw 
		WHERE dsw.step_id = ds.step_id and dsw.doma_id = ds.doma_id GROUP BY step_id) as days_summ,
(SELECT sum(dsw.v_work) FROM doma_step_works dsw 
		WHERE dsw.step_id = ds.step_id and dsw.doma_id = ds.doma_id GROUP BY step_id) as v_summ,
(SELECT sum(IF(wm.sposob_id=1, ma.price* wm.kol*dsw.v_work,ma.price* wm.kol)) nn FROM doma_works_materials wm 
			LEFT JOIN materials as ma ON ma.id = wm.material_id
			LEFT JOIN doma_step_works as dsw ON dsw.step_id = wm.step_id and dsw.doma_id = wm.doma_id and  dsw.work_id =wm.work_id
			WHERE wm.step_id = ds.step_id and wm.doma_id = ds.doma_id) as ma_summ,
(SELECT count(dsw.v_work) FROM doma_step_works dsw 
		WHERE dsw.step_id = ds.step_id and dsw.doma_id = ds.doma_id GROUP BY step_id) as cnt_works
FROM doma_steps ds
			LEFT JOIN step as st ON st.id = ds.step_id
			LEFT JOIN doma_types as dt ON dt.id = ds.doma_id
			LEFT JOIN units as un ON un.id = ds.unit_id
		WHERE ds.doma_id = '{$doma_id}'
		ORDER BY ds.sort");	
	//var_dump($result);
	$info = MySQL::sql_fetch_array("SELECT name FROM doma_types WHERE id = '{$doma_id}'");

	$list_unit = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list_unit',$list_unit);
	$smarty->assign('doma_id',$doma_id);
	$smarty->assign('list',$result);
	$smarty->assign('info',$info);
	$smarty->assign('list_steps',$list_steps);
	$smarty->assign('tab',$tab);
	
	$smarty->assign('INC_PAGE','doma_steps.tpl');	
	
	
}
elseif(preg_match('~^doma/plan/([0-9]+)/$~ms', $Path, $q)) {

	$doma_id = intval($q[1]);

	$result = MySQL::fetchAllArray("SELECT st.*, dtp.name as dom, ste.type as dom_type, ste.name as step, wk.name as work,wk.id as work_id, un.name as unit,
			IF(st.shift1=0,DATE_FORMAT(NOW(),'%d.%m.%Y'),DATE_FORMAT(ADDDATE(NOW(), st.shift1),'%d.%m.%Y')) as datestart,
			IF(st.shift1=0,DATE_FORMAT(ADDDATE(NOW(), st.days),'%d.%m.%Y'),DATE_FORMAT(ADDDATE(NOW(), st.shift1+st.days),'%d.%m.%Y')) as dateend
		FROM doma_step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN step as ste ON ste.id = st.step_id
			LEFT JOIN doma_types as dtp ON dtp.id = st.doma_id
			LEFT JOIN units as un ON un.id = wk.unit_id
		WHERE  st.doma_id = '{$doma_id}' ORDER BY dtp.id, st.step_id,st.sort
		");	
	//var_dump($result);
	
	$info = MySQL::sql_fetch_array("SELECT name FROM doma_types WHERE id = '{$doma_id}'");
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('doma_id',$doma_id);
	$smarty->assign('list',$result);
	$smarty->assign('info',$info);
	
	$smarty->assign('INC_PAGE','doma_plan_works.tpl');	
	
	
}
elseif(preg_match('~^doma/works/([0-9]+)/([0-9]+)/$~ms', $Path, $q)) {
	
	$step_id = intval($q[1]);
	$doma_id = intval($q[2]);

	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST); 
		$result = MySQL::query(" 
			INSERT INTO doma_step_works (doma_id, step_id, work_id, note) 
				VALUES (
					'".$doma_id."',
					'".$step_id."',
					'".$_POST['work_id']."',
					'".$_POST['note']."'
				)
		");
		//copy all materials from works to works step dom
		if ($result) {
			$result = MySQL::sql_fetch_array("SELECT count(dsw.work_id) cnt FROM works_materials wm 
				LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id
				WHERE wm.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}'
			");			
			if (!empty($result) and !empty($result['cnt'])) {
				MySQL::query(" 
					INSERT INTO doma_works_materials (doma_id, step_id, work_id, material_id) 
						SELECT '".$doma_id."','".$step_id."', dsw.work_id, wm.material_id FROM works_materials wm 
				LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id
				WHERE wm.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}'");
			}
		}
		
	}
			
			
	
	
	$list_works = MySQL::fetchAllArray('SELECT * FROM works ORDER BY name');
	
	$list = MySQL::fetchAllArray("SELECT st.*,wk.name as work,wk.id as work_id, un.name as unit, wk.price, DATE_FORMAT(ADDDATE(NOW(), st.days),'%d.%m.%Y') as dateend,
	(SELECT count(*) FROM doma_works_materials where doma_works_materials.step_id = st.step_id and doma_works_materials.work_id = st.work_id and doma_works_materials.doma_id = st.doma_id) as matkol,
	(SELECT sum(IF(wm.sposob_id=1, ma.price* wm.kol*st.v_work,ma.price* wm.kol)) summ FROM doma_works_materials wm 
			LEFT JOIN materials as ma ON ma.id = wm.material_id
			WHERE wm.step_id = st.step_id and wm.doma_id = st.doma_id and wm.work_id = st.work_id GROUP BY wm.step_id
) as matsumm  
		FROM doma_step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN units as un ON un.id = wk.unit_id
		WHERE step_id = '{$step_id}' and doma_id = '{$doma_id}' ORDER BY st.sort");	
	//var_dump($result);
	
		
	$info = MySQL::sql_fetch_array("SELECT dt.name,st.name as step FROM doma_types dt, step st 
			WHERE st.id = '{$step_id}' and dt.id = '{$doma_id}'");		
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('doma_id',$doma_id);
	$smarty->assign('step_id',$step_id);
	$smarty->assign('list',$list);
	$smarty->assign('info',$info);
	$smarty->assign('list_works',$list_works);
	$smarty->assign('tab',$tab);
	
	$smarty->assign('INC_PAGE','doma_step_works.tpl');	
	
	
}
elseif(preg_match('~^doma/materials/([0-9]+)/([0-9]+)/([0-9]+)/$~ms', $Path, $q)) {

		$work_id = intval($q[1]);
		$step_id = intval($q[2]);
		$doma_id = intval($q[3]);

		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			//var_dump($_POST);
			MySQL::query(" 
				INSERT INTO doma_works_materials (doma_id, work_id, step_id, material_id) 
					VALUES (
						'".$doma_id."',
						'".$work_id."',
						'".$step_id."',
						'".$_POST['material_id']."'
					)
			");
			
		}		
		
		
		
		$info = MySQL::sql_fetch_array("SELECT dt.name,st.name as step, wk.name as work FROM doma_types dt, step st, works wk 
			WHERE st.id = '{$step_id}' and dt.id = '{$doma_id}' and wk.id = '{$work_id}' ");

		
		$list = MySQL::fetchAllArray("SELECT wm.*, ma.name, un.name as unit,dsw.v_work,ma.price FROM doma_works_materials wm 
			LEFT JOIN materials as ma ON ma.id = wm.material_id
			LEFT JOIN units as un ON un.id = ma.unit_id
			LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id and  dsw.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}'
			WHERE wm.work_id = '{$work_id}' and wm.step_id = '{$step_id}' and wm.doma_id = '{$doma_id}'
			ORDER BY wm.id");
			
		$list_materials = MySQL::fetchAllArray("SELECT mat.*, un.name as unit FROM materials mat 
				INNER JOIN units as un ON un.id = mat.unit_id
		ORDER BY mat.id");

		//$list_unit = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');	
		
				
			//var_dump($info);
		
		$smarty->assign('list',$list);
		$smarty->assign('list_materials',$list_materials);
		//$smarty->assign('list_unit',$list_unit);
		$smarty->assign('info',$info);
		$smarty->assign('doma_id',$doma_id);
		$smarty->assign('work_id',$work_id);
		$smarty->assign('step_id',$step_id);
		$smarty->assign('INC_PAGE','doma_works_materials.tpl');		
}
elseif(preg_match('~^doma/edit/([0-9]+)/$~ms', $Path, $q)) {

		$doma_id = intval($q[1]);
		
		$info = MySQL::sql_fetch_array("SELECT * FROM doma_types WHERE id = '{$doma_id}'");
		
		$smarty->assign('steps_name', array("Не выбрано","Дом","Забор","Септик","Вода"));
		$smarty->assign('steps_val', array("","Дом","Забор","Септик","Вода"));
		

		$smarty->assign('info',$info);
		$smarty->assign('INC_PAGE','doma_types_edit.tpl');		
}
//$smarty->assign('console',$Path);






?>