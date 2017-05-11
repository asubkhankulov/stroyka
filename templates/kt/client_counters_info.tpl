<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	
	{if !empty($pribor)}
	
	<h4>{$pribor.mesto_ustanovki} - {$pribor.pribor} <span {if $pribor.maxdate == $today}class="label label-success" title="Есть данные за текущие сутки" {else}class="label label-default" title="Нет данных за текущие сутки"{/if} data-toggle="tooltip" data-placement="top">{if $pribor.maxdate == $today}Работает{else}Не работает{/if}</span>
	Суммарный расход, м3: <span class="label label-info">{$pribor.vol|default:"нет данных"}</span></h4>
<hr>

	{include file='dop_menu.tpl'}

	<hr>

	<div class="row">

<style><!--
div.input-group { width:100% }
-->
</style>	
   
		<div>
		  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab"><i class="fa fa-info" aria-hidden="true"></i> Информация</a></li>
		    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab"><i class="fa fa-picture-o" aria-hidden="true"></i> Фото объекта</a></li>
		  </ul>
		
		  <!-- Tab panes -->
		  <div class="tab-content">
		    <div role="tabpanel" class="tab-pane fade in active" id="home">
			<form class="form-horizontal navbar-left col-sm-10">
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group" style="width:100%">
									<span class="input-group-addon hidden-xs">Место установки:</span>
									<input type="text" class="form-control input-sm" name="mesto_ustanovki" id="mesto_ustanovki" value="{$pribor.mesto_ustanovki}" placeholder="Укажите объект" required />
									
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Наименование прибора:</span>
									<input type="text" class="form-control input-sm" name="mesto_ustanovki" id="mesto_ustanovki" value="{$pribor.pribor}" placeholder="Укажите объект" required />
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Заводской номер прибора:</span>
									<input type="text" class="form-control input-sm" name="serial_number" value="{$pribor.serial_number}" id="serial_number" placeholder="Укажите заводской номер" required/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Год выпуска:</span>
									<input type="text" class="form-control input-sm" name="data_vypuska" value="{$pribor.data_vypuska}" id="data_vypuska" placeholder="Укажите год выпуска"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Дата поверки:</span>
									<input type="text" id="data_poverki" class="form-control input-sm" name="data_poverki" value="" placeholder="Укажите дату поверки прибора" />
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Тип измеряемой жидкости:</span>
									<input type="text" class="form-control input-sm" name="type_izm" id="type_izm" value="{$pribor.type_izm}" placeholder="Укажите тип жидкости"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">ФИО ответсвенного лица:</span>
									<input type="text" class="form-control input-sm" name="fio_otvetsv" value="{$pribor.fio_otvetsv}" id="fio_otvetsv" placeholder="Укажите ответсвенное лицо" required/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Телефон:</span>
									<input type="text" class="form-control input-sm" name="tel" value="{$pribor.tel}" id="tel" placeholder="Укажите телефон" required/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon hidden-xs">Email:</span>
									<input type="text" class="form-control input-sm" name="email" value="{$pribor.email}" id="email" placeholder="Укажите email" required/>
								</div>
							</div>
						</div>                   
                </form>		    
		    </div>
      		    <div role="tabpanel" class="tab-pane fade" id="profile">
      		    
			           <div class="row placeholders">

			         </div> 
			          
			          <div class="container">
			          <div class="row">
			          	{if !empty($files)}
			          	{section name=cus loop=$files}
			          	 <div class="col-md-3 col-sm-4 col-xs-6" id="oi-{$smarty.section.cus.iteration}">
			            {*<div class="col-xs-1 col-sm-2" id="oi-{$smarty.section.cus.iteration}">*}
			              <img src="/umaster2/server/php/files/{$files[cus]}" width="200" class="img-responsive img-thumbnail">
			              <span class="label label-danger io" onclick="deleteimg('{$files[cus]}',{$smarty.section.cus.iteration});">X</span>
			            </div>{/section}
			            {/if}
			        	<div class="col-md-3 col-sm-4 col-xs-6"" id="il">
			            		<center><img src="/img/uo.jpg" class="img-responsive img-thumbnail" alt="photo" id="userphoto">
			                  <span class="btn btn-success fileinput-button">
						        <i class="glyphicon glyphicon-plus"></i>
						        <span data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Ошибка при загрузке файла..." id="df">Выберите файл для загрузки</span>
						        <!-- The file input field used as target for the file upload widget -->
						        <input id="fileupload" type="file" name="files[]">
						    </span>
						    <br>
						    <br>
						    <!-- The global progress bar -->
						    <div id="progress" class="progress">
						        <div class="progress-bar progress-bar-success"></div>
						    </div></center>
			            </div>
  		    
      		    </div>
      		    </div>

		  </div>
		
		</div>	
	
	</div>
	{else}
	<div class="alert alert-danger" role="alert">Нет доступа!</div>

	{/if}
	
        <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="/umaster/js/vendor/jquery.ui.widget.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="/umaster/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="/umaster/js/jquery.fileupload.js"></script>

<script>
$('#data_poverki').datetimepicker({
	format: 'DD.MM.YYYY',
	{if $pribor.data_poverki <> '0000-00-00'}defaultDate: "{$pribor.data_poverki}",{/if}
    locale: 'ru'
});

var globid = 0;

function deleteimg(img,id) {
	url = '/ajax/index.php';   
	globid = id;    
    $.post(url,
    {
        'action': 'del_oimg',
        'img': img
    }, checkTime = function(data) {
		//alert(data);
		if (data = 'ok') {
			$("#oi-"+globid).hide();
		}
		else {
			
		}
	});	
}
/*jslint unparam: true */
/*global window, $ */
$(function () {
    'use strict';
    // Change this to the location of your server-side upload handler:
    var url = '/umaster2/server/php/';
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
                	alert(file.error);
                	
                	$("#userphoto").attr("src","/img/uo.jpg");
                }
                else {
                	//$("#userphoto").attr("src",file.url + "?" + file.size);
                	$("#il").before( '<div class="col-md-3 col-sm-4 col-xs-6"><img src="' +file.url + "?" + file.size + '" width="200" class="img-responsive img-thumbnail"></div>' );
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
    
