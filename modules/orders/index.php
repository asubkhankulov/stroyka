<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком реальных построек на участках */
if(preg_match('~^orders/$~ms', $Path, $q)) {
	

	$list = MySQL::fetchAllArray('SELECT DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date,
sum(dzm.kol) as all_kol,
usr.login_name as username, mat.name as material, mat.id as mat_id,
dz.id as zpok_id, mat_t.name as mat_type,
uch.name as uch, poselok.name as pos, uch.id as uch_id, poselok.id as pos_id, sw.name as work_name,
DATE_FORMAT(rdsw.enddate_fakt,"%d.%m.%Y") as enddatefakt, unt.name as unit, 0 as postupilo, dzm.rdwm_id
FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			LEFT JOIN real_doma_works_materials as rdwm ON rdwm.id = dzm.rdwm_id
			LEFT JOIN real_doma_step_works as rdsw ON rdsw.id = rdwm.work_id
			LEFT JOIN works as sw ON sw.id = rdwm.work_id
			LEFT JOIN b2b_users as usr ON usr.id = dz.user_id
			LEFT JOIN materials as mat ON mat.id = rdwm.material_id
			LEFT JOIN materials_types as mat_t ON mat_t.id = mat.type_id
			LEFT JOIN units as unt ON unt.id = mat.unit_id
			LEFT JOIN uchastok as uch ON uch.id = dz.uchastok_id
			LEFT JOIN mesto as poselok ON poselok.id = uch.mesto_id
			LEFT JOIN stroyka as str ON str.id = rdwm.stroyka_id
GROUP BY dz.uchastok_id, rdsw.work_id, mat.id ORDER BY poselok.id, mat.id, dzm.date_zak');
	
		
	if (!empty($list)) {
		$poselki = array();
		$uchastki = array();
		$all_data = array();
		$mat_uch = array();
		$mat_all = array();
		$mat_uch_color = array();
		foreach ($list as $k=>$data_arr) {
			
			//$poselki[$data_arr['pos']][$data_arr['uch_id']] = array($data_arr['mat_id'],$data_arr['kol']);
			$uchastki[$data_arr['uch_id']] = array('name' =>$data_arr['uch'], 'pos' => $data_arr['pos'], 'mat_id' => $data_arr['mat_id']);
			$all_data[$data_arr['mat_id'].'-'.$data_arr['rdwm_id']] = array('name' =>$data_arr['material'], 'type' => $data_arr['mat_type'], 'work'=>$data_arr['work_name'], 'enddatefakt'=>$data_arr['enddatefakt'], 'unit' => $data_arr['unit']);
			
			$mat_uch[$data_arr['mat_id'].'-'.$data_arr['rdwm_id']][$data_arr['uch_id']] += intval($data_arr['all_kol']);
			
			$mat_uch_color[$k] = 'u';
			if (empty($data_arr['postupilo']) && (empty($data_arr['enddatefakt']) or $data_arr['enddatefakt'] == '00.00.0000' )) $mat_uch_color[$data_arr['mat_id'].'-'.$data_arr['rdwm_id']][$data_arr['uch_id']] = 'danger';
			elseif(empty($data_arr['postupilo']) && (!empty($data_arr['enddatefakt']) and $data_arr['enddatefakt'] != '00.00.0000' ) ) $mat_uch_color[$data_arr['mat_id'].'-'.$data_arr['rdwm_id']][$data_arr['uch_id']] = 'info';
			
			$mat_all[$data_arr['mat_id']] += intval($data_arr['all_kol']);
			
			
			//echo $last_prosr;
			
		}
	}	
			
	//html_dump($all_data);
	//html_dump($mat_uch);
	
	/*
	 * Выбираем цену из справочника материалов, если не задана цена в документе
	 * иначе берем из докуента
	 */
	$zpost = MySQL::fetchAllArray('SELECT sum(dzm.kol) as kols,dz.id, DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date, DATE_FORMAT(dzm.date_zak,"%d.%m.%Y") as zakupkadate, DATE_FORMAT(dz.postup_date,"%d.%m.%Y") as postup_date,
IF(dzm.price>0,sum(dzm.kol*dzm.price),sum(dzm.kol* (SELECT price FROM materials WHERE id = (SELECT material_id FROM real_doma_works_materials WHERE id = dzm.rdwm_id) ) )) as all_summ,
usr.login_name as user, dz.uchastok_id as uchastok_id 
FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			LEFT JOIN b2b_users as usr ON usr.id = dz.user_id
			WHERE dzm.date_zak BETWEEN \''.$mindate.'\' AND \''.$maxdate.'\' GROUP BY dzm.zpost_id ORDER BY dz.zakupka_date');

	
	$mat_val = MySQL::fetchAll('SELECT id FROM materials_types ORDER BY id');
	$mat_name = MySQL::fetchAll('SELECT name FROM materials_types ORDER BY id');
	
	$smarty->assign('list',$list);
	
	$smarty->assign('all_data',$all_data);
	$smarty->assign('uchastki',$uchastki);
	$smarty->assign('mat_uch',$mat_uch);
	$smarty->assign('mat_all',$mat_all);
	$smarty->assign('mat_uch_color',$mat_uch_color);
	//$smarty->assign('uchastok_id',$uchastok_id);

	$smarty->assign('mindate',$mindate);
	$smarty->assign('maxdate',$maxdate);	

	$smarty->assign('list_type_val',$mat_val);	
	$smarty->assign('list_type_name',$mat_name);	
	
	$smarty->assign('zpost',$zpost);
	
	$smarty->assign('INC_PAGE','orders.tpl');
	
	
}
elseif(preg_match('~^orders/view/$~ms', $Path, $q)) {
	
	$mindate = isset($_REQUEST['mindate']) ? $_REQUEST['mindate'] : '2017-03-01';
    $maxdate = isset($_REQUEST['maxdate']) ? $_REQUEST['maxdate'] : '2017-05-01';
	

	$list = MySQL::fetchAllArray('SELECT dzm.*, DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date,
sum(dzm.kol) as all_kol,
usr.login_name as username, mat.name as material, mat.id as mat_id,
dz.id as zpok_id, mat_t.name as mat_type,
uch.name as uch, poselok.name as pos, uch.id as uch_id, poselok.id as pos_id, IFNULL(usrp.login_name,\'не задан\') as prorab
FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			LEFT JOIN real_doma_works_materials as rdwm ON rdwm.id = dzm.rdwm_id
			LEFT JOIN b2b_users as usr ON usr.id = dz.user_id
			LEFT JOIN materials as mat ON mat.id = rdwm.material_id
			LEFT JOIN materials_types as mat_t ON mat_t.id = mat.type_id
			LEFT JOIN uchastok as uch ON uch.id = dz.uchastok_id
			LEFT JOIN mesto as poselok ON poselok.id = uch.mesto_id
			LEFT JOIN stroyka as str ON str.id = rdwm.stroyka_id
			LEFT JOIN b2b_users as usrp ON usrp.id = str.prorab_id
			
WHERE dzm.date_zak BETWEEN \''.$mindate.'\' AND \''.$maxdate.'\' GROUP BY dz.uchastok_id, mat.id ORDER BY poselok.id,dzm.date_zak');
	
	
	if (!empty($list)) {
		$poselki = array();
		$uchastki = array();
		$all_data = array();
		$mat_uch = array();
		$mat_all = array();
		foreach ($list as $k=>$data_arr) {
			
			//$poselki[$data_arr['pos']][$data_arr['uch_id']] = array($data_arr['mat_id'],$data_arr['kol']);
			$uchastki[$data_arr['uch_id']] = array('name' =>$data_arr['uch'], 'pos' => $data_arr['pos'], 'mat_id' => $data_arr['mat_id'], 'prorab'=>$data_arr['prorab']);
			$all_data[$data_arr['mat_id']] = array('name' =>$data_arr['material'], 'type' => $data_arr['mat_type']);
			
			$mat_uch[$data_arr['mat_id']][$data_arr['uch_id']] += intval($data_arr['all_kol']);
			$mat_all[$data_arr['mat_id']] += intval($data_arr['all_kol']);
			
			
			//echo $last_prosr;
			
		}
	}	
			
	//html_dump($all_data);
	//html_dump($mat_uch);
	
	/*
	 * Выбираем цену из справочника материалов, если не задана цена в документе
	 * иначе берем из докуента
	 */
	$zpost = MySQL::fetchAllArray('SELECT sum(dzm.kol) as kols,dz.id, DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date, DATE_FORMAT(dzm.date_zak,"%d.%m.%Y") as zakupkadate, DATE_FORMAT(dz.postup_date,"%d.%m.%Y") as postup_date,
IF(dzm.price>0,sum(dzm.kol*dzm.price),sum(dzm.kol* (SELECT price FROM materials WHERE id = (SELECT material_id FROM real_doma_works_materials WHERE id = dzm.rdwm_id) ) )) as all_summ,
usr.login_name as user, dz.uchastok_id as uchastok_id 
FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			LEFT JOIN b2b_users as usr ON usr.id = dz.user_id
			WHERE dzm.date_zak BETWEEN \''.$mindate.'\' AND \''.$maxdate.'\' GROUP BY dzm.zpost_id ORDER BY dz.zakupka_date');

	
	$mat_val = MySQL::fetchAll('SELECT id FROM materials_types ORDER BY id');
	$mat_name = MySQL::fetchAll('SELECT name FROM materials_types ORDER BY id');
	
	$smarty->assign('list',$list);
	
	$smarty->assign('all_data',$all_data);
	$smarty->assign('uchastki',$uchastki);
	$smarty->assign('mat_uch',$mat_uch);
	$smarty->assign('mat_all',$mat_all);
	//$smarty->assign('list_brigada',$brigada);
	//$smarty->assign('uchastok_id',$uchastok_id);

	$smarty->assign('mindate',$mindate);
	$smarty->assign('maxdate',$maxdate);	

	$smarty->assign('list_type_val',$mat_val);	
	$smarty->assign('list_type_name',$mat_name);	
	
	$smarty->assign('zpost',$zpost);
	
	$smarty->assign('INC_PAGE','orders_view.tpl');
	
	
}

//$smarty->assign('console',$Path);






?>