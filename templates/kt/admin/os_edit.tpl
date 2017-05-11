<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="well well-sm">
			Редактирование записи / <a href="/os/">Основные средства</a>  - {$info.name}
		</div>   
                
        <hr>
	
		<h4>Редактирование:</h4>

		<form class="form-horizontal text-primary" action="/os/" method="POST">
			<input type="hidden" name="action" value="edit" />
			<input type="hidden" name="id" value="{$info.id}" />
          <div class="form-group">
            <label for="name" class="control-label">Нименование:</label>
			<input type="text" class="form-control input-sm" name="name" value="{$info.name}" placeholder="Например: АК-47 штурмовой вариант" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="uchastok_id" class="control-label">Местоположение</label>
           	<select class="form-control" name="uchastok_id" id="input3">
           		<option value="0">Неопределено</option>
		      {if !empty($list_mesto)}{section name=cus loop=$list_mesto}
				  <option value="{$list_mesto[cus].id}" {if $info.uchastok_id == $list_mesto[cus].id}selected{/if}>{$list_mesto[cus].uchastok} / {$list_mesto[cus].poselok}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="price" class="control-label">Цена:</label>
			<input type="text" class="form-control input-sm" name="price" value="{$info.price}" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="kol" class="control-label">Количество:</label>
			<input type="text" class="form-control input-sm" name="kol" value="{$info.kol}" placeholder="5" required />
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="note" value="{$info.note}" placeholder="бронебойные" />
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Сохранить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
              </div>
          </div>
		</form>			
	

</div>