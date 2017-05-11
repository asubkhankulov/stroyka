<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Стройка Века</title>
    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/font-awesome.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="/css/dashboard.css" rel="stylesheet">
    <link href="/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
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
<link rel="icon" href="favicon.ico" type="image/x-icon" /> 
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />    
</head>

<body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"> <span class="sr-only">Открыть навигацию</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button> {*<a href="/"><img alt="АСУ компании ООО "Комплекс-Техно"" src="/img/logo.gif"></a>*} План-Смета v.1.0.0 </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    {*<li><a href="http://www.учеттеплоэнергии.рф/" target="_blank">Наш сайт</a></li>*}
                    <li class="dropdown "> <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						Аккаунт
						<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li class="dropdown-header">Выберите</li>
                            <li class=""><a href="/index/">Пользователи</a></li>
                            <li class="divider"></li>
                            <li class=""><a href="/stroyka/">Стройка</a></li>
                            <li class=""><a href="/orders/">Мои заявки</a></li>
                            <li class=""><a href="/zakup/">Закупки</a></li>
                            <li class="divider"></li>
                            	<li class=""><a href="/doma/">Типы построек</a></li>
                            	<li class=""><a href="/step/">Этапы стройки</a></li>
                            	<li><a href="/works/">Работы</a></li>
                            <li class="divider"></li>
                            	<li><a href="/materials/">Материалы</a></li>
                            	<li><a href="/types/">Типы материалов</a></li>
                            	<li><a href="/units/">Ед. измерения</a></li>
                            <li class="divider"></li>
                            	<li><a href="/mesto/">Посёлки</a></li>
                            	<li><a href="/prorabs/">Прорабы</a></li>
                            	<li><a href="/brigada/">Бригады</a></li>
                            	<li><a href="/autos/">Машины</a></li>
                            	<li><a href="/sklad/">Склады</a></li>
                            <li class="divider"></li>
                            	<li><a href="/vendors/">Поставщики</a></li>
                            	<li><a href="/docs/">Документы</a></li>
                            <li class="divider"></li>
                            	<li><a href="/os/">Основные средства</a></li>
                            	<li><a href="/uslugi/">Услуги</a></li>
                            <li class="divider"></li>
                            	<li><a href="/exit/">Выход</a></li>
                        </ul>
                    </li>
                </ul><!--
                <form class="navbar-form navbar-right">
                    <div class="form-group">
                        <input type="text" name="q" class="form-control" placeholder="Быстрый поиск клиента..."> </div>
                    <button type="submit" class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
                </form>
            --></div>
        </div>
    </nav>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 col-md-2 sidebar">
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'index'} class="active"{/if}><a href="/index/"><i class="fa fa-street-view" aria-hidden="true"></i> Пользователи <span class="sr-only">(текущая)</span></a></li>
				</ul>                    
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'stroyka'} class="active"{/if}><a href="/stroyka/"><i class="fa fa-cubes" aria-hidden="true"></i> Стройка</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'orders'} class="active"{/if}><a href="/orders/"><i class="fa fa-rub" aria-hidden="true"></i> Мои заявки</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'zakup'} class="active"{/if}><a href="/zakup/"><i class="fa fa-rub" aria-hidden="true"></i> Закупки</a></li>
				</ul>                    
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'doma'} class="active"{/if}><a href="/doma/"><i class="fa fa-home {if !empty($msg)}fa-spin{/if}" aria-hidden="true"></i> Типы построек</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'step'} class="active"{/if}><a href="/step/"><i class="fa fa-random" aria-hidden="true"></i> Этапы стройки</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'works'} class="active"{/if}><a href="/works/"><i class="fa fa-gavel" aria-hidden="true"></i> Работы</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'materials'} class="active"{/if}><a href="/materials/"><i class="fa fa-book" aria-hidden="true"></i> Материалы</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'types'} class="active"{/if}><a href="/types/"><i class="fa fa-tasks" aria-hidden="true"></i> Типы материалов</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'units'} class="active"{/if}><a href="/units/"><i class="fa fa-balance-scale" aria-hidden="true"></i> Ед. измерения</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'mesto'} class="active"{/if}><a href="/mesto/"><i class="fa fa-tree" aria-hidden="true"></i> Посёлки</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'prorabs'} class="active"{/if}><a href="/prorabs/"><i class="fa fa-wheelchair-alt" aria-hidden="true"></i> Прорабы</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'brigada'} class="active"{/if}><a href="/brigada/"><i class="fa fa-users" aria-hidden="true"></i> Бригады</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'autos'} class="active"{/if}><a href="/autos/"><i class="fa fa-truck" aria-hidden="true"></i> Машины</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'sklad'} class="active"{/if}><a href="/sklad/"><i class="fa fa-home" aria-hidden="true"></i> Склады</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'vendors'} class="active"{/if}><a href="/vendors/"><i class="fa fa-blind" aria-hidden="true"></i> Поставщики</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'docs'} class="active"{/if}><a href="/docs/"><i class="fa fa-briefcase" aria-hidden="true"></i> Документы</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li{if $smarty.const.MODULE_PATH == 'os'} class="active"{/if}><a href="/os/"><i class="fa fa-bank" aria-hidden="true"></i> Основные средства</a></li>
                    <li{if $smarty.const.MODULE_PATH == 'uslugi'} class="active"{/if}><a href="/uslugi/"><i class="fa fa-taxi" aria-hidden="true"></i> Услуги</a></li>
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