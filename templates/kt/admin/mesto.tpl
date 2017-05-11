            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Посёлки</h1>
                
                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th style="width: 5%">№</th>
                                <th align="center">Наименование</th>
                                <th align="center">Участков</th>
                                <th align="center">Срок обеспечение материалом</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr id="cnt_{$list[cus].id}">
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}"><input type="text" class="form-control" name="name" value="{$list[cus].name}" id="{$list[cus].id}_name"></td>
                                <td><a href="/mesto/{$list[cus].id}/">{$list[cus].kol}</a></td>
                                <td><input type="text" class="form-control" name="days" value="{$list[cus].days}" id="{$list[cus].id}_days"></td>
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
		
<hr>
		<h4>Добавление нового</h4>
	
		<form class="form-horizontal text-primary" action="/mesto/" method="POST">
			<input type="hidden" name="action" value="add" />
		  <div class="form-group">
		    <label for="input1" class="col-sm-4 control-label hidden-xs">Наименование посёлка:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="name" id="input1" placeholder="Укажите наименование" required>
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
                  <button type="reset" class="btn btn-default">Очистить форму</button> 
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

			var field = '';        

			UpdateField = function(field_id, obj) {
				

				var val1 = $("#"+field_id+"_name").val();
				var val2 = $("#"+field_id+"_days").val();
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_mesto',
	                'id': field_id,
	                'name': val1,
	                'days': val2
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
			            'action': 'del_mesto',
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