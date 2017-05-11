            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="well well-sm">
					<a href="/stroyka/">Стройка</a> / <a href="/stroyka/view/{$uchastok_id}/">в {$info[0].poselok} на участке {$info[0].uchastok}</a>  - выполнение:
				</div>                   
{include file='dop_menu.tpl'}        

<hr>        
                

                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
	                   <thead>
	                        <tr class="info" align="center">
	                        	<th rowspan="2">№</th>
                                <th rowspan="2"  align="center">Тип</th>
                                <th rowspan="2"  align="center">Этап</th>
                                <th rowspan="2"  align="center">Наименование</th>
                                {*<th rowspan="2"  align="center">Материалов</th>
                                <th rowspan="2"  align="center">Сумма мат., руб</th>*}
                                {*<th rowspan="2"  style="width: 5%" align="center">Продолж., дни</th>*}

	                            <th colspan="3" align="center">ПЛАН</th>
	                            <th colspan="2" align="center">ПРОГНОЗ</th>
	                            <th colspan="3" align="center">ФАКТ</th>

                                <th rowspan="2"  style="width: 5%" align="center">Отст/опер</th>
                                <th rowspan="2"  style="width: 15%" align="center">Недочёты</th>
                                <th rowspan="2"  style="width: 15%" align="center">Штраф</th>
                                <th rowspan="2"  style="width: 15%" align="center">Удерж. за проср.</th>
                                <th rowspan="2"  style="width: 15%" align="center">Перерасх.мат</th>
                                <th rowspan="2"  style="width: 5%" align="center">Объём работ</th>
                                <th rowspan="2"  align="center">Ед. изм.</th>
                                <th rowspan="2"  style="width: 5%" align="center">Цена раб.</th>
                                <th rowspan="2"  align="center">Сумма раб.</th>
                                <th rowspan="2"  align="center">Начислено</th>
                                <th rowspan="2"  align="center">Бригада</th>
                                <th rowspan="2" >
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                                
	                        </tr>
	                        <tr class="info" align="center">
	                            <th align="center">Прод.</th>
	                            <th align="center">Нач.</th>
	                            <th align="center">Кон.</th>
	                            
	                            {*<th align="center">Прод.</th>*}
	                            <th style="width: 5%" align="center">Нач.</th>
	                            <th style="width: 5%" align="center">Кон.</th>

	                            <th  style="width: 15%" align="center">Нач.</th>
	                            <th  style="width: 15%" align="center">Кон.</th>
	                            <th align="center">Прод.</th>
	                        </tr>
	                   </thead>
                    
                        {*<thead>
                            <tr>
                                <th>№</th>
                                <th align="center">Тип</th>
                                <th align="center">Этап</th>
                                <th align="center">Наименование</th>
                                <th align="center">Бригада</th>
                                <th style="width: 5%" align="center">Объём работ</th>
                                <th align="center">Ед. изм.</th>
                                <th align="center">Цена раб.</th>
                                <th align="center">Сумма раб.</th>
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
                        </thead>*}
                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr id="cnt_{$list[cus].id}">
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td>{$list[cus].step_type}</td>
                                <td>{$list[cus].step}</td>
                                <td>{$list[cus].work}</td>
                                {*<td>{$list[cus].matkol}</td>
                                <td>{$list[cus].matsumm|default:0}</td>*}
                                {*<td><input type="text" class="form-control" name="days" value="{$list[cus].days}" id="{$list[cus].id}_days"></td>*}
                                
                                <td>{$list[cus].days}</td>
                                <td>{$list[cus].startdate}</td>
                                <td>{$list[cus].enddate}</td>

                                {*<td>{$list[cus].days}</td>*}
                                <td>{$list[cus].start_prognoz|default:$list[cus].startdate}</td>
                                <td>{$list[cus].end_prognoz|default:$list[cus].enddate}</td>
                                
                                <td  style="width: 150px"><input type="text" class="form-control" style="width: 100px" name="date_nach" id="datetimepicker_{{$smarty.section.cus.iteration}}" value="{$list[cus].startdatefakt}"></td>
                                <td  style="width: 150px"><input type="text" class="form-control" style="width: 100px" name="date_okonch" id="datetimepicker_{{$smarty.section.cus.iteration}}_end" value="{$list[cus].enddatefakt}" ></td>
                                <td>{$list[cus].d_fakt}</td>
                                
                                <td {if $list[cus].prosr < 0}class="warning"{/if}>{$list[cus].prosr}</td>
                                
                                <td style="width: 150px"><input type="text" class="form-control" style="width: 150px" name="nedochet" id="nedochet_{{$smarty.section.cus.iteration}}" value="{$list[cus].nedochet}" ></td>
                                <td  style="width: 80px"><input type="text" class="form-control" style="width: 80px" name="shtraf" id="shtraf_{{$smarty.section.cus.iteration}}" value="{$list[cus].shtraf}" ></td>
                                <td {if $list[cus].prosr < 0}class="warning"{/if}>{if $list[cus].prosr < 0}{$list[cus].prosr*-3000}{/if}</td>
                                <td  style="width: 80px"><input type="text" class="form-control" style="width: 80px" name="pererashodm" id="pererashodm_{{$smarty.section.cus.iteration}}" value="0" ></td>
                                <td><input type="text" style="width: 80px" class="form-control" name="v_work" value="{$list[cus].v_work}" id="v_work_{{$smarty.section.cus.iteration}}"></td>
                                <td>{$list[cus].unit}</td>
                                <td><input type="text" style="width: 80px" class="form-control" name="price" value="{$list[cus].price}" id="price_{{$smarty.section.cus.iteration}}"></td>
                                <td>{$list[cus].price*$list[cus].v_work}</td>
                                <td>{if $list[cus].prosr < 0}{$list[cus].price*$list[cus].v_work-$list[cus].shtraf-$list[cus].prosr*-3000}{else}{$list[cus].price*$list[cus].v_work-$list[cus].shtraf}{/if}</td>
                                <td style="width: 100px">
                                	<select class="form-control" name="brigada_id" style="width: 100px" id="brigada_{{$smarty.section.cus.iteration}}">
								      <option value="0">Нет</option>
								      {if !empty($list_brigada)}
								      {section name=bri loop=$list_brigada}
										  <option value="{$list_brigada[bri].id}" {if $list_brigada[bri].id == $list[cus].brigada_id}selected{/if}>{$list_brigada[bri].name} / {$list_brigada[bri].type}{if !empty($list_brigada[bri].type2)} / {$list_brigada[bri].type2}{/if} </option>
									  {/section}{/if}
									</select>
								</td>
                                

                                {*<td><input type="text" class="form-control" name="note" value="{$list[cus].note}" id="{$list[cus].id}_note"></td>*}
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this,{{$smarty.section.cus.iteration}});" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> </td>
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
					$('#datetimepicker_{$smarty.section.foo.index}_end'){literal}.datetimepicker({
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

			UpdateField = function(field_id, obj,iter) {
				
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