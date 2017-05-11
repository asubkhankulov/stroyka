            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="well well-sm">
					<a href="/doma/">Типы построек</a> / <a href="/doma/step/{$doma_id}/">{$info.name}</a> / <a href="/doma/works/{$step_id}/{$doma_id}/">{$info.step}</a> / {$info.work} <a href="/doma/materials/{$work_id}/{$step_id}/{$doma_id}/" title="Обновить страницу"><i class="fa fa-refresh" aria-hidden="true"></i></a> -  cписок материалов:
				</div>                

                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th style="width: 5%">№</th>
                                <th align="center">Наименование</th>
                                <th align="center">Способ расчета</th>
                                <th align="center">Норма</th>
                              	<th align="center">Ед. изм.</th>
                                <th align="center">Объём работы</th>
                                <th align="center">Кол-во</th>
                                <th align="center">Цена</th>
                                <th align="center">Сумма</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr id="cnt_{$list[cus].id}">
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}">{$list[cus].name}</td>
                                <td><select class="form-control" name="sposob_id" id="{$list[cus].id}_sposob" onchange="DoChange('{$list[cus].id}');">
									  <option value="0" {if $list[cus].sposob_id  == 0}selected{/if}>Выберите</option>
									  <option value="1" {if $list[cus].sposob_id  == 1}selected{/if}>По норме</option>
									  <option value="2" {if $list[cus].sposob_id  == 2}selected{/if}>По плану</option>
								</select></td>
                                <td><input type="text" class="form-control" name="norma" value="{$list[cus].kol}" id="{$list[cus].id}_norma" {if $list[cus].sposob_id  == 0 or $list[cus].sposob_id  == 2}readonly{/if}></td>
                                <td>{$list[cus].unit}</td>
                                <td>{$list[cus].v_work}</td>
                                {*<td>{if $list[cus].sposob_id==1}{$list[cus].v_work*$list[cus].kol}{else}<input type="text" class="form-control" name="plan" value="{$list[cus].kol}" id="{$list[cus].id}_plan" {if $list[cus].sposob_id  == 0 or $list[cus].sposob_id  == 1}readonly{/if}>{/if}</td>*}
                                <td><input type="text" class="form-control" name="plan" value="{if $list[cus].sposob_id  == 1}{$list[cus].v_work*$list[cus].kol}{else}{if $list[cus].sposob_id  == 2}{$list[cus].kol}{else}-{/if}{/if}" id="{$list[cus].id}_plan" {if $list[cus].sposob_id  == 0 or $list[cus].sposob_id  == 1}readonly{/if}></td>
                                <td>{$list[cus].price}</td>
                                <td>{if $list[cus].sposob_id  == 1}{$list[cus].price*$list[cus].v_work*$list[cus].kol}{else}{if $list[cus].sposob_id  == 2}{$list[cus].price*$list[cus].kol}{else}-{/if}{/if}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    

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
    </div>
	
		<div class="well well-lg{if !empty($list)} hidden{/if}">Пока нет ни одной записи.</div>
	                
 
 	<div class="row">
		<h4>Добавление матерала к работе - <span class="label label-info">{$info.work}</span>:</h4>
		{if !empty($list_materials)}
		<form class="form-horizontal text-primary" action="/doma/materials/{$work_id}/{$step_id}/{$doma_id}/" method="POST">
			<input type="hidden" name="action" value="add" />
		  <div class="form-group">
		    <label for="input2" class="col-sm-4 control-label hidden-xs">Материал:</label>
		    <div class="col-sm-8">
		      <select class="form-control" name="material_id" id="input2" required>
		      {if !empty($list_materials)}{section name=cus loop=$list_materials}
				  <option value="{$list_materials[cus].id}">{$list_materials[cus].name}, {$list_materials[cus].unit}</option>
			  {/section}{/if}
				</select>
		    </div>
		  </div>
		  {*<div class="form-group">
		    <label for="input3" class="col-sm-4 control-label hidden-xs">Количество:</label>
		    <div class="col-sm-8">
		      <input type="number" class="form-control" name="material_kol" id="input3" placeholder="" required>
		    </div>
		  </div>*}

          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Добавить материал</button>
                  <button type="reset" class="btn btn-default">Очистить форму</button>  
              </div>
          </div>
		</form>	
		{else}
		Нет материалов в справочнике! <a href="/materials/">Добавьте</a>.
		{/if}
	
	</div>
 
 
 
 </div>
            <div class="modal fade" tabindex="-1" role="dialog" id="cntdlg" aria-labelledby="exampleModalLabel1">
  <div class="modal-dialog">
    <div class="modal-content modal-md">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel1">Добавить тип дома</h4>
      </div>
      <div class="modal-body">
			<div class="input-group col-xs-12">
				<span class="input-group-addon hidden-xs">Нименование дома</span>
				<input type="text" class="form-control input-sm" name="name" id="cnt_name" placeholder="Например: Дом 10*10" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required autofocus />
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
        <button type="button" class="btn btn-primary" id="add">Сохранить</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
    <script type="text/javascript">
	$(document).ready(function() {            

		    var cnt_id = 0;
		    var cnt_sum = {$cnt_sum|default:0};

			$(function () {
				  $('[data-toggle="tooltip"]').tooltip()
			});
			    

		    
	
		    $("#deldlg").on('shown.bs.modal', function (event) {
		    	  var button = $(event.relatedTarget) // Button that triggered the modal
		    	  cnt_id = button.data('whatever') // Extract info from data-* attributes
		    });
		    $("#cntdlg").on('show.bs.modal', function (event) {
		    	$("#cnt_name").tooltip('hide');
		    	var button = $(event.relatedTarget) // Button that triggered the modal
		    	cnt_id = button.data('whatever') // Extract info from data-* attributes
		    	if (cnt_id != undefined ) {
		    		$("#cnt_name").val($("#cntval_"+cnt_id).text());
		    	}
		    	else {
			    	cnt_id = 0;
			    	$("#cnt_name").val('');
		    	}
		    	//console.log(cnt_id);
		    });

		    var field = '';
		
			UpdateField = function(field_id, obj) {
				

				var val1 = $("#"+field_id+"_sposob").val();
				//alert(val1);
				if (val1 == 0) {
					alert("Нельзя сохранять не выбрав способ расчёта!");
					return;
				}

				var val2 = '';

				if (val1 == 1) {
				 	val2 = $("#"+field_id+"_norma").val();
				}
				else {
					 val2 = $("#"+field_id+"_plan").val();
				}

				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_doma_materials',
	                'id': field_id,
	                'val1': val1,
	                'val2': val2
	            }, checkTime = function(data) {
					

	            	switch(data) {
	                case 'ok':
	                	$(field).tooltip('show');
	                	window.location = "/doma/materials/{$work_id}/{$step_id}/{$doma_id}/";
	                    break
	                default:
	                	$(field).tooltip(data);
	            }


				});
			}    

			DoChange = function(field_id) {

				
				var val = $("#"+field_id+"_sposob").val();

				if (val == 0) {
					//alert(val);
					$("#"+field_id+"_plan").attr("readonly","readonly");
					$("#"+field_id+"_norma").attr("readonly","readonly");
				}
				else if (val == 2) {
					//(val);
					$("#"+field_id+"_plan").removeAttr("readonly");
					$("#"+field_id+"_norma").attr("readonly","readonly");
				}
				else {
					//alert(val);
					$("#"+field_id+"_plan").attr("readonly","readonly");
					$("#"+field_id+"_norma").removeAttr("readonly");
				}
				
			}			
		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_doma_material_work',
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