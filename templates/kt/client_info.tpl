<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h4  class="page-header">Профиль пользователя: {$item.comp_name}</h4>
            
                <form class="form-horizontal">
                	<div class="row placeholders">
			            <div class="col-xs-6 col-sm-3">
			              <img src="{$userphoto}?{$smarty.now|date_format:"%s"}" width="125" height="125" class="img-responsive img-thumbnail" alt="photo" id="userphoto">
			                  <span class="btn btn-success fileinput-button">
						        <i class="glyphicon glyphicon-plus"></i>
						        <span data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Ошибка при загрузке файла..." id="df">Выберите файл</span>
						        <!-- The file input field used as target for the file upload widget -->
						        <input id="fileupload" type="file" name="files[]">
						    </span>
			                  <span class="btn btn-danger" id="delf" style="display:{if $userphoto=='/img/user.jpg'}none{else}{/if}">
						        <i class="glyphicon glyphicon-minus"></i>
						        <span>Удалить файл</span>
						    </span>
						    <br>
						    <br>
						    <!-- The global progress bar -->
						    <div id="progress" class="progress" style="display:none">
						        <div class="progress-bar progress-bar-success"></div>
						    </div>
			            </div>
			         </div> 
               
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Фамилия</span>
									<input type="text" class="form-control input-sm" name="login_fam" value="{$item.login_fam}" id="login_fam" placeholder="Укажите фамилию"/>
									<span class="input-group-btn"><button class="btn btn-primary btn-sm" type="button" onclick="UpdateField('login_fam',this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button></span>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Имя</span>
									<input type="text" class="form-control input-sm" name="login_name" value="{$item.login_name}" id="login_name" placeholder="Укажите имя"/>
									<span class="input-group-btn"><button class="btn btn-primary btn-sm" type="button" onclick="UpdateField('login_name',this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button></span>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Отчество</span>
									<input type="text" class="form-control input-sm" name="login_otch" value="{$item.login_otch}" id="login_otch" placeholder="Укажите отчество"/>
									<span class="input-group-btn"><button class="btn btn-primary btn-sm" type="button" onclick="UpdateField('login_otch',this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button></span>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">E-mail</span>
									<input type="email" id="inputEmail" class="form-control input-sm" name="login_mail" value="{$item.login_mail}" placeholder="Укажите E-mail" required />
									<span class="input-group-btn"><button class="btn btn-primary btn-sm" type="button" title="Сохранено..." onclick="UpdateField('login_mail',this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button></span>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Телефон</span>
									<input type="text" class="form-control input-sm" name="login_tel" id="login_tel" value="{$item.login_tel}" placeholder="Укажите телефон"/>
									<span class="input-group-btn"><button class="btn btn-primary btn-sm" type="button" title="Сохранено..." onclick="UpdateField('login_tel',this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button></span>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Пароль</span>
									<input type="password" class="form-control input-sm" name="pass" value="" id="pass" placeholder="Введите новый для смены текущего пароля" required/>
									<span class="input-group-btn"><button class="btn btn-primary btn-sm" type="button" title="Сохранено..." onclick="UpdateField('pass',this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button></span>
								</div>
							</div>
						</div>    
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Текущий пароль</span>
									<input type="password" class="form-control input-sm" name="pass-tek" value="" id="pass-tek" placeholder="Чтобы изменить любой реквизит, введите текущий пароль" required/>
									<span class="input-group-btn"><button class="btn btn-primary btn-sm" id="tpas" type="button" data-toggle="tooltip" data-placement="top" title="Чтобы изменить любой реквизит, введите текущий пароль"><i class="fa fa-exclamation" aria-hidden="true"></i></button></span>
								</div>
							</div>
						</div>    
					<div class="alert alert-danger" role="alert" id="ttt" style="display:none">Чтобы изменить любой реквизит, введите текущий пароль!</div>
					<div class="alert alert-danger" role="alert" id="ttts" style="display:none">Текущий пароль не верен!</div>
                    <hr>
                        <h4>Реквизиты компании</h4>
                       
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Наименование организации</span>
									<input type="text" class="form-control input-sm" name="comp_name" value="{$item.comp_name}" id="comp_name" placeholder="">
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Должность руководителя</span>
									<input type="text" class="form-control input-sm" name="director" value="{$item.director}" id="director" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Ф.И.О. руководителя</span>
									<input type="text" class="form-control input-sm" name="director_fio" value="{$item.director_fio}" id="director_fio" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Действует на основании</span>
									<input type="text" class="form-control input-sm" name="ustav" value="{$item.ustav}" id="ustav" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Юридический адрес</span>
									<input type="text" class="form-control input-sm" name="ur_address" value="{$item.ur_address}" id="ur_address" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Фактический адрес</span>
									<input type="text" class="form-control input-sm" name="fact_address" value="{$item.fact_address}" id="fact_address" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Почтовый адрес</span>
									<input type="text" class="form-control input-sm" name="post_address" value="{$item.post_address}" id="post_address" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">ИНН</span>
									<input type="text" class="form-control input-sm" name="inn" id="inn" value="{$item.inn}" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">КПП</span>
									<input type="text" class="form-control input-sm" name="kpp" id="kpp" value="{$item.kpp}" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">ОКПО</span>
									<input type="text" class="form-control input-sm" name="okpo" value="{$item.okpo}" id="okpo" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">ОГРН</span>
									<input type="text" class="form-control input-sm" name="ogrn" value="{$item.ogrn}" id="ogrn" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Банк</span>
									<input type="text" class="form-control input-sm" name="bank" value="{$item.bank}" id="bank" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">БИК</span>
									<input type="text" class="form-control input-sm" name="bik" value="{$item.bik}" id="bik" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Расчётный счёт (р/с)</span>
									<input type="text" class="form-control input-sm" name="rs" value="{$item.rs}" id="rs" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Корреспондентский счёт (к/с)</span>
									<input type="text" class="form-control input-sm" name="ks" value="{$item.ks}" id="ks" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Телефон</span>
									<input type="text" class="form-control input-sm" name="comp_tel" value="{$item.comp_tel}" id="comp_tel" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Адрес E-mail</span>
									<input type="text" class="form-control input-sm" name="comp_mail" value="{$item.comp_mail}" id="comp_mail" placeholder=""/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Официальный сайт</span>
									<input type="text" class="form-control input-sm" name="comp_url" value="{$item.comp_url}" id="comp_url" placeholder="Укажите сайт"/>
								</div>
							</div>
						</div>                   
                </form>
