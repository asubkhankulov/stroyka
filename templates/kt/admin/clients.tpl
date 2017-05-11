            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Список пользователей</h1>
                <p><a href="/index/add/" class="btn btn-success"><i class="fa fa-user-plus" aria-hidden="true"></i> Добавить клиента / сотрудника</a></p>
				<div class="alert alert-success alert-dismissible hidden" role="alert">
				  <button type="button" class="close" data-dismiss="alert" aria-label="Закрыть"><span aria-hidden="true">&times;</span></button>
				  Клиент добавлен успешно!
				</div>                
                {if !empty($list)}
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th style="width: 20%">Наименование</th>
                                <th class="hidden-xs" style="width: 15%" align="center">Количество объектов</th>
                                <th>Контактное лицо</th>
                                <th>Телефон</th>
                                <th>Баланс, руб.</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        {section name=cus loop=$list}
                            <tr id="client_{$list[cus].id}">
                                <td>{$list[cus].comp_name}</td>
                                <td class="hidden-xs" align="center"><a href="/index/counters/{$list[cus].id}/">{$list[cus].cnt}</a></td>
                                <td>{$list[cus].login_name}</td>
                                <td>{$list[cus].login_tel}</td>
                                <td>{$list[cus].bill|replace:',':' '}</td>
                                <td align="center"> <a href="/index/info/{$list[cus].id}/" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить клиента" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}    
                        </tbody>
                    </table>
                </div>
	{else}
		<div class="well well-lg">Пока нет ни одной записи по клиентам.</div>
	{/if}                
            
            
            
	<h2 class="page-header">Список администраторов</h2>            
                {if !empty($admins)}
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>Контактное лицо</th>
                                <th>Телефон</th>
                                <th>Последний раз был</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        {section name=cus loop=$admins}
                            <tr id="client_{$list[cus].id}">
                                <td>{$admins[cus].login_name}</td>
                                <td>{$admins[cus].login_tel}</td>
                                <td>{$admins[cus].last_login_date}</td>
                                <td align="center"> <a href="/index/info/{$admins[cus].id}/" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить?" data-toggle="modal" data-target="#deldlg" data-whatever="{$admins[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}    
                        </tbody>
                    </table>

                </div>
	{else}
		<div class="well well-lg">Пока нет ни одной записи по администратолрам....Что очень странно!</div>
	{/if}    

	<h3 class="page-header">Список сотрудников / сметчиков / прорабов</h3>            
                {if !empty($users)}
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>Контактное лицо</th>
                                <th>Телефон</th>
                                <th>Последний раз был</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        {section name=cus loop=$users}
                            <tr id="client_{$list[cus].id}">
                                <td>{$users[cus].login_name}</td>
                                <td>{$users[cus].login_tel}</td>
                                <td>{$users[cus].last_login_date}</td>
                                <td align="center"> <a href="/index/info/{$users[cus].id}/" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить?" data-toggle="modal" data-target="#deldlg" data-whatever="{$users[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}    
                        </tbody>
                    </table>

                </div>
	{else}
		<div class="well well-lg">Пока нет ни одной записи по сотрудникам.</div>
	{/if} 
		          
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

		    var client_id = 0;

		    var added_client = {$added_client};
		    if (added_client != 0) {
			    $("#client_"+added_client).addClass("success");
			    $("div.alert").removeClass("hidden");
			    
		    }
		
		    $("#deldlg").on('shown.bs.modal', function (event) {
		    	  var button = $(event.relatedTarget) // Button that triggered the modal
		    	  client_id = button.data('whatever') // Extract info from data-* attributes
		    });
		
		    
		   
		
		    $('#Del').click(function() {
		
			    //если форма валидна, то
			    if (client_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_client',
			            'id': client_id
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data == 'ok')  { 
			        		 $('#deldlg').modal('hide');
			        		 $('#client_'+client_id).hide();

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