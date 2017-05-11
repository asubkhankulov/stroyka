            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="well well-sm">
					<a href="/stroyka/">Стройка</a> / <a href="/stroyka/view/{$uchastok_id}/">в {$info[0].poselok} на участке {$info[0].uchastok}</a>  - планирование:
				</div>                   
{include file='dop_menu.tpl'}        

<hr>        
                

                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>№</th>
                                <th style="width: 5%" align="center">п/н</th>
                                {*<th style="width: 3%" align="center">Постройка</th>*}
                                <th align="center">Тип</th>
                                <th align="center">Этап</th>
                                <th align="center">Наименование</th>
                                <th style="width: 5%" align="center">Объём работ</th>
                                <th align="center">Ед. изм.</th>
                                {*<th align="center">Цена</th>
                                <th align="center">Сумма</th>*}
                                <th align="center">Материалов</th>
                                <th align="center">Сумма мат., руб</th>
                                <th style="width: 5%" align="center">Продолж., дни</th>
                                <th align="center">Дата нач.</th>
                                <th align="center">Дата оконч.</th>
                                <th align="center">Примечание</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr id="cnt_{$list[cus].id}">
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td><input type="text" class="form-control" name="sort" value="{$list[cus].sort}" id="{$list[cus].id}_sort"></td>
                                {*<td>{$list[cus].dom}</td>*}
                                {*<td><input type="text" class="form-control" name="shift1" value="{$list[cus].shift1}" id="{$list[cus].id}_shift1"></td>*}
                                <td>{$list[cus].step_type}</td>
                                <td>{$list[cus].step}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/stroyka/materials/{$list[cus].stroyka_id}/{$list[cus].work_id}/{$list[cus].step_id}/{$list[cus].doma_id}/">{$list[cus].work}</a></td>
                                <td>{$list[cus].v_work}</td>
                                <td>{$list[cus].unit}</td>
                                {*<td id="cntprice_{$list[cus].id}">{$list[cus].price}</td>
                                <td id="cntsumm_{$list[cus].id}">{$list[cus].price*$list[cus].v_work}</td>*}
                                <td>{$list[cus].matkol}</td>
                                <td>{$list[cus].matsumm|default:0}</td>
                                <td><input type="text" class="form-control" name="days" value="{$list[cus].days}" id="{$list[cus].id}_days"></td>
                                <td><input type="text" class="form-control" name="date_nach" id="datetimepicker_{{$smarty.section.cus.iteration}}" value="{$list[cus].startdate}" {*if $smarty.section.cus.iteration >1}readonly{/if*}></td>
                                <td><input type="text" class="form-control" name="date_okonch" value="{$list[cus].enddate}" id="{$list[cus].id}_do" readonly></td>
                                <td><input type="text" class="form-control" name="note" value="{$list[cus].note}" id="{$list[cus].id}_note"></td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this,{$smarty.section.cus.iteration},'{$list[cus].startdate}');" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    </div>
<hr> 
	
				<div class="well well-sm">
					Планирование бригад по видам работ:
				</div>                   
      
                <div class="table-responsive{if empty($list_type)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>№</th>
                                <th align="center">Вид бригады/работ</th>
                                <th align="center">Назначаем бригаду</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>{if !empty($list_type)}
                        {section name=typ loop=$list_type}
                            <tr>
                                <td>{{$smarty.section.typ.iteration}}</td>
                                <td>{$list_type[typ]}</td>
                                <td><select class="form-control" name="brigada_id" id="type_{{$smarty.section.typ.iteration}}">
								      {if !empty($list_brigada)}
								      <option value="0">Нет</option>
								      {section name=bri loop=$list_brigada}
								      	{if $list_brigada[bri].type == $list_type[typ] or $list_brigada[bri].type2 == $list_type[typ]}
										  <option value="{$list_brigada[bri].id}">{$list_brigada[bri].name} / {$list_brigada[bri].type} </option>
										{/if}
									  {/section}{/if}
									</select>
								</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField_brigata('{$list_type[typ]}',{$smarty.section.typ.iteration},this);" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    </div>
	
		                
            </div>
      


    <script type="text/javascript">
	$(document).ready(function() {            

		    var cnt_id = 0;
		    var cnt_sum = {$cnt_sum|default:0};

			$(function () {
				  $('[data-toggle="tooltip"]').tooltip()
			});
			    
			{if $smarty.section.cus.total > 0}
				{section name=foo start=1 loop=$smarty.section.cus.total step=1}
				$('#datetimepicker_{$smarty.section.foo.index}'){literal}.datetimepicker({
		        	format: 'DD.MM.YYYY',
		            locale: 'ru'
		        });{/literal}
			    
				{/section}
			{/if}
	
		    $("#deldlg").on('shown.bs.modal', function (event) {
		    	  var button = $(event.relatedTarget) // Button that triggered the modal
		    	  cnt_id = button.data('whatever') // Extract info from data-* attributes
		    });

			var field = '';        

			UpdateField = function(field_id, obj, iter, date_plan) {
				
				cnt_id = iter;
				var val1 = $("#datetimepicker_"+cnt_id).val();
				var val2 = $("#"+field_id+"_sort").val();
				var val3 = $("#"+field_id+"_shift1").val();
				var val4 = $("#"+field_id+"_days").val();
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_real_work_startdate',
	                'id': field_id,
	                'iter': cnt_id,
	                'date_plan': date_plan,
	                'val1': val1,
	                'val2': val2,
	                'val3': val3,
	                'val4': val4
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

			var field2 = '';  

			UpdateField_brigata = function(type, iter, obj) {
				
				cnt_id = iter;
				var val1 = $("#type_"+cnt_id).val();

				if (field2 != '') $(field2).tooltip('hide');
				field2 = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_real_work_brigada',
	                'brigada_id': val1,
	                'type': type,
	                'uchastok_id': {$uchastok_id}
	            }, checkTime = function(data) {
					

	            	switch(data) {
	                case 'ok':
	                	$(field2).tooltip('show');
	                    break
	                default:
	                	$(field2).tooltip(data);
	            }


				});
			}
		    

		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_os____',
			            'id': cnt_id
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data == 'ok')  { 
			        		 $('#deldlg').modal('hide');
			        		 $('#cnt_'+cnt_id).hide();
			        		 cnt_sum = cnt_sum - 1;
			        		 
			        		 if (cnt_sum = 0) {
			        			 $('div.table-responsive').addClass('hidden');
				        		 $('div.well').removeClass('hidden');
			        		 }

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