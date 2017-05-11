<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="well well-sm">
			Редактирование записи / <a href="/works/">Работы</a>  - {$info.name}
		</div>   
                
        <hr>
	
		<h4>Редактирование:</h4>

		<form class="form-horizontal text-primary" action="/works/" method="POST">
			<input type="hidden" name="action" value="edit" />
			<input type="hidden" name="id" value="{$info.id}" />
          <div class="form-group">
            <label for="name" class="control-label">Нименование:</label>
			<input type="text" class="form-control input-sm" name="name" value="{$info.name}" placeholder="Укажите наименование" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="price" class="control-label">Цена:</label>
			<input type="text" class="form-control input-sm" name="price" value="{$info.price}" placeholder=""/>
          </div>
          <div class="form-group">
            <label for="unit_id" class="control-label">Ед. изм.:</label>
            <select class="form-control" name="unit_id">
   				{html_options values=$list_unit_id output=$list_unit_name selected=$info.unit_id}
			</select>
          </div>
          <div class="form-group">
            <label for="type" class="control-label">Делают:</label>
            <select class="form-control" name="type">
				{html_options values=$list_type output=$list_type selected=$info.type}
			</select>
          </div>
          <div class="form-group">
            <label for="note" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="note" value="{$info.note}" placeholder="" />
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Сохранить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
              </div>
          </div>
		</form>			
	

</div>