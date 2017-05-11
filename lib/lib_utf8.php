<?php 
    //  Преобразует специальные символы в HTML сущности   
    function htmls($res, $stat = true) {          
        if($stat) {
            $res = trim($res);
        }
        return htmlspecialchars($res,ENT_QUOTES,'UTF-8');
    }
	
	/* Метод преобразования даты 
    *  Зарезервированные переменные
    *  %d - день (число);
    *  %D - день недели;
    *  %B - день недели с большой буквы; 
    *  %m - номер месяца;
    *  %M - название месяца (родительный падеж);
    *  %Y - год; 
    *  %H - часы; 
    *  %i - минуты;
    *  %s - секунды;   
    */
    function format_date_rod_padej($date, $format = '%d %M %Y %H:%i, %B'){

        $months = array(
            'Января', 'Февраля', 'Марта', 'Апреля', 'Мая', 'Июня', 'Июля', 'Августа', 'Сентября', 'Октября', 'Ноября', 'Декабря'
        );

        $day_week_array = array(
            '0' => 'воскресенье',
            '1' => 'понедельник',
            '2' => 'вторник',
            '3' => 'среда',
            '4' => 'четверг',
            '5' => 'пятница',
            '6' => 'суббота',
        );
        
        $day_week_array_big = array(
            '0' => 'Воскресенье',
            '1' => 'Понедельник',
            '2' => 'Вторник',
            '3' => 'Среда',
            '4' => 'Четверг',
            '5' => 'Пятница',
            '6' => 'Суббота',
        );
        
        $date = strtotime($date);
                
        $day = date("d", $date);
        $month = date('m', $date);
        $month_name = $months[(int)date('m', $date)-1];
        $year = date('Y', $date);
        $day_week = $day_week_array[date('w', $date)];
        $day_week_big = $day_week_array_big[date('w', $date)];
        $full_time = strftime("%H:%M:%S",$date); 
        $h = date('H', $date); 
        $m = date('i', $date); 
        $s = date('s', $date); 
        
        $format_per= array('%d', '%D', '%B', '%m', '%M', '%Y', '%H', '%i', '%s');        
        $format_replace = array($day, $day_week, $day_week_big, $month, $month_name, $year, $h, $m, $s);
        $date_view = str_replace($format_per, $format_replace, $format);
                
        return $date_view;          
    } 
	    
    //Функция выводит var_dump в pre
    function v_dump() {
        $return = "";
        foreach (func_get_args() as $k => $v)
            $return.=var_export($v,true);
        echo "<div style='position:absolute; top:0px; right:0px;z-index:1000; width:auto; background: #333333; padding:5px 15px;'><pre style='background: #ccc; padding:10px;'><b style='color:#000;'>".$return."</b></pre></div>";
        return $return;
    }
    
    //Функция выводит var_dump в pre
    function html_dump() {
        $return = "";
        foreach (func_get_args() as $k => $v)
            $return.=var_export($v,true);
        echo "<pre style=\"background: #FFFFFF\">".$return."</pre>";
        return $return;
    }
    
    // Функция для работы с постраничкой  в Smarty
    function SitePager($list, $events_numbers, $current_page = 1, $page_numbers = 10) {
        global $smarty;
        $total_pages =  ceil($list/$events_numbers);
        
        $smarty->assign('currentPage',$current_page); // Текущая страница
        $smarty->assign('pageNumbers',$page_numbers); // Сколько страниц на странице
        $smarty->assign('totalPages',$total_pages);  // Всего страниц
    }  
    
    // Функция создает новый файл или перезаписывает его
    function CreateNewFiles($fname, $contents) {
        global $smarty; 
        @chmod($fname, 0777);
        $f = fopen($fname, "w");
        $result = fwrite($f, $contents); 
        fclose($f);
         
        if (!$result)
        {             
            return false;  
        }  else {
            return true;
        } 
    } 
    
    // Пример convert('cp1251', 'utf-8', $arr)
    function convert($from, $to, $var)
    {
        if (is_array($var))
        {
            $new = array();
            foreach ($var as $key => $val)
            {
                $new[convert($from, $to, $key)] = convert($from, $to, $val);
            }
            $var = $new;
        }
        else if (is_string($var))
        {
            $var = iconv($from, $to, $var);
        }
        return $var;
    }    
    
    // Преобразование JSON в массив
    function json2array($json){  
       if(get_magic_quotes_gpc()){
          $json = stripslashes($json);
       }        
       //$json = substr($json, 1, -1);         
       $json = str_replace(array(":", "{", "[", "}", "]"), array("=>", "array(", "array(", ")", ")"), $json); 
       @eval("\$json_array = array({$json});");
       return @$json_array[0];
    } 
    
    // Функция определения адреса посетителя
    function getRealIpAddr()
    {
      if (!empty($_SERVER['HTTP_CLIENT_IP']))
      {
        $ip=$_SERVER['HTTP_CLIENT_IP'];
      }
      elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
      {
        $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
      }
      else
      {
        $ip=$_SERVER['REMOTE_ADDR'];
      }
      return $ip;
    }
    
    function connectsitePOST($PostData, $url = '', $debag = false){ 
        if(empty($url) || empty($PostData)) {  
            exit;
        }  
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HEADER, false);         
        //curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_0); // костыль на squid
        curl_setopt($ch, CURLOPT_HTTPHEADER, array("Expect:") ); 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);          
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13'); 
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, false);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $PostData);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $result = curl_exec($ch);
        
        if($debag){             
            $errmsg  = curl_error( $ch );             
            if(!curl_errno($ch))
            {
                $info = curl_getinfo($ch);                  
                html_dump($errmsg);
                html_dump($info);
            }    
        }
        
        curl_close($ch);          
        return trim($result);          
    }  
    
  /*      **
 * Возвращает сумму прописью
 * @author runcore
 * @uses morph(...)
 */
