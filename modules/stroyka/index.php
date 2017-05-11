<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком реальных построек на участках */
if(preg_match('~^stroyka/$~ms', $Path, $q)) {
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		if (!isset($_POST['id'])) {
			$result = MySQL::query(" 
				INSERT INTO stroyka (doma_types_id, uchastok_id, prorab_id, note) 
					VALUES (
						'".$_POST['doma_types_id']."',
						'".$_POST['uchastok_id']."',
						'".$_POST['prorab_id']."',
						'".$_POST['note']."'
					)
			");
			if ($result) {

				$stroyka_id = MySQL::sql_insert_id();
				$doma_id = $_POST['doma_types_id'];
				
				
				//copy all steps from doma_steps to real_doma_steps
				$result = MySQL::sql_fetch_array("SELECT count(step_id) cnt FROM doma_steps WHERE doma_id = '{$doma_id}'");
				if (!empty($result) and !empty($result['cnt'])) {

						MySQL::query(" 
							INSERT INTO real_doma_steps (stroyka_id, doma_id, step_id, unit_id, v_step, type, sort) 
								     SELECT '".$stroyka_id."','".$doma_id."', step_id, unit_id, v_step, type, sort FROM doma_steps WHERE doma_id = '{$doma_id}'");
				
				}
				//copy all doma_step_works to real_doma_step_works
				$result = MySQL::sql_fetch_array("SELECT count(work_id) cnt FROM doma_step_works WHERE doma_id = '{$doma_id}'");
				if (!empty($result) and !empty($result['cnt'])) {
						MySQL::query(" 
							INSERT INTO real_doma_step_works (stroyka_id, doma_id, step_id, work_id, v_work, days, sort, shift1) 
								          SELECT '".$stroyka_id."','".$doma_id."', step_id, work_id, v_work, days, sort, shift1 FROM doma_step_works WHERE doma_id = '{$doma_id}'");
					
				}
				//copy all materials from works to works step dom
				$result = MySQL::sql_fetch_array("SELECT count(material_id) cnt FROM works_materials wm 
					LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id
					WHERE dsw.doma_id = '{$doma_id}'
				");			
				if (!empty($result) and !empty($result['cnt'])) {
						MySQL::query(" 
							INSERT INTO real_doma_works_materials (stroyka_id, doma_id, step_id, work_id, material_id, sposob_id, norma, kol) 
								               SELECT '".$stroyka_id."','".$doma_id."', step_id, work_id, material_id, sposob_id, norma, kol FROM doma_works_materials WHERE doma_id = '{$doma_id}'");
				}
			}
			
			
			
			
			
			
		}
		else {
			$id = intval($_POST['id']);
			MySQL::query("UPDATE doma_types___ SET name = '".$_POST['name']."', type = '".$_POST['type']."', note = '".$_POST['note']."' WHERE id = {$id}");			
			
		}

		
	}		

	$result = MySQL::fetchAllArray('SELECT str.*, count(str.uchastok_id) cnt , uch.name as uchastok, pos.name as poselok, dtp.name as dom FROM stroyka str 
		LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
		LEFT JOIN doma_types as dtp ON dtp.id = str.doma_types_id and dtp.type = \'Дом\' 
		LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
		LEFT JOIN mesto as pos ON pos.id = uch.mesto_id
	GROUP BY str.uchastok_id 
	ORDER BY str.id');
	
	/*
	$result = MySQL::fetchAllArray('SELECT str.*, dt.name as object, dt.type as object_type,usr.login_name as prorab, uch.name as uchastok, pos.name as poselok FROM stroyka str 
		LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
		LEFT JOIN b2b_users as usr ON usr.id = str.prorab_id 
		LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
		LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
	ORDER BY str.uchastok_id,dt.type');
	*/
	//var_dump($result);
	
	$mesta = MySQL::fetchAllArray('SELECT uch.id, uch.name as uchastok, pos.name as poselok FROM uchastok uch
			INNER JOIN mesto as pos ON pos.id = uch.mesto_id
	 ORDER BY pos.id,uch.name');	
	
	$doma_types = MySQL::fetchAllArray('SELECT id,name,type FROM doma_types ORDER BY name');	
	$prorabs = MySQL::fetchAllArray('SELECT id,login_name FROM b2b_users WHERE status = 1 ORDER BY login_name');	
	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('list_mesto',$mesta);
	$smarty->assign('doma_types',$doma_types);
	$smarty->assign('prorabs',$prorabs);
	$smarty->assign('INC_PAGE','stroyka.tpl');
}
elseif(preg_match('~^stroyka/plan/([0-9]+)/$~ms', $Path, $q)) {
	$uchastok_id = intval($q[1]);
	
	$info = MySQL::fetchAllArray('SELECT str.*, dt.name as object, dt.type as object_type,usr.login_name as prorab, uch.name as uchastok, pos.name as poselok FROM stroyka str 
		LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
		LEFT JOIN b2b_users as usr ON usr.id = str.prorab_id 
		LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
		LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
	WHERE str.uchastok_id = '.$uchastok_id.'
	ORDER BY dt.type');
	

	
	$list = MySQL::fetchAllArray("SELECT st.*,dtp.name as dom,ste.name as step,ste.type as step_type, wk.name as work,wk.id as work_id, un.name as unit, wk.price,
	(SELECT count(*) FROM real_doma_works_materials rdwm where rdwm.step_id = st.step_id and rdwm.work_id = st.work_id and rdwm.doma_id = st.doma_id and rdwm.stroyka_id = st.stroyka_id) as matkol,
	(SELECT sum(IF(wm.sposob_id=1, ma.price* wm.kol*st.v_work,ma.price* wm.kol)) summ FROM real_doma_works_materials wm 
			LEFT JOIN materials as ma ON ma.id = wm.material_id
			WHERE wm.step_id = st.step_id and wm.doma_id = st.doma_id and wm.work_id = st.work_id and wm.stroyka_id = st.stroyka_id GROUP BY wm.step_id
) as matsumm,
DATE_FORMAT(IFNULL(st.start_date,ADDDATE(dsw.start_date, st.shift1)),'%d.%m.%Y') as  startdate,
DATE_FORMAT(IFNULL(ADDDATE(st.start_date,st.days),ADDDATE(dsw.start_date, st.days+st.shift1)),'%d.%m.%Y') as  enddate
		FROM real_doma_step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN step as ste ON ste.id = st.step_id
			LEFT JOIN doma_types as dtp ON dtp.id = st.doma_id
			LEFT JOIN units as un ON un.id = wk.unit_id
			LEFT JOIN real_doma_step_works as dsw ON (dsw.start_date IS NOT NULL and dsw.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}'))
		WHERE  st.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}') ORDER BY dtp.id, st.step_id,st.sort");	
	
	$list_type = array('Строители', 'Электрики', 'Сантехники', 'Отопление', 'Универсалы', 'Ювелиры');
	$list_brigada = MySQL::fetchAllArray('SELECT * FROM brigada ORDER BY name');
	
	$smarty->assign('list',$list);
	$smarty->assign('info',$info);
	$smarty->assign('list_type',$list_type);
	$smarty->assign('list_brigada',$list_brigada);
	$smarty->assign('uchastok_id',$uchastok_id);
	
	$smarty->assign('INC_PAGE','stroyka_plan.tpl');
	
	
}
elseif(preg_match('~^stroyka/real/([0-9]+)/$~ms', $Path, $q)) {
	$uchastok_id = intval($q[1]);
	
	$info = MySQL::fetchAllArray('SELECT str.*, dt.name as object, dt.type as object_type,usr.login_name as prorab, uch.name as uchastok, pos.name as poselok FROM stroyka str 
		LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
		LEFT JOIN b2b_users as usr ON usr.id = str.prorab_id 
		LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
		LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
	WHERE str.uchastok_id = '.$uchastok_id.'
	ORDER BY dt.type');
	

	
	$list = MySQL::fetchAllArray("SELECT st.*,dtp.name as dom,ste.name as step,ste.type as step_type, wk.name as work,wk.id as work_id, un.name as unit,
	(SELECT count(*) FROM real_doma_works_materials rdwm where rdwm.step_id = st.step_id and rdwm.work_id = st.work_id and rdwm.doma_id = st.doma_id and rdwm.stroyka_id = st.stroyka_id) as matkol,
	(SELECT sum(IF(wm.sposob_id=1, ma.price* wm.kol*st.v_work,ma.price* wm.kol)) summ FROM real_doma_works_materials wm 
			LEFT JOIN materials as ma ON ma.id = wm.material_id
			WHERE wm.step_id = st.step_id and wm.doma_id = st.doma_id and wm.work_id = st.work_id and wm.stroyka_id = st.stroyka_id GROUP BY wm.step_id
) as matsumm,
DATE_FORMAT(IFNULL(st.start_date,ADDDATE(dsw.start_date, st.shift1)),'%d.%m.%Y') as  startdate,
DATE_FORMAT(IFNULL(ADDDATE(st.start_date,st.days),ADDDATE(dsw.start_date, st.days+st.shift1)),'%d.%m.%Y') as  enddate,
DATE_FORMAT(st.startdate_fakt,'%d.%m.%Y') as startdatefakt,  
DATE_FORMAT(st.enddate_fakt,'%d.%m.%Y') as enddatefakt,
IFNULL(DATEDIFF(st.enddate_fakt,st.startdate_fakt),0) as d_fakt,
(st.days-IFNULL(DATEDIFF(st.enddate_fakt,st.startdate_fakt),0)) as otsto,
DATEDIFF(ADDDATE(dsw.start_date, st.days+st.shift1),st.enddate_fakt) as prosr,
UNIX_TIMESTAMP(IFNULL(st.start_date,ADDDATE(dsw.start_date, st.shift1))) as unix_start    
		FROM real_doma_step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN step as ste ON ste.id = st.step_id
			LEFT JOIN doma_types as dtp ON dtp.id = st.doma_id
			LEFT JOIN units as un ON un.id = wk.unit_id
			LEFT JOIN real_doma_step_works as dsw ON (dsw.start_date IS NOT NULL and dsw.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}'))
		WHERE  st.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}') ORDER BY dtp.id, st.step_id,st.sort");	
		
	if (!empty($list)) {
		$last_prosr = 0;
		$plan_date = 0;
		foreach ($list as $k=>$data_arr) {
			
			if ($last_prosr != 0 && (empty($data_arr['enddatefakt']) or $data_arr['enddatefakt'] == '00.00.0000')) {
				
				$plan_date = intval($data_arr['unix_start']) + 24*60*60 * (0-$last_prosr);
				$list[$k]['start_prognoz'] = date('d.m.Y',$plan_date);
				$list[$k]['end_prognoz'] = date('d.m.Y',$plan_date+24*60*60*intval($data_arr['days']));
				
			}
			
			$last_prosr = intval($data_arr['prosr']) != 0 ? intval($data_arr['prosr']) : $last_prosr;
			
			//echo $last_prosr;
			
		}
	}
			
	//html_dump($list);
	$brigada = MySQL::fetchAllArray('SELECT * FROM brigada ORDER BY type');
	
	$smarty->assign('list',$list);
	$smarty->assign('info',$info);
	$smarty->assign('list_brigada',$brigada);
	$smarty->assign('uchastok_id',$uchastok_id);
	
	$smarty->assign('INC_PAGE','stroyka_real.tpl');
	
	
}
elseif(preg_match('~^stroyka/zak/([0-9]+)/$~ms', $Path, $q)) {
	$uchastok_id = intval($q[1]);
	
	$info = MySQL::sql_fetch_array('SELECT str.*, dt.name as object, dt.type as object_type,usr.login_name as prorab, uch.name as uchastok, pos.name as poselok, pos.days as obes_days FROM stroyka str 
		LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
		LEFT JOIN b2b_users as usr ON usr.id = str.prorab_id 
		LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
		LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
	WHERE str.uchastok_id = '.$uchastok_id.'
	ORDER BY dt.type LIMIT 1');
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST);
		$data_zak = $_POST['zpost_zakupka'];
		$data_pos = $_POST['zpost_post'];
		$data_kol = $_POST['zpost'];
		$data_sql = array();
		foreach ($data_pos as $id_rdwm => $date_zak) {
			if (!empty($id_rdwm) and !empty($data_kol[$id_rdwm]) and !empty($date_zak)) {
				$data_sql[$date_zak][] = array('id_rdwm'=>$id_rdwm,'kol'=>$data_kol[$id_rdwm],'data_zak'=>$data_zak[$id_rdwm]);
			}
		}
		
		//html_dump($data_sql);	

		if (!empty($data_sql)) {
			
			foreach ($data_sql as $date_zak => $data) {
				$res = MySQL::query(" 
					INSERT INTO docs_zpok (mesto_id, uchastok_id, start_date, user_id, postup_date, zakupka_date) 
						VALUES (
							'".$info[0]['id']."',
							'".$uchastok_id."',
							NOW(),
							'".$_SESSION['userid']."',
							'".$date_zak."',
							'".$data[0]['data_zak']."'
						)
				");
				
				if ($res) {
					$ins_id = MySQL::sql_insert_id();
					
					//$data = $_POST['zpost'];
					if (!empty($data)) {
						$sql = array();
						foreach ($data as $temp) {
							$id_rdwm = $temp['id_rdwm'];
							$kol 	 = $temp['kol'];
							$data_zak = $temp['data_zak'];
							$sql[] = "({$ins_id},{$id_rdwm},{$kol},'{$data_zak}')";
						}
						$res = MySQL::query(' 
							INSERT INTO docs_zpok_materials (zpost_id, rdwm_id, kol, date_zak) 
								VALUES '.join(',',$sql));
						
					}
					//html_dump($sql);
			
				}				
				
			}
		}

	}
	
	$list = MySQL::fetchAllArray("SELECT st.*,dtp.name as dom,ste.name as step,ste.type as step_type, wk.name as work,wk.id as work_id, un.name as unit,
DATE_FORMAT(IFNULL(st.start_date,ADDDATE(dsw.start_date, st.shift1)),'%d.%m.%Y') as  startdate,
DATE_FORMAT(IFNULL(ADDDATE(st.start_date,st.days),ADDDATE(dsw.start_date, st.days+st.shift1)),'%d.%m.%Y') as  enddate,
DATE_FORMAT(st.startdate_fakt,'%d.%m.%Y') as startdatefakt,  
DATE_FORMAT(st.enddate_fakt,'%d.%m.%Y') as enddatefakt,
IFNULL(DATEDIFF(st.enddate_fakt,st.startdate_fakt),0) as d_fakt,
(st.days-IFNULL(DATEDIFF(st.enddate_fakt,st.startdate_fakt),0)) as otsto,
DATEDIFF(ADDDATE(dsw.start_date, st.days+st.shift1),st.enddate_fakt) as prosr,
UNIX_TIMESTAMP(IFNULL(st.start_date,ADDDATE(dsw.start_date, st.shift1))) as unix_start,
mat.name as material, rdwm.kol as matkol, mat_t.name as mat_type, un_mat.name mat_unit, mat.type_id as mat_type_id, (poselok.days+mat.days) as obespech, rdwm.id as id_rdwm, poselok.days as obesp_pos,
(SELECT sum(dzm.kol) FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			WHERE dz.uchastok_id = {$uchastok_id} and dzm.rdwm_id = rdwm.id
) as vputi   
		FROM real_doma_step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN step as ste ON ste.id = st.step_id
			LEFT JOIN doma_types as dtp ON dtp.id = st.doma_id
			LEFT JOIN units as un ON un.id = wk.unit_id
			LEFT JOIN real_doma_step_works as dsw ON (dsw.start_date IS NOT NULL and dsw.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}'))
			LEFT JOIN real_doma_works_materials as rdwm ON rdwm.step_id = st.step_id and rdwm.work_id = st.work_id and rdwm.doma_id = st.doma_id and rdwm.stroyka_id = st.stroyka_id
			LEFT JOIN materials as mat ON mat.id = rdwm.material_id
			LEFT JOIN materials_types as mat_t ON mat_t.id = mat.type_id
			LEFT JOIN units as un_mat ON un_mat.id = mat.unit_id
			LEFT JOIN uchastok as uch ON uch.id = '{$uchastok_id}'
			LEFT JOIN mesto as poselok ON poselok.id = uch.mesto_id
			
		WHERE  st.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}') ORDER BY dtp.id, st.step_id,st.sort");	
		
	if (!empty($list)) {
		$last_prosr = 0;
		$plan_date = 0;
		$now = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
		$next_week = $now + 24*60*60 *7;
		foreach ($list as $k=>$data_arr) {
			
			if ($last_prosr != 0 && (empty($data_arr['enddatefakt']) or $data_arr['enddatefakt'] == '00.00.0000')) {
				
				$plan_date = intval($data_arr['unix_start']) + 24*60*60 * (0-$last_prosr);
				$list[$k]['start_prognoz'] = date('d.m.Y',$plan_date);
				$list[$k]['end_prognoz'] = date('d.m.Y',$plan_date+24*60*60*intval($data_arr['days']));
				
				$list[$k]['data_post'] = date('d.m.Y',$plan_date - 24*60*60 * (intval($data_arr['obesp_pos'])));
				$list[$k]['datapost'] = date('Y-m-d',$plan_date - 24*60*60 * (intval($data_arr['obesp_pos'])));
				
				$list[$k]['start_zakupka'] = date('d.m.Y',$plan_date - 24*60*60 * (intval($data_arr['obespech'])));
				$list[$k]['startzakupka'] = date('Y-m-d',$plan_date - 24*60*60 * (intval($data_arr['obespech'])));
				
				$tmp = ($plan_date - 24*60*60 * (intval($data_arr['obespech'])));
				$list[$k]['on_next_week'] = ($tmp >= $now && $tmp <= $next_week) ? ' success' : '' ;
				
				
				
			}
			else {
				$list[$k]['start_zakupka'] = date('d.m.Y',intval($data_arr['unix_start']) - 24*60*60 * (intval($data_arr['obespech'])));
				$list[$k]['startzakupka'] = date('Y-m-d',intval($data_arr['unix_start']) - 24*60*60 * (intval($data_arr['obespech'])));
				
				$list[$k]['data_post'] = date('d.m.Y',intval($data_arr['unix_start']) - 24*60*60 * (intval($data_arr['obesp_pos'])));
				$list[$k]['datapost'] = date('Y-m-d',intval($data_arr['unix_start']) - 24*60*60 * (intval($data_arr['obesp_pos'])));

				$tmp = (intval($data_arr['unix_start']) - 24*60*60 * (intval($data_arr['obespech'])));
				$list[$k]['on_next_week'] = ($tmp >= $now && $tmp <= $next_week) ? ' success' : '' ;
			}
			
			$last_prosr = intval($data_arr['prosr']) != 0 ? intval($data_arr['prosr']) : $last_prosr;
			
			//echo $last_prosr;
			
		}
	}
	/*
	 * Выбираем цену из справочника материалов, если не задана цена в документе
	 * иначе берем из докуента
	 */
	$zpost = MySQL::fetchAllArray('SELECT sum(dzm.kol) as kols,dz.id, DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date, DATE_FORMAT(dzm.date_zak,"%d.%m.%Y") as zakupkadate, DATE_FORMAT(dz.postup_date,"%d.%m.%Y") as postup_date,
IF(dzm.price>0,sum(dzm.kol*dzm.price),sum(dzm.kol* (SELECT price FROM materials WHERE id = (SELECT material_id FROM real_doma_works_materials WHERE id = dzm.rdwm_id) ) )) as all_summ,
usr.login_name as user 
FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			LEFT JOIN b2b_users as usr ON usr.id = dz.user_id
	
			WHERE dz.uchastok_id = '.$uchastok_id.' GROUP BY dzm.zpost_id ORDER BY dz.zakupka_date');
			
	//html_dump($list);
	$mat_val = MySQL::fetchAll('SELECT id FROM materials_types ORDER BY id');
	$mat_name = MySQL::fetchAll('SELECT name FROM materials_types ORDER BY id');
	
	$smarty->assign('list',$list);
	$smarty->assign('info',$info);
	$smarty->assign('zpost',$zpost);
	$smarty->assign('list_brigada',$brigada);
	$smarty->assign('uchastok_id',$uchastok_id);

	$smarty->assign('stroyka_id',$stroyka_id);
	$smarty->assign('doma_id',$doma_id);	

	$smarty->assign('list_type_val',$mat_val);	
	$smarty->assign('list_type_name',$mat_name);	
	
	$smarty->assign('INC_PAGE','stroyka_zak.tpl');
	
	
}
elseif(preg_match('~^stroyka/zak/([0-9]+)/([0-9]+)/$~ms', $Path, $q)) {
	$uchastok_id = intval($q[1]);
	$zpok_id = intval($q[2]);
	
	$info = MySQL::sql_fetch_array('SELECT str.*, dt.name as object, dt.type as object_type,usr.login_name as prorab, uch.name as uchastok, pos.name as poselok, pos.days as obes_days FROM stroyka str 
		LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
		LEFT JOIN b2b_users as usr ON usr.id = str.prorab_id 
		LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
		LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
	WHERE str.uchastok_id = '.$uchastok_id.'
	ORDER BY dt.type LIMIT 1');
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST);
		
		$data_zak = $_POST['zpost_zakupka'];
		$data_kol = $_POST['zpost'];
		$data_sql = array();
		foreach ($data_zak as $id_rdwm => $date_zak) {
			if (!empty($id_rdwm) and empty($data_kol[$id_rdwm])) {
				$data_sql[$date_zak][] = array('id_rdwm'=>$id_rdwm,'kol'=>$data_kol[$id_rdwm]);
			}
		}
		
		html_dump($data_sql);
		

		$res = MySQL::query(" 
			INSERT INTO docs_zpost (mesto_id, uchastok_id, start_date, user_id) 
				VALUES (
					'".$info[0]['id']."',
					'".$uchastok_id."',
					NOW(),
					'".$_SESSION['userid']."'
				)
		");

		
		if ($res) {
			$ins_id = MySQL::sql_insert_id();
			
			$data = $_POST['zpost'];
			if (!empty($data)) {
				$sql = array();
				foreach ($data as $id_rdwm => $kol) {
					if (!empty($id_rdwm) && !empty($kol)) $sql[] = "({$ins_id},{$id_rdwm},{$kol})";
				}
				$res = MySQL::query(' 
					INSERT INTO docs_zpost_materials (zpost_id, rdwm_id, kol) 
						VALUES '.join(',',$sql));
				
			}
			
		}
		
	}
	
	$list = MySQL::fetchAllArray("SELECT st.*,dtp.name as dom,ste.name as step,ste.type as step_type, wk.name as work,wk.id as work_id, un.name as unit,
DATE_FORMAT(IFNULL(st.start_date,ADDDATE(dsw.start_date, st.shift1)),'%d.%m.%Y') as  startdate,
DATE_FORMAT(IFNULL(ADDDATE(st.start_date,st.days),ADDDATE(dsw.start_date, st.days+st.shift1)),'%d.%m.%Y') as  enddate,
DATE_FORMAT(st.startdate_fakt,'%d.%m.%Y') as startdatefakt,  
DATE_FORMAT(st.enddate_fakt,'%d.%m.%Y') as enddatefakt,
IFNULL(DATEDIFF(st.enddate_fakt,st.startdate_fakt),0) as d_fakt,
(st.days-IFNULL(DATEDIFF(st.enddate_fakt,st.startdate_fakt),0)) as otsto,
DATEDIFF(ADDDATE(dsw.start_date, st.days+st.shift1),st.enddate_fakt) as prosr,
UNIX_TIMESTAMP(IFNULL(st.start_date,ADDDATE(dsw.start_date, st.shift1))) as unix_start,
mat.name as material, rdwm.kol as matkol, mat_t.name as mat_type, un_mat.name mat_unit, mat.type_id as mat_type_id, (poselok.days+mat.days) as obespech, rdwm.id as id_rdwm,
(SELECT sum(dzm.kol) FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			WHERE dz.uchastok_id = {$uchastok_id} and dzm.rdwm_id = rdwm.id
) as vputi   
		FROM real_doma_step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN step as ste ON ste.id = st.step_id
			LEFT JOIN doma_types as dtp ON dtp.id = st.doma_id
			LEFT JOIN units as un ON un.id = wk.unit_id
			LEFT JOIN real_doma_step_works as dsw ON (dsw.start_date IS NOT NULL and dsw.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}'))
			LEFT JOIN real_doma_works_materials as rdwm ON rdwm.step_id = st.step_id and rdwm.work_id = st.work_id and rdwm.doma_id = st.doma_id and rdwm.stroyka_id = st.stroyka_id
			LEFT JOIN materials as mat ON mat.id = rdwm.material_id
			LEFT JOIN materials_types as mat_t ON mat_t.id = mat.type_id
			LEFT JOIN units as un_mat ON un_mat.id = mat.unit_id
			LEFT JOIN uchastok as uch ON uch.id = '{$uchastok_id}'
			LEFT JOIN mesto as poselok ON poselok.id = uch.mesto_id
			
		WHERE  st.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}') ORDER BY dtp.id, st.step_id,st.sort");	
		
	if (!empty($list)) {
		$last_prosr = 0;
		$plan_date = 0;
		foreach ($list as $k=>$data_arr) {
			
			if ($last_prosr != 0 && (empty($data_arr['enddatefakt']) or $data_arr['enddatefakt'] == '00.00.0000')) {
				
				$plan_date = intval($data_arr['unix_start']) + 24*60*60 * (0-$last_prosr);
				$list[$k]['start_prognoz'] = date('d.m.Y',$plan_date);
				$list[$k]['end_prognoz'] = date('d.m.Y',$plan_date+24*60*60*intval($data_arr['days']));
				
				$list[$k]['data_post'] = date('d.m.Y',$plan_date - 24*60*60 * (intval($data_arr['obespech'])));
				
				$list[$k]['start_zakupka'] = date('d.m.Y',$plan_date - 24*60*60 * (intval($data_arr['obespech'])));
				
			}
			else $list[$k]['start_zakupka'] = date('d.m.Y',intval($data_arr['unix_start']) - 24*60*60 * (intval($data_arr['obespech'])));
			
			$last_prosr = intval($data_arr['prosr']) != 0 ? intval($data_arr['prosr']) : $last_prosr;
			
			//echo $last_prosr;
			
		}
	}
	/*
	 * Выбираем цену из справочника материалов, если не задана цена в документе
	 * иначе берем из документа
	 */
	$zpok = MySQL::fetchAllArray('SELECT dzm.*, DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date,DATE_FORMAT(dzm.date_zak,"%d.%m.%Y") as zakupkadate, DATE_FORMAT(dz.postup_date,"%d.%m.%Y") as postup_date,
IF(dzm.price>0,dzm.price,mat.price) as doc_price,
usr.login_name as username, mat.name as material,
dz.id as zpok_id
FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			LEFT JOIN real_doma_works_materials as rdwm ON rdwm.id = dzm.rdwm_id
			LEFT JOIN b2b_users as usr ON usr.id = dz.user_id
			LEFT JOIN materials as mat ON mat.id = rdwm.material_id
			WHERE dz.id = '.$zpok_id);
			
	//html_dump($zpok);
	$mat_val = MySQL::fetchAll('SELECT id FROM materials_types ORDER BY id');
	$mat_name = MySQL::fetchAll('SELECT name FROM materials_types ORDER BY id');
	
	$smarty->assign('list',$list);
	$smarty->assign('info',$info);
	$smarty->assign('zpok',$zpok);
	//$smarty->assign('list_brigada',$brigada);
	$smarty->assign('uchastok_id',$uchastok_id);

	//$smarty->assign('stroyka_id',$stroyka_id);
	$smarty->assign('zpok_id',$zpok_id);	

	$smarty->assign('list_type_val',$mat_val);	
	$smarty->assign('list_type_name',$mat_name);	
	
	$smarty->assign('INC_PAGE','stroyka_zak_zpok.tpl');
	
	
}
elseif(preg_match('~^stroyka/view/([0-9]+)/$~ms', $Path, $q)) {
	
	$uchastok_id = intval($q[1]);
	
	$result = MySQL::fetchAllArray('SELECT str.*, dt.name as object, dt.type as object_type,usr.login_name as prorab, uch.name as uchastok, pos.name as poselok FROM stroyka str 
		LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
		LEFT JOIN b2b_users as usr ON usr.id = str.prorab_id 
		LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
		LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
	WHERE str.uchastok_id = '.$uchastok_id.'
	ORDER BY dt.type');
	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list',$result);
	$smarty->assign('uchastok_id',$uchastok_id);

	
	$smarty->assign('INC_PAGE','stroyka_view.tpl');	
	
	
}
elseif(preg_match('~^stroyka/step/([0-9]+)/([0-9]+)/$~ms', $Path, $q)) {
	//добавление этапа к постройке
	$stroyka_id = intval($q[1]);
	$doma_id = intval($q[2]);
	$tab = '';
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST);
		$result = MySQL::query(" 
			INSERT INTO real_doma_steps (stroyka_id, doma_id, step_id, note) 
				VALUES (
					'".$stroyka_id."',
					'".$doma_id."',
					'".$_POST['step_id']."',
					'".$_POST['note']."'
				)
		");
		$step_id = $_POST['step_id'];
		if ($result) {
			//copy all works from step to dom
			$result = MySQL::sql_fetch_array("SELECT count(work_id) cnt FROM step_works WHERE step_id = '{$step_id}'");
			if (!empty($result) and !empty($result['cnt'])) {
					MySQL::query(" 
						INSERT INTO real_doma_step_works (stroyka_id, doma_id, step_id, work_id) 
							SELECT '".$stroyka_id."','".$doma_id."','".$step_id."',work_id FROM step_works WHERE step_id = '{$step_id}'");

			}
			//copy all materials from works to works step dom
			$result = MySQL::sql_fetch_array("SELECT count(dsw.work_id) cnt FROM works_materials wm 
				LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id
				WHERE wm.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}'
			");			
			if (!empty($result) and !empty($result['cnt'])) {
				MySQL::query(" 
					INSERT INTO real_doma_works_materials (stroyka_id, doma_id, step_id, work_id, material_id) 
						SELECT '".$stroyka_id."','".$doma_id."','".$step_id."', dsw.work_id, wm.material_id FROM works_materials wm 
				LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id
				WHERE wm.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}'");

			}
		}
			
		$tab = $_POST['type'];
		
	}	

	
	$list_steps = MySQL::fetchAllArray('SELECT * FROM step ORDER BY type,name');
	//var_dump($list_steps);
	
	$result = MySQL::fetchAllArray("SELECT ds.*, st.name as name, dt.name as doma, st.type as step_type, 
(SELECT sum(wk.price*dsw.v_work)  FROM real_doma_step_works dsw 
			LEFT JOIN works as wk ON wk.id = dsw.work_id
		WHERE dsw.step_id = ds.step_id and dsw.doma_id = ds.doma_id and dsw.stroyka_id = ds.stroyka_id GROUP BY dsw.step_id ) as price_summ,
(SELECT sum(dsw.days) FROM real_doma_step_works dsw 
		WHERE dsw.step_id = ds.step_id and dsw.doma_id = ds.doma_id and dsw.stroyka_id = ds.stroyka_id GROUP BY step_id) as days_summ,
(SELECT sum(dsw.v_work) FROM real_doma_step_works dsw 
		WHERE dsw.step_id = ds.step_id and dsw.doma_id = ds.doma_id and dsw.stroyka_id = ds.stroyka_id GROUP BY step_id) as v_summ,
(SELECT sum(IF(wm.sposob_id=1, ma.price* wm.kol*dsw.v_work,ma.price* wm.kol)) nn FROM real_doma_works_materials wm 
			LEFT JOIN materials as ma ON ma.id = wm.material_id
			LEFT JOIN real_doma_step_works as dsw ON dsw.step_id = wm.step_id and dsw.doma_id = wm.doma_id and  dsw.work_id =wm.work_id and dsw.stroyka_id = wm.stroyka_id
			WHERE wm.step_id = ds.step_id and wm.doma_id = ds.doma_id) as ma_summ
FROM real_doma_steps ds
			LEFT JOIN step as st ON st.id = ds.step_id
			LEFT JOIN doma_types as dt ON dt.id = ds.doma_id
			LEFT JOIN units as un ON un.id = ds.unit_id
		WHERE ds.doma_id = '$doma_id' and ds.stroyka_id = '$stroyka_id'
		ORDER BY ds.sort");	
	//var_dump($result);
	
	$info = MySQL::sql_fetch_array("SELECT dt.name as object, dt.type as object_type, str.uchastok_id, uch.name as uchastok, pos.name as poselok FROM stroyka str
										LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
										LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
										LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
									 WHERE str.doma_types_id = '{$doma_id}' and str.id = '{$stroyka_id}'");

	$list_unit = MySQL::fetchAllArray('SELECT * FROM units ORDER BY id');	
	
	$smarty->assign('cnt_sum',count($result));
	$smarty->assign('list_unit',$list_unit);
	$smarty->assign('stroyka_id',$stroyka_id);
	$smarty->assign('doma_id',$doma_id);
	$smarty->assign('list',$result);
	$smarty->assign('info',$info);
	$smarty->assign('list_steps',$list_steps);
	$smarty->assign('tab',$tab);
	
	$smarty->assign('INC_PAGE','real_doma_steps.tpl');	
	
	
}
elseif(preg_match('~^stroyka/works/([0-9]+)/([0-9]+)/([0-9]+)/$~ms', $Path, $q)) {
	//добавление этапа к постройке
	$stroyka_id = intval($q[1]);
	$step_id = intval($q[2]);
	$doma_id = intval($q[3]);
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST); 
		$result = MySQL::query(" 
			INSERT INTO real_doma_step_works (stroyka_id, doma_id, step_id, work_id, note) 
				VALUES (
					'".$stroyka_id."',
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
					INSERT INTO real_doma_works_materials (stroyka_id, doma_id, step_id, work_id, material_id) 
						SELECT '".$stroyka_id."','".$doma_id."','".$step_id."', dsw.work_id, wm.material_id FROM works_materials wm 
				LEFT JOIN doma_step_works as dsw ON dsw.work_id = wm.work_id
				WHERE wm.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}'");
			}
		}
		
	}	

	$list_works = MySQL::fetchAllArray('SELECT * FROM works ORDER BY name');
	
	$list = MySQL::fetchAllArray("SELECT st.*,wk.name as work,wk.id as work_id, un.name as unit, wk.price, DATE_FORMAT(ADDDATE(NOW(), st.days),'%d.%m.%Y') as dateend,
	(SELECT count(*) FROM real_doma_works_materials rdwm where rdwm.step_id = st.step_id and rdwm.work_id = st.work_id and rdwm.doma_id = st.doma_id and rdwm.stroyka_id = st.stroyka_id) as matkol,
	(SELECT sum(IF(wm.sposob_id=1, ma.price* wm.kol*st.v_work,ma.price* wm.kol)) summ FROM real_doma_works_materials wm 
			LEFT JOIN materials as ma ON ma.id = wm.material_id
			WHERE wm.step_id = st.step_id and wm.doma_id = st.doma_id and wm.work_id = st.work_id and wm.stroyka_id = st.stroyka_id GROUP BY wm.step_id
) as matsumm  
		FROM real_doma_step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN units as un ON un.id = wk.unit_id
		WHERE st.step_id = '{$step_id}' and st.doma_id = '{$doma_id}' and st.stroyka_id = '{$stroyka_id}' ORDER BY st.sort");	

	
	$info = MySQL::sql_fetch_array("SELECT dt.name as object, dt.type as object_type, str.uchastok_id, uch.name as uchastok, pos.name as poselok, st.name as step FROM stroyka str
										LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
										LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
										LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
										LEFT JOIN step as st ON st.id = '{$step_id}' 
									 WHERE str.doma_types_id = '{$doma_id}' and str.id = '{$stroyka_id}'");
		
	

	
	$smarty->assign('cnt_sum',count($result));
	//$smarty->assign('list_unit',$list_unit);
	$smarty->assign('stroyka_id',$stroyka_id);
	$smarty->assign('doma_id',$doma_id);
	$smarty->assign('step_id',$step_id);
	$smarty->assign('list',$list);
	$smarty->assign('info',$info);
	$smarty->assign('list_works',$list_works);
	
	$smarty->assign('INC_PAGE','real_doma_step_works.tpl');	
	
	
}
elseif(preg_match('~^stroyka/materials/([0-9]+)/([0-9]+)/([0-9]+)/([0-9]+)/$~ms', $Path, $q)) {

	$stroyka_id = intval($q[1]);
	$work_id = intval($q[2]);
	$step_id = intval($q[3]);
	$doma_id = intval($q[4]);


		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			//var_dump($_POST);
			MySQL::query(" 
				INSERT INTO real_doma_works_materials (stroyka_id, doma_id, work_id, step_id, material_id) 
					VALUES (
						'".$stroyka_id."',
						'".$doma_id."',
						'".$work_id."',
						'".$step_id."',
						'".$_POST['material_id']."'
					)
			");
			
		}		
		
		
		
	$info = MySQL::sql_fetch_array("SELECT dt.name as object, dt.type as object_type, str.uchastok_id, uch.name as uchastok, pos.name as poselok, st.name as step, wk.name as work FROM stroyka str
										LEFT JOIN doma_types as dt ON dt.id = str.doma_types_id 
										LEFT JOIN uchastok as uch ON uch.id = str.uchastok_id 
										LEFT JOIN mesto as pos ON pos.id = uch.mesto_id 
										LEFT JOIN step as st ON st.id = '{$step_id}' 
										LEFT JOIN works wk ON wk.id = '$work_id}' 
									 WHERE str.doma_types_id = '{$doma_id}' and str.id = '{$stroyka_id}'");

		
	$list = MySQL::fetchAllArray("SELECT wm.*, ma.name, un.name as unit,dsw.v_work,ma.price FROM real_doma_works_materials wm 
		LEFT JOIN materials as ma ON ma.id = wm.material_id
		LEFT JOIN units as un ON un.id = ma.unit_id
		LEFT JOIN real_doma_step_works as dsw ON dsw.work_id = wm.work_id and  dsw.step_id = '{$step_id}' and dsw.doma_id = '{$doma_id}' and dsw.stroyka_id =  '{$stroyka_id}'
		WHERE wm.work_id = '{$work_id}' and wm.step_id = '{$step_id}' and wm.doma_id = '{$doma_id}' and wm.stroyka_id =  '{$stroyka_id}'
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
	$smarty->assign('stroyka_id',$stroyka_id);
	$smarty->assign('doma_id',$doma_id);
		
	$smarty->assign('INC_PAGE','real_works_materials.tpl');		
}
//$smarty->assign('console',$Path);






?>