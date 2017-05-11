            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
{include file='dop_menu_orders.tpl'} 
<hr>        
					<!--form class="form-inline" role="form" action="/orders/" method="GET" >
					  <div class="form-group">
					    <label for="mindate">Период:</label>
					    <input type="text" class="form-control" name="mindate" id="datetimepicker_1" value="">
					  </div>
					  <div class="form-group">
					    <label for="maxdate">-</label>
					    <input type="text" class="form-control" name="maxdate" id="datetimepicker_2" value="">
					  </div>&nbsp;<button type="text" class="btn btn-success btn-sm" onclick="return UpdateField(1)">Показать</button>
					</form-->		
					<hr>
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>Материал</th>
                             <th align="center">Тип</th>
                             {foreach from=$uchastki key=uchID item=i}
							  <th align="center">{$i.name}: {$i.pos} / {$i.prorab}</th>
							{/foreach}
                             
                             <th align="center">Итого</th>
                         </tr>
                     </thead>
                     <tbody>
					{if !empty($all_data)}
                        {foreach from=$all_data key=matID item=alld}
                            <tr>
                                <td><a href="#" title="перейти">{$alld.name}, {$alld.unit}</a> // {$alld.work} {$alld.enddatefakt}</td>
                                <td class="zak_matt">{$alld.type}</td>
		                             {foreach from=$uchastki key=uchID item=i}
									  	<td align="center" class="{$mat_uch_color[$matID][$uchID]}">{if isset($mat_uch[$matID][$uchID])}{$mat_uch[$matID][$uchID]}{else}-{/if}</td>
									 {/foreach}
                                
                                <td>{$mat_all[$matID]}</td>
                            </tr>
                        {/foreach}  {/if}                      
                        </tbody>
                    {* <tfoot>
                         <tr class="active">
                             <td><b>Итого</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                             <td></td>
                             <td></td>
                         </tr>
                     </tfoot>*}
                 </table>
                 
				<div class="well well-sm">
					<table class="table table-bordered">
					<tr><td class="danger">Работа не выполнена-заказ материала есть-материал не поставлен-не сделан ЗПОСТ</td></tr>
					<tr><td class="info">Работа выполнена-ЕСТЬ ДОП заказ материала-материал не поставлен-не сделан ЗПОСТ/сделан ЗПОСТ</td></tr>
					</table>
				</div>  	
	
                <div class="table-responsive{if empty($zpost)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
	                   <thead>
	                        <tr class="info" align="center">
	                        	<th>#</th>
	                        	<th style="width: 5%">№ док.</th>
                                <th align="center">Дата</th>
                                <th align="center">Необх. дата зак.</th>
                                <th align="center">Количество материалов в заказе, шт.</th>
                                <th align="center">Сумма, руб.</th>
                                <th align="center">Статус</th>
                                <th align="center">Примечание</th>
                                <th align="center">Ответсвенный</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                                
	                        </tr>

	                   </thead>
                    

                        <tbody>{if !empty($zpost)}
                        {section name=zpo loop=$zpost}
                            <tr id="zpost_{$zpost[zpo].id}">
                                <td>{{$smarty.section.zpo.iteration}}</td>
                                <td>{$zpost[zpo].id}</td>
                                <td><a href="/stroyka/zak/{$zpost[zpo].uchastok_id}/{$zpost[zpo].id}/">{$zpost[zpo].doc_date}</a></td>
                                <td>{$zpost[zpo].zakupkadate}</td>
                                <td>{$zpost[zpo].kols}</td>
                                <td>{$zpost[zpo].all_summ}</td>
                                <td></td>
                                <td></td>
                                <td>{$zpost[zpo].user}</td>
                                <td align="center"> <a href="/stroyka/zak/{$zpost[zpo].uchastok_id}/{$zpost[zpo].id}/" role="button" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$zpost[zpo].id}"><em class="fa fa-trash"></em></button></td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    </div>	
	                 
	
		                
            </div>
      
