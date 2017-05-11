<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="well well-sm">
			Редактирование записи / <a href="/materials/">Материалы</a>  - {$info.name}
		</div>   
                
        <hr>
	
		<h4>Редактирование:</h4>

		<form class="form-horizontal text-primary" action="/materials/" method="POST">
			<input type="hidden" name="action" value="edit" />
			<input type="hidden" name="id" value="{$info.id}" />
          <div class="form-group">
            <label for="name" class="control-label">Нименование:</label>
			<input type="text" class="form-control input-sm" name="name" value="{$info.name}" placeholder="Например: Автоматический выключатель" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Не должно быть пустым!" required />
          </div>
          <div class="form-group">
            <label for="uchastok_id" class="control-label">Тип:</label>
             <select class="form-control" name="type_id" id="input2">
		      {if !empty($list_type)}{section name=cus loop=$list_type}
				  <option value="{$list_type[cus].id}"{if $info.type_id == $list_type[cus].id}selected{/if}>{$list_type[cus].name}</option>
			  {/section}{/if}
			</select>

          </div>
          <div class="form-group">
            <label for="unit_id" class="control-label">Ед. изм.:</label>
           	<select class="form-control" name="unit_id" id="input3">
		      {if !empty($list_unit)}{section name=cus loop=$list_unit}
				  <option value="{$list_unit[cus].id}"{if $info.unit_id == $list_unit[cus].id}selected{/if}>{$list_unit[cus].name}</option>
			  {/section}{/if}
			</select>
          </div>
          <div class="form-group">
            <label for="price" class="control-label">Цена:</label>
			<input type="text" class="form-control input-sm" name="price" value="{$info.price}" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="m" class="control-label">Вес:</label>
			<input type="text" class="form-control input-sm" name="m" value="{$info.m}" id="cnt_m" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="v" class="control-label">Объём:</label>
			<input type="text" class="form-control input-sm" name="v" id="cnt_v" value="{$info.m}" placeholder="100.65" />
          </div>
          <div class="form-group">
            <label for="name" class="control-label">Примечание:</label>
			<input type="text" class="form-control input-sm" name="note" value="{$info.note}" placeholder="Например: ABB" />
          </div>
          <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success">Сохранить</button> 
                  <button type="reset" class="btn btn-default">Очистить</button>
              </div>
          </div>
		</form>			
	
		<div class="well well-sm">
			Привязка к поставщикам / <a href="/materials/">Материалы</a>  - {$info.name}
		</div>   
		
		<form action="/materials/edit/{$info.id}/" method="POST" id="zpost">
			<input type="hidden" name="action" value="zpost" />
                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
	                   <thead>
	                        <tr class="info" align="center">
	                        	<th style="width: 15px" >№</th>
                                <th align="center" style="width: 5%" >Вкл/выкл.</th>
                                <th align="center" style="width: 5%" >Приорит.</th>
                                <th align="center">Поставщик</th>
                                <th align="center">Цена</th>
                                <th align="center">Артикул</th>
                                {*<th>                                    <center><em class="fa fa-cog"></em></center>                                </th>*}
                                
	                        </tr>

	                   </thead>
                    

                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr>
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td><input type="checkbox" value="{if !empty($list[cus].id)}{$list[cus].id}{else}0{/if}" name="vendors[{$list[cus].vid}][vkl]" {if !empty($list[cus].id)}checked{/if}></td>
                                <td><input type="checkbox" value="2" name="vendors[{$list[cus].vid}][prior]" {if !empty($list[cus].is_osnownoy)}checked{/if}></td>
                                <td>{$list[cus].name}</td>
                                <td><input type="text" class="form-control zpost" style="width: 180px" name="vendors[{$list[cus].vid}][price]" value="{$list[cus].price}"></td>
                                <td><input type="text" class="form-control zpost" style="width: 120px" name="vendors[{$list[cus].vid}][article]" value="{$list[cus].article}"></td>

                                {*<td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this,{{$smarty.section.cus.iteration}});" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> </td>*}
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    </div>
                              <div class="form-group">
              <div class="col-sm-offset-4 col-sm-8p">
                  <button type="submit" class="btn btn-success pull-left">Сохранить</button> 
              </div>
          </div>
		</form>		

</div>