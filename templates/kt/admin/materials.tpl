            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Список материалов</h1>
                {*<p><button type="button" class="btn btn-success" data-toggle="modal" data-target="#cntdlg"><i class="fa fa-book" aria-hidden="true"></i> Добавить новый материал</button></p>*}
				<div class="alert alert-success alert-dismissible hidden" role="alert">
				  <button type="button" class="close" data-dismiss="alert" aria-label="Закрыть"><span aria-hidden="true">&times;</span></button>
				  Материал добавлен успешно!
				</div>                
                
                <div class="table-responsive{*if empty($list)} hidden{/if*}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>№</th>
                                <th align="center">Материал</th>
                                <th align="center">Тип</th>
                                <th style="width: 50px" align="center">Ед. изм.</th>
                                <th align="center">Осн. поставщик</th>
                                <th style="width: 150px" align="center">Цена</th>
                                <th style="width: 150px" align="center">Вес, кг</th>
                                <th style="width: 150px" align="center">Объём, м3</th>
                                <th style="width: 150px" align="center">Срок поставки, дней</th>
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
                                <td id="cntval_{$list[cus].id}">{$list[cus].name}</td>
                                <td id="cnttype_{$list[cus].id}">{$list[cus].type}</td>
                                <td id="cntunit_{$list[cus].id}">{$list[cus].unit}</td>
                                <td>{$list[cus].vendor}</td>
                                <td id="cntprice_{$list[cus].id}"><input type="text" class="form-control" name="price" value="{$list[cus].price}" id="{$list[cus].id}_price"></td>
                                <td id="cntm_{$list[cus].id}"><input type="text" class="form-control" name="m" value="{$list[cus].m}" id="{$list[cus].id}_m"></td>
                                <td id="cntv_{$list[cus].id}"><input type="text" class="form-control" name="v" value="{$list[cus].v}" id="{$list[cus].id}_v"></td>
                                <td id="cntd_{$list[cus].id}"><input type="text" class="form-control" name="days" value="{$list[cus].days}" id="{$list[cus].id}_days"></td>
                                <td id="cntnote_{$list[cus].id}">{$list[cus].note}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <a href="/materials/edit/{$list[cus].id}/" role="button" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    <hr>
	
		<h4>Добавление материала:</h4>
	
		<form class="form-horizontal text-primary" action="/materials/" method="POST">
			<input type="hidden" name="action" value="add" />
          <div class="form-group">
            <label for="name" class="control-label">Наименование:</label>
			<input type="text" class="form-control input-sm" name="name" id="cnt_name" placeholder="Например: Автоматический выключатель" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="type_id" class="control-label">Тип:</label>
             <select class="form-control" name="type_id" id="input2">
		      {if !empty($list_type)}{section name=cus loop=$list_type}
				  <option value="{$list_type[cus].id}">{$list_type[cus].name}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="unit_id" class="control-label">Ед. изм.:</label>
           	<select class="form-control" name="unit_id" id="input3">
		      {if !empty($list_unit)}{section name=cus loop=$list_unit}
				  <option value="{$list_unit[cus].id}">{$list_unit[cus].name}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="price" class="control-label">Цена:</label>
			<input type="text" class="form-control input-sm" name="price" id="cnt_price" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="m" class="control-label">Вес:</label>
			<input type="text" class="form-control input-sm" name="m" id="cnt_m" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="v" class="control-label">Объём:</label>
			<input type="text" class="form-control input-sm" name="v" id="cnt_v" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="note" id="cnt_note" placeholder="Например: ABB" />
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Добавить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
              </div>
          </div>
		</form>	
	

                    
    {*                
                    <hr>
    <form action="/materials/" method="POST">
   	<input type="hidden" name="action" value="add_list" />
      <div class="modal-body">
          <div class="form-group">
            <label for="text" class="control-label">Добавить материалы списком:</label>
            <textarea class="form-control" name="text" id="text" required></textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="reset" class="btn btn-default" data-dismiss="modal">Отмена</button>
        <button type="submit" class="btn btn-primary">Отправить</button>
      </div>
    </form>
    
 			<div class="well well-sm">
				<span class="label label-success">Можно копировать из Экселя и вставлять</span></br>
				<span class="label label-default">Колонки должны совпадать с таблицей на этой странице</span>
			</div>
    
    *}

                    
                    

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
	
		                
            </div>

