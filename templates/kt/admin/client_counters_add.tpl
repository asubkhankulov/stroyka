<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<h4  class="page-header">Профиль пользователя: {$item.comp_name}</h4>
	
	{include file='dop_menu.tpl'}
	<hr>
	
	<div class="row">
		<h4>Добавление прибора учёта</h4>
	
		<form class="form-horizontal text-primary" action="/index/counters/{$item.id}/" method="POST">
			<input type="hidden" name="action" value="add" />
		  <div class="form-group">
		    <label for="input1" class="col-sm-4 control-label hidden-xs">Место установки:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="mesto_ustanovki" id="input1" placeholder="Укажите объект" required autofocus>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input2" class="col-sm-4 control-label hidden-xs">Тип прибора:</label>
		    <div class="col-sm-8">
		      <select class="form-control" name="counter_type_id" id="input2" required>
		      {if !empty($list)}{section name=cus loop=$list}
				  <option value="{$list[cus].id}">{$list[cus].name}</option>
			  {/section}{/if}
				</select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input3" class="col-sm-4 control-label hidden-xs">Заводской номер прибора:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="serial_number" id="input3" placeholder="Укажите заводской номер" required>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input4" class="col-sm-4 control-label hidden-xs">Год выпуска:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="data_vypuska" id="data_vypuska" placeholder="Укажите год выпуска">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input5" class="col-sm-4 control-label hidden-xs">Дата поверки:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="data_poverki" id="data_poverki" placeholder="Укажите дату поверки прибора">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input6" class="col-sm-4 control-label hidden-xs">Тип измеряемой жидкости:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="type_izm" id="type_izm" placeholder="Укажите тип жидкости">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input7" class="col-sm-4 control-label hidden-xs">ФИО ответсвенного лица:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="fio_otvetsv" id="input7" placeholder="Укажите ответсвенное лицо">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input8" class="col-sm-4 control-label hidden-xs">Телефон:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="tel" id="input8" placeholder="Укажите телефон">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input9" class="col-sm-4 control-label hidden-xs">Email:</label>
		    <div class="col-sm-8">
		      <input type="email" class="form-control" name="email" id="input9" placeholder="Укажите email">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input10" class="col-sm-4 control-label hidden-xs">Номер SIM-карты:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="sim_number" id="input10" placeholder="Укажите номер SIM-карты">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="input11" class="col-sm-4 control-label hidden-xs">Цена в месяц, руб.:</label>
		    <div class="col-sm-8">
		      <input type="text" class="form-control" name="price" id="input11" placeholder="Укажите цену за 1 месяц">
		    </div>
		  </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Добавить прибор</button> 
                  <a href="/index/counters/{$item.id}/" class="btn btn-default">Отмена</a>
              </div>
          </div>
		</form>	
	
	</div>

    <script type="text/javascript">
	$(document).ready(function() {    

        $('#data_poverki').datetimepicker({
        	format: 'YYYY-MM-DD',
            locale: 'ru'
        });
        $('#data_vypuska').datetimepicker({
        	viewMode: 'years',
        	format: 'YYYY',
            locale: 'ru'
        });		

	});

    </script>