</div>
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="/umaster/js/vendor/jquery.ui.widget.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="/umaster/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="/umaster/js/jquery.fileupload.js"></script>

    <script type="text/javascript">
	$(document).ready(function() {    

		$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
		});
		
		var field = '';        

		UpdateField = function(field_name, obj) {
			

			var pass = $("#pass-tek").val();
			$("#ttt").hide();
			$("#ttts").hide();
			
			if (pass == '') {
				$("#tpass").tooltip('show');
				$("#ttt").show();
				return;
			}

			var val = $("#"+field_name).val();
			if (field != '') $(field).tooltip('hide');
			field = obj;
			
			
			url = '/ajax/index.php';       
            $.post(url,
            {
                'action': 'update_user',
                'field': field_name,
                'tpass': pass,
                'val': val
            }, checkTime = function(data) {
				

            	switch(data) {
                case 'ok':
                	$(field).tooltip('show');
                    break
                case "wrong":
                    //alert('Текущий пароль не верен!');
                    $("#ttts").show();
                    break
                default:
                	$(field).tooltip(data);
            }


			});
		}

	
	});

    </script>

<script>
var usrphoto = '{$userphoto}';

$('#delf').click(function() {
	
    if (usrphoto != "/img/user.jpg") {
		url = '/ajax/index.php';       
        $.post(url,
        {
            'action': 'del_uimg',
            'id': usrphoto
        }, checkTime = function(data) {
        	 //console.log(data);
        	 if (data == 'ok')  { 
        		 $("#userphoto").attr("src","/img/user.jpg");
        		 usrphoto = "/img/user.jpg";
        		 $('#delf').hide();

	         }
        	 else { //alert(data);
        	 	$("#success-alert").text(data);
        	 }
        	 

		}

		);

    }
});
/*jslint unparam: true */
/*global window, $ */
$(function () {
    'use strict';
    // Change this to the location of your server-side upload handler:
    var url = '/umaster/server/php/';
    $('#fileupload').fileupload({
        url: url,
        dataType: 'json',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        maxFileSize: 999000,
        // Enable image resizing, except for Android and Opera,
        // which actually support image resizing, but fail to
        // send Blob objects via XHR requests:
        disableImageResize: /Android(?!.*Chrome)|Opera/
            .test(window.navigator.userAgent),
        previewMaxWidth: 100,
        previewMaxHeight: 100,
        previewCrop: true,        
        done: function (e, data) {
            $.each(data.result.files, function (index, file) {
                //$('<p/>').text(file.name).appendTo('#files');
                if (file.error != undefined ) {
                	//alert(file.error);
                	
                	$("#userphoto").attr("src","/img/user.jpg");
                	
                }
                else {
                	$("#userphoto").attr("src",file.url + "?" + file.size);
                	usrphoto = file.url;
                	$("#delf").show();
                }
            });
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .progress-bar').css(
                'width',
                progress + '%'
            );
        }
    }).prop('disabled', !$.support.fileInput)
        .parent().addClass($.support.fileInput ? undefined : 'disabled');
});
</script>