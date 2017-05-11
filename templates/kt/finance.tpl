            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            
             <h4  class="page-header">Профиль пользователя: {$item.comp_name}</h4>
             <p><strong>Состояние счёта:</strong></p>
             <p>Баланс: {$inf_balance|default:0} руб.</p>
             <p>Расход: {$pribor.itogo|default:0} руб./мес</p>
             {*<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{$balans_day.itogo|default:0} руб./день</p>*}
               
			<h3  class="page-header">Управление услугами</h3>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                            <tr class="info">
                                <th style="width: 20%">Плательщик</th>
                                <th style="width: 15%" align="center">Количество приборов</th>
                                <th>Стоимость ежемесячного обслуживания приборов учёта в месяц, рублей </th>
                                <th>Период, мес.</th>
                                <th>Сумма счёта, рублей</th>
                            </tr>
                        </thead>
                        <tbody>
                        
                            <tr>
                                <td>{$item.comp_name}</td>
                                <td align="center"><a href="/">{$item.col_cnt}</a></td>
                                <td align="center">{$pribor.itogo}</td>
                                <td>
                                	<select class="form-control" name="period" id="period" onchange="ChangeSumm(this.value)">
                                		<option value="1" selected>1 мес.</option>
                                		<option value="3">3 мес.</option>
                                		<option value="6">6 мес.</option>
                                		<option value="9">9 мес.</option>
                                		<option value="12">12 мес.</option>
                                	</select>
                                
                                </td>
                                <td align="center" id="summa"></td>
                            </tr>
                           
                        </tbody>
                    </table>
                </div>
            
             <p><button type="button" class="btn btn-success" id="inv-do"><i class="fa fa-rub" aria-hidden="true"></i> Выставить счёт</button></p>
       
	            <div class="col-sm-7" id="mmm" style="display: none">
					<div class="alert alert-default alert-dismissible" role="alert" id="myAlert">
					 	<button type="button" class="close" onclick="$('#mmm').hide();" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<div class="panel panel-default">
						  <!-- Default panel contents -->
						  <div class="panel-heading">Выставлен счёт № <span id="inv-num"></span></div>
						
						  <!-- Table -->
						  <table class="table">
			                            <tr>
			                                <td>Сумма счёта:</td>
			                                <td id="inv-sum">5000</td>
			                            </tr>
			                            <tr>
			                                <td>Счёт:</td>
			                                <td>
			                                	<a class="btn btn-primary" href="#" role="button" id="inv-lnk" target="_blank"><span class="glyphicon glyphicon-print" aria-hidden="true"> Распечатать</span></a>
			                                	<a class="btn btn-success" href="#" role="button" id="inv-lnk2" target="_blank"><span class="fa fa-file-excel-o" aria-hidden="true"> Скачать в Excel</span></a>
			                                	<a class="btn btn-danger" href="#" role="button" id="inv-lnk3" target="_blank"><span class="fa fa-file-pdf-o" aria-hidden="true">Скачать в PDF</span></a>
			                                	<button class="btn btn-default" id="inv-lnk3" data-toggle="modal" data-target="#cntdlg" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Письмо отправлено!"><span class="fa fa-envelope-o" aria-hidden="true"> Отправить по электронной почте</span></button>
			                                </td>
			                            </tr>
			                            <tr>
			                                <td>Плательщик:</td>
			                                <td>{$item.comp_name}</td>
			                            </tr>	                            
			                            <tr class="info">
			                                <td>Информация:</td>
			                                <td>Все выставленные счета можно увидеть на странице <a href="/docs/" role="button"><i class="fa fa-briefcase" aria-hidden="true"></i> Документы</a></td>
			                            </tr>	                            
						  </table>
						</div>
					</div>
				</div>
				 </div>
				<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				