<div class="modal fade" tabindex="-1" role="dialog" id="cntdlg" aria-labelledby="exampleModalLabel1">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Добавить материал</h4>
      </div>
    <form>
   	<input type="hidden" name="action" value="add" />
      <div class="modal-body">
          <div class="form-group">
            <label for="name" class="control-label">Нименование:</label>
			<input type="text" class="form-control input-sm" name="name" id="cnt_name" placeholder="Например: Автоматический выключатель" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="type_id" class="control-label">Тип:</label>
             <select class="form-control" name="type_id" id="input2" required>
		      {if !empty($list_type)}{section name=cus loop=$list_type}
				  <option value="{$list_typet[cus].id}">{$list_type[cus].name}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="unit_id" class="control-label">Ед. изм.:</label>
           	<select class="form-control" name="unit_id" id="input3" required>
		      {if !empty($list_unit)}{section name=cus loop=$list_unit}
				  <option value="{$list_typet[cus].id}">{$list_unit[cus].name}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="price" class="control-label">Цена:</label>
			<input type="text" class="form-control input-sm" name="price" id="cnt_price" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="m" class="control-label">Вес:</label>
			<input type="text" class="form-control input-sm" name="m" id="cnt_m" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="v" class="control-label">Объём:</label>
			<input type="text" class="form-control input-sm" name="v" id="cnt_v" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="unit" id="cnt_note" placeholder="Например: ABB" />
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
        <button type="button" class="btn btn-primary" id="add">Сохранить</button>
      </div>
    </form>
    </div>
  </div>
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
		    		$("#cnt_type").val($("#cnttype_"+cnt_id).text());
		    		$("#cnt_unit").val($("#cntunit_"+cnt_id).text());
		    		$("#cnt_price").val($("#cntprice_"+cnt_id).text());
		    		$("#cnt_note").val($("#cntnote_"+cnt_id).text());
		    	}
		    	else {
			    	cnt_id = 0;
			    	$("#cnt_name").val('');
		    	}
		    	//console.log(cnt_id);
		    });
		
		    $('#add').on('click', function () {
		       
				mat_name = $("#cnt_name").val();
				mat_type = $("#cnt_type").val();
				mat_unit = $("#cnt_unit").val();
				mat_price = $("#cnt_price").val();
				mat_note = $("#cnt_note").val();
				
			    if (mat_name != '') {
			    	$("#mat_name").tooltip('hide');
			    	$("#mat_type").tooltip('hide');
			    	$("#mat_unit").tooltip('hide');
			    	var $btn = $(this).button('Сохраняю...');
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'add_material',
			            'name': mat_name,
			            'type': mat_type,
			            'unit': mat_unit,
			            'price': mat_price,
			            'note': mat_note,
			            'id': cnt_id
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data == 'ok')  { 
			        		 $('#cntdlg').modal('hide');
			        		 //$('#cnt_'+client_id).hide();
			        		 $btn.button('reset');
			        		 $('div.well').hide();
			        		 //cnt_sum = cnt_sum +1;
			        		 //alert(cnt_sum);
			        		 //$('div.table-responsive').show();
			        		 window.location = "/materials/";

				         }
			        	 else { //alert(data);
			        	 	$("#success-alert").text('Произошла ошибка: ' + data);
			        	 }
			        	 

					}

					);

			    }
			    else {
			    	$("#cnt_name").tooltip('show');
			    }
			    
		    });		    
		   
			var field = '';        

			UpdateField = function(field_id, obj) {
				

				var val1 = $("#"+field_id+"_price").val();
				var val2 = $("#"+field_id+"_m").val();
				var val3 = $("#"+field_id+"_v").val();
				var val4 = $("#"+field_id+"_days").val();
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_material',
	                'id': field_id,
	                'price': val1,
	                'm': val2,
	                'v': val3,
	                'days': val4
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
			            'action': 'del_material',
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