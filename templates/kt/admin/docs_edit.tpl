<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="well well-sm">
			Редактирование записи / <a href="/docs/">Документы</a>  - {$info.name}
		</div>   
                
        <hr>
	
		<h4>Редактирование:</h4>
	
		<form class="form-horizontal text-primary" action="/docs/" method="POST">
			<input type="hidden" name="action" value="edit" />
			<input type="hidden" name="id" value="{$info.id}" />
          <div class="form-group">
            <label for="name" class="control-label">Наименование:</label>
			<input type="text" class="form-control input-sm" name="name" value="{$info.name}" id="cnt_name" placeholder="Например: Генплан" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="price" class="control-label">Цена:</label>
			<input type="text" class="form-control input-sm" name="price" value="{$info.price}" id="cnt_price" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="srok" class="control-label">Срок:</label>
			<input type="text" class="form-control input-sm" name="srok" value="{$info.srok}" id="cnt_m" placeholder="10" />
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="note" value="{$info.note}" id="cnt_note" placeholder="Например: черновик" />
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Сохранить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
              </div>
          </div>
		</form>	
</div>