<hr>
<h4  class="page-header">Движения средств по счёту {$item.comp_name}</h4>    

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
					<p><i class="fa fa-calendar" aria-hidden="true"></i> Для просмотра данных о движении средств укажите период</p>
					<hr>
                 <table class="table table-bordered" id="htmltable" style="display:none">
                     <thead>
                         <tr class="info" align="center">
                             <th rowspan="2" align="center">Дата</th>
                             <th colspan="2" align="center">Состояние счёта, руб.</th>
                         </tr>
                         <tr class="info" align="center">
                             <th align="center">Поступление</th>
                             <th align="center">Списание</th>
                         </tr>
                     </thead>
                     <tbody>
                     <tr>
                     <td>1</td>
                     <td>2</td>
                     <td>3</td>
                     </tr>
                     {* тут данные с js-скрипта *}
                     </tbody>
                     <tfoot>
                         <tr class="active">
                             <td><b>Итого</b></td>
                             <td class="info" id="flsummpost"></td>
                             <td class="info" id="flsummspis"></td>
                         </tr>
                         <tr class="active">
                             <td><b>Итого баланс за период</b></td>
                             <td colspan="2" class="info" id="flsumm"></td>
                         </tr>
                     </tfoot>
                 </table>
                 		</div>		
            
           
            
            
            
            <div class="modal fade" tabindex="-1" role="dialog" id="cntdlg" aria-labelledby="exampleModalLabel1">
  <div class="modal-dialog">
    <div class="modal-content modal-md">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel1">Отправить счёт на почту</h4>
      </div>
      <div class="modal-body">
			<div class="input-group col-xs-12">
				<span class="input-group-addon hidden-xs">Укажите адрес почты</span>
				<input type="email" class="form-control input-sm" name="email" value="{$item.login_mail}" id="email" placeholder="Укажите адрес почты" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required autofocus />
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
        <button type="button" class="btn btn-primary" id="add">Отправить</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->           
	<script type="text/javascript" src="/js/NumberFormat154.js"></script>            
    <script type="text/javascript">

    var selSumm = 0;
    var col_cnt = {$item.col_cnt|default:0};
    ChangeSumm(1);

	function ChangeSumm(cnt_mes) {
		var itogo = parseFloat({$pribor.s|default:0}); //стоимость обслуживания в 1 мес

		selSumm = itogo * cnt_mes;
		//$("#summa").text(selSumm);

		var num = new NumberFormat();
		num.setInputDecimal('.');
		num.setNumber(selSumm); // obj.value is '5450.26'
		num.setPlaces('2', true);
		num.setCurrencyValue('$');
		num.setCurrency(false);
		num.setCurrencyPosition(num.LEFT_OUTSIDE);
		num.setNegativeFormat(num.PARENTHESIS);
		num.setNegativeRed(false);
		num.setSeparators(true, ',', '.');
		//obj.value = num.toFormatted();
		$("#summa").text(num.toFormatted().replace(/,/g," "));

		
		return selSumm;

		
	}

    $(document).ready(function() {            


		$(function () {
			  $('[data-toggle="tooltip"]').tooltip()
		});

        $('#datetimepicker_1_1').datetimepicker({
        	format: 'DD.MM.YYYY',
        	defaultDate: "{$docs.mindate}",
            minDate: "{$docs.mindate}",
            locale: 'ru'
        });
        $('#datetimepicker_2_1').datetimepicker({
            //useCurrent: false, //Important! See issue #1075
        	format: 'DD.MM.YYYY',
            defaultDate: "{$docs.maxdate}",
            minDate: "{$docs.mindate}",
            locale: 'ru'
        });
        $("#datetimepicker_1_1").on("dp.change", function (e) {
            $('#datetimepicker_2_1').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker2").on("dp.change", function (e) {
            $('#datetimepicker_1_1').data("DateTimePicker").maxDate(e.date);
        });

		UpdateField = function(id_tab) {
			
			
			var url = '/ajax/index.php';       

			  $.getJSON( url, {
				  'action': 'get_billing',
				  'mindate': $("#datetimepicker_1_1").val(),
				  'maxdate': $("#datetimepicker_2_1").val(),
				  'userid': {$item.id},
				  format: "json"
				  }){literal}
			    .done(function( data ) {
			    	$('#htmltable').show();
			    	$('#htmltable tbody > tr').remove();
			    	var items = [];
			    	var summ = 0;
			    	var summpost = 0;
			    	var summspis = 0;
				    $.each( data, function( i, item ) {
					    if (i != "all" && i != "alls" && i != "allp") {
						    items.push( "<tr><td>" + i + "</td><td>" + item['p'] + "</td><td>" + item['r'] + "</td></tr>" );
						    //summpost += parseFloat(item['p']); 
						    //summspis += parseFloat(item['r']); 
					    }
					    else {
					    	if (i == "all") {summ = item['all'];}
					    	if (i == "alls") {summspis = item['alls'];}
					    	if (i == "allp") {summpost = item['allp'];}
					    }
				    	  //summ += parseFloat(item['p']) + parseFloat(item['r']);
				    });
				    $('#htmltable'+' tbody').html(items.join( "" ));
					
					$("#flsumm").text(summ);

					$("#flsummpost").text(summpost);
	
					$("#flsummspis").text(summspis);

				      
			});
			    {/literal}
				return false;

		}

		    var globID = 0; //ид последнего счтёчика
		    
		    $('#add').on('click', function () {
			       
				email_name = $("#email").val();
				
			    if (email_name != '' && globID > 0) {
			    	$("#email").tooltip('hide');
			    	var $btn = $(this).button('Отправляю...');
					url = '/ajax/get_inv.php';       
			        $.post(url,
			        {
			            'action': 'email',
			            'id': globID,
			            'email': email_name
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data == 'ok')  { 
			        		 $('#cntdlg').modal('hide');
			        		 $('#inv-lnk3').tooltip('show');
			        		 $btn.button('reset');
				         }
			        	 else { //alert(data);
			        	 	$("#success-alert").text('Произошла ошибка: ' + data);
			        	 }
			        	 

					}

					);

			    }
			    else {
			    	$("#email").tooltip('show');
			    }
			    
		    });		   
		
		    $('#inv-do').click(function() {

		
		    	$('#mmm').hide();
			    if (selSumm > 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'add_inv',
			            'summ': selSumm
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data.result == 'ok')  { 


			        			var num = new NumberFormat();
			        			num.setInputDecimal('.');
			        			num.setNumber(data.summ); // obj.value is '5450.26'
			        			num.setPlaces('2', true);
			        			num.setCurrencyValue('$');
			        			num.setCurrency(false);
			        			num.setCurrencyPosition(num.LEFT_OUTSIDE);
			        			num.setNegativeFormat(num.PARENTHESIS);
			        			num.setNegativeRed(false);
			        			num.setSeparators(true, ',', '.');
			        			
			        		 $('#inv-sum').text(num.toFormatted().replace(/,/g," "));
			        		 $('#inv-num').text(data.id);
			        		 globID = data.id;
			        		 $('#inv-lnk').attr('href',"/ajax/invoice.php?print=1&id=" + data.id);
			        		 $('#inv-lnk2').attr('href',"/ajax/get_inv.php?id=" + data.id);
			        		 $('#inv-lnk3').attr('href',"/ajax/invoice.php?id=" + data.id);
			        		 $('#mmm').show();

				         }
			        	 else { //alert(data);
			        	 	alert('Произошла ошибка!');
			        	 }
			        	 

					}, "json"

					);

			    }
			    else {
			    	alert('Сумма счета 0!');
			    }
		  });
	});

    </script>            