function num2str($num) {
	$nul='ноль';
	$ten=array(
		array('','один','два','три','четыре','пять','шесть','семь', 'восемь','девять'),
		array('','одна','две','три','четыре','пять','шесть','семь', 'восемь','девять'),
	);
	$a20=array('десять','одиннадцать','двенадцать','тринадцать','четырнадцать' ,'пятнадцать','шестнадцать','семнадцать','восемнадцать','девятнадцать');
	$tens=array(2=>'двадцать','тридцать','сорок','пятьдесят','шестьдесят','семьдесят' ,'восемьдесят','девяносто');
	$hundred=array('','сто','двести','триста','четыреста','пятьсот','шестьсот', 'семьсот','восемьсот','девятьсот');
	$unit=array( // Units
		array('копейка' ,'копейки' ,'копеек',	 1),
		array('рубль'   ,'рубля'   ,'рублей'    ,0),
		array('тысяча'  ,'тысячи'  ,'тысяч'     ,1),
		array('миллион' ,'миллиона','миллионов' ,0),
		array('миллиард','милиарда','миллиардов',0),
	);
	//
	list($rub,$kop) = explode('.',sprintf("%015.2f", floatval($num)));
	$out = array();
	if (intval($rub)>0) {
		foreach(str_split($rub,3) as $uk=>$v) { // by 3 symbols
			if (!intval($v)) continue;
			$uk = sizeof($unit)-$uk-1; // unit key
			$gender = $unit[$uk][3];
			list($i1,$i2,$i3) = array_map('intval',str_split($v,1));
			// mega-logic
			$out[] = $hundred[$i1]; # 1xx-9xx
			if ($i2>1) { $out[]= $tens[$i2];
							// .' '.
							$out[]= $ten[$gender][$i3]; # 20-99
			}
			else $out[]= $i2>0 ? $a20[$i3] : $ten[$gender][$i3]; # 10-19 | 1-9
			// units without rub & kop
			if ($uk>1) $out[]= morph($v,$unit[$uk][0],$unit[$uk][1],$unit[$uk][2]);
		} //foreach
	}
	else $out[] = $nul;
	//html_dump($out);
	$out[] = morph(intval($rub), $unit[1][0],$unit[1][1],$unit[1][2]); // rub
	$out[] = $kop.' '.morph($kop,$unit[0][0],$unit[0][1],$unit[0][2]); // kop
	
	$out[1] = mb_convert_case($out[1], MB_CASE_TITLE, 'UTF-8');

	return trim(preg_replace('/ {2,}/', ' ', join(' ',$out)));
}

/**
 * Склоняем словоформу
 * @ author runcore
 */
function morph($n, $f1, $f2, $f5) {
	$n = abs(intval($n)) % 100;
	if ($n>10 && $n<20) return $f5;
	$n = $n % 10;
	if ($n>1 && $n<5) return $f2;
	if ($n==1) return $f1;
	return $f5;
}


function return_sql_date($date = '',$delim = '.') {
	list($d,$m,$y) = explode($delim,$date);
	return $y.'-'.$m.'-'.$d;
}

function return_rus_date($date = '',$delim = '-') {
	list($y,$m,$d) = explode($delim,$date);
	return $d.'.'.$m.'.'.$y;
}

function return_rus_date_time($date = '',$delim = '-') {
	list($data,$time) = explode(' ',$date);
	list($y,$m,$d) = explode($delim,$data);
	return $d.'.'.$m.'.'.$y. ' ' .$time;
}

function generatePassword($length = 8){
  $chars = 'abdefhiknrstyzABDEFGHKNQRSTYZ23456789';
  $numChars = strlen($chars);
  $string = '';
  for ($i = 0; $i < $length; $i++) {
    $string .= substr($chars, rand(1, $numChars) - 1, 1);
  }
  return $string;
}
?>