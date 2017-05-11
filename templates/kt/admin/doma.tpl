            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Типы построек</h1>
                
                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th style="width: 5%">№</th>
                                <th align="center">Наименование</th>
                                <th align="center">Тип</th>
                                <th align="center">Этапов</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr id="cnt_{$list[cus].id}">
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/step/{$list[cus].id}/">{$list[cus].name}</a></td>
                                <td>{$list[cus].type}</td>
                                <td><a href="/doma/step/{$list[cus].id}/">{$list[cus].steps}</a></td>
                                <td align="center"> <a href="/doma/edit/{$list[cus].id}/" role="button" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a>
                                <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Скопировано..."><i class="fa fa-files-o" title="Скопировать" aria-hidden="true"></i></button>
                                 <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
    		</div>
	
		<div class="well well-lg{if !empty($list)} hidden{/if}">Пока нет ни одной записи.</div>
	<hr>
	<h4>Добавление нового:</h4>
		 <form class="form-horizontal text-primary" action="/doma/" method="POST">
			<input type="hidden" name="action" value="add" />
          <div class="form-group">
            <label for="name" class="control-label">Наименование:</label>
			<input type="text" class="form-control input-sm" name="name" placeholder="Например: Дом 6*6" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="type" class="control-label">Тип:</label>
			<select class="form-control" name="type">
				  <option value="">Не выбран</option>
				  <option value="Дом">Дом</option>
				  <option value="Забор">Забор</option>
				  <option value="Септик">Септик</option>
				  <option value="Вода">Вода</option>
				  <option value="Прочее">Прочее</option>
			</select>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="note" value="{$info.note}" id="cnt_note" placeholder="" />
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Сохранить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
              </div>
          </div>
		</form>	

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
				

				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'copy_doma',
	                'id': field_id
	            }, checkTime = function(data) {
					

	            	switch(data) {
	                case 'ok':
	                	$(field).tooltip('show');
	                	window.location = "/doma/";
	                    break
	                default:
	                	$(field).tooltip(data);
	            }


				});
			}
			
		    $('#add').on('click', function () {
		       
				cnt_name = $("#cnt_name").val();
				
			    if (cnt_name != '') {
			    	$("#cnt_name").tooltip('hide');

					mat_type = '';
					mat_unit = '';
					mat_price = '';
					mat_note = '';
			    	
			    	var $btn = $(this).button('Сохраняю...');
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'add_dom_type',
			            'name': cnt_name,
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
			        		 window.location = "/doma/";

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
		   
		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_dom_type',
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