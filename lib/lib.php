<?php 
		// Функция - определения формы слов
    // Например, "1 год, 2 года, 5 лет"
    // Пример вызова : decline('123', array('книга', 'книги', 'книг'));
	// $onlyword – если стоит true, то функция будет возвращать только существительное, идущее после числительного
    
    function decline($digit,$expr,$onlyword=false)
    {
        if(!is_array($expr)) $expr = array_filter(explode(' ', $expr));
        if(empty($expr[2])) $expr[2]=$expr[1];
        $i=preg_replace('/[^0-9]+/s','',$digit)%100;
        if($onlyword) $digit='';
        if($i>=5 && $i<=20) $res=$digit.' '.$expr[2];
        else
        {
            $i%=10;
            if($i==1) $res=$digit.' '.$expr[0];
            elseif($i>=2 && $i<=4) $res=$digit.' '.$expr[1];
            else $res=$digit.' '.$expr[2];
        }
        return trim($res);
	}
	
    // Функция - транслит
    function rus2lat($string){ 	
        $rus = array('ё','ж','ц','ч','ш','щ','ю','я','Ё','Ж','Ц','Ч','Ш','Щ','Ю','Я','Ъ','Ь','ъ','ь');
        $lat = array('e','zh','c','ch','sh','sh','ju','ja','E','ZH','C','CH','SH','SH','JU','JA','','','','');
        $string = str_replace($rus,$lat,$string);
        $string = strtr($string,
        "АБВГДЕЗИЙКЛМНОПРСТУФХЫЭабвгдезийклмнопрстуфхыэ",
        "ABVGDEZIJKLMNOPRSTUFHIEabvgdezijklmnoprstufhie");
        return $string;
    }
	
	// Функция - транслит
    function rus2latutf8($string){ 	
		$string = convert('utf-8', 'cp1251', $string);                     
        $rus = array('ё','ж','ц','ч','ш','щ','ю','я','Ё','Ж','Ц','Ч','Ш','Щ','Ю','Я','Ъ','Ь','ъ','ь');
        $lat = array('e','zh','c','ch','sh','sh','ju','ja','E','ZH','C','CH','SH','SH','JU','JA','','','','');
        $string = str_replace($rus,$lat,$string);
        $string = strtr($string,
        "АБВГДЕЗИЙКЛМНОПРСТУФХЫЭабвгдезийклмнопрстуфхыэ",
        "ABVGDEZIJKLMNOPRSTUFHIEabvgdezijklmnoprstufhie");
		$string = convert('cp1251', 'utf-8', $string);      
        return $string;
    }    
    // Json в windows
    function array2json($arr) {
        $parts = array();
        $is_list = false;
        
        if (!is_array($arr)) return;
        if (count($arr)<1) return '{}';
        
        //Find out if the given array is a numerical array
        $keys = array_keys($arr);
        $max_length = count($arr);  
                 
        if(($keys[0] == 0) and !empty($keys[$max_length]) and ($keys[$max_length] == $max_length)) {//See if the first key is 0 and last key is length - 1
            $is_list = true;
            for($i=0; $i<count($keys); $i++) { //See if each key correspondes to its position
                if($i != $keys[$i]) { //A key fails at position check.
                    $is_list = false; //It is an associative array.
                    break;
                }
            }
        }

        foreach($arr as $key=>$value) {
            if(is_array($value)) { //Custom handling for arrays
                if($is_list) $parts[] = array2json($value); /* :RECURSION: */
                else $parts[] = '"' . $key . '":' . array2json($value); /* :RECURSION: */
            } else {
                $str = '';
                if(!$is_list) $str = '"' . $key . '":';

                //Custom handling for multiple data types
                if(is_numeric($value)) $str .= $value; //Numbers
                elseif($value === false) $str .= 'false'; //The booleans
                elseif($value === true) $str .= 'true';
                else $str .= '"' . addslashes($value) . '"'; //All other things
                // :TODO: Is there any more datatype we should be in the lookout for? (Object?)

                $parts[] = $str;
            }
        }
        $json = implode(',',$parts);

        if($is_list) return '[' . $json . ']';//Return numerical JSON
        return '{' . $json . '}';//Return associative JSON
    }  
?>