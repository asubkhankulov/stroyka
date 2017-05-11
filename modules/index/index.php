<?
if(empty($_SESSION['login'])) {
	$smarty->display(TPL_URL.'/signin.tpl');
	exit();              
}
global $Path;
$q = array();
if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) { 
	/* Главная страница со списком клиентов */
	if(preg_match('~^index/$~ms', $Path, $q)) {
		
		$result = MySQL::fetchAllArray('SELECT id,comp_name,login_name,login_tel, col_cnt as cnt FROM b2b_users WHERE is_admin = 0 and status = 0 ORDER BY id DESC');
		$users = MySQL::fetchAllArray('SELECT id,login_name,login_tel, DATE_FORMAT(last_login_date,"%d.%m.%Y %H:%i:%s") as last_login_date FROM b2b_users WHERE is_admin = 0 and status = 1 ORDER BY id DESC');
		// с биллингом
		//$result = MySQL::fetchAllArray('SELECT u.id,u.comp_name,u.login_name,u.login_tel, u.col_cnt as cnt, FORMAT(SUM(b.tranzaction),2) bill FROM b2b_users as u,billing as b WHERE is_admin = 0 AND b.user_id = u.id  GROUP BY b.user_id ORDER BY id DESC');
		$admins = MySQL::fetchAllArray('SELECT id,login_name,login_tel, DATE_FORMAT(last_login_date,"%d.%m.%Y %H:%i:%s") as last_login_date FROM b2b_users WHERE is_admin = 1 ORDER BY id DESC');
		//var_dump($result);
		
		$added_client = 0;
		if (isset($_SESSION['added_client'])) {
			$added_client = isset($_SESSION['added_client']) ? $_SESSION['added_client'] : 0;
			unset($_SESSION['added_client']);
		}
	
		$smarty->assign('added_client',$added_client);
		$smarty->assign('list',$result);
		$smarty->assign('admins',$admins);
		$smarty->assign('users',$users);
		$smarty->assign('INC_PAGE','clients.tpl');
	}/* Добавление нового клиента */
	elseif(preg_match('~^index/add/$~ms', $Path, $q)) {
		
		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			//var_dump($_POST);
			MySQL::query(" 
				INSERT INTO b2b_users (login, pass, login_fam, login_otch, login_name, login_mail, login_tel, comp_name, director, director_fio, ustav, ur_address, fact_address, post_address, inn, kpp, okpo, ogrn, bank, bik, rs, ks, comp_tel, comp_mail, comp_url, dogovor, dogovor_date, is_admin, date_added) 
					VALUES (
						'".$_POST['login']."',
						'".md5($_POST['pass'])."',
						'".$_POST['login_fam']."',
						'".$_POST['login_otch']."',
						'".$_POST['login_name']."',
						'".strtolower($_POST['login_mail'])."',
						'".$_POST['login_tel']."',
						'".htmlentities($_POST['comp_name'],ENT_COMPAT,'UTF-8')."',
						'".$_POST['director']."',
						'".$_POST['director_fio']."',
						'".$_POST['ustav']."',
						'".$_POST['ur_address']."',
						'".$_POST['fact_address']."',
						'".$_POST['post_address']."',
						'".$_POST['inn']."',
						'".$_POST['kpp']."',
						'".$_POST['okpo']."',
						'".$_POST['ogrn']."',
						'".$_POST['bank']."',
						'".$_POST['bik']."',
						'".$_POST['rs']."',
						'".$_POST['ks']."',
						'".$_POST['comp_tel']."',
						'".$_POST['comp_mail']."',
						'".$_POST['comp_url']."',
						'".$_POST['dogovor']."',
						'".$_POST['dogovor_date']."',
						'".(isset($_POST['is_admin'])?1:0)."',
						NOW()
					)
			");
			
			$_SESSION['added_client'] = MySQL::sql_insert_id();
			
			/*
			 * добавим запись в биллинг
			 */
			if (!empty($_SESSION['added_client'])) {
			MySQL::query(" 
				INSERT INTO billing (user_id, tranzaction, kogda) 
					VALUES (
						'".$_SESSION['added_client']."',
						'0',
						NOW()
					)
			");	
			}		
			
		
			Header('Location: /'); 
	        exit();
		}
		
		
		
		$smarty->assign('INC_PAGE','add_client.tpl');
	}/* Информация о клиенте */
	elseif(preg_match('~^index/info/([0-9]+)/$~ms', $Path, $q)) {
		
		$user_id = intval($q[1]);
		$result = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");
		
		$smarty->assign('item',$result);
		$smarty->assign('INC_PAGE','client_info.tpl');
	}/* Информация о счетчиках клиента */
	elseif(preg_match('~^index/counters/([0-9]+)/$~ms', $Path, $q)) {
		$user_id = intval($q[1]);
	
		/*
		 * Прилетели данные из формы
		 */
		if (isset($_POST['action'])) {
			//var_dump($_POST);
			MySQL::query(" 
				INSERT INTO counters_clients (user_id, counter_type_id, serial_number, mesto_ustanovki, data_poverki, price, status, data_vypuska, type_izm, fio_otvetsv, tel, email, sim_number) 
					VALUES (
						'".$user_id."',
						'".$_POST['counter_type_id']."',
						'".$_POST['serial_number']."',
						'".$_POST['mesto_ustanovki']."',
						'".$_POST['data_poverki']."',
						'".$_POST['price']."',
						'1',
						'".$_POST['data_vypuska']."',
						'".$_POST['type_izm']."',
						'".$_POST['fio_otvetsv']."',
						'".$_POST['tel']."',
						'".strtolower($_POST['email'])."',
						'".$_POST['sim_number']."'
					)
			");
			
			MySQL::query("UPDATE b2b_users SET col_cnt = (SELECT count(*) FROM counters_clients WHERE user_id = {$user_id}) WHERE id = '{$user_id}'");
	
			$smarty->assign('show_alert',MySQL::sql_insert_id());
			
		}
		
		
		
		
		
		$item = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");
		$list = MySQL::fetchAllArray("SELECT cc.*, ct.name as pribor, DATE_FORMAT(MAX(dct.datadate),'%Y-%m-%d') maxdate  FROM counters_clients cc 
	INNER JOIN counters_type as  ct ON ct.id = cc.counter_type_id
	LEFT JOIN data_cnt as  dct ON dct.D7sn = cc.serial_number
	WHERE user_id = '{$user_id}' GROUP BY cc.serial_number");
		
		$smarty->assign('today',date("Y-m-d",time()));
		$smarty->assign('item',$item);
		$smarty->assign('list',$list);
		$smarty->assign('INC_PAGE','client_counters.tpl');
	}/* Информация по счётчику клиента */
	elseif(preg_match('~^index/counters/([0-9]+)/([0-9]+)/$~ms', $Path, $q)) {
		$user_id = intval($q[1]);
		$pribor_id = intval($q[2]);
	
		
		$item = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");
		$pribor = MySQL::sql_fetch_array("SELECT cc.*, ct.name as pribor, ct.id ctid, DATE_FORMAT(MAX(dct.datadate),'%Y-%m-%d') maxdate, MAX(dct.datadate)mx,MIN(dct.datadate) mn, MAX(D7Vol) vol FROM counters_clients cc 
	INNER JOIN counters_type as  ct ON ct.id = cc.counter_type_id
	LEFT JOIN data_cnt as  dct ON dct.D7sn = cc.serial_number
	WHERE cc.id = '{$pribor_id}' GROUP BY cc.serial_number");
	
	
		$list = MySQL::fetchAllArray('SELECT id,name FROM counters_type ORDER BY name');
		
		$pribor['mn'] = !empty($pribor['mn']) ? substr($pribor['mn'],0,-3) : '';
		
		$smarty->assign('today',date("Y-m-d",time()));
		$smarty->assign('item',$item);
		$smarty->assign('pribor',$pribor);
		$smarty->assign('list',$list);
	
		$smarty->assign('INC_PAGE','client_counters_info.tpl');
	}/* Добавление счетчика клиента */
	elseif(preg_match('~^index/counters/add/([0-9]+)/$~ms', $Path, $q)) {
		
		$user_id = intval($q[1]);
		$item = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");
		$list = MySQL::fetchAllArray('SELECT id,name FROM counters_type ORDER BY name');
		
		$smarty->assign('item',$item);
		$smarty->assign('list',$list);
		$smarty->assign('INC_PAGE','client_counters_add.tpl');
	}/* Информация о клиенте */
	elseif(preg_match('~^index/messages/([0-9]+)/$~ms', $Path, $q)) {
		
		$user_id = intval($q[1]);
		$result = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");
		
		$smarty->assign('item',$result);
		$smarty->assign('INC_PAGE','client_info.tpl');
	}/* Информация о клиенте */
	elseif(preg_match('~^index/docs/([0-9]+)/$~ms', $Path, $q)) {
		
		$user_id = intval($q[1]);
		$result = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");
		$dates = MySQL::sql_fetch_array("SELECT DATE_FORMAT(MAX(inv_date),'%Y-%m-%d') maxdate, DATE_FORMAT(MIN(inv_date),'%Y-%m-%d') mindate FROM docs WHERE user_id = '{$user_id}' ORDER BY inv_date DESC");
		$items2 = MySQL::sql_fetch_array("SELECT DATE_FORMAT(MAX(inv_date),'%Y-%m-%d') maxdate, DATE_FORMAT(MIN(inv_date),'%Y-%m-%d') mindate FROM docs_upd WHERE user_id = '{$user_id}'");		
		
		$smarty->assign('docs',$dates);	
		$smarty->assign('docs2',$items2);	

		$smarty->assign('item',$result);

		$smarty->assign('INC_PAGE','client_info_docs.tpl');
	}/* Информация о клиенте - лицевой счёт */
	elseif(preg_match('~^index/balance/([0-9]+)/$~ms', $Path, $q)) {
		
		$user_id = intval($q[1]);
		$result = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");

		$item = MySQL::sql_fetch_array("SELECT FORMAT(SUM(price),2) itogo, SUM(price) s FROM counters_clients WHERE user_id = '{$user_id}'");
		$balans = MySQL::sql_fetch_array("SELECT FORMAT(SUM(tranzaction),2) itogo FROM billing WHERE user_id = '{$user_id}'");
		
		$dates = MySQL::sql_fetch_array("SELECT DATE_FORMAT(MAX(kogda),'%Y-%m-%d') maxdate, DATE_FORMAT(MIN(kogda),'%Y-%m-%d') mindate FROM billing WHERE user_id = '{$user_id}'");
		
		$smarty->assign('item',$result);
		$smarty->assign('pribor',$item);
		$smarty->assign('balans',$balans);	
		$smarty->assign('docs',$dates);		
		
		$smarty->assign('INC_PAGE','client_info_balance.tpl');
	}

}
else { //На стороне клиента
	
	/* Главная страница со списком счётчиков */
	if(preg_match('~^index/$~ms', $Path, $q)) {
		
	$list = MySQL::fetchAllArray("SELECT cc.*, ct.name as pribor, ct.id ctid, DATE_FORMAT(MAX(dct.datadate),'%Y-%m-%d') maxdate, FORMAT(MAX(dct.D7Vol),3) mx, 
	DATEDIFF(DATE_ADD(cc.data_poverki,INTERVAL 2 YEAR),NOW()) as days_to_poverka, DATE_FORMAT(DATE_ADD(cc.data_poverki,INTERVAL 2 YEAR),'%d.%m.%Y') as next_poverka 
	FROM counters_clients cc 
INNER JOIN counters_type as  ct ON ct.id = cc.counter_type_id
LEFT JOIN data_cnt as  dct ON dct.D7sn = cc.serial_number
WHERE cc.user_id = '".$_SESSION['userid']."'
GROUP BY cc.serial_number");
	
//	foreach ($list as $key => $val) {
//		$list[$key]['mx'] = number_format($val['mx'], 3, '.', ' ');
//	}
	

	$smarty->assign('next_poverka',$result['next_poverka']);


	$smarty->assign('today',date("Y-m-d",time()));
	$smarty->assign('list',$list);
	

	$smarty->assign('INC_PAGE','client_counters.tpl');
	
	}
/* Информация о счетчиках клиента */
	elseif(preg_match('~^index/counters/([0-9]+)/$~ms', $Path, $q)) {
		$user_id = $_SESSION['userid'];
		$cnt_id = intval($q[1]);
	
		
		$item = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");
		$pribor = MySQL::sql_fetch_array("SELECT cc.*, ct.name as pribor, DATE_FORMAT(MAX(dct.datadate),'%Y-%m-%d') maxdate, MAX(D7Vol) vol  FROM counters_clients cc 
	INNER JOIN counters_type as  ct ON ct.id = cc.counter_type_id
	LEFT JOIN data_cnt as  dct ON dct.D7sn = cc.serial_number
	WHERE user_id = '{$user_id}' and cc.id = {$cnt_id} GROUP BY cc.serial_number");

		//if (chdir(getcwd() . '\umaster2\server\php\files')) {
		if (chdir(getcwd() . '/umaster2/server/php/files')) {
			$files = glob("f_".md5($user_id)."_*.*");
		}
		
		$pribor['vol'] = number_format($pribor['vol'], 3, '.', ' ');
	
	
		$smarty->assign('today',date("Y-m-d",time()));
		$smarty->assign('item',$item);
		$smarty->assign('files',$files);
		$smarty->assign('pribor',$pribor);
		$smarty->assign('cnt_id',$cnt_id);
		$smarty->assign('INC_PAGE','client_counters_info.tpl');
	}/* Информация по счётчику клиента */
	elseif(preg_match('~^index/info/([0-9]+)/$~ms', $Path, $q)) {
		$user_id = $_SESSION['userid'];
		$cnt_id = intval($q[1]);
	
		
		$item = MySQL::sql_fetch_array("SELECT * FROM b2b_users WHERE id = '{$user_id}'");
		$pribor = MySQL::sql_fetch_array("SELECT cc.*, ct.name as pribor, ct.id ctid, DATE_FORMAT(MAX(dct.datadate),'%Y-%m-%d') maxdate, MAX(dct.datadate) mx,MIN(dct.datadate) mn, MAX(D7Vol) vol FROM counters_clients cc 
	INNER JOIN counters_type as  ct ON ct.id = cc.counter_type_id
	LEFT JOIN data_cnt as  dct ON dct.D7sn = cc.serial_number
	WHERE cc.user_id = '{$user_id}' AND cc.id = '{$cnt_id}' GROUP BY cc.serial_number");
	
		$pribor['mn'] = substr($pribor['mn'],0,-3);
		$pribor['vol'] = number_format($pribor['vol'], 3, '.', ' ');
		
		$smarty->assign('today',date("Y-m-d",time()));
		$smarty->assign('item',$item);
		$smarty->assign('pribor',$pribor);
		$smarty->assign('cnt_id',$cnt_id);
	
		$smarty->assign('INC_PAGE','client_counters_grafik.tpl');
	}	
}

//$smarty->assign('console',$Path);






?>