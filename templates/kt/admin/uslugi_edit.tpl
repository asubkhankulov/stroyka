<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="well well-sm">
			Редактирование записи / <a href="/uslugi/">Услуги</a>  - {$info.name}
		</div>   
                
        <hr>
	
		<h4>Редактирование:</h4>
	
		<form class="form-horizontal text-primary" action="/uslugi/" method="POST">
			<input type="hidden" name="action" value="edit" />
			<input type="hidden" name="id" value="{$info.id}" />
          <div class="form-group">
            <label for="name" class="control-label">Наименование:</label>
			<input type="text" class="form-control input-sm" name="name" value="{$info.name}" id="cnt_name" placeholder="Например: Шабашники" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="type" class="control-label">Тип:</label>
            <select class="form-control" name="type">
				{html_options values=$list_type output=$list_type selected=$info.type}
			</select>
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Сохранить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
              </div>
          </div>
		</form>	
</div>