            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h4 class="page-header">Список сообщений</h4>
                <p><button type="button" class="btn btn-success" data-toggle="modal" data-target="#cntdlg"><i class="fa fa-circle-o-notch fa-spin" aria-hidden="true"></i> Создать сообщение</button></p>
				<div class="alert alert-success alert-dismissible {if empty($added)}hidden{/if}" role="alert">
				  <button type="button" class="close" data-dismiss="alert" aria-label="Закрыть"><span aria-hidden="true">&times;</span></button>
				  Сообщение отправлено!
				</div>                
                
                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th style="width: 5%">№</th>
                                <th style="width: 15%" align="center">Дата</th>
                                <th align="center">Тема</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr id="msg_{$list[cus].id}">
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td>{$list[cus].date|date_format:"%d.%m.%Y %H:%M:%S"}</td>
                                <td>{if empty($list[cus].is_viewed)}<strong>{$list[cus].name}</strong>{else}{$list[cus].name}{/if}</td>
                                <td align="center"> <a href="/messages/{$list[cus].id}/" class="btn btn-success" title="Просмотр">Просмотр</a> {*<button type="button" class="btn btn-default" title="Просмотр"  data-toggle="modal" data-target="#cntdlg" data-whatever="{$list[cus].id}"><em class="fa fa-pencil"></em></button>*} {*<button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button>*} </td>
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
	
		<div class="well well-lg{if !empty($list)} hidden{/if}">Сообщений нет.</div>
	                
            </div>
<div class="modal fade" tabindex="-1" role="dialog" id="cntdlg" aria-labelledby="exampleModalLabel1">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Новое сообщение</h4>
      </div>
    <form action="/messages/" method="POST">
   	<input type="hidden" name="action" value="add" />
   	<input type="hidden" name="to_user_id" value="0" />
      <div class="modal-body">
          <div class="form-group">
            <label for="name" class="control-label">Тема:</label>
            <input type="text" class="form-control" name="name" id="name" required>
          </div>
          <div class="form-group">
            <label for="text" class="control-label">Сообщение:</label>
            <textarea class="form-control" name="text" id="text" required></textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Отмена</button>
        <button type="submit" class="btn btn-primary">Отправить</button>
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
		   
		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_msg',
			            'id': cnt_id
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data == 'ok')  { 
			        		 $('#deldlg').modal('hide');
			        		 $('#msg_'+cnt_id).hide();
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