            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Список типов материалов</h1>
                <p><button type="button" class="btn btn-success" data-toggle="modal" data-target="#cntdlg"><i class="fa fa-book" aria-hidden="true"></i> Добавить новый</button></p>
				<div class="alert alert-success alert-dismissible hidden" role="alert">
				  <button type="button" class="close" data-dismiss="alert" aria-label="Закрыть"><span aria-hidden="true">&times;</span></button>
				  Материал добавлен успешно!
				</div>                
                
                <div class="table-responsive{*if empty($list)} hidden{/if*}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>№</th>
                                <th>Наименование</th>
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
                                <td align="center"> <button type="button" class="btn btn-default" title="Редактировать"  data-toggle="modal" data-target="#cntdlg" data-whatever="{$list[cus].id}"><em class="fa fa-pencil"></em></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    <hr>
    <form action="/units/" method="POST">
   	<input type="hidden" name="action" value="add" />
      <div class="modal-body">
          <div class="form-group">
            <label for="text" class="control-label">Добавить списком:</label>
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
				<span class="label label-default">Добавится только уникальные наименования</span>
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
    </div>
	
		<div class="well well-lg{if !empty($list)} hidden{/if}">Пока нет ни одной записи.</div>
	                
            </div>
            <div class="modal fade" tabindex="-1" role="dialog" id="cntdlg" aria-labelledby="exampleModalLabel1">
  <div class="modal-dialog">
    <div class="modal-content modal-md">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel1">Добавить новый</h4>
      </div>
      <div class="modal-body">
			<div class="input-group col-xs-12">
				<span class="input-group-addon hidden-xs">Нименование</span>
				<input type="text" class="form-control input-sm" name="name" id="cnt_name" placeholder="Например: Электрика" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
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
				//mat_note = $("#cnt_note").val();
				
			    if (mat_name != '') {
			    	$("#mat_name").tooltip('hide');
			    	var $btn = $(this).button('Сохраняю...');
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'add_mat_type',
			            'name': mat_name,
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
			        		 window.location = "/types/";

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
			            'action': 'del_mat_type',
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