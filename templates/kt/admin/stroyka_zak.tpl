            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="well well-sm">
					<a href="/stroyka/">Стройка</a> / <a href="/stroyka/view/{$uchastok_id}/">в {$info.poselok} на участке {$info.uchastok}</a>  - заказ: <span class="label label-info">Срок обеспечения материалом в {$info.poselok} дней - {$info.obes_days}</span>
				</div>                   
{include file='dop_menu.tpl'}        

<hr>        
      <form class="form-inline" role="form">
	  <div class="form-group">
	    <label for="datetimepicker2">Тип материала:</label>
		<select class="form-control" name="type_material" id="type_material">
			<option value="0">без фильтра</option>
			{html_options values=$list_type_val output=$list_type_name selected=''}
		</select>
	    
	    <button type="text" class="btn btn-success btn-sm" onclick="return SelectType()">Применить</button>
	    
	  </div>
	  <div class="pull-right"><button type="text" class="btn btn-danger btn-sm" onclick="return MakeZpost(this)">Создать заказ</button></div>
	</form>
<hr> 
	  <div class="form-group">
	Показать:
	<span class="label label-primary btn" onclick="$('.zak_type').toggle();">Тип</span>
	<span class="label label-primary btn" onclick="$('.zak_step').toggle();">Этап</span>
	<span class="label label-primary btn" onclick="$('.zak_matt').toggle();">Тип. матер.</span>
	<span class="label label-danger btn" onclick="$('.fakt_ended').toggle();">Завершённые работы</span>
	</div>

		<form action="/stroyka/zak/{$uchastok_id}/" method="POST" id="zpost">
			<input type="hidden" name="action" value="zpost" />
			<input type="hidden" name="uchastok_id" value="{$uchastok_id}" />
                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
	                   <thead>
	                        <tr class="info" align="center">
	                        	<th>№</th>
                                <th align="center" class="zak_type" hidden>Тип</th>
                                <th align="center" class="zak_step" hidden>Этап</th>
                                <th align="center">Работа</th>
                                <th align="center">Нач. раб.</th>
                                <th align="center">Оконч. раб.</th>
                                <th align="center">Материал</th>
                                <th style="width: 5%" align="center">Необх. дата пост.</th>
                                <th align="center" class="zak_matt" hidden>Тип. мат.</th>
                                <th align="center">План, кол.</th>

	                            <th align="center">Пост.</th>
	                            <th align="center">В заявках</th>
	                            <th align="center">Ожидается</th>

                                <th style="width: 5%" align="center">Потребность</th>
                                <th style="width: 5%" align="center">Необх. дата заказа</th>
                                <th style="width: 5%" align="center">Заказ</th>
                                <th align="center">Изр</th>
                                <th align="center">Остаток</th>
                                {*<th>                                    <center><em class="fa fa-cog"></em></center>                                </th>*}
                                
	                        </tr>

	                   </thead>
                    

                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr id="cnt_{$list[cus].mat_type_id}" class="mat_type_{$list[cus].mat_type_id} mat_all {if !empty($list[cus].enddatefakt) and $list[cus].enddatefakt != '00.00.0000'}fakt_ended danger" hidden{else}"{/if}>
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td class="zak_type" hidden>{$list[cus].step_type}</td>
                                <td class="zak_step" hidden>{$list[cus].step}</td>
                                <td>{$list[cus].work}</td>
                                <td>{$list[cus].start_prognoz|default:$list[cus].startdate}</td>
                                <td>{$list[cus].end_prognoz|default:$list[cus].enddate}</td>
                                <td><a href="/stroyka/materials/{$list[cus].stroyka_id}/{$list[cus].work_id}/{$list[cus].step_id}/{$list[cus].doma_id}/" title="перейти">{$list[cus].material|default:'не задан'}</a></td>
                                <td class="zak_matt" hidden>{$list[cus].mat_type|default:''}</td>
                                <td>{$list[cus].data_post}<input type="hidden" name="zpost_post[{$list[cus].id_rdwm}]" value="{$list[cus].datapost}" /></td>
                                <td>{$list[cus].matkol|default:''}, {$list[cus].mat_unit}</td>
                                
                                <td></td>
                                <td>{$list[cus].vputi}</td>
                                <td></td>

                                <td {if $list[cus].matkol-$list[cus].vputi < 0}class="warning"{/if}>{$list[cus].matkol-$list[cus].vputi}</td>
                                <td  style="width: 150px">{$list[cus].start_zakupka}<input type="hidden" name="zpost_zakupka[{$list[cus].id_rdwm}]" value="{$list[cus].startzakupka}" />{*<input type="text" class="form-control" style="width: 100px" name="date_nach" id="datetimepicker_{{$smarty.section.cus.iteration}}" value="{$list[cus].start_prognoz|default:$list[cus].start_zakupka}">*}</td>
                                <td  style="width: 80px" class="{$list[cus].on_next_week}"><input type="text" class="form-control zpost" style="width: 80px" name="zpost[{$list[cus].id_rdwm}]" id="{$list[cus].id_rdwm}" value="0" ></td>
                                <td></td>
                                <td></td>


                                {*<td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this,{{$smarty.section.cus.iteration}});" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> </td>*}
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    </div>
		</form>

	<hr>
				<div class="well well-sm">
					<span class="label label-info">Список заказов:</span>
				</div>  	
	
                <div class="table-responsive{if empty($zpost)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
	                   <thead>
	                        <tr class="info" align="center">
	                        	<th>#</th>
	                        	<th style="width: 5%">№ док.</th>
                                <th align="center">Дата</th>
                                <th align="center">Необх. дата пост.</th>
                                <th align="center">Количество материалов в заказе, шт.</th>
                                <th align="center">Сумма, руб.</th>
                                <th align="center">Статус</th>
                                <th align="center">Примечание</th>
                                <th align="center">Ответственный</th>
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
                                <td><a href="/stroyka/zak/{$uchastok_id}/{$zpost[zpo].id}/">{$zpost[zpo].doc_date}</a></td>
                                <td>{$zpost[zpo].postup_date}</td>
                                <td>{$zpost[zpo].kols}</td>
                                <td>{$zpost[zpo].all_summ}</td>
                                <td></td>
                                <td></td>
                                <td>{$zpost[zpo].user}</td>
                                <td align="center"> <a href="/stroyka/zak/{$uchastok_id}/{$zpost[zpo].id}/" role="button" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$zpost[zpo].id}"><em class="fa fa-trash"></em></button></td>
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
		    var cnt_kol = {$smarty.section.cus.total};

			$(function () {
				  $('[data-toggle="tooltip"]').tooltip()
			});
			    
			{*if $smarty.section.cus.total > 0}
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
			{/if*}
	
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