<?php 
    session_start();
    Header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); //Дата в прошлом
    Header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
    Header("Pragma: no-cache"); // HTTP/1.1
    Header("Last-Modified: ".gmdate("D, d M Y H:i:s")."GMT");


    require_once('../_init.php');
    

	if($_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest' or $_REQUEST['action'] == 'getchart')
    {
        if(!empty($_REQUEST['action'])) {  
            $action = htmlspecialchars(trim($_REQUEST['action']));  
            switch ($action) {
                case 'login':
                	
        			$login = strtolower(htmls($_POST['email']));
        			$password = md5(htmls($_POST['pass']));
        			
        			$result = MySQL::sql_fetch_array('SELECT * FROM b2b_users WHERE login_mail = "'.$login.'" and pass = "'.$password.'" LIMIT 1');
        			//html_dump($result);
        			
        			if (!empty($result)) {
        				
        				$_SESSION['userid'] = $result['id'];
        				$_SESSION['login'] = $result['login'];
        				$_SESSION['is_admin'] = $result['is_admin'];
        				MySQL::query('UPDATE b2b_users SET last_login_date = NOW(), last_recovery = "2000-01-01 00:00:00", recovery_hash = "" WHERE id = "'.$result['id'].'" LIMIT 1');
        				
        				
        				echo 'ok';
        			}
        			else echo 'error';
                	
                    
                break;
                case 'del_uimg':
                	
        			$id = $_POST['id'];
        			$uid = 'userphoto_'.md5($_SESSION['userid']);
        			
        			if (strpos($id,$uid)) {
        				
						if (is_file(SITE_DIR.'/umaster/server/php/files/'.$uid.'.jpeg')) {
					          $result = unlink(SITE_DIR.'/umaster/server/php/files/'.$uid.'.jpeg');
					    }
					    elseif (is_file(SITE_DIR.'/umaster/server/php/files/'.$uid.'.jpg')) {
					          $result = unlink(SITE_DIR.'/umaster/server/php/files/'.$uid.'.jpg');
					    }
					    elseif (is_file(SITE_DIR.'/umaster/server/php/files/'.$uid.'.png')) {
					          $result = unlink(SITE_DIR.'/umaster/server/php/files/'.$uid.'.png');
					    }
					    elseif (is_file(SITE_DIR.'/umaster/server/php/files/'.$uid.'.gif')) {
					          $result = unlink(SITE_DIR.'/umaster/server/php/files/'.$uid.'.gif');
					    }
					    else $result = false;
        				
        			} else $result = false;
        			
        			
        			if ($result) {
        				echo 'ok';
        			}
        			else echo 'error';
                	
                    
                break;
                case 'del_oimg':
                	
        			$img = trim(basename($_POST['img']));
        			
        			
					if (!empty($img) && is_file(SITE_DIR.'/umaster2/server/php/files/'.$img)) {
				          $result = unlink(SITE_DIR.'/umaster2/server/php/files/'.$img);
				    }
				    else $result = false;
        			
        			
        			if ($result) {
        				echo 'ok';
        			}
        			else echo 'error';
                	
                    
                break;
                case 'recovery':
                	
        			$email = strtolower(htmls($_POST['email']));
        			
        			$result = MySQL::sql_fetch_array('SELECT id,TIMESTAMPDIFF(MINUTE,last_recovery,NOW()) as last_rec FROM b2b_users WHERE login_mail = "'.$email.'"  LIMIT 1');
        			//html_dump($result);
        			
        			if (!empty($result)) {
        				
        				
        				if (intval($result['last_rec']) < 10) {
        					echo 'с момента последнего запроса прошло менее 10 минут!';
        				}
        				else
        				{
        					$hash = md5($result['last_rec'].time().$result['id']);
        					MySQL::query('UPDATE b2b_users SET recovery_hash = "'.$hash.'", last_recovery = NOW() WHERE id = "'.$result['id'].'" LIMIT 1');
        					
							require_once($_SERVER['DOCUMENT_ROOT'].'/lib/class.FreakMailer.php');  
							$mailer = new FreakMailer(); 
							
							// Устанавливаем тему письма
							$mailer->Subject = 'Восстановление пароля в системе ОДИС24';
							$mailer->CharSet = 'UTF-8';
							
							$mailer->Body = nl2br("Здравствуйте!\n Ссылка для восстановления пароля: ".SITE_HTTP."?recovery=".$hash."\n\nЕсли Вы этого не делали, проигнорируйте это письмо.\n\nС уважением,Администрация\nОДИС24");
							$mailer->isHTML(true);						
							$mailer->AddAddress($email);
							$mailer->Send();
							$mailer->ClearAddresses();
        					
        					echo 'ok';
        					
        				}

        				
        				
        				
        			}
        			else echo 'Не найден адрес почты!';
                	
                    
                break;
                case 'getchart':
                	
        			$id = $_REQUEST['serial'];
        			$mindate = $_REQUEST['mindate'].':00';
        			$maxdate = $_REQUEST['maxdate'].':59';
        			// 1 = почасовой, 2 = посуточный
        			if ($_REQUEST['typedate'] == '1') {
        				$typedate = '%Y-%m-%d %H:00:00';
        				
        				$errors = MySQL::fetchAllArray("SELECT DATE_FORMAT(D7OffDateTime,'%Y-%m-%d %H:00:00') data, IF(((UNIX_TIMESTAMP(CONCAT(D7Date,' ',D7Time,':00'))-UNIX_TIMESTAMP(D7OffDateTime))/60)>60,(UNIX_TIMESTAMP(DATE_FORMAT(D7OffDateTime,'%Y-%m-%d %H:00:00') + INTERVAL 1 HOUR)-UNIX_TIMESTAMP(D7OffDateTime))/60,(UNIX_TIMESTAMP(CONCAT(D7Date,' ',D7Time,':00'))-UNIX_TIMESTAMP(D7OffDateTime))/60) as pros,
D7OffDateTime,
CONCAT(D7Date,' ',D7Time,':00'),
DATE_FORMAT(D7OffDateTime,'%Y-%m-%d %H:00:00') + INTERVAL 1 HOUR as next,
(UNIX_TIMESTAMP(DATE_FORMAT(D7OffDateTime,'%Y-%m-%d %H:00:00') + INTERVAL 1 HOUR)-UNIX_TIMESTAMP(D7OffDateTime))/60 FROM data_cnt WHERE D7sn = '{$id}' and (D7OffDateTime BETWEEN '{$mindate}' AND '{$maxdate}') and RType = '16' HAVING pros >=0");
        				
        				
        			}
        			else {
        				//$typedate = '%Y-%m-%d';
        				$typedate = '%Y-%m-%d %H:00:00';
        				$mindate = substr($mindate,0,10).' 00:00:00';
        				$maxdate = substr($maxdate,0,10).' 23:59:59';
        				
						$errors = MySQL::fetchAllArray("SELECT DATE_FORMAT(D7OffDateTime,'%Y-%m-%d') data, 
			SUM(IF(((UNIX_TIMESTAMP(CONCAT(D7Date,' ',D7Time,':00'))-UNIX_TIMESTAMP(D7OffDateTime))/60)>60,(UNIX_TIMESTAMP(DATE_FORMAT(D7OffDateTime,'%Y-%m-%d %H:00:00') + INTERVAL 1 HOUR)-UNIX_TIMESTAMP(D7OffDateTime))/60,(UNIX_TIMESTAMP(CONCAT(D7Date,' ',D7Time,':00'))-UNIX_TIMESTAMP(D7OffDateTime))/60))/60 as pros,
			D7OffDateTime,
			CONCAT(D7Date,' ',D7Time,':00') switch_ON,
			DATE_FORMAT(D7OffDateTime,'%Y-%m-%d %H:00:00') + INTERVAL 1 HOUR as next,
			(UNIX_TIMESTAMP(DATE_FORMAT(D7OffDateTime,'%Y-%m-%d %H:00:00') + INTERVAL 1 HOUR)-UNIX_TIMESTAMP(D7OffDateTime))/60 min_to_end_hour 
			FROM data_cnt WHERE D7sn = '{$id}' and (D7OffDateTime BETWEEN '{$mindate}' AND '{$maxdate}')and RType = '16' GROUP BY data HAVING pros >=0");
        				
        				
        				
        			}
        			
        			$times = MySQL::sql_fetch_array("SELECT TIMESTAMPDIFF(HOUR,'{$mindate}','{$maxdate}') as hours");
        			//$result = MySQL::fetchAllArray('SELECT datadate, D7Vol as vol FROM data_cnt WHERE D7sn = "'.$id.'"');
        			//$result = MySQL::fetchAllArray("SELECT DATE_FORMAT(datadate,'%Y-%m-%d %H:%i') data, D7Vol as vol FROM data_cnt WHERE D7sn = '{$id}' GROUP BY data");
        			//$result = MySQL::fetchAllArray("SELECT DISTINCT DATE_FORMAT(datadate,'%Y-%m-%d %H') data,  (MAX(D7Vol)-MIN(D7Vol)) as vol FROM data_cnt WHERE D7sn = '{$id}' and (datadate BETWEEN '{$mindate}' AND '{$maxdate}') and RType <> '16' GROUP BY data");
        			//по дате времени с прибора
        			$result = MySQL::fetchAllArray("SELECT DISTINCT DATE_FORMAT(CONCAT(D7Date,' ',D7Time,':00'),'{$typedate}') data,  (MAX(D7Vol)-MIN(D7Vol)) as vol FROM data_cnt WHERE D7sn = '{$id}' and (datadate BETWEEN '{$mindate}' AND '{$maxdate}') and RType <> '16' GROUP BY data");
        			//$result = MySQL::fetchAllArray("SELECT DISTINCT DATE_FORMAT(CONCAT(D7Date,' ',D7Time,':00'),'{$typedate}') data,  (MAX(D7Vol)-MIN(D7Vol)) as vol FROM data_cnt WHERE D7sn = '{$id}'and RType <> '16' GROUP BY data HAVING (data BETWEEN '{$mindate}' AND '{$maxdate}')");
        			//var_dump("SELECT DISTINCT DATE_FORMAT(CONCAT(D7Date,' ',D7Time,':00'),'%Y-%m-%d %H') data,  (MAX(D7Vol)-MIN(D7Vol)) as vol FROM data_cnt WHERE D7sn = '{$id}' and (datadate BETWEEN '{$mindate}' AND '{$maxdate}') and RType <> '16' GROUP BY data");
        			//html_dump($result);
        			
        			if ($_REQUEST['typedate'] == '1') {
        				
						$days = array();
						$first_day = substr($_REQUEST['mindate'],0,13).':00:00';
						for ($i=0; $i<=$times['hours']; $i++) {
							$days[] = "TIMESTAMPADD(HOUR,{$i},'{$first_day}') '{$i}'";
						}
						
						$times = MySQL::sql_fetch_array("SELECT ".join(',',$days)); 

						//var_dump($result);
        				
        				
						$koef = 60;
						$summ = 0;
			        	foreach ($times as $id=>$date) {
							foreach ($result as $tmp=>$data) {
								if ($data['data'] == $date) {
									$times[$id] = $data;
									break;
								}
							}
							if ($errors) {
								foreach ($errors as $tmp=>$data) {
									$data['pros'] = round(floatval($data['pros']),2);
									$data['pros'] = $data['pros'] > $koef ? $koef :  $data['pros'];
									if ($data['data'] == $date) {
										if (isset($times[$id]['pros'])) {
											$times[$id]['pros'] = round(intval($times[$id]['pros'])) + $data['pros'];
										} 
										else {
											$times[$id]['pros'] = $data['pros'];
										}
										unset($errors[$tmp]);
										//break;
									}
								}				
							}
							
							if (!is_array($times[$id])) {
								$tmps = $date;
								$times[$id] = array();
								$times[$id]['vol'] = 0;
								$times[$id]['data'] = $tmps;
								$times[$id]['dont_work'] = $koef;
								$times[$id]['work'] = 0;
								
							}
							else {
								$times[$id]['dont_work'] = round($times[$id]['pros'],2);
								$times[$id]['work'] = $koef - round($times[$id]['pros'],2);

							}
							$times[$id]['ni'] = ($id <> 0) ? $summ + $times[$id]['vol'] : 0;
							$times[$id]['data'] = $times[$id]['data'];
							$times[$id]['data_rus'] = return_rus_date_time($times[$id]['data']);
							$summ +=  $times[$id]['vol'];
							if (empty($times[$id]['vol'])) unset($times[$id]['vol']);
							
							
						}
						
						$result = $times;
			
						
						/*
						$summ = $ni = 0;
							foreach ($result as $tmp=>$data_result) {
								if ($errors) {
									foreach ($errors as $tmp2=>$data_errors) {
										if ($data_result['data'] == $data_errors['data']) {
											$data_errors['pros'] = round(floatval($data_errors['pros']),2);
											$data_errors['pros'] = $data_errors['pros'] > $koef ? $koef :  $data_errors['pros'];
											if (isset($result[$tmp]['pros'])) {
												$result[$tmp]['pros'] = round(intval($result[$tmp]['pros'])) + $data_errors['pros'];
											} 
											else {
												$result[$tmp]['pros'] = $data_errors['pros'];
											}
											unset($errors[$tmp2]);
										}
									}				
								}
								
								$result[$tmp]['in_work'] = $koef - round($result[$tmp]['pros'],2);
								$result[$tmp]['dont_work'] = round($result[$tmp]['pros'],2);
								if ($tmp <> 0) $ni =  $summ + $data_result['vol'];
								$summ +=  $data_result['vol'];
								
								
								
							}
*/
        				
        			}
        			else {
						$days = array();
						$first_day = substr($_REQUEST['mindate'],0,10).' 00:00:00';
						for ($i=0; $i<=$times['hours']; $i++) {
							$days[] = "TIMESTAMPADD(HOUR,{$i},'{$first_day}') '{$i}'";
						}			
			
						
						$times = MySQL::sql_fetch_array("SELECT ".join(',',$days));

						$koef = 24;
						
						$times_day = array();
						//var_dump($times);
			
						foreach ($times as $id=>$date) {
							$real_day = substr($date,0,10);
							$times_day[$real_day] = array();
							foreach ($result as $tmp=>$data) {
								if ($data['data'] == $date) {
									$times[$id] = $data;
									break;
								}
							}
							if ($errors) {
								foreach ($errors as $tmp=>$data) {
									if ($data['data'] == $real_day) {
										$times_day[$real_day]['pros'] = round(floatval($data['pros']),2);
									}
								}				
							}
						}
												//var_dump($result);
												//var_dump($times);
						
						//$times = $times_day;			
						
						$tbl = '';
						$summ = $ni = $in_work_s = $dont_work_s = 0;
						foreach ($times as $tmp=>$data) {
							//var_dump($data);
							if ($last_rd != $real_day)
							if (!is_array($data)) {
								$tmps = $data;
								$data = array();
								$data['vol'] = 0;
								$data['data'] = $tmps;
								$data['pros'] = 1;
								$dont_work = 1;
								
								
							}
							else {
								$dont_work = 0;
							}
							$real_day = substr($data['data'],0,10);
							
							$times_day[$real_day]['vol'] = isset($times_day[$real_day]['vol']) ? $times_day[$real_day]['vol'] + $data['vol'] : $data['vol'];
							$times_day[$real_day]['data'] = $real_day;
							$times_day[$real_day]['data_rus'] = return_rus_date($real_day);
							$times_day[$real_day]['pros'] = isset($times_day[$real_day]['pros']) ? $times_day[$real_day]['pros'] + $dont_work : $dont_work;
			
			
						}	
						$i = 0;	
						//var_dump($times_day);
						$result = array();	
						foreach ($times_day as $tmp=>$data) {
							$data['ni'] =  ($i <> 0) ? $summ + $data['vol'] : 0;
							//$result[] = $data;
							$data['work'] = $koef-$data['pros'];
							$data['dont_work'] = $data['pros'];
							$summ +=  $data['vol'];
							if (empty($data['vol'])) unset($data['vol']);
							$result[] = $data; 
							$i++;
						}			
										        				
        			}
        			
        			
        			if (!empty($result)) {
        				
        				echo json_encode($result);
        			}
        			else echo json_encode($result = array());
                	
                    
                break;
                case 'getchart_errors':
                	
        			$id = $_REQUEST['serial'];
        			$mindate = $_REQUEST['mindate'].':00';
        			$maxdate = $_REQUEST['maxdate'].':59';
        			
        			//$result = MySQL::fetchAllArray('SELECT datadate, D7Vol as vol FROM data_cnt WHERE D7sn = "'.$id.'"');
        			//$result = MySQL::fetchAllArray("SELECT DATE_FORMAT(datadate,'%Y-%m-%d %H:%i') data, D7Vol as vol FROM data_cnt WHERE D7sn = '{$id}' GROUP BY data");
        			//$result = MySQL::fetchAllArray("SELECT DATE_FORMAT(datadate,'%d%.%m.%Y %H:%i:%s') data,  D7NSType, D7OffDateTime, D7OffCause FROM data_cnt WHERE D7sn = '{$id}' and (datadate BETWEEN '{$mindate}' AND '{$maxdate}') and RType = '16'");
        			//$result = MySQL::fetchAllArray("SELECT DATE_FORMAT(CONCAT(D7Date,' ',D7Time,':00'),'%d%.%m.%Y %H:%i:%s') data,  D7NSType, D7OffDateTime, D7OffCause, IFNULL(FORMAT((UNIX_TIMESTAMP(CONCAT(D7Date,' ',D7Time,':00'))-UNIX_TIMESTAMP(D7OffDateTime))/60,0),0) as pros FROM data_cnt WHERE D7sn = '{$id}' and (datadate BETWEEN '{$mindate}' AND '{$maxdate}') and RType = '16' HAVING pros >=0");
        			$result = MySQL::fetchAllArray("SELECT DATE_FORMAT(D7OffDateTime,'%d%.%m.%Y %H:%i:%s') data,  D7NSType, D7OffCause, IFNULL(SEC_TO_TIME((UNIX_TIMESTAMP(CONCAT(D7Date,' ',D7Time,':00'))-UNIX_TIMESTAMP(D7OffDateTime))),0) as pros FROM data_cnt WHERE D7sn = '{$id}' and (D7OffDateTime BETWEEN '{$mindate}' AND '{$maxdate}') and RType = '16' and D7OffDateTime <> '0000-00-00 00:00:00' HAVING pros >=0");
        			//var_dump("SELECT DATE_FORMAT(D7OffDateTime,'%d%.%m.%Y %H:%i:%s') data,  D7NSType, D7OffCause, IFNULL(SEC_TO_TIME((UNIX_TIMESTAMP(CONCAT(D7Date,' ',D7Time,':00'))-UNIX_TIMESTAMP(D7OffDateTime))),0) as pros FROM data_cnt WHERE D7sn = '{$id}' and (D7OffDateTime BETWEEN '{$mindate}' AND '{$maxdate}') and RType = '16' and D7OffDateTime <> '0000-00-00 00:00:00' HAVING pros >=0");
        			
        			
        			if (!empty($result)) {
        				/*
        				 * получим итог в формате HH:MM:DD
        				 */
        				$result2 = MySQL::fetchAllArray("SELECT SEC_TO_TIME(SUM(IFNULL((UNIX_TIMESTAMP(CONCAT(D7Date,' ',D7Time,':00'))-UNIX_TIMESTAMP(D7OffDateTime)),0))) as pros_all FROM data_cnt WHERE D7sn = '{$id}' and (D7OffDateTime BETWEEN '{$mindate}' AND '{$maxdate}') and RType = '16' and D7OffDateTime <> '0000-00-00 00:00:00'");
        				$result[] = $result2[0];
        				echo json_encode($result);
        			}
        			else echo json_encode($result = array());
                	
                    
                break;
              	case 'del_client':
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM b2b_users WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
              	case 'copy_doma':
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
						//копируем в doma_types c именем + копия
        				$result = MySQL::query("INSERT INTO doma_types (name, type) SELECT CONCAT(name,' *******КОПИЯ!******'), type FROM doma_types WHERE id = '{$id}'");

        				if ($result) {
							$new_id = MySQL::sql_insert_id();

							$result = MySQL::query("INSERT INTO doma_steps (doma_id, step_id, sort, v_step, status, type, note) 
																	 SELECT '".$new_id."', step_id, sort, v_step, status, type, note FROM doma_steps WHERE doma_id = '{$id}'");
        				       					
							if ($result) {
								$result = MySQL::query(" 
								INSERT INTO doma_step_works (doma_id, step_id, work_id, v_work, days, shift1, status, sort, note) 
									SELECT '".$new_id."',step_id, work_id, v_work, days, shift1, status, sort, note FROM doma_step_works WHERE doma_id = '{$id}'");
								
								if ($result) {
									$result = MySQL::query(" 
									INSERT INTO doma_works_materials (doma_id, step_id, work_id, material_id, sposob_id, norma, plan, kol, note) 
										SELECT '".$new_id."', step_id, work_id, material_id, sposob_id, norma, plan, kol, note FROM doma_works_materials WHERE doma_id = '{$id}'");
									
								}
								
							}
        				
        				
        					echo 'ok';
        				}
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_material': //УДАЛИТЬ МАТЕРИАЛ
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM materials WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_docs': //docs
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM docs WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_unit': //УДАЛИТЬ МАТЕРИАЛ
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM units WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_mat_type': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM materials_types WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_step': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM step WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_prorabs': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM prorabs WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_dom_type': //doma/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				if (MySQL::query('DELETE FROM doma_types WHERE id = "'.$id.'" LIMIT 1')) {
        				 	MySQL::query('DELETE FROM doma_steps WHERE doma_id = "'.$id.'"');
        				 	MySQL::query('DELETE FROM doma_step_works WHERE doma_id = "'.$id.'"');
        				 	MySQL::query('DELETE FROM doma_works_materials WHERE doma_id = "'.$id.'"');
        				}
        				 	
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_mesto': //mesto/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM mesto WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_work': //mesto/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM works WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_step_work': //mesto/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM step_works WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_doma_work': //doma/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM doma_step_works WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_real_doma_work': //doma/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM real_doma_step_works WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_doma_material_work': //doma/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM doma_works_materials WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_real_doma_material_work': //stroyka/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM real_doma_works_materials WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_vendor': //mesto/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM vendors WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_os': //os/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM osnovnye_sredstva WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_zpok': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM docs_zpok_materials WHERE zpost_id = "'.$id.'"');
        				MySQL::query('DELETE FROM docs_zpok WHERE id = "'.$id.'"');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_zpost': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM docs_zakup_zpok WHERE zakup_id = "'.$id.'"');
        				MySQL::query('DELETE FROM docs_zakup WHERE id = "'.$id.'"');
        				MySQL::query("UPDATE docs_zpok_materials SET zpos_doc_id = 0 WHERE zpos_doc_id = {$id}");
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_from_zpok': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM docs_zpok_materials WHERE id = "'.$id.'"');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_from_zpost': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				/*
        				 * если materials_id = 0 значит надо проапдейтить таблицу docs_zpok_materials (материал с заявкой)
        				 * иначе - материал добавлен без заявки
        				 */
        				$data = MySQL::sql_fetch_assoc('SELECT dzml_id,materials_id FROM docs_zakup_zpok WHERE id = "'.$id.'"');
        				$res = MySQL::query('DELETE FROM docs_zakup_zpok WHERE id = "'.$id.'"');
        				if (is_array($data) and empty($data['materials_id'])) MySQL::query("UPDATE docs_zpok_materials SET zpos_doc_id = 0 WHERE id = " . $data['dzml_id']);
	       				echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'update_zpok': 
                	
        			$id = intval($_POST['id']);
	        		$val1 = floatval(str_replace(',','.',$_POST['price']));
					$val1 = round($val1,2);

					$val2 = floatval(str_replace(',','.',$_POST['kol']));
					$val2 = round($val2,2);
        			
        			if(MySQL::query("UPDATE docs_zpok_materials SET price = '{$val1}', kol = '{$val2}' WHERE id = '{$id}'")) {
       					echo 'ok';
        			}
        			else {
        				echo 'Ошибка!';
        			}
                	
                    
                break;
                case 'del_auto': //mesto/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM autos WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_uch': //mesto/
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM uchastok WHERE id = "'.$id.'" LIMIT 1');
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав на удаление';
        			}
                	
                    
                break;
                case 'del_work': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM step_works WHERE id = "'.$id.'" LIMIT 1');

       					echo 'ok';
        			}
        			else {
        				echo 'Error';
        			}
                	
                    
                break;
                case 'del_mat_work': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM works_materials WHERE id = "'.$id.'" LIMIT 1');

       					echo 'ok';
        			}
        			else {
        				echo 'Error';
        			}
                	
                    
                break;
                case 'del_brigada': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM brigada WHERE id = "'.$id.'" LIMIT 1');

       					echo 'ok';
        			}
        			else {
        				echo 'Error';
        			}
                	
                    
                break;
                case 'del_uslugi': 
                	
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query('DELETE FROM uslugi WHERE id = "'.$id.'" LIMIT 1');

       					echo 'ok';
        			}
        			else {
        				echo 'Error';
        			}
                	                    
                break;
                case 'add_material': //Добавить/обновить materials
                	
        			$name = htmls($_POST['name']);
        			$type = htmls($_POST['type']);
        			$unit = htmls($_POST['unit']);
        			$price = floatval(htmls($_POST['price']));
        			$price = round($price,2);
					$m = floatval(htmls($_POST['m']));
					$m = round($m,2);
					$v = floatval(htmls($_POST['v']));
					$v = round($v,2);        			
        			//$price = number_format($price, 2, ',', '');
        			$note = htmls($_POST['note']);
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				if (empty($id)) MySQL::query("INSERT INTO materials (name,type_id,unit_id,price,v,m,note) VALUES ('{$name}','{$type}','{$unit}','{$price}','{$v}','{$m}','{$note}')");
        				else MySQL::query("UPDATE materials SET name = '{$name}',type = '{$type}',unit = '{$unit}',price = '{$price}',note = '{$note}', v='{$v}',m='{$m}' WHERE id = '{$id}'");
       					echo 'ok';
       					//echo $price;
        			}
        			else {
        				echo 'Нет прав';
        			}
                	
                    
                break;
                case 'update_material': //Добавить/обновить materials
                	
        			$price = floatval(htmls($_POST['price']));
        			$price = round($price,2);
					$m = floatval(htmls($_POST['m']));
					$m = round($m,2);
					$v = floatval(htmls($_POST['v']));
					$v = round($v,2);        			
        			$days = htmls($_POST['days']);
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query("UPDATE materials SET price = '{$price}',note = '{$note}', v='{$v}',m='{$m}', days='{$days}' WHERE id = '{$id}'");
       					echo 'ok';
       					//echo $price;
        			}
        			else {
        				echo 'Нет прав';
        			}
                	
                    
                break;
                case 'update_mesto': 
                	
        			$days = htmls($_POST['days']);
        			$name = htmls($_POST['name']);
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query("UPDATE mesto SET name = '{$name}', days='{$days}' WHERE id = '{$id}'");
       					echo 'ok';
       					//echo $price;
        			}
        			else {
        				echo 'Нет прав';
        			}
                	
                    
                break;
                case 'add_unit': //
                	
        			$name = htmls($_POST['name']);
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				if (empty($id)) MySQL::query("INSERT INTO units (name) VALUES ('{$name}')");
        				else MySQL::query("UPDATE units SET name = '{$name}' WHERE id = '{$id}'");
       					echo 'ok';
       					//echo $price;
        			}
        			else {
        				echo 'Нет прав';
        			}
                	
                    
                break;
                case 'add_mat_type': //
                	
        			$name = htmls($_POST['name']);
        			$id = intval($_POST['id']);
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				if (empty($id)) MySQL::query("INSERT INTO materials_types (name) VALUES ('{$name}')");
        				else MySQL::query("UPDATE materials_types SET name = '{$name}' WHERE id = '{$id}'");
       					echo 'ok';
       					//echo $price;
        			}
        			else {
        				echo 'Нет прав';
        			}
                	
                    
                break;
                case 'add_dom_type': //doma/
                	
                    $name = htmls($_POST['name']);
        			$type = htmls($_POST['type']);
        			$unit = htmls($_POST['unit']);
        			$price = floatval(htmls($_POST['price']));
        			$price = round($price,2);
        			//$price = number_format($price, 2, ',', '');
        			$note = htmls($_POST['note']);
        			$id = intval($_POST['id']);                    

        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				if (empty($id)) MySQL::query("INSERT INTO doma_types (name,type,unit,price,note) VALUES ('{$name}','{$type}','{$unit}','{$price}','{$note}')");
        				else MySQL::query("UPDATE doma_types SET name = '{$name}',type = '{$type}',unit = '{$unit}',price = '{$price}',note = '{$note}' WHERE id = '{$id}'");
       					echo 'ok';
       					//echo $price;
        			}
        			else {
        				echo 'Нет прав';
        			}
                    
                break;
                case 'step_edit': //doma/
                	
                    $name = htmls($_POST['name']);
        			$id = intval($_POST['id']);                    

        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				if (!empty($id)) MySQL::query("UPDATE step SET name = '{$name}' WHERE id = '{$id}'");
       					echo 'ok';
       					//echo $price;
        			}
        			else {
        				echo 'Нет прав';
        			}
                    
                break;
                case 'update_field':
                	
        			$id = intval($_POST['id']);
        			$field = $_POST['field'];
        			$value = ($field == 'pass') ? md5(trim($_POST['val'])) : htmlentities($_POST['val'],ENT_COMPAT,'UTF-8');
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				if ($field == 'dogovor') {
        					list($value,$value2) = explode('::',$value);
        					$value2 = return_sql_date($value2);
        					MySQL::query("UPDATE b2b_users SET {$field} = '{$value}', dogovor_date = '{$value2}' WHERE id = '{$id}' LIMIT 1");
        				}
        				else MySQL::query("UPDATE b2b_users SET {$field} = '{$value}' WHERE id = '{$id}' LIMIT 1");
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_doma_step_works':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = $_POST['val1'];
	        			$val2 = $_POST['val2'];
	        			$val3 = $_POST['val3'];
	        			$val4 = $_POST['val4'];
	        			
	        			$val1 = floatval(str_replace(',','.',$val1));
						$val1 = round($val1,1);
	        			
        				MySQL::query("UPDATE doma_step_works SET v_work = '{$val1}', days = '$val2', note = '$val3', sort = '$val4' WHERE id = '{$id}' LIMIT 1");
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_real_doma_step_works':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = $_POST['val1'];
	        			$val2 = $_POST['val2'];
	        			$val3 = $_POST['val3'];
	        			$val4 = $_POST['val4'];
	        			
	        			$val1 = floatval(str_replace(',','.',$val1));
						$val1 = round($val1,1);
	        			
        				MySQL::query("UPDATE real_doma_step_works SET v_work = '{$val1}', days = '$val2', note = '$val3', sort = '$val4' WHERE id = '{$id}' LIMIT 1");
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_doma_step':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = $_POST['val1'];
	        			$val2 = $_POST['val2'];
	        			$val3 = $_POST['val3'];
	        			
	        			$val1 = floatval(str_replace(',','.',$val1));
						$val1 = round($val1,1);
	        			
        				MySQL::query("UPDATE doma_steps SET v_step = '{$val1}', unit_id = '{$val2}', sort = '{$val3}' WHERE id = '{$id}' LIMIT 1");
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_real_doma_step':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = $_POST['val1'];
	        			$val2 = $_POST['val2'];
	        			$val3 = $_POST['val3'];
	        			
	        			$val1 = floatval(str_replace(',','.',$val1));
						$val1 = round($val1,1);
	        			
        				MySQL::query("UPDATE real_doma_steps SET v_step = '{$val1}', unit_id = '{$val2}', sort = '{$val3}' WHERE id = '{$id}' LIMIT 1");
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_work_sort':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = $_POST['val1'];
	        			
        				MySQL::query("UPDATE step_works SET sort = '{$val1}' WHERE id = '{$id}' LIMIT 1");
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_work_plansort':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = $_POST['val1'];
	        			$val2 = $_POST['val2'];
	        			
        				MySQL::query("UPDATE doma_step_works SET sort = '{$val1}', shift1 = '{$val2}' WHERE id = '{$id}' LIMIT 1");
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_real_work_real':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			if (!empty($_POST['val1'])) {
	        				list($d,$m,$y) = explode('.',$_POST['val1']);
	        				$val1 = "{$y}-{$m}-{$d}";
	        			}
	        			if (!empty($_POST['val1'])) {
	        				list($d,$m,$y) = explode('.',$_POST['val2']);
	        				$val2 = "{$y}-{$m}-{$d}";
	        				$val2 = strlen($val2) > 4 ? $val2 : '';
	        			}
	        			
	        			$val3 = str_replace("'",'',$_POST['val3']);
	        			
	        			
	        			$val4 = floatval(str_replace(',','.',$_POST['val4']));
						$val4 = round($val4,2);
	        			$val5 = floatval(str_replace(',','.',$_POST['val5']));
						$val5 = round($val5,2);
	        			$val6 = floatval(str_replace(',','.',$_POST['val6']));
						$val6 = round($val6,2);
						
						$val7 = $_POST['val7'];
	        			
	        			
        				MySQL::query("UPDATE real_doma_step_works SET 
        					startdate_fakt = '$val1', 
        					enddate_fakt = '$val2', 
        					nedochet = '$val3', 
        					v_work = '$val4',
        					price = '$val5',
        					shtraf = '$val6',
        					brigada_id = '$val7'
        				 WHERE id = '{$id}' LIMIT 1");
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_real_work_brigada':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$brigada_id = $_POST['brigada_id'];
	        			$uchastok_id = $_POST['uchastok_id'];
	        			$type = $_POST['type'];

	        			
        				$list = MySQL::fetchAll("SELECT st.id
										FROM real_doma_step_works st 
											LEFT JOIN works as wk ON wk.id = st.work_id
										WHERE  st.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = '{$uchastok_id}') and wk.type = '$type'");
						if (!empty($list)) MySQL::query('UPDATE real_doma_step_works SET brigada_id = '.$brigada_id.' WHERE id IN  ('.join(',',$list).')');										
						
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_real_work_startdate':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$iter = intval($_POST['iter']);//номер работы из таблицы - 1- первая
	        			list($d,$m,$y) = explode('.',$_POST['val1']);
	        			$val2 = $_POST['val2'];
	        			$val3 = $_POST['val3'];
	        			$val4 = $_POST['val4'];
	        			$date_plan = $_POST['date_plan'];
	        			if ($iter == 1)	{

	        					//получим массив всех работ
	        					$list = MySQL::fetchAll("SELECT st.id
		FROM real_doma_step_works st 
		WHERE  st.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = (SELECT uchastok_id FROM stroyka st
LEFT JOIN real_doma_step_works as dsw ON dsw.id = '{$id}'
WHERE st.id = dsw.stroyka_id)) ");
							
	        				if (!empty($list)) MySQL::query('UPDATE real_doma_step_works SET start_date = NULL WHERE id IN  ('.join(',',$list).')');
	        				MySQL::query("UPDATE real_doma_step_works SET start_date = '{$y}-{$m}-{$d}', sort = '{$val2}', shift1 = '{$val3}', days = '{$val4}' WHERE id = '{$id}' LIMIT 1");
	        			}
	        			else {
	        				MySQL::query("UPDATE real_doma_step_works SET sort = '{$val2}', shift1 = '{$val3}', days = '{$val4}' WHERE id = '{$id}' LIMIT 1");
	        				if ($date_plan != $_POST['val1']) { //надо пересчитать все смещения в работах ниже этой
	        					//получим массив всех работ
	        					$list = MySQL::fetchAllArray("SELECT st.id,dsw.start_date as real_start_date, st.start_date,st.days, st.shift1, 
IFNULL(st.start_date,ADDDATE(dsw.start_date, st.shift1)) as  startdate,
DATE_FORMAT(IFNULL(ADDDATE(st.start_date,st.days),ADDDATE(dsw.start_date, st.days+st.shift1)),'%d.%m.%Y') as  enddate
		FROM real_doma_step_works st 
			LEFT JOIN works as wk ON wk.id = st.work_id
			LEFT JOIN step as ste ON ste.id = st.step_id
			LEFT JOIN doma_types as dtp ON dtp.id = st.doma_id
			LEFT JOIN units as un ON un.id = wk.unit_id
			LEFT JOIN real_doma_step_works as dsw ON (dsw.start_date IS NOT NULL and dsw.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = (SELECT uchastok_id FROM stroyka st
LEFT JOIN real_doma_step_works as dsw ON dsw.id = '{$id}'
WHERE st.id = dsw.stroyka_id)))
		WHERE  st.stroyka_id in (SELECT id FROM stroyka WHERE uchastok_id = (SELECT uchastok_id FROM stroyka st
LEFT JOIN real_doma_step_works as dsw ON dsw.id = '{$id}'
WHERE st.id = dsw.stroyka_id)) ORDER BY dtp.id, st.step_id,st.sort");

								if (!empty($list)) {
									//var_dump($list);
									//$real_start_date = $list[0]['real_start_date']; //стартовая работа
									//найдём рассчётную дату по присланному ИД = $_POST['id']
									foreach ($list as $iter => $data) {
										if ($id == $data['id']) {
											$calc_date = $data['startdate'];
											$calc_shift = intval($data['shift1']);
											$real_start_date = $data['real_start_date'];
										}
									}
									
									//вычислим новое смещение
									$info = MySQL::sql_fetch_array("SELECT DATEDIFF('{$y}-{$m}-{$d}','{$real_start_date}') as shift");
									if (!empty($info) && !empty($info['shift']) ) {
										//проапдейтим все смещения
										$iter_next_id = false;
										$new_shift = intval($info['shift']);
										$dif_shift = $calc_shift - $new_shift;
										foreach ($list as $iter => $data) {
											if ($id == $data['id']) {
												$calc_new_shift = $new_shift;
												$iter = $data['id'];
												MySQL::query("UPDATE real_doma_step_works SET shift1 = '{$calc_new_shift}' WHERE id = '{$iter}'");
												$iter_next_id = true;
											}
											elseif ($iter_next_id) {
												$calc_new_shift = intval($data['shift1']) + (0-$dif_shift);
												$iter = $data['id'];
												MySQL::query("UPDATE real_doma_step_works SET shift1 = '{$calc_new_shift}' WHERE id = '{$iter}'");
											}
										}
										
										
										
									}
									
									
								}
	        					 
	        				}
	        				
	        			}
        				echo 'ok'.'UPDATE doma_step_works SET start_date = NULL WHERE id IN  ('.join(',',$list).')';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_step_sleduet':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = $_POST['val1'];
	        			
        				MySQL::query("UPDATE step SET sleduet = '{$val1}' WHERE id = '{$id}' LIMIT 1");
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_doma_materials':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = intval($_POST['val1']); //sposob_id: 1=norma, 2=plan
	        			$val2 = $_POST['val2'];
	        			
						MySQL::query("UPDATE doma_works_materials SET sposob_id = '{$val1}', kol = '{$val2}' WHERE id = '{$id}' LIMIT 1");
						//if ($val1 == 1)	MySQL::query("UPDATE doma_works_materials SET sposob_id = '{$val1}', norma = '{$val2}' WHERE id = '{$id}' LIMIT 1");
						//else 			MySQL::query("UPDATE doma_works_materials SET sposob_id = '{$val1}', plan = '{$val2}' WHERE id = '{$id}' LIMIT 1");
        				//echo "UPDATE doma_works_materials SET sposob_id = '{$val1}', norma = '{$val2}' WHERE id = '{$id}' LIMIT 1";
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_real_doma_materials':
                	

        			if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$id = $_POST['id'];
	        			$val1 = intval($_POST['val1']); //sposob_id: 1=norma, 2=plan
	        			$val2 = $_POST['val2'];
	        			
						MySQL::query("UPDATE real_doma_works_materials SET sposob_id = '{$val1}', kol = '{$val2}' WHERE id = '{$id}' LIMIT 1");
						//if ($val1 == 1)	MySQL::query("UPDATE doma_works_materials SET sposob_id = '{$val1}', norma = '{$val2}' WHERE id = '{$id}' LIMIT 1");
						//else 			MySQL::query("UPDATE doma_works_materials SET sposob_id = '{$val1}', plan = '{$val2}' WHERE id = '{$id}' LIMIT 1");
        				//echo "UPDATE doma_works_materials SET sposob_id = '{$val1}', norma = '{$val2}' WHERE id = '{$id}' LIMIT 1";
        				echo 'ok';
	        			
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'update_field_cnt':
                	
        			$id = intval($_POST['id']);
        			$field = $_POST['field'];
        			$value = $field == 'pass' ? md5(trim($_POST['val'])) : $_POST['val'];
        			$value = $field == 'data_poverki' ? return_sql_date(trim($_POST['val'])) : $_POST['val'];
        			if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
        				MySQL::query("UPDATE counters_clients SET {$field} = '{$value}' WHERE id = '{$id}' LIMIT 1");
       					echo 'ok';
        			}
        			else {
        				echo 'Нет прав!';
        			}
                	
                    
                break;
                case 'get_invoice_1': //получить счета пользователя за период
                	
                    if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$user_id = $_SESSION['userid'];
	        			$mindate = return_sql_date($_REQUEST['mindate']);
	        			$maxdate = return_sql_date($_REQUEST['maxdate']) . ' 23:59:59';
	        			//$result = MySQL::fetchAllArray("SELECT id, DATE_FORMAT(inv_date,'%Y-%m-%d') inv_date, inv_pay_date, pp_number, FORMAT(inv_sum,2) inv_sum, pay_status  FROM docs WHERE user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY inv_date DESC LIMIT 1000");
	        			$result = MySQL::fetchAllArray("SELECT id, DATE_FORMAT(inv_date,'%d.%m.%Y %H:%m:%s') as inv_date2, DATE_FORMAT(inv_pay_date,'%d.%m.%Y') as inv_pay_date, pp_number, FORMAT(inv_sum,2) inv_sum, pay_status, inv_sum as flsumm  FROM docs WHERE user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY inv_date DESC LIMIT 1000");
	        			echo json_encode($result);
                    }
        			else {
        				echo json_encode($result = array('error' => 'Нет прав!'));
        			}                	

                	
                    
                break;                
                case 'get_invoice_2': //получить УПД пользователя за период
                	
                    if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$user_id = $_SESSION['userid'];
	        			$mindate = return_sql_date($_REQUEST['mindate']);
	        			$maxdate = return_sql_date($_REQUEST['maxdate']) . ' 23:59:59';
	        			//$result = MySQL::fetchAllArray("SELECT id, DATE_FORMAT(inv_date,'%Y-%m-%d') inv_date, inv_pay_date, pp_number, FORMAT(inv_sum,2) inv_sum, pay_status  FROM docs WHERE user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY inv_date DESC LIMIT 1000");
	        			$result = MySQL::fetchAllArray("SELECT id, DATE_FORMAT(inv_date,'%c') inv_m, DATE_FORMAT(inv_date,'%Y') inv_date2, pp_number, FORMAT(inv_sum,2) inv_sum, is_file,file_name,file_name_real FROM docs_upd WHERE user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') and is_file = 0 ORDER BY inv_date DESC LIMIT 1000");
	        			echo json_encode($result);
                    }
        			else {
        				echo json_encode($result = array('error' => 'Нет прав!'));
        			}                	
                break;                
                case 'get_invoice_3': //получить АКТ сверки пользователя за период
                	
                    if(isset($_SESSION['userid']) && !empty($_SESSION['userid'])) {
	        			$user_id = $_SESSION['userid'];
	        			$mindate = return_sql_date($_REQUEST['mindate']);
	        			$maxdate = return_sql_date($_REQUEST['maxdate']) . ' 23:59:59';
	        			//$result = MySQL::fetchAllArray("SELECT id, DATE_FORMAT(inv_date,'%Y-%m-%d') inv_date, inv_pay_date, pp_number, FORMAT(inv_sum,2) inv_sum, pay_status  FROM docs WHERE user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY inv_date DESC LIMIT 1000");
	        			
	        			$dop_sql = !empty($user_id) ? ' and b2b_users.id = '.$user_id : '';
	        			
	        			$result = MySQL::fetchAllArray("SELECT b2b_users.id userid,b2b_users.comp_name 
FROM docs_upd, b2b_users, docs 
WHERE (docs_upd.user_id = b2b_users.id or docs.user_id = b2b_users.id) and ( (docs_upd.inv_date BETWEEN '{$mindate}' AND '{$maxdate}') or (docs.inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ) and b2b_users.id = '{$user_id}' GROUP BY b2b_users.id ORDER BY docs.inv_date DESC LIMIT 1000");
	        			//echo json_encode($result);
	        			if (!empty($result)) {
	        				foreach ($result as $key=>$val) {
	        					$result[$key]['url'] = base64_encode($val['userid'].':'.$mindate.':'.return_sql_date($_REQUEST['maxdate']));
	        					//var_dump($result[$key]);
	        				}
	        				
	        			}
	        			echo json_encode($result);
                    }
        			else {
        				echo json_encode($result = array('error' => 'Нет прав!'));
        			}                	
                break;                
                case 'get_invoice_admin_2': //получить УПД пользователя за период
                	
                    if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
	        			$user_id = $_REQUEST['userid'];
	        			$mindate = $_REQUEST['mindate'];
	        			$maxdate = $_REQUEST['maxdate'] . ' 23:59:59';
	        			//$result = MySQL::fetchAllArray("SELECT id, DATE_FORMAT(inv_date,'%Y-%m-%d') inv_date, inv_pay_date, pp_number, FORMAT(inv_sum,2) inv_sum, pay_status  FROM docs WHERE user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY inv_date DESC LIMIT 1000");
	        			
	        			$result = empty($user_id) ? MySQL::fetchAllArray("SELECT b2b_users.id userid,b2b_users.comp_name,docs_upd.id, DATE_FORMAT(inv_date,'%c') inv_m, DATE_FORMAT(inv_date,'%Y') inv_date, pp_number, FORMAT(inv_sum,2) inv_sum,file_name,file_name_real,is_file,inv_date ind FROM docs_upd, b2b_users WHERE docs_upd.user_id = b2b_users.id and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY ind DESC LIMIT 1000") : 
	        										MySQL::fetchAllArray("SELECT b2b_users.id userid,b2b_users.comp_name,docs_upd.id, DATE_FORMAT(inv_date,'%c') inv_m, DATE_FORMAT(inv_date,'%Y') inv_date, pp_number, FORMAT(inv_sum,2) inv_sum,file_name,file_name_real,is_file,inv_date ind FROM docs_upd,b2b_users WHERE docs_upd.user_id = b2b_users.id and user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY ind DESC LIMIT 1000");
	        			echo json_encode($result);
                    }
        			else {
        				echo json_encode(array('error' => 'Нет прав!'));
        			}                	

                	
                    
                break;                
                case 'get_invoice_admin_3': //получить УПД пользователя за период
                	
                    if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
	        			$user_id = $_REQUEST['userid'];
	        			$mindate = $_REQUEST['mindate'];
	        			$maxdate = $_REQUEST['maxdate'] . ' 23:59:59';
	        			//$result = MySQL::fetchAllArray("SELECT id, DATE_FORMAT(inv_date,'%Y-%m-%d') inv_date, inv_pay_date, pp_number, FORMAT(inv_sum,2) inv_sum, pay_status  FROM docs WHERE user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY inv_date DESC LIMIT 1000");
	        			
	        			$dop_sql = !empty($user_id) ? ' and b2b_users.id = '.$user_id : '';
	        			
	        			$result = MySQL::fetchAllArray("SELECT b2b_users.id userid,b2b_users.comp_name 
FROM docs_upd, b2b_users, docs 
WHERE (docs_upd.user_id = b2b_users.id or docs.user_id = b2b_users.id) and ( (docs_upd.inv_date BETWEEN '{$mindate}' AND '{$maxdate}') or (docs.inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ) {$dop_sql} GROUP BY b2b_users.id ORDER BY docs.inv_date DESC LIMIT 1000");
	        			//echo json_encode($result);
	        			if (!empty($result)) {
	        				foreach ($result as $key=>$val) {
	        					$result[$key]['url'] = base64_encode($val['userid'].':'.$mindate.':'.$_REQUEST['maxdate']);
	        					//var_dump($result[$key]);
	        				}
	        				
	        			}
	        			echo json_encode($result);
                    }
        			else {
        				echo json_encode(array('error' => 'Нет прав!'));
        			}                	

                	
                    
                break;                
                case 'get_invoice_admin_1': //получить счета пользователя за период
                	
                    if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
	        			$user_id = $_REQUEST['userid'];
	        			$mindate = $_REQUEST['mindate'];
	        			$maxdate = $_REQUEST['maxdate'] . ' 23:59:59';
	        			//$result = MySQL::fetchAllArray("SELECT id, DATE_FORMAT(inv_date,'%Y-%m-%d') inv_date, inv_pay_date, pp_number, FORMAT(inv_sum,2) inv_sum, pay_status  FROM docs WHERE user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY inv_date DESC LIMIT 1000");
	        			
	        			$result = empty($user_id) ? MySQL::fetchAllArray("SELECT b2b_users.comp_name, b2b_users.id as userid, docs.id, DATE_FORMAT(docs.inv_date,'%d.%m.%Y %H:%i:%s') inv_date, DATE_FORMAT(docs.inv_pay_date,'%d.%m.%Y') inv_pay_date, docs.pp_number, FORMAT(docs.inv_sum,2) inv_sum, docs.pay_status, docs.inv_sum as flsumm  FROM docs, b2b_users WHERE docs.user_id = b2b_users.id and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY id DESC LIMIT 1000") : 
	        										MySQL::fetchAllArray("SELECT b2b_users.comp_name, b2b_users.id as userid, docs.id, DATE_FORMAT(docs.inv_date,'%d.%m.%Y %H:%i:%s') inv_date, DATE_FORMAT(docs.inv_pay_date,'%d.%m.%Y') inv_pay_date, docs.pp_number, FORMAT(docs.inv_sum,2) inv_sum, docs.pay_status, docs.inv_sum as flsumm FROM docs, b2b_users WHERE docs.user_id = b2b_users.id and user_id = '{$user_id}' and (inv_date BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY id DESC LIMIT 1000");
	        			echo json_encode($result);
                    }
        			else {
        				echo json_encode(array('error' => 'Нет прав!'));
        			}                	

                	
                    
                break;                
                case 'get_billing': //получить биллинг пользователя за период
                	
                    /*
                     * могут смотреть или админы
                     * или
                     * пользователь только по себе
                     */
                	if( (isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) or ($_REQUEST['userid'] == $_SESSION['userid'])) {
	        			$user_id = $_REQUEST['userid'];

	        			$mindate = return_sql_date($_REQUEST['mindate']);
	        			$maxdate = return_sql_date($_REQUEST['maxdate']) . ' 23:59:59';
	        			
	        			$result = MySQL::fetchAllArray("SELECT id,tranzaction,DATE_FORMAT(kogda,'%d.%m.%Y') kogda, kogda as data FROM billing WHERE user_id = '{$user_id}' and (kogda BETWEEN '{$mindate}' AND '{$maxdate}') ORDER BY data");
	        			
	        			$out_data = array();
	        			$all = 0;
	        			$all_spis = 0;
	        			$all_post = 0;
	        			
	        			if (!empty($result)) 
	        				foreach ($result as $key=>$value) {
	        					if (floatval($value['tranzaction']) > 0) {
	        						//$out_data[$value['kogda']]['p'] += round(floatval($value['tranzaction']),2);
	        						$out_data[$value['kogda']]['p'] += floatval($value['tranzaction']);
	        						$out_data[$value['kogda']]['r'] += 0;
	        						//$all_post += round(floatval($value['tranzaction']),2); 
	        						$all_post += floatval($value['tranzaction']); 
	        					}
	        					else {
	        						//$out_data[$value['kogda']]['r'] += round(floatval($value['tranzaction']),2);
	        						$out_data[$value['kogda']]['r'] += floatval($value['tranzaction']);
	        						$out_data[$value['kogda']]['p'] += 0;
	        						//$all_spis += round(floatval($value['tranzaction']),2); 
	        						$all_spis += floatval($value['tranzaction']); 
	        					}
	        					//$all += round(floatval($value['tranzaction']),2);
	        					$all += floatval($value['tranzaction']);
	        				}
	        			$out_data['all'] = array('all' => number_format(round($all,2), 2, '.', ' '), 'alls' => number_format(round($all_spis,2), 2, '.', ' '), 'allp' => number_format(round($all_post,2), 2, '.', ' '));
	        			$out_data['alls'] = array('alls' => number_format(round($all_spis,2), 2, '.', ' '));
	        			$out_data['allp'] = array('allp' => number_format(round($all_post,2), 2, '.', ' '));
	        			
	        			echo json_encode($out_data);
                    }
        			else {
        				echo json_encode(array('error' => 'Нет прав!'));
        			}                	

                	
                    
                break;                
                case 'add_pay': //подтвердить оплату счёта
                	
                    if(isset($_SESSION['is_admin']) && !empty($_SESSION['is_admin'])) {
	        			$id = $_REQUEST['id'];
	        			$inv_date = return_sql_date($_REQUEST['date']);
	        			$summ = floatval($_REQUEST['summ']);
	        			$pp_name = floatval($_REQUEST['pp_name']);
	        			
	        			if (!empty($id) && !empty($summ)) {
	        				
	        				$result = MySQL::sql_fetch_array('SELECT *,DATE_FORMAT(inv_date,"%d%.%m.%Y") as invs_date FROM docs WHERE id = "'.$id.'" LIMIT 1');
	        				if (is_array($result) && !empty($result)) {
	        					
	        					//добавим в биллинг сумму прихода
	        					$userid = $result['user_id'];
	        					MySQL::query("INSERT INTO billing (kogda,tranzaction,user_id) VALUES (NOW(),'{$summ}','{$userid}')");
        						$res_id = MySQL::sql_insert_id();
	        					
	        					//добавим информацию по счету, сменим статус
	        					MySQL::query("UPDATE docs SET inv_pay_date = '{$inv_date}', pp_number = '{$pp_name}', pay_status = '1', pay_summ = pay_summ + {$summ}, tranz_id = {$res_id} WHERE id = '{$id}' LIMIT 1");
								// снимем флаг, что по отрицательному балансу было сообщение
								MySQL::query("UPDATE b2b_users SET notify_balans_minus = '1' WHERE id = '{$userid}' LIMIT 1");
	        					
	        					$balans = MySQL::sql_fetch_array("SELECT FORMAT(SUM(tranzaction),2) itogo FROM billing WHERE user_id = '{$userid}'");
    							$inf_balance = !empty($balans) ? $balans['itogo'] : '0';
    							
    							$user_info = MySQL::sql_fetch_array("SELECT login_otch,login_name,login_mail FROM b2b_users WHERE id = '{$userid}'");
	        					
	        					//уведомление клиенту
	        					//в сообщения
	        					$smarty->assign('user_info',$user_info);   
	        					$smarty->assign('id',$id);   
	        					$smarty->assign('result',$result);   
	        					$smarty->assign('summ',$summ);   
	        					$smarty->assign('inf_balance',$inf_balance);   
							
								$mes = $smarty->fetch('emails/email_pay_info.tpl');
						
								MySQL::query(" 
								INSERT INTO msg (parent_id,name,text, date, user_id, to_user_id, is_viewed, to_admin) 
									VALUES (
										'0',
										'".htmlspecialchars ('Подтверждение оплаты счёта в системе ОДИС24',ENT_QUOTES,'UTF-8')."',
										'".htmlspecialchars ($mes,ENT_QUOTES,'UTF-8')."',
										NOW(),
										'".$_SESSION['userid']."',
										'{$userid}',
										0,
										0
								)
							");	 

								//на почту
							require_once($_SERVER['DOCUMENT_ROOT'].'/lib/class.FreakMailer.php');  
							$mailer = new FreakMailer(); 
							
							// Устанавливаем тему письма
							$mailer->Subject = 'Подтверждение оплаты счёта в системе ОДИС24';
							$mailer->CharSet = 'UTF-8';
							
							$mailer->Body = nl2br($mes);
							$mailer->isHTML(true);						
							$mailer->AddAddress($user_info['login_mail']);
							$mailer->Send();
							$mailer->ClearAddresses();								
	        					
	        					echo json_encode(array('result' => 'ok'));
	        					
	        				}
	        				else {
	        					echo json_encode(array('result' => 'error', 'error' => 'Не найден счёт или пустая сумма!'));
	        				}
	        				
	        				
	        				
	        				
	        			}
	        			else {
	        				echo json_encode(array('result' => 'error','error' => 'Номер счёта или сумма нулевые!'));
	        				
	        			}
	        			
                    }
        			else {
        				echo json_encode($result = array('error' => 'Нет прав!'));
        			}                	

                	
                    
                break;                

            }
        }
    }
?>