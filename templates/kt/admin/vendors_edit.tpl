<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="well well-sm">
			Редактирование записи / <a href="/vendors/">Список поставщиков</a>  - {$info.name}
		</div>   
                
        <hr>
	
		<h4>Редактирование:</h4>

		<form class="form-horizontal text-primary" action="/vendors/" method="POST">
			<input type="hidden" name="action" value="edit" />
			<input type="hidden" name="id" value="{$info.id}" />
          <div class="form-group">
            <label for="name" class="control-label">Нименование:</label>
			<input type="text" class="form-control input-sm" name="name" value="{$info.name}" placeholder="Например: Петрович" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="adress" class="control-label">Адрес:</label>
			<input type="text" class="form-control input-sm" value="{$info.adress}" name="adress" placeholder="" />
          </div>
          <div class="form-group">
            <label for="ur" class="control-label">Юр. лица:</label>
            <textarea name="ur" class="form-control" rows="3">{$info.ur}</textarea>
          </div>
          <div class="form-group">
            <label for="contact" class="control-label">Контактное лицо:</label>
			<input type="text" class="form-control input-sm" value="{$info.contact}" name="contact" placeholder="" />
          </div>
          <div class="form-group">
            <label for="tel" class="control-label">Телефон:</label>
			<input type="text" class="form-control input-sm" value="{$info.tel}" name="tel" placeholder="" />
          </div>
          <div class="form-group">
            <label for="email" class="control-label">Почта:</label>
			<input type="text" class="form-control input-sm" value="{$info.email}" name="email" placeholder="" />
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" value="{$info.note}" name="note" id="cnt_note" placeholder="" />
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Сохранить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
              </div>
          </div>
		</form>			
	

</div>