            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<div class="well well-sm">
		<a href="/stroyka/">Стройка</a> / <a href="/stroyka/view/{$info.uchastok_id}/">в {$info.poselok} на участке {$info.uchastok}</a> / {$info.object_type} <a href="/stroyka/step/{$stroyka_id}/{$doma_id}/">{$info.object}</a> / <a href="/stroyka/works/{$stroyka_id}/{$step_id}/{$doma_id}/">{$info.step}</a>  - cписок работ:
	</div>                

                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th style="width: 5%">№</th>
                                <th style="width: 5%" align="center">п/н</th>
                                <th align="center">Наименование</th>
                                <th align="center">Объём работ</th>
                                <th align="center">Ед. изм.</th>
                                <th align="center">Цена</th>
                                <th align="center">Сумма</th>
                                <th align="center">Материалов</th>
                                <th align="center">Сумма мат., руб</th>
                                <th align="center">Продолжительность, дни</th>
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
                                <td id="cntval_{$list[cus].id}"><a href="/stroyka/materials/{$stroyka_id}/{$list[cus].work_id}/{$step_id}/{$doma_id}/">{$list[cus].work}</a></td>
                                <td><input type="text" class="form-control" name="v_work" value="{$list[cus].v_work}" id="{$list[cus].id}_v_work"></td>
                                <td>{$list[cus].unit}</td>
                                <td id="cntprice_{$list[cus].id}">{$list[cus].price}</td>
                                <td id="cntsumm_{$list[cus].id}">{$list[cus].price*$list[cus].v_work}</td>
                                <td>{$list[cus].matkol}</td>
                                <td>{$list[cus].matsumm|default:0}</td>
                                <td><input type="text" class="form-control" name="days" value="{$list[cus].days}" id="{$list[cus].id}_days"></td>
                                <td><input type="text" class="form-control" name="date_nach" value="{{$smarty.now|date_format:"%d.%m.%Y"}}" id="{$list[cus].id}_dn" readonly></td>
                                <td><input type="text" class="form-control" name="date_okonch" value="{$list[cus].dateend}" id="{$list[cus].id}_do" readonly></td>
                                <td><input type="text" class="form-control" name="note" value="{$list[cus].note}" id="{$list[cus].id}_note"></td>
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
		<h4>Добавление новой работы:</h4>
		{if !empty($list_works)}
	
		<form class="form-horizontal text-primary" action="/stroyka/works/{$stroyka_id}/{$step_id}/{$doma_id}/" method="POST">
			<input type="hidden" name="action" value="add" />
		  <div class="form-group">
		    <label for="unit_id" class="col-sm-4 control-label hidden-xs">Наименование работы:</label>
		    <div class="col-sm-8">
           	<select class="form-control" name="work_id" id="input3">
		      {if !empty($list_works)}{section name=cus loop=$list_works}
				  <option value="{$list_works[cus].id}">{$list_works[cus].name}</option>
			  {/section}{/if}
			</select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input7" class="col-sm-4 control-label hidden-xs">Примечание:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="notr" id="input7" placeholder="">
		    </div>
		  </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Добавить работу</button>
                  <button type="reset" class="btn btn-default">Очистить</button>  
              </div>
          </div>
		</form>	
		{else}
		Нет работ в справочнике! <a href="/works/">Добавьте</a>.
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
				

				var val1 = $("#"+field_id+"_v_work").val();
				var val2 = $("#"+field_id+"_days").val();
				var val3 = $("#"+field_id+"_note").val();
				var val4 = $("#"+field_id+"_sort").val();
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_real_doma_step_works',
	                'id': field_id,
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
		   
		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_real_doma_work',
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