<div class="modal fade" tabindex="-1" role="dialog" id="deldlg" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog">
    <div class="modal-content modal-sm">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Диалог</h4>
      </div>
      <div class="modal-body">
        <p id="success-alert">Удаляем?&hellip;</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Нет</button>
        <button type="button" class="btn btn-primary" id="Del">Да</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

    <script type="text/javascript">
	$(document).ready(function() {            

		    var cnt_id = 0;
		   // var cnt_kol = {$smarty.section.cus.total};

			$(function () {
				  $('[data-toggle="tooltip"]').tooltip()
			});
			    
	        $('#datetimepicker_1').datetimepicker({
	        	format: 'YYYY-MM-DD',
	        	defaultDate: "{$mindate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
	            locale: 'ru'
	        });
	        $('#datetimepicker_2').datetimepicker({
	            //useCurrent: false, //Important! See issue #1075
	        	format: 'YYYY-MM-DD',
	            defaultDate: "{$maxdate|default:$smarty.now|date_format:"%Y-%m-%d"}}",
	            locale: 'ru'
	        });
	        $("#datetimepicker_1").on("dp.change", function (e) {
	            $('#datetimepicker_2').data("DateTimePicker").minDate(e.date);
	        });
	        $("#datetimepicker_2").on("dp.change", function (e) {
	            $('#datetimepicker_1').data("DateTimePicker").maxDate(e.date);
	        });	        
	
		    $("#deldlg").on('shown.bs.modal', function (event) {
		    	  var button = $(event.relatedTarget) // Button that triggered the modal
		    	  cnt_id = button.data('whatever') // Extract info from data-* attributes
		    });

			var field = '';        

			UpdateField_ = function(field_id, obj,iter) {
				
				cnt_id = iter;
				var val1 = $("#datetimepicker_"+cnt_id).val();
				var val2 = $("#datetimepicker_"+cnt_id+"_end").val();
				var val3 = $("#nedochet_"+cnt_id).val();
				var val4 = $("#v_work_"+cnt_id).val();
				var val5 = $("#price_"+cnt_id).val();
				var val6 = $("#shtraf_"+cnt_id).val();
				var val7 = $("#brigada_"+cnt_id).val();
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_real_work_real',
	                'id': field_id,
	                'val1': val1,
	                'val2': val2,
	                'val3': val3,
	                'val4': val4,
	                'val5': val5,
	                'val6': val6,
	                'val7': val7,
	            }, checkTime = function(data) {
					

	            	switch(data) {
	                case 'ok':
	                	$(field).tooltip('show');
	                    break
	                default:
	                	$(field).tooltip(data);
	            }


				});
			}

			SelectType = function() {
				
				var val = $("#type_material").val();
				
				if (val == 0) {
					$('tr.mat_all').show();
				}
				else {
					$('tr.mat_all').hide();
					$('tr.mat_type_'+val).toggle();
				}
				return false;
				

			}

			MakeZpost = function(obj) {
				var has_kol = false;
				if (cnt_kol > 0) {
					 $(obj).addClass('hidden');
					$( "input.zpost" ).each(function(index) {
						  //$( this ).addClass( "foo" );
						  if ($( this ).val() > 0) has_kol = true;
						 // console.log( index  );
					});

					if (has_kol) {
						$(obj).removeClass('hidden');
						$( "#zpost" ).submit();
					}
					else {
						alert('Нет позиций для заказа! Установите количество в поле "Заказ"!');
						$(obj).removeClass('hidden');
					}
				}
				

				return false;
				

			}
		    

		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_zpok',
			            'id': cnt_id
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data == 'ok')  { 
			        		 $('#deldlg').modal('hide');
			        		 $('#zpost_'+cnt_id).hide();
			        		 //cnt_sum = cnt_sum - 1;
			        		 
				         }
			        	 else { //alert(data);
			        	 	$("#success-alert").text('Произошла ошибка: ' + data);
			        	 }
			        	 

					}

					);

			    }
		  });

	});

    </script>            