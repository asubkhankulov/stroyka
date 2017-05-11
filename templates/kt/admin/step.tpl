            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Список этапов</h1>
                {*<p><a href="/step/new/" class="btn btn-success"><i class="fa fa-random" aria-hidden="true"></i> Добавить новый этап</a></p>*}

                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th style="width: 5%">#</th>
                                <th align="center">Наименование</th>
                                <th align="center">Работ</th>
                                <th align="center">Тип</th>
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
                                <td><a href="/step/works/{$list[cus].id}/" id="cntval_{$list[cus].id}">{$list[cus].name}</a></td>
                                <td><a href="/step/works/{$list[cus].id}/">{$list[cus].works}</a></td>
                                <td>{$list[cus].type}</td>
                                <td>{$list[cus].note}</td>
                                <td align="center"> <a href="/step/edit/{$list[cus].id}/" role="button" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    
<hr>
		<h4>Добавление нового этапа</h4>
	
		<form class="form-horizontal text-primary" action="/step/" method="POST">
			<input type="hidden" name="action" value="add" />
		  <div class="form-group">
		    <label for="input1" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="name" id="input1" placeholder="Укажите наименование" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="type" class="col-sm-4 control-label hidden-xs">Тип:</label>
		    <div class="col-sm-8">
			<select class="form-control" name="type">
				{html_options values=$steps_val output=$steps_name selected='0'}
			</select>
		    </div>
		  </div>
		  {*<div class="form-group">
		    <label for="sleduet" class="col-sm-4 control-label hidden-xs">Следует за:</label>
		    <div class="col-sm-8">
		      <input type="nubmer" class="form-control" name="sleduet" id="input2" placeholder="">
		    </div>
		  </div>*}
		  <div class="form-group">
		    <label for="note" class="col-sm-4 control-label hidden-xs">Примечание:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="note" id="input4" placeholder="">
		    </div>
		  </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Добавить этап</button> 
                  <a href="/step/" class="btn btn-default">Отмена</a>
              </div>
          </div>
		</form>	

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
	                
            </div>
            <div class="modal fade" tabindex="-1" role="dialog" id="cntdlg" aria-labelledby="exampleModalLabel1">
  <div class="modal-dialog">
    <div class="modal-content modal-md">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel1">Редактирование этапа</h4>
      </div>
      <div class="modal-body">
			<div class="input-group col-xs-12">
				<span class="input-group-addon hidden-xs">Нименование</span>
				<input type="text" class="form-control input-sm" name="name" id="cnt_name" placeholder="Кладка стен" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required autofocus />
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

		    var cnt_name = '';
		
			var field = '';        

			UpdateField = function(field_id, obj) {
				

				var val1 = $("#"+field_id+"_sleduet").val();
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_step_sleduet',
	                'id': field_id,
	                'val1': val1
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
			            'action': 'del_step',
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