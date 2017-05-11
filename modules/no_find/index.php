<?
    header("HTTP/1.1 404 Not Found");
    header("Status: 404 Not Found");
    //$smarty->assign('INC_PAGE','page404.tpl');
    $smarty->display(TPL_URL.'/page404.tpl');
?>