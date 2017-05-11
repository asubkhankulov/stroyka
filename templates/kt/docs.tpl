<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<h4  class="page-header">Профиль пользователя: {$item.comp_name}</h4>
	
	<div class="row">
	
		<span class="label label-default">Договор: {$item.dogovor} от {$item.dogovor_date2}</span>

		<div><br/>
		  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Счета на оплату</a></li>
		    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">Отчётные документы</a></li>
		    <li role="presentation"><a href="#situation" aria-controls="situation" role="tab" data-toggle="tab">Акты сверки</a></li>
		  </ul>
		
		  <!-- Tab panes -->
		  <div class="tab-content">
		    <div role="tabpanel" class="tab-pane fade in active" id="home">
		    
		    <br>
				<div class="panel panel-info">
				  <div class="panel-heading"><span class="label label-info"><strong>Счета</strong></span></div>
				  <div class="panel-body">
					<form class="form-inline" role="form">
					  <div class="form-group">
					    <label  for="datetimepicker1">Период с:</label>
					    <input type="text" class="form-control" id="datetimepicker_1_1" value=""> {*  datetimepicker_№_tab№   *}
					  </div>
					  <div class="form-group">
					    <label  for="datetimepicker2">по:</label>
					    <input type="text" class="form-control" id="datetimepicker_2_1" value="">
					  </div>&nbsp;<button type="text" class="btn btn-success btn-sm" onclick="return UpdateField(1)">Показать</button>
					</form>		
					<hr>
					<p><i class="fa fa-calendar" aria-hidden="true"></i> Для просмотра необходимых счетов на оплату укажите период</p>
					<hr>
                 <table class="table table-bordered" id="htmltable1" style="display:none">
                     <thead>
                         <tr class="info" align="center">
                             <th >Счёт №</th>
                             <th align="center">Дата формирования счёта</th>
                             <th align="center">Дата оплаты счёта</th>
                             <th align="center">№ ПП</th>
                             <th align="center">Сумма, руб.</th>
                             <th align="center">Статус</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                     <tbody>
                     {* тут данные с js-скрипта *}
                     </tbody>
                     <tfoot>
                         <tr class="active">
                             <td><b>Итого</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                             <td></td>
                             <td></td>
                         </tr>
                     </tfoot>
                 </table>					
				  </div>
				</div>
	    		<br>
	    		

				
	    		
	    		
		    </div>
      
		    <div role="tabpanel" class="tab-pane fade" id="profile"><br>
				<div class="panel panel-warning">
				  <div class="panel-heading"><span class="label label-info"><strong>Отчётные документы</strong></span></div>
				  <div class="panel-body">
					<form class="form-inline" role="form">
					  <div class="form-group">
					    <label  for="datetimepicker1">Период с:</label>
					    <input type="text" class="form-control" id="datetimepicker_1_2" value=""> {*  datetimepicker_№_tab№   *}
					  </div>
					  <div class="form-group">
					    <label  for="datetimepicker2">по:</label>
					    <input type="text" class="form-control" id="datetimepicker_2_2" value="">
					  </div>&nbsp;<button type="text" class="btn btn-success btn-sm" onclick="return UpdateField(2)">Показать</button>
					</form>		
					<hr>
					<p><i class="fa fa-calendar" aria-hidden="true"></i> Для просмотра необходимых докуметов укажите период</p>
					<hr>
                 <table class="table table-bordered table-condensed" id="htmltable2"  style="display:none">
                     <thead>
                         <tr class="info">
                             <th align="center">Период</th>
                             <th align="center">Вид документа</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                     <tbody>
                     {* тут данные с js-скрипта *}
                     </tbody>
                 </table>					
				  </div>
				</div>
	    		<br>
	    				        
		    </div>

		    <div role="tabpanel" class="tab-pane fade" id="situation"><br>
		      	<div class="panel panel-danger">
				  <div class="panel-heading"><span class="label label-info"><strong>Акт сверки</strong></span></div>
				  <div class="panel-body">
					<form class="form-inline" role="form">
					  <div class="form-group">
					    <label  for="datetimepicker1">Период с:</label>
					    <input type="text" class="form-control" id="datetimepicker_1_3" value=""> {*  datetimepicker_№_tab№   *}
					  </div>
					  <div class="form-group">
					    <label  for="datetimepicker2">по:</label>
					    <input type="text" class="form-control" id="datetimepicker_2_3" value="">
					  </div>&nbsp;<button type="text" class="btn btn-success btn-sm" onclick="return UpdateField(3)">Показать</button>
					</form>		
					<hr>
					<p><i class="fa fa-calendar" aria-hidden="true"></i> Для просмотра необходимых актов сверки укажите период</p>
					<hr>
                 <table class="table table-bordered table-condensed" id="htmltable3"  style="display:none">
                     <thead>
                         <tr class="info">
                             <th align="center">Компания</th>
                             <th align="center">Тип документа</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                     <tbody>
                     {* тут данные с js-скрипта *}
                     </tbody>
                 </table>					
				  </div>
				</div>
	    		<br>
		    </div>
		  </div>
		
		</div>	
	
	</div>

    <script type="text/javascript" src="/js/numberFormat154.js"></script>     
    <script type="text/javascript">

	
	$(document).ready(function() {    

		$(function () {
			  $('[data-toggle="tooltip"]').tooltip();

		});


        $('#datetimepicker_1_1').datetimepicker({
        	format: 'DD.MM.YYYY',
        	defaultDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            minDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            locale: 'ru'
        });
        $('#datetimepicker_2_1').datetimepicker({
            //useCurrent: false, //Important! See issue #1075
        	format: 'DD.MM.YYYY',
            defaultDate: "{$docs.maxdate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            minDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            locale: 'ru'
        });
        $("#datetimepicker_1_1").on("dp.change", function (e) {
            $('#datetimepicker_2_1').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker2").on("dp.change", function (e) {
            $('#datetimepicker_1_1').data("DateTimePicker").maxDate(e.date);
        });

         $('#datetimepicker_1_2').datetimepicker({
        	format: 'DD.MM.YYYY',
        	defaultDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            minDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            locale: 'ru'
        });
        $('#datetimepicker_2_2').datetimepicker({
            //useCurrent: false, //Important! See issue #1075
        	format: 'DD.MM.YYYY',
            defaultDate: "{$smarty.now|date_format:"%Y-%m-%d"}}",
            minDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            locale: 'ru'
        });
        $("#datetimepicker_1_1").on("dp.change", function (e) {
            $('#datetimepicker_2_1').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker2").on("dp.change", function (e) {
            $('#datetimepicker_1_1').data("DateTimePicker").maxDate(e.date);
        });

         $('#datetimepicker_1_3').datetimepicker({
        	format: 'DD.MM.YYYY',
        	defaultDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            minDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            locale: 'ru'
        });
        $('#datetimepicker_2_3').datetimepicker({
            //useCurrent: false, //Important! See issue #1075
        	format: 'DD.MM.YYYY',
            defaultDate: "{$smarty.now|date_format:"%Y-%m-%d"}",
            minDate: "{$docs.mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
            locale: 'ru'
        });
        $("#datetimepicker_1_1").on("dp.change", function (e) {
            $('#datetimepicker_2_1').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker2").on("dp.change", function (e) {
            $('#datetimepicker_1_1').data("DateTimePicker").maxDate(e.date);
        });


		
        var tab_id = 1;   

        var a = [];
        a[1] = 'Январь ';
        a[2] = 'Февраль ';
        a[3] = 'Март ';
        a[4] = 'Апрель ';
        a[5] = 'Май ';
        a[6] = 'Июнь ';
        a[7] = 'Июль ';
        a[8] = 'Август ';
        a[9] = 'Сентябрь ';
        a[10] = 'Октябрь ';
        a[11] = 'Ноябрь ';
        a[12] = 'Декабрь ';    

		UpdateField = function(id_tab) {
			
			tab_id = id_tab;
			
			var url = '/ajax/index.php';       

			  $.getJSON( url, {
				  'action': 'get_invoice_'+tab_id,
				  'mindate': $("#datetimepicker_1_"+tab_id).val(),
				  'maxdate': $("#datetimepicker_2_"+tab_id).val(),
				  format: "json"
				  })
			    .done(function( data ) {
			    	$('#htmltable'+tab_id).show();
			    	$('#htmltable'+tab_id+' tbody > tr').remove();
			    	var items = [];
			    	var summ = 0;
			    	if (tab_id == 1) {
					    $.each( data, function( i, item ) {
					    	  items.push( "<tr"+(item['pay_status']==0?'':' class="success"')+"><td>" + item['id'] + "</td><td>" + item['inv_date2'] + "</td><td>" + (item['inv_pay_date']==null?'-':item['inv_pay_date']) + "</td><td>" + (item['pp_number']==null?'-':item['pp_number']) + "</td><td>" + item['inv_sum'].replace(/,/g," ") + "</td><td>" + (item['pay_status']==0?'Не оплачен':'Оплачен') + "</td><td>"+'<a class="btn btn-primary" target=_blank href="/ajax/invoice.php?print=1&id='+item['id']+'" role="button" id="inv-lnk" target="_blank"><span class="glyphicon glyphicon-print" aria-hidden="true"> Посмотреть</span></a> <a class="btn btn-success" href="/ajax/get_inv.php?id='+item['id']+'" role="button" id="inv-lnk2" target="_blank"><span class="fa fa-file-excel-o" aria-hidden="true"> Скачать в Excel</span></a> <a class="btn btn-danger" href="/ajax/invoice.php?id='+item['id']+'" role="button" id="inv-lnk3" target="_blank"><span class="fa fa-file-pdf-o" aria-hidden="true"> Скачать в PDF</span></a></td></tr>' );
					    	  summ += parseFloat(item['flsumm']);
					    });
					    $('#htmltable'+tab_id+' tbody').html(items.join( "" ));
						var num = new NumberFormat();
						num.setInputDecimal('.');
						num.setNumber(summ); // obj.value is '5450.26'
						num.setPlaces('2', true);
						num.setCurrencyValue('$');
						num.setCurrency(false);
						num.setCurrencyPosition(num.LEFT_OUTSIDE);
						num.setNegativeFormat(num.PARENTHESIS);
						num.setNegativeRed(false);
						num.setSeparators(true, ',', '.');
						//obj.value = num.toFormatted();
						$("#flsumm").text(num.toFormatted().replace(/,/g," "));
			    	}
			    	if (tab_id == 2) {
					    $.each( data, function( i, item ) {
					    	if (item['is_file'] == '1') {
					    	  items.push( "<tr><td>" + a[item['inv_m']] +item['inv_date2'] + "</td><td>Универсальный передаточный документ №" + item['id'] + " (файл: " + item['file_name'] + ")</td><td>"+'<a class="btn btn-info" href="/files/'+item['file_name_real']+'" target="_blank" role="button" id="inv-lnk19"><span class="fa fa-file-pdf-o" aria-hidden="true"> Скачать файл</span></a></td></tr>' );
					    	}
					    	else {
					    		items.push( "<tr><td>" + a[item['inv_m']] +item['inv_date2'] + "</td><td>Универсальный передаточный документ №" + item['id'] + "</td><td>"+'<a class="btn btn-danger" href="/ajax/upd.php?id='+item['id']+'" target="_blank" role="button" id="inv-lnk19"><span class="fa fa-file-pdf-o" aria-hidden="true"> Скачать в PDF</span></a></td></tr>' );
					    	}
					    });
					    if (items.length > 0) {
					    	$('#htmltable'+tab_id+' tbody').html(items.join( "" ));
					    }
					    else {
					    	$('#htmltable'+tab_id+' tbody').html("<tr><td colspan=3>За выбранный период документов не найдено!</td></tr>");
					    }
						    
			    	}
			    	if (tab_id == 3) {
					    $.each( data, function( i, item ) {
					    	  items.push( "<tr><td>" + item['comp_name'] + "</td><td>Акт сверки взаиморасчетов</td><td>"+'<a class="btn btn-danger" href="/ajax/act.php?id='+item['url']+'" target="_blank" role="button"><span class="fa fa-file-pdf-o" aria-hidden="true"> Скачать в PDF</span></a> <a class="btn btn-info" href="/ajax/act.php?id='+item['url']+'&print=1" target="_blank" role="button"><span class="fa fa-file-pdf-o" aria-hidden="true"> Посмотреть</span></a></td></tr>' );
					    });
					    if (items.length > 0) {
					    	$('#htmltable'+tab_id+' tbody').html(items.join( "" ));
					    }
					    else {
					    	$('#htmltable'+tab_id+' tbody').html("<tr><td colspan=3>За выбранный период документов не найдено!</td></tr>");
					    }
						    
			    	}				    	
				      
			});

				return false;

		}


		    

	    
	});

    </script>
