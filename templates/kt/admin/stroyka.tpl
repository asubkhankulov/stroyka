           <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="well well-sm">
				<a href="/stroyka/">Стройка</a> - cписок участков стройки:
			</div>                   
<hr>        
                
                <div class="table-responsive{*if empty($list)} hidden{/if*}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>№</th>
                                <th align="center">Место</th>
                                <th align="center">Построек</th>
                                <th align="center">Дом</th>
                                <th align="center">Плановая сумма, руб</th>
                                <th align="center">Затраты, руб</th>
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
                                <td>{$list[cus].uchastok} / {$list[cus].poselok}</td>
                                <td><a href="/stroyka/view/{$list[cus].uchastok_id}/">{$list[cus].cnt}</a></td>
                                <td>{$list[cus].dom}</td>
                                <td>1 500 000</td>
                                <td>958 057</td>
                                <td>{$list[cus].note}</td>
                                <td align="center"> <a href="/stroyka/view/{$list[cus].uchastok_id}/" role="button" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>

                    <hr>
	
		<h4>Добавление новой постройки на участок:</h4>
	
		<form class="form-horizontal text-primary" action="/stroyka/" method="POST">
			<input type="hidden" name="action" value="add" />
          <div class="form-group">
            <label for="uchastok_id" class="control-label">Местоположение:</label>
           	<select class="form-control" name="uchastok_id" id="input3" required>
		      {if !empty($list_mesto)}{section name=cus loop=$list_mesto}
				  <option value="{$list_mesto[cus].id}">{$list_mesto[cus].uchastok} / {$list_mesto[cus].poselok}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="doma_types_id" class="control-label">Постройка:</label>
           	<select class="form-control" name="doma_types_id" required>
           		<option value="0">Неопределено</option>
		      {if !empty($doma_types)}{section name=cus loop=$doma_types}
				  <option value="{$doma_types[cus].id}">{$doma_types[cus].name}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="prorab_id" class="control-label">Прораб:</label>
           	<select class="form-control" name="prorab_id">
           		<option value="0">Неопределено</option>
		      {if !empty($prorabs)}{section name=cus loop=$prorabs}
				  <option value="{$prorabs[cus].id}">{$prorabs[cus].login_name}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="note" id="cnt_note" placeholder="" />
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