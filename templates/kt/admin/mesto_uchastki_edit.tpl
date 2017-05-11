<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="well well-sm">
			Редактирование записи / <a href="/mesto/">Посёлки</a> / Участок  - {$info.name}
		</div>   
                
        <hr>
	
		<h4>Редактирование:</h4>
	
		<form class="form-horizontal text-primary" action="/mesto/{$info.mesto_id}/" method="POST">
			<input type="hidden" name="action" value="edit" />
			<input type="hidden" name="id" value="{$info.id}" />
		  <div class="form-group">
		    <label for="input1" class="col-sm-4 control-label hidden-xs">Наименование участка:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="name" value="{$info.name}" placeholder="Укажите наименование" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="s" class="col-sm-4 control-label hidden-xs">Размер, соток:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" value="{$info.s}" name="s" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="d" class="col-sm-4 control-label hidden-xs">Длина, м:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="d" value="{$info.d}" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="shir" class="col-sm-4 control-label hidden-xs">Ширина, м:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="shir" value="{$info.shir}" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="septik" class="col-sm-4 control-label hidden-xs">Септик</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="septik" value="{$info.septik}" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="voda" class="col-sm-4 control-label hidden-xs">Вода:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="voda" value="{$info.voda}" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="note" class="col-sm-4 control-label hidden-xs">Примечание:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="note"  value="{$info.note}" placeholder="">
		    </div>
		  </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Сохранить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
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

		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_uch',
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