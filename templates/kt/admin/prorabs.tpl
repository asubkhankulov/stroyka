            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Список прорабов</h1>

                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th style="width: 5%">#</th>
                                <th align="center">ФИО</th>
                                <th align="center">Телефон</th>
                                <th align="center">Занят на объектах</th>
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
                                <td><a href="/prorabs/in/{$list[cus].id}/">{$list[cus].poselok} / {$list[cus].works}</a></td>
                                <td>{$list[cus].note}</td>
                                <td align="center"> <button type="button" class="btn btn-default" title="Редактировать"  data-toggle="modal" data-target="#cntdlg" data-whatever="{$list[cus].id}"><em class="fa fa-pencil"></em></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                 
    			</div>
	
		<div class="well well-lg{if !empty($list)} hidden{/if}">Пока нет ни одной записи.</div>
		
<hr>
		<h4>Добавление нового:</h4>
	
		<form class="form-horizontal text-primary" action="/prorabs/" method="POST">
			<input type="hidden" name="action" value="add" />
		  <div class="form-group">
		    <label for="input1" class="col-sm-4 control-label hidden-xs">ФИО:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="name" id="input1" placeholder="Укажите имя" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="login" class="col-sm-4 control-label hidden-xs">Логин для входа (обычно почта):</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="login" placeholder="user@mail.ru" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="pass" class="col-sm-4 control-label hidden-xs">Пароль для входа (если будет пустой сгенерируется случайный):</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="pass" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="tel" class="col-sm-4 control-label hidden-xs">Телефон:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="tel" id="input2" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="note" class="col-sm-4 control-label hidden-xs">Примечание:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="note" id="input4" placeholder="">
		    </div>
		  </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Добавить</button> 
                  <a href="/step/" class="btn btn-default">Очистить</a>
              </div>
          </div>
		</form>			
	                
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
			            'action': 'del_prorabs',
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