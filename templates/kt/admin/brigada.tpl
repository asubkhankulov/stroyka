            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Список бригад</h1>
                
                <div class="table-responsive{*if empty($list)} hidden{/if*}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>№</th>
                                <th align="center">Наименование</th>
                                <th align="center">Телефон</th>
                                <th align="center">Профиль</th>
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
                                <td>{$list[cus].tel}</td>
                                <td>{$list[cus].type}{if !empty($list[cus].type2)} / {$list[cus].type2}{/if}</td>
                                <td id="cntnote_{$list[cus].id}">{$list[cus].note}</td>
                                <td align="center"> <a href="/brigada/edit/{$list[cus].id}/" role="button" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    <hr>
	
		<h4>Добавление нового:</h4>
	
		<form class="form-horizontal text-primary" action="/brigada/" method="POST">
			<input type="hidden" name="action" value="add" />
          <div class="form-group">
            <label for="name" class="control-label">Наименование:</label>
			<input type="text" class="form-control input-sm" name="name" id="cnt_name" placeholder="Например: Шабашники" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="tel" class="control-label">Телефон:</label>
			<input type="text" class="form-control input-sm" name="tel" id="cnt_note" placeholder="" />
          </div>
          <div class="form-group">
            <label for="type" class="control-label">Тип:</label>
            <select class="form-control" name="type">
				{html_options values=$list_type output=$list_type selected=$info.type}
			</select>
          </div>
          <div class="form-group">
            <label for="type2" class="control-label">Тип 2:</label>
            <select class="form-control" name="type2">
				{html_options values=$list_type output=$list_type selected=$info.type2}
			</select>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="note" id="cnt_note" placeholder="Например: молдовашки" />
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Добавить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
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
	
		                
            </div>
  

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
		
		  
		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_brigada',
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