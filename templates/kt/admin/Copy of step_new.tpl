<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

	<div class="row">
		<h4>Добавление нового этапа</h4>
	
		<form class="form-horizontal text-primary" action="/step/new/" method="POST">
			<input type="hidden" name="action" value="add" />
		  <div class="form-group">
		    <label for="input2" class="col-sm-4 control-label hidden-xs">Тип дома:</label>
		    <div class="col-sm-8">
		      <select class="form-control" name="type_id" id="input2" required>
		      {if !empty($list)}{section name=cus loop=$list}
				  <option value="{$list[cus].id}">{$list[cus].name}</option>
			  {/section}{/if}
				</select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input1" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="name" id="input1" placeholder="Укажите наименование" required autofocus>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input3" class="col-sm-4 control-label hidden-xs">Продолжительность, дни:</label>
		    <div class="col-sm-8">
		      <input type="number" class="form-control" name="days" id="input3" placeholder="" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input4" class="col-sm-4 control-label hidden-xs">Дата начала:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="start_date" id="start_date" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input5" class="col-sm-4 control-label hidden-xs">Сумма этапа:</label>
		    <div class="col-sm-8">
		      <input type="number" class="form-control" name="step_summ" id="step_summ" placeholder="">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input6" class="col-sm-4 control-label hidden-xs">Статус:</label>
		    <div class="col-sm-8">
		      <select class="form-control" name="status_id" id="input6" required>
				  <option value="Предварителен">Предварителен</option>
				  <option value="Активен">Активен</option>
				  <option value="Приостановлен">Приостановлен</option>
				  <option value="Завершен">Завершен</option>
				  <option value="Отменен">Отменен</option>
				</select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input1" class="col-sm-4 control-label hidden-xs">Примечание:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="notr" id="input1" placeholder="">
		    </div>
		  </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Добавить этап</button> 
                  <a href="/step/" class="btn btn-default">Отмена</a>
              </div>
          </div>
		</form>	
	
	</div>

    <script type="text/javascript">
	$(document).ready(function() {    

        $('#start_date').datetimepicker({
        	format: 'YYYY-MM-DD',
            locale: 'ru'
        });


	});

    </script>
