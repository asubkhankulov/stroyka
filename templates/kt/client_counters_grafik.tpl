<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

	{if !empty($pribor)}
	
	<h4>{$pribor.mesto_ustanovki} - {$pribor.pribor} <span {if $pribor.maxdate == $today}class="label label-success" title="Есть данные за текущие сутки" {else}class="label label-default" title="Нет данных за текущие сутки"{/if} data-toggle="tooltip" data-placement="top">{if $pribor.maxdate == $today}Работает{else}Не работает{/if}</span>
	Суммарный расход, м3: <span class="label label-info">{if $inf_balance>0}{$pribor.vol|default:"нет данных"}{else}****{/if}</span></h4>
<hr>

	{include file='dop_menu.tpl'}

	<hr>
	{if $inf_balance>0}
	
	{if !empty($pribor.maxdate)}
	<form class="form-inline" role="form">
	  <div class="form-group">
	    <label  for="datetimepicker1">Период с:</label>
	    <input type="text" class="form-control" id="datetimepicker1" value="{$pribor.mn}">
	  </div>
	  <div class="form-group">
	    <label  for="datetimepicker2">по:</label>
	    <input type="text" class="form-control" id="datetimepicker2" value="{$pribor.mx}">
	    <button type="text" class="btn btn-success btn-sm" onclick="return generateChartData(true)">Сформировать</button>
	  </div>
	</form>
	<hr>

	<form class="form-inline" role="form">
	  <div class="form-group">
	    <label  for="inlineRadio1">Тип данных:</label>
	<label class="radio-inline">
	  <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1" disabled> Поминутный
	</label>
	<label class="radio-inline">
	  <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="1" checked> Почасовой
	</label>
	<label class="radio-inline">
	  <input type="radio" name="inlineRadioOptions" id="inlineRadio3" value="2"> Посуточный
	</label>  </div>
	</form>	
	  <hr>
	<div class="row">

		<div id="showtabs"><br/>
		  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab"><i class="fa fa-bar-chart" aria-hidden="true"></i> График расхода</a></li>
		    <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab"><i class="fa fa-table" aria-hidden="true"></i> Табличные данные</a></li>
		    <li role="presentation"><a href="#situation" aria-controls="situation" role="tab" data-toggle="tab"><i class="glyphicon glyphicon-warning-sign" aria-hidden="true"></i> Нештатные ситуации</a></li>
		  </ul>
		
		  <!-- Tab panes -->
		  <div class="tab-content">
		    <div role="tabpanel" class="tab-pane fade in active" id="home">
		       	<div style="margin-left:40px;"><br>
			       	<b>Вид графика:</b> 
		            <button type="text" class="btn btn-default btn-sm active" id="rb1" onclick="setDepth(1)" title="График с колонками"><i class="fa fa-bar-chart fa-3x" aria-hidden="true"></i></button>
		            <button type="text" class="btn btn-default btn-sm" id="rb2" onclick="setDepth(2)" title="График с линиями"><i class="fa fa-line-chart fa-3x" aria-hidden="true"></i></button>
				</div>  
	    		<div id="chartdiv" style="width: 100%; height: 400px;"></div>
		    </div>
      
		    <div role="tabpanel" class="tab-pane fade" id="profile"><br>
                    <table class="table table-striped table-bordered table-condensed" id="tabl_data" style="display:none">
                        <thead>
                            <tr class="info">
                                <th>Дата и время</th>
                                <th align="center">Расход, м3</th>
                                <th>Расход с нарастающим итогом, м3</th>
                                <th>В рабочем состоянии, <span id="hhdd">мин.</span></th>
                                <th>В не рабочем состоянии, <span id="hhdd2">мин.</span></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                     <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td class="info" id="flsumm"></td>
                             <td class="info" id="flsumm1"></td>
                             <td class="info" id="flsumm2"></td>
                             <td class="info" id="flsumm3"></td>
                         </tr>
                         <tr class="active" id="hours">
                             <td colspan="3"><b>Итого часов:</b></td>
                             <td class="info" id="flsumm_1"></td>
                             <td class="info" id="flsumm_2"></td>
                         </tr>
                     </tfoot>
                    </table>	
                    
                    <div>
                    <a href="#" class="btn btn-info btn-sm" role="button" target="_blank" id="print_tabl" style="display:none"><i class="fa fa-print" aria-hidden="true"></i> Распечатать</a>
                    <a href="#" class="btn btn-danger btn-sm" role="button" id="print_tabl_pdf" target="_blank" style="display:none"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> Сохранить в PDF</a>
                    </div>	    
		        
		    </div>

		    <div role="tabpanel" class="tab-pane fade" id="situation"><br>
                  <table class="table table-striped table-bordered" id="tabl_errors" style="display:none">
                        <thead>
                            <tr class="info">
                                <th>Дата и время</th>
                                <th align="center">Событие</th>
                                <th>Причина</th>
                                <th>Время отключения, часов</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                     <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td></td>
                             <td></td>
                             <td class="info" id="flsumm6"></td>
                         </tr>
                     </tfoot>
                    </table>
                    <div>
                    <a href="#" class="btn btn-info btn-sm" role="button" target="_blank" id="print_err" style="display:none"><i class="fa fa-print" aria-hidden="true"></i> Распечатать</a>
                    <a href="#" class="btn btn-danger btn-sm" role="button" id="print_err_pdf" target="_blank" style="display:none"><i class="fa fa-file-pdf-o" aria-hidden="true"></i> Сохранить в PDF</a>
                    </div>	    
                    
		    </div>
		  </div>
		
		</div>	
	
	</div>

        <script src="/js/amcharts/amcharts.js" type="text/javascript"></script>
        <script src="/js/amcharts/serial.js" type="text/javascript"></script>
        <script src="/js/amcharts/lang/ru.js" type="text/javascript"></script>
        <script src="/js/dataloader.min.js" type="text/javascript"></script>
        
        <script type="text/javascript" src="/js/NumberFormat154.js"></script>    
        
    <script type="text/javascript">

	function generateChartData(mode) {

		
		var chartData = [];
	    var typeDate = $( "input:radio[name=inlineRadioOptions]:checked" ).val();

	    if (!mode) return false;
	    $('#showtabs').show();
	    $('#print_tabl').attr("href","/ajax/print_tabl.php?print=1&serial="+{$pribor.serial_number}+"&mindate="+$('#datetimepicker1').val()+"&maxdate="+$('#datetimepicker2').val()+"&typedate="+typeDate+"&cnt_id="+{$pribor.id}).show();
	    $('#print_tabl_pdf').attr("href","/ajax/print_tabl.php?serial="+{$pribor.serial_number}+"&mindate="+$('#datetimepicker1').val()+"&maxdate="+$('#datetimepicker2').val()+"&typedate="+typeDate+"&cnt_id="+{$pribor.id}).show();

	    $('#print_err').attr("href","/ajax/print_errors.php?print=1&serial="+{$pribor.serial_number}+"&mindate="+$('#datetimepicker1').val()+"&maxdate="+$('#datetimepicker2').val()+"&typedate="+typeDate+"&cnt_id="+{$pribor.id}).show();
	    $('#print_err_pdf').attr("href","/ajax/print_errors.php?serial="+{$pribor.serial_number}+"&mindate="+$('#datetimepicker1').val()+"&maxdate="+$('#datetimepicker2').val()+"&typedate="+typeDate+"&cnt_id="+{$pribor.id}).show();
	    

		url = '/ajax/index.php';       
	    $.post(url,
	    {
	        'action': 'getchart',
	        'serial': {$pribor.serial_number},
	        'mindate': $('#datetimepicker1').val(),
	        'maxdate': $('#datetimepicker2').val(),
	        'typedate': typeDate
	        
	    }, checkTime = function(data) {
			//alert(data);
			var plusstr = '';
			if (data) {
	            chart.dataProvider = data;
	            if (typeDate == '1') {
	            	chart.dataDateFormat = "YYYY-MM-DD HH";
	            	chart.categoryAxis.minPeriod = "hh";
	            	$('#hours').show();
	            	$('#hhdd, #hhdd2').text('мин.');
	            	//plusstr = ":00:00";
	            }
	            else {
	            	$('#hours').hide();
	            	chart.dataDateFormat = "YYYY-MM-DD";
	            	chart.categoryAxis.minPeriod = "DD";
	            	$('#hhdd, #hhdd2').text('часов');
	            	
	            }
	            chart.validateData();

		    	var items = [];
		    	var summ = 0;
		    	var summ2 = 0;
		    	var summ_work = 0;
		    	var summ_dont_work = 0;
		    	var vol = 0;
		    	var ni = 0;
 
    			var num = new NumberFormat();
    			num.setInputDecimal('.');
    			 // obj.value is '5450.26'
    			num.setPlaces('3', true);
    			num.setCurrencyValue('$');
    			num.setCurrency(false);
    			num.setCurrencyPosition(num.LEFT_OUTSIDE);
    			num.setNegativeFormat(num.PARENTHESIS);
    			num.setNegativeRed(false);
    			num.setSeparators(true, ',', '.');		    	
		    	
		    	$('#tabl_data').show();
			    $.each( data, function( i,item ) {
			    	  num.setNumber((item['vol'] != undefined ? item['vol'] : 0))
			    	  vol = num.toFormatted().replace(/,/g," ");
			    	  num.setNumber((item['ni'] != undefined ? item['ni'] : 0))
			    	  ni = num.toFormatted().replace(/,/g," ");
			    	  items.push( "<tr><td>" + item['data_rus'] + "</td><td>" + vol + "</td><td>" + ni + "</td><td>" + item['work'] + "</td><td>" + item['dont_work'] + "</td></tr>" );
			    	  summ = parseFloat(item['ni']);
			    	  summ2 += parseFloat((item['vol'] != undefined ? item['vol'] : 0));
			    	  summ_work += parseFloat(item['work']);
			    	  summ_dont_work += parseFloat(item['dont_work']);
			    	  //console.log(item);
			    	  
			    });
			    summ = summ == 0 ? summ2 : summ;
			    $('#tabl_data'+' tbody').html(items.join( "" ));


			    num.setNumber(summ)
			    $('#flsumm').text(num.toFormatted().replace(/,/g," "));
			    //$('#flsumm').text(summ);
			    if (typeDate == '1') {

				    num.setPlaces('0', true);
				    num.setNumber(summ_work);
				    $('#flsumm2').text(num.toFormatted().replace(/,/g," "));
				    num.setNumber(summ_dont_work);
				    $('#flsumm3').text(num.toFormatted().replace(/,/g," "));

				    num.setPlaces('2', true);
				    num.setNumber(summ_work/60);
				    $('#flsumm_1').text(num.toFormatted().replace(/,/g," "));
				    num.setNumber(summ_dont_work/60);
				    $('#flsumm_2').text(num.toFormatted().replace(/,/g," "));
				    
			    }	
			    else {
				    num.setPlaces('2', true);
				    num.setNumber(summ_work);
				    $('#flsumm2').text(num.toFormatted().replace(/,/g," "));
				    num.setNumber(summ_dont_work);
				    $('#flsumm3').text(num.toFormatted().replace(/,/g," "));

			    }		    
	            
			}
			else {
				alert('Error in chart data!');
			}
		}, "json");

	    $.post(url,
	    	    {
	    	        'action': 'getchart_errors',
	    	        'serial': {$pribor.serial_number},
	    	        'mindate': $('#datetimepicker1').val(),
	    	        'maxdate': $('#datetimepicker2').val()
	    	    }, checkTime = function(data) {
	    			//alert(data);
	    			if (data) {

	    		    	var items = [];
	    		    	var c = 0;
	    		    	var summ = 0;
	    		    	
	    		    	
	    		    	$('#tabl_errors').show();
	    			    $.each( data, function( i,item ) {
	    			    	  //items.push( "<tr><td>" + item['data'] + "</td><td>" + item['D7OffDateTime'] + "</td><td>" + item['D7NSType'] + "</td><td>" + item['D7OffCause'] + "</td><td>" + (item['pros'].replace(",", "") > 0?item['pros'].replace(",", ""):'0')  + "</td></tr>" );
	    			    	  //items.push( "<tr><td>" + item['data'] + "</td><td>" + item['D7NSType'] + "</td><td>" + item['D7OffCause'] + "</td><td>" + (item['pros'].replace(",", "") > 0?item['pros'].replace(",", ""):'0')  + "</td></tr>" );
	    			    	  //items.push( "<tr><td>" + item['data'] + "</td><td>" + item['D7NSType'] + "</td><td>" + item['D7OffCause'] + "</td><td>" + item['pros'] + "</td></tr>" );
	    			    	  //summ += parseFloat(item['pros'].replace(",", ""));
	    			    	  //console.log(item);
	    			    	  if (item['pros'] != undefined) {
		    			    	  items.push( "<tr><td>" + item['data'] + "</td><td>" + item['D7NSType'] + "</td><td>" + item['D7OffCause'] + "</td><td>" + item['pros'] + "</td></tr>" );
	    			    	  }
	    			    	  else  summ = item['pros_all'];	    			    	  
	    			    	  
	    			    });

	    			    if (items.length == 0) items.push( "<tr><td colspan='4'>За выбранный период нет данных по авариям!</td></tr>" );
	    			    $('#flsumm6').text(summ);
	    			    
	    			    $('#tabl_errors'+' tbody').html(items.join( "" ));

	    	            
	    			}
	    			else {
	    				alert('Error in chart data!');
	    			}
	    		}, "json");		

	    return false;
	}

	var chart;
	AmCharts.ready(function () {
	    // SERIAL CHART
	    chart = new AmCharts.AmSerialChart();
	    chart.dataProvider = generateChartData(false);
	    
	    chart.categoryField = "data";
	    chart.language = "ru";
	    //chart.marginRight = 0;
	    //chart.marginTop = 0;
	    //chart.autoMarginOffset = 0;
	    chart.dataDateFormat = "YYYY-MM-DD HH";
	    // the following two lines makes chart 3D
	    //chart.depth3D = 20;
	    //chart.angle = 30;

	    // AXES
	    // category
	    var categoryAxis = chart.categoryAxis;
	    //categoryAxis.labelRotation = 90;
	    categoryAxis.dashLength = 5;
	    categoryAxis.gridPosition = "start";
	    categoryAxis.parseDates = true,
	    categoryAxis.minPeriod = "hh";

	    
	    // value
	    var valueAxis = new AmCharts.ValueAxis();
	    valueAxis.title = "Расход, м3";
	    valueAxis.dashLength = 5;
	    chart.addValueAxis(valueAxis);

	    // GRAPH            
	    var graph = new AmCharts.AmGraph();
	    graph.valueField = "vol";
	    graph.colorField = "color";
	    graph.balloonText = "[[category]]: [[value]]";
	    graph.type = "column";
	    graph.lineAlpha = 0;
	    graph.fillAlphas = 1;
	    chart.addGraph(graph);

        var graph2 = new AmCharts.AmGraph();
        graph2.type = "line";
        graph2.title = "Расход";
        graph2.lineColor = "#FF6600";
        graph2.valueField = "vol";
        graph2.lineThickness = 2;
        graph2.bullet = "round";
        graph2.bulletBorderThickness = 1;
        graph2.connect = false;
        //graph2.hidden = true;
        graph2.bulletBorderColor = "#FF6600";
        graph2.bulletBorderAlpha = 1;
        graph2.bulletColor = "#FF6600";
        graph2.dashLengthField = "dashLengthLine";
        graph2.balloonText = "<span style='font-size:13px;'>[[title]] [[category]]:<b>[[value]]</b> [[additional]]</span>";
        chart.addGraph(graph2);	    

        // SCROLLBAR
        var chartScrollbar = new AmCharts.ChartScrollbar();
        chart.addChartScrollbar(chartScrollbar);	    


	    // WRITE
	    chart.write("chartdiv");
	    chart.hideGraph(chart.graphs[1]);
	});
	

    function setDepth(id) {
        if (id == 1) {
           chart.hideGraph(chart.graphs[1]);
           chart.showGraph(chart.graphs[0]);
           $('#rb'+(id+1)).removeClass('active');
           $('#rb'+id).addClass('active');
         } else {
           chart.hideGraph(chart.graphs[0]);
           chart.showGraph(chart.graphs[1]);
           $('#rb'+(id-1)).removeClass('active');
           $('#rb'+id).addClass('active');
        }
        chart.validateNow();
    } 	


	
	$(document).ready(function() {    

		$('#showtabs').hide();

		$(function () {
			  $('[data-toggle="tooltip"]').tooltip();

		});

		$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
			   // newly activated tab
			  //console.log(e.target);
				  //alert($(e.target).attr("href"));
		});		


        $('#datetimepicker1').datetimepicker({
        	format: 'YYYY-MM-DD HH:mm',
        	defaultDate: "{$pribor.mn}",
            minDate: "{$pribor.mn}",
            locale: 'ru'
        });
        $('#datetimepicker2').datetimepicker({
            //useCurrent: false, //Important! See issue #1075
        	format: 'YYYY-MM-DD HH:mm',
            defaultDate: "{$pribor.mx}",
            minDate: "{$pribor.mn}",
            locale: 'ru'
        });
        $("#datetimepicker1").on("dp.change", function (e) {
            $('#datetimepicker2').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker2").on("dp.change", function (e) {
            $('#datetimepicker1').data("DateTimePicker").maxDate(e.date);
        });

        $('#data_poverki').datetimepicker({
        	format: 'YYYY-MM-DD',
            locale: 'ru'
        });
        $('#data_vypuska').datetimepicker({
        	viewMode: 'years',
        	format: 'YYYY',
            locale: 'ru'
        });


		
		var field = '';        

		UpdateField = function(field_name, obj) {
			
			var val = $("#"+field_name).val();
			if (field != '') $(field).tooltip('hide');
			field = obj;
			
			
			url = '/ajax/index.php';       
            $.post(url,
            {
                'action': 'update_field_cnt',
                'field': field_name,
                'id': {$pribor.id},
                'val': val
            }, checkTime = function(data) {
				//alert(data);
				if (data = 'ok') {
					$(field).tooltip('show');
				}
				else {
					$(field).tooltip(data);
				}
			});
		}    

	    
	});

    </script>
    	{else}
		<div class="alert alert-info" role="alert">Нет данных с прибора для просмотра отчётов!</div>

		{/if}
		{else}
		<div class="alert alert-info" role="alert">

Здравствуйте!<br>  
Информируем Вас о том, что баланс Вашего лицевого счета составляет: {$inf_balance} руб.<br>
В связи с этим предоставление услуг приостановлено с {$smarty.now|date_format:"%d.%m.%Y"}.<br>
Напоминаем Вам, что работа услуг обеспечивается только при наличии средств на лицевом счете.<br>
Для того чтобы Вы могли просматривать данные с Ваших приборов рекомендуем пополнить баланс.<br>
Пополнить баланс Вы можете в профиле пользователя в разделе «Финансы».<br>
Благодарим за сотрудничество!<br>
<a href="/finance/" role="btn" class="btn btn-success">Пополнить</a><br>
--<br>
С уважением,<br>
Команда системы ОДИС <br>
support@odis24.ru<br>
		</div>
		{/if}
	{else}
	<div class="alert alert-danger" role="alert">Нет доступа!</div>

	{/if}