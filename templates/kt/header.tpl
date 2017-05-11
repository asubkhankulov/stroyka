<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Система информационно-измерительная «ОДИС»</title>
    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/font-awesome.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="/css/dashboard.css" rel="stylesheet">
    <link href="/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/umaster/css/jquery.fileupload.css">
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/js/jquery.min.js"></script>
	<script src="/js/moment-with-locales.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/bootstrap-datetimepicker.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/js/ie10-viewport-bug-workaround.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  <style> 
    .io { 
		vertical-align: top;
    } 




  </style>   
<link rel="icon" href="favicon.ico" type="image/x-icon" /> 
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />  
</head>

<body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"> <span class="sr-only">Открыть навигацию</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button> <a href="/"><img alt="АСУ компании ООО "Комплекс-Техно"" src="/img/logo.gif"></a>{*<a class="navbar-brand" href="/">АСУ компании ООО "Комплекс-Техно"</a>*} </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    {*<li><a href="http://www.учеттеплоэнергии.рф/" target="_blank">Сайт компании</a></li>*}
                    <li class="dropdown "> <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						Аккаунт
						<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li class="dropdown-header">Выберите</li>
                            <li class=""><a href="/index/">Приборы</a></li>
                            <li class=""><a href="/messages/">Сообщения</a></li>
                            <li class="divider"></li>
                            <li><a href="/info/">Информация</a></li>
                            <li><a href="/finance/">Финансы</a></li>
                            <li><a href="/docs/">Документы</a></li>
                            <li class="divider"></li>
                            <li><a href="/exit/">Выход</a></li>
                        </ul>
                    </li>
                </ul>
                        <h4 style="margin-left:320px"><span class="label">Баланс: {$inf_balance|default:0} руб.</span><div class="btn-group btn-group-xs" role="group" aria-label="..."><a href="/finance/" role="btn" class="btn btn-success">Пополнить</a></div></h4>

           </div>
        </div>
    </nav>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 col-md-2 sidebar">
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'index'} class="active"{/if}><a href="/index/"><i class="fa fa-calculator" aria-hidden="true"></i> Приборы <span class="sr-only">(текущая)</span></a></li>
                    <li{if $smarty.const.MODULE_PATH == 'messages'} class="active"{/if}><a href="/messages/"><i class="fa fa-circle-o-notch {if !empty($msg)}fa-spin{/if}" aria-hidden="true"></i> Сообщения</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'info'} class="active"{/if}><a href="/info/"><i class="fa fa-user" aria-hidden="true"></i> Информация</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'finance'} class="active"{/if}><a href="/finance/"><i class="fa fa-rub" aria-hidden="true"></i> Финансы</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'docs'} class="active"{/if}><a href="/docs/"><i class="fa fa-briefcase" aria-hidden="true"></i> Документы</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li><a href="/exit/"><i class="fa fa-sign-out" aria-hidden="true"></i> Выход</a></li>
                </ul>
                <!--
          <ul class="nav nav-sidebar">
            <li><a href="">Nav item again</a></li>
            <li><a href="">One more nav</a></li>
            <li><a href="">Another nav item</a></li>
          </ul>
-->
            </div>