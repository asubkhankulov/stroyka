<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();

/* Главная страница со списком реальных построек на участках */
if(preg_match('~^zakup/$~ms', $Path, $q)) {

	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST);
		//die;

		//$data_pos = $_POST['zakup'];
		$data_id = $_POST['zpost_uch'];
		$vendors_id = intval($_POST['vendors_id']);
		
		$data_sql = is_array($data_id) ? array_keys($data_id) : array();

		
		//var_dump($data_sql);
		//die;
		
		if (!empty($data_sql)) {
			
				$res = MySQL::query(" 
					INSERT INTO docs_zakup (vendors_id, user_id, start_date) 
						VALUES (
							'{$vendors_id}',
							'".$_SESSION['userid']."',
							NOW()
						)
				");
				
				if ($res) {
					$ins_id = MySQL::sql_insert_id();
					
					//$data = $_POST['zpost'];
					
						//$sql = array();
						$sql = "SELECT {$ins_id},zpost_id,kol,price,id FROM docs_zpok_materials WHERE id IN(".join(',',$data_sql).")";
						/*
						foreach ($data_sql as $temp) {
							$sql[] = "({$ins_id},{$temp})";
						}
						
						$res = MySQL::query(' 
							INSERT INTO docs_zakup_zpok (zakup_id, zpost_id, kol, price, dzml_id) 
								VALUES '.join(',',$sql));
						*/
						$res = MySQL::query(" 
							INSERT INTO docs_zakup_zpok (zakup_id, zpost_id, kol, price, dzml_id)
								{$sql} 
								");
						
						$res = MySQL::query("UPDATE docs_zpok_materials SET zpos_doc_id = {$ins_id} WHERE id IN(".join(',',$data_sql).")");
						
					//html_dump($sql);
			
				}				
				
			}

	}
	
	/*
	$list = MySQL::fetchAllArray('SELECT dzm.*, DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date,
sum(dzm.kol) as all_kol,
usr.login_name as username, mat.name as material, mat.id as mat_id,
dz.id as zpok_id, mat_t.name as mat_type,
uch.name as uch, poselok.name as pos, uch.id as uch_id, poselok.id as pos_id, IFNULL(usrp.login_name,\'не задан прораб\') as prorab,
mat_t.id as mat_type_id,
IFNULL(sum(d_zakup.kol),0) as zakup_kol
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
			LEFT JOIN docs_zakup_zpok as d_zakup ON d_zakup.zpost_id = dz.id and d_zakup.dzml_id = dzm.id
 GROUP BY dz.uchastok_id, mat.id ORDER BY poselok.id,dzm.date_zak');
	*/
	$list = MySQL::fetchAllArray('SELECT dzm.id, 
dzm.kol all_kol,
 mat.name as material, mat.id as mat_id,
dz.id as zpok_id, mat_t.name as mat_type,
uch.name as uch, uch.id as uch_id,
mat_t.id as mat_type_id, un.name as unit, IFNULL(usrp.login_name,\'не задан прораб\') as prorab, pos.name as pos
FROM docs_zpok_materials dzm 
			LEFT JOIN docs_zpok as dz ON dz.id = dzm.zpost_id
			LEFT JOIN real_doma_works_materials as rdwm ON rdwm.id = dzm.rdwm_id
			LEFT JOIN materials as mat ON mat.id = rdwm.material_id
			LEFT JOIN materials_types as mat_t ON mat_t.id = mat.type_id
			LEFT JOIN uchastok as uch ON uch.id = dz.uchastok_id
			LEFT JOIN mesto as pos ON pos.id = uch.mesto_id
			LEFT JOIN stroyka as str ON str.id = rdwm.stroyka_id
			LEFT JOIN b2b_users as usrp ON usrp.id = str.prorab_id
			LEFT JOIN units as un ON un.id = mat.unit_id
			WHERE dzm.zpos_doc_id = 0
ORDER BY mat_id');
	
	$mat_t = array();
	
	if (!empty($list)) {
		$poselki = array();
		$uchastki = array();
		$all_data = array();
		$mat_uch = array();
		$mat_all = array();
		//$id_uch = array();
		foreach ($list as $k=>$data_arr) {
			
			//$poselki[$data_arr['pos']][$data_arr['uch_id']] = array($data_arr['mat_id'],$data_arr['kol']);
			$uchastki[$data_arr['uch_id']] = array('name' =>$data_arr['uch'], 'pos' => $data_arr['pos'], 'mat_id' => $data_arr['mat_id'], 'prorab'=>$data_arr['prorab']);
			$all_data[$data_arr['mat_id']] = array('name' =>$data_arr['material'], 'type' => $data_arr['mat_type'], 'zakup_kol' => $data_arr['zakup_kol'], 'mat_type_id' => $data_arr['mat_type_id']);
			
			$mat_uch[$data_arr['mat_id']][$data_arr['uch_id']][] = array('kol' => $data_arr['all_kol'], 'zpok' => $data_arr['zpok_id'], 'un' => $data_arr['unit'], 'dzm_id' => $data_arr['id']);
			//$id_uch[$data_arr['mat_id']][$data_arr['uch_id']] = intval($data_arr['zpok_id']);
			$mat_all[$data_arr['mat_id']] += intval($data_arr['all_kol']);
			
			$mat_t[$data_arr['mat_type_id']] = $data_arr['mat_type'];
			
			//echo $last_prosr;
			
		}
	}	
			
	//html_dump($mat_uch);
	//html_dump($mat_uch);
	
	/*
	 * Выбираем цену из справочника материалов, если не задана цена в документе
	 * иначе берем из докуента
	 */
	
	$zpost = MySQL::fetchAllArray('SELECT sum(dzz.kol) as kols,dz.id, DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date,
IF(dzz.price>0,sum(dzz.kol*dzz.price),sum(dzz.kol* 0) ) as all_summ,
usr.login_name as username, vs.name as vendor
FROM docs_zakup_zpok dzz 
			LEFT JOIN docs_zakup as dz ON dz.id = dzz.zakup_id
			LEFT JOIN vendors as vs ON vs.id = dz.vendors_id
			LEFT JOIN b2b_users as usr ON usr.id = dz.user_id
			GROUP BY dzz.zakup_id ORDER BY dz.id');

	//$zpost = array();
	
	$ven_val = MySQL::fetchAll('SELECT id FROM vendors ORDER BY id');
	$ven_name = MySQL::fetchAll('SELECT name FROM vendors ORDER BY id');
	
	//$smarty->assign('list',$list);
	
	$smarty->assign('all_data',$all_data);
	$smarty->assign('uchastki',$uchastki);
	$smarty->assign('mat_uch',$mat_uch);
	//$smarty->assign('id_uch',$id_uch);
	$smarty->assign('mat_all',$mat_all);
	//$smarty->assign('list_brigada',$brigada);
	//$smarty->assign('uchastok_id',$uchastok_id);

	//$smarty->assign('mindate',$mindate);
	//$smarty->assign('maxdate',$maxdate);	

	$smarty->assign('list_type_val',array_keys($mat_t));	
	$smarty->assign('list_type_name',array_values($mat_t));	
	
	$smarty->assign('list_ven_val',$ven_val);	
	$smarty->assign('list_ven_name',$ven_name);	
	
	$smarty->assign('zpost',$zpost);
	
	$smarty->assign('INC_PAGE','zakup.tpl');
	
	
}
elseif(preg_match('~^zakup/edit/([0-9]+)/$~ms', $Path, $q)) {
	
	$zpost_id = intval($q[1]);
	
	
	/*
	 * Прилетели данные из формы
	 */
	if (isset($_POST['action'])) {
		//var_dump($_POST);
		
		$material_id = intval($_POST['material_id']);
		$uchastok_id = intval($_POST['uchastok_id']);
		$vendors_id = intval($_POST['vendors_id']); //FIXME получить цену из постащика для материала
		$kol = intval($_POST['kol']);

		$res = MySQL::query(" 
			INSERT INTO docs_zakup_zpok (materials_id, kol, zakup_id, uchastok_id, price) 
				VALUES (
					'{$material_id}',
					'{$kol}',
					'{$zpost_id}',
					'{$uchastok_id}',
					(SELECT price FROM materials where id = '{$material_id}')
				)
		");
		
	}	
	
	

	$zpok = MySQL::fetchAllArray('SELECT dzz.id, dzz.kol,dz.id as zpost_id, zayvka.id as zpok_id, DATE_FORMAT(dz.start_date,"%d.%m.%Y") as doc_date,
DATE_FORMAT(dzml.date_zak,"%d.%m.%Y") as zakupkadate, DATE_FORMAT(zayvka.postup_date,"%d.%m.%Y") as postup_date,
IF(dzz.price>0,dzz.kol*dzz.price,dzz.kol*dzz.price) as all_summ,
IF(dzz.price>0,dzz.price,dzz.price) as doc_price,
usr.login_name as username, vs.id as vendor_id, mat.name as material, mat_t.name as mat_type,
CONCAT(uch.name," / ", pos.name) as sklad, un.name as unit
FROM docs_zakup_zpok dzz 
			LEFT JOIN docs_zakup as dz ON dz.id = dzz.zakup_id
			LEFT JOIN docs_zpok as zayvka ON zayvka.id = dzz.zpost_id
			LEFT JOIN vendors as vs ON vs.id = dz.vendors_id
			LEFT JOIN b2b_users as usr ON usr.id = dz.user_id
			LEFT JOIN docs_zpok_materials as dzml ON dzml.id = dzz.dzml_id
			LEFT JOIN real_doma_works_materials as rdwm ON rdwm.id = dzml.rdwm_id
			LEFT JOIN materials as mat ON mat.id = IFNULL(rdwm.material_id,dzz.materials_id)
			LEFT JOIN materials_types as mat_t ON mat_t.id = mat.type_id
			LEFT JOIN uchastok as uch ON uch.id = IFNULL(zayvka.uchastok_id,dzz.uchastok_id)
			LEFT JOIN mesto as pos ON pos.id = uch.mesto_id
			LEFT JOIN units as un ON un.id = mat.unit_id
			WHERE dz.id = '.$zpost_id);
	
	$list = MySQL::fetchAllArray('SELECT id,name FROM materials ORDER BY id');
	
	$list_sklad = MySQL::fetchAllArray('SELECT uch.id,CONCAT(uch.name," / ", pos.name) as name FROM uchastok as uch 
											LEFT JOIN mesto as pos ON pos.id = uch.mesto_id
										ORDER BY pos.id');
	
	$ven_val = MySQL::fetchAll('SELECT id FROM vendors ORDER BY id');
	$ven_name = MySQL::fetchAll('SELECT name FROM vendors ORDER BY id');
	
	$smarty->assign('zpok',$zpok);
	$smarty->assign('zpost_id',$zpost_id);
	
	$smarty->assign('list_ven_val',$ven_val);	
	$smarty->assign('list_ven_name',$ven_name);		
	
	$smarty->assign('list',$list);		
	$smarty->assign('list_sklad',$list_sklad);		
	
	$smarty->assign('INC_PAGE','zakup_zak_edit.tpl');
	
	
}

//$smarty->assign('console',$Path);






?>