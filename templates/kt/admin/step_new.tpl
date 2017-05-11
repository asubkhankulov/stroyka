<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

	<div class="row">
		<h4>Добавление нового этапа</h4>
	
		<form class="form-horizontal text-primary" action="/step/new/" method="POST">
			<input type="hidden" name="action" value="add" />
		  <div class="form-group">
		    <label for="input1" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="name" id="input1" placeholder="Укажите наименование" required autofocus>
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
