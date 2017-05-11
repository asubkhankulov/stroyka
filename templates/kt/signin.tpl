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

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <style>
      body {
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #eee;
}

.form-signin {
  max-width: 330px;
  padding: 15px;
  margin: 0 auto;
}
.form-signin .form-signin-heading,
.form-signin .checkbox {
  margin-bottom: 10px;
}
.form-signin .checkbox {
  font-weight: normal;
}
.form-signin .form-control {
  position: relative;
  height: auto;
  -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
          box-sizing: border-box;
  padding: 10px;
  font-size: 16px;
}
.form-signin .form-control:focus {
  z-index: 2;
}
.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
} 
      </style>
<link rel="icon" href="favicon.ico" type="image/x-icon" /> 
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />        
  </head>

  <body>
  {if $recovery == 'ok' }
	<div class="alert alert-success alert-dismissible" role="alert">
	  <button type="button" class="close" data-dismiss="alert" aria-label="Закрыть"><span aria-hidden="true">&times;</span></button>
	  Новый пароль отправлен на почту!
	</div>
  {/if}
  {if $recovery == 'fail' }
	<div class="alert alert-danger alert-dismissible" role="alert">
	  <button type="button" class="close" data-dismiss="alert" aria-label="Закрыть"><span aria-hidden="true">&times;</span></button>
	  Ошибка восстановления пароля. Попробуйте новое восстановление!
	</div>
  {/if}
    <div class="container">

      <form class="form-signin">
      {*<img alt="АСУ компании ООО "Комплекс-Техно"" src="/img/logo.png" width="300">*}
        <h2 class="form-signin-heading">Вход в систему учёта</h2>
        <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="#" data-toggle="modal" data-target="#cntdlg">Забыли пароль?</a></div>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="inputEmail" class="form-control" placeholder="Ваш email" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Ваш пароль" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Запомнить меня
          </label>
        </div>
        <button id="mbtn" class="btn btn-lg btn-primary btn-block" type="submit" data-loading-text="Проверка...">Войти</button>
        <div class="alert alert-danger hidden" role="alert">Неправильный логин и/или пароль</div>
      </form>
      
<div class="modal fade" tabindex="-1" role="dialog" id="cntdlg" aria-labelledby="exampleModalLabel1">
  <div class="modal-dialog">
    <div class="modal-content modal-md">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel1">Восстановление пароля</h4>
      </div>
      <div class="modal-body">
			<div class="input-group col-xs-12">
				<span class="input-group-addon hidden-xs">Ваш email в системе:</span>
				<input type="email" class="form-control input-sm" name="email" id="email" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required autofocus />
				
			</div>
			<div class="input-group col-xs-12"><p class="help-block">На зарегистрированную почту отправим инструкции по изменению пароля.</p></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
        <button type="button" class="btn btn-primary" id="recover">Восстановить</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->    

    </div> <!-- /container -->
 
   
   
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="/js/jquery.min.js"><\/script>')</script>
    <script src="/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="/js/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/js/ie10-viewport-bug-workaround.js"></script>
    <script type="text/javascript">

		$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
		});
   
		$( ".form-signin" ).submit(function(event){

			event.preventDefault();
			$(".alert").addClass('hidden');
			$("#mbtn").button('loading');
			
			
			email = $('#inputEmail').val();
			pass = $('#inputPassword').val();

			url = '/ajax/index.php';       
	        $.post(url,
	        {
	            'action': 'login',
	            'email': email,
	            'pass': pass
	        }, checkTime = function(data) {
	        	 //console.log(data);
	        	 if (data == 'ok')  { 
	        		 window.location = "/";

		         }
	        	 else { //alert(data);
	        	 	$(".alert").toggleClass('hidden');
	        	 }
	        	 
	        	 $("#mbtn").button('reset');
			}

			);

			return false;
			});

	    $('#recover').on('click', function () {
		       
			email = $("#email").val();
			
		    if (email != '') {
		    	$("#email").tooltip('hide');
		    	var $btn = $(this).button('Отправляю...');
				url = '/ajax/index.php';       
		        $.post(url,
		        {
		            'action': 'recovery',
		            'email': email
		        }, checkTime = function(data) {
		        	 //console.log(data);
		        	 if (data == 'ok')  { 
		        		 $btn.button('reset');
		        		 $("p.help-block").removeClass('bg-danger').addClass('bg-success').html("На почту отправлена инструкция по смене пароля. Дождитесь письма!");

			         }
		        	 else { 
		        	 	$("p.help-block").removeClass('bg-success').addClass('bg-danger').text('Произошла ошибка: ' + data);
		        	 }
		        	 

				}

				);

		    }
		    else {
		    	$("#cnt_name").tooltip('show');
		    }
		    
	    });	
		
    </script>
  </body>
</html>
