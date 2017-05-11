<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<div class="well well-sm">
		<a href="/doma/">Типы построек</a> / {$info.name}  - cписок этапов:
	</div>                

{include file='dop_menu_shablon.tpl'}        

<hr>
	
	<div class="row">

		<div><br/>
		  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist" id="tblist">
		    <li role="presentation" {if $tab==''}class="active"{/if}><a href="#all" aria-controls="all" role="tab" data-toggle="tab">Этапы списком</a></li>
		    <li role="presentation" {if $tab=='Коробка'}class="active"{/if}><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Коробка</a></li>
		    <li role="presentation" {if $tab=='Внутренние'}class="active"{/if}><a href="#vnutr" aria-controls="vnutr" role="tab" data-toggle="tab">Внутренние</a></li>
		    <li role="presentation" {if $tab=='Внешние'}class="active"{/if}><a href="#vnesh" aria-controls="vnesh" role="tab" data-toggle="tab">Внешние</a></li>
		    <li role="presentation" {if $tab=='Сети'}class="active"{/if}><a href="#seti" aria-controls="seti" role="tab" data-toggle="tab">Сети</a></li>
		    <li role="presentation" {if $tab=='Благоустройство'}class="active"{/if}><a href="#blago" aria-controls="blago" role="tab" data-toggle="tab">Благоустройство</a></li>
		    <li role="presentation" {if $tab=='Документация'}class="active"{/if}><a href="#docum" aria-controls="docum" role="tab" data-toggle="tab">Документация</a></li>
		  </ul>
		
		  <!-- Tab panes --> {* ВСее Внутренние Внешние Сети Благоустройство Документация *}
		  <div class="tab-content">
		    <div role="tabpanel" class="tab-pane fade in{if $tab==''} active{/if}" id="all">
		    <br>
				<div class="panel panel-warning">
				  <div class="panel-heading"><span class="label label-info"><strong>Этапы списком</strong></span></div>
				  <div class="panel-body">
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>№</th>
                             <th align="center">Тип</th>
                             <th align="center">п/н</th>
                             <th align="center">Наименование</th>
                             <th align="center">Объём этапа</th>
                             <th align="center">Ед. изм.</th>
                             <th align="center">Сумма, руб.</th>
                             <th align="center">Цена этапа, руб.</th>
                             <th align="center">Продолж., дни</th>
                             <th align="center">Сумма мат., руб</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                        <tbody>{if !empty($list)}
                        {assign var="all_price" value=0}
                        {*assign var="all_v" value=0*}
                        {assign var="all_days" value=0}
                        {section name=cus loop=$list}
                            <tr id="cnt_{$list[cus].id}">
                             	<td>{{$smarty.section.cus.iteration}}</td>
                                <td>{$list[cus].step_type}</td>
                                <td><input type="text" class="form-control" name="sort" value="{$list[cus].sort}" id="{$list[cus].id}_sort"></td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/works/{$list[cus].step_id}/{$doma_id}/">{$list[cus].name}<br>(работ: {$list[cus].cnt_works|default:0})</a></td>
                                <td><input type="text" class="form-control" name="v_step" value="{$list[cus].v_step}" id="{$list[cus].id}_v_step"></td>
                                <td><select class="form-control" name="unit_id" id="{$list[cus].id}_unit">
							      {if !empty($list_unit)}{section name=cus2 loop=$list_unit}
									  <option value="{$list_unit[cus2].id}" {if $list[cus].unit_id  == $list_unit[cus2].id}selected{/if}>{$list_unit[cus2].name}</option>
								  {/section}{/if}
								</select>
								</td>
                                <td>{$list[cus].price_summ}</td>
                                <td>{if $list[cus].v_step!='0.0' and !empty($list[cus].v_step)}{$list[cus].price_summ/$list[cus].v_step}{else}нет объема этапа{/if}</td>
                                <td>{$list[cus].days_summ}</td>
                                <td>{$list[cus].ma_summ}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                            {assign var=all_price value=$all_price+$list[cus].price_summ}
                            {*assign var=all_v value=$all_v+$list[cus].v_summ*}
                            {assign var=all_days value=$all_days+$list[cus].days_summ}

                        {/section}  {/if}  
                        </tbody>                     
                        <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td>{$all_price}</td>
                             <td></td>
                             <td>{$all_days}</td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                         </tr>
                     </tfoot>
                 </table>					
				  </div>
				</div>
	    		<br>
	    		
					<h4>Добавление этапа:</h4>
				
					<form class="form-horizontal text-primary" action="/doma/step/{$doma_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="type" value="" />
					  <div class="form-group">
					    <label for="step_id" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="step_id" id="input3">
						      {if !empty($list_steps)}{section name=cus loop=$list_steps}
								  <option value="{$list_steps[cus].id}">{$list_steps[cus].name} / {$list_steps[cus].type|default:'не указан тип'}</option>
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="input1" class="col-sm-4 control-label hidden-xs">Примечание:</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" name="note" id="note" placeholder="">
					    </div>
					  </div>
			          <div class="form-group">
			              <div class="col-sm-offset-4 col-sm-8p">
			                  <button type="submit" class="btn btn-success">Добавить этап</button> 
			                  <a href="/step/" class="btn btn-default">Отмена</a>
			              </div>
			          </div>
					</form>	
		    	</div> {*end tab*}
		    <div role="tabpanel" class="tab-pane fade in{if $tab=='Коробка'} active{/if}" id="home">
		    <br>
				<div class="panel panel-warning">
				  <div class="panel-heading"><span class="label label-info"><strong>Коробка</strong></span></div>
				  <div class="panel-body">
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>№</th>
                             <th align="center">Наименование</th>
                             <th align="center">Объём этапа</th>
                             <th align="center">Ед. изм.</th>
                             <th align="center">Сумма, руб.</th>
                             <th align="center">Цена этапа, руб.</th>
                             <th align="center">Продолж., дни</th>
                             <th align="center">Сумма мат., руб</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                        <tbody>{if !empty($list)}
                        {assign var="all_price" value=0}
                        {*assign var="all_v" value=0*}
                        {assign var="all_days" value=0}
                        {section name=cus loop=$list}
                        	{if $list[cus].type == 'Коробка'}
                            <tr id="cnt_{$list[cus].id}">
                             	<td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/works/{$list[cus].step_id}/{$doma_id}/">{$list[cus].name}</a></td>
                                <td><input type="text" class="form-control" name="v_step" value="{$list[cus].v_step}" id="{$list[cus].id}_v_step"></td>
                                <td><select class="form-control" name="unit_id" id="{$list[cus].id}_unit">
							      {if !empty($list_unit)}{section name=cus2 loop=$list_unit}
									  <option value="{$list_unit[cus2].id}" {if $list[cus].unit_id  == $list_unit[cus2].id}selected{/if}>{$list_unit[cus2].name}</option>
								  {/section}{/if}
								</select>
								</td>
                                <td>{$list[cus].price_summ}</td>
                                <td>{if $list[cus].v_step!='0.0' and !empty($list[cus].v_step)}{$list[cus].price_summ/$list[cus].v_step}{else}нет объема этапа{/if}</td>
                                <td>{$list[cus].days_summ}</td>
                                <td>{$list[cus].ma_summ}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                            {assign var=all_price value=$all_price+$list[cus].price_summ}
                            {*assign var=all_v value=$all_v+$list[cus].v_summ*}
                            {assign var=all_days value=$all_days+$list[cus].days_summ}
                            {/if}
                        {/section}  {/if}  
                        </tbody>                     
                        <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td>{$all_price}</td>
                             <td></td>
                             <td>{$all_days}</td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                         </tr>
                     </tfoot>
                 </table>					
				  </div>
				</div>
	    		<br>
	    		
					<h4>Добавление этапа:</h4>
				
					<form class="form-horizontal text-primary" action="/doma/step/{$doma_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="type" value="Коробка" />
					  <div class="form-group">
					    <label for="step_id" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="step_id" id="input3">
						      {if !empty($list_steps)}{section name=cus loop=$list_steps}
						      	{if $list_steps[cus].type == 'Коробка'}
								  <option value="{$list_steps[cus].id}">{$list_steps[cus].name}</option>
								{/if}
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="input1" class="col-sm-4 control-label hidden-xs">Примечание:</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" name="note" id="note" placeholder="">
					    </div>
					  </div>
			          <div class="form-group">
			              <div class="col-sm-offset-4 col-sm-8p">
			                  <button type="submit" class="btn btn-success">Добавить этап</button> 
			                  <a href="/step/" class="btn btn-default">Отмена</a>
			              </div>
			          </div>
					</form>	
		    	</div> {*end tab*}
		    <div role="tabpanel" class="tab-pane fade in{if $tab=='Внутренние'} active{/if}" id="vnutr">
		    <br>
				<div class="panel panel-warning">
				  <div class="panel-heading"><span class="label label-info"><strong>Внутренние</strong></span></div>
				  <div class="panel-body">
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>№</th>
                             <th align="center">Наименование</th>
                             <th align="center">Объём этапа</th>
                             <th align="center">Ед. изм.</th>
                             <th align="center">Сумма, руб.</th>
                             <th align="center">Цена этапа, руб.</th>
                             <th align="center">Продолж., дни</th>
                             <th align="center">Сумма мат., руб</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                        <tbody>{if !empty($list)}
                        {assign var="all_price" value=0}
                        {*assign var="all_v" value=0*}
                        {assign var="all_days" value=0}
                        {section name=cus loop=$list}
                        	{if $list[cus].type == 'Внутренние'}
                            <tr id="cnt_{$list[cus].id}">
                             	<td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/works/{$list[cus].step_id}/{$doma_id}/">{$list[cus].name}</a></td>
                                <td><input type="text" class="form-control" name="v_step" value="{$list[cus].v_step}" id="{$list[cus].id}_v_step"></td>
                                <td><select class="form-control" name="unit_id" id="{$list[cus].id}_unit">
							      {if !empty($list_unit)}{section name=cus2 loop=$list_unit}
									  <option value="{$list_unit[cus2].id}" {if $list[cus].unit_id  == $list_unit[cus2].id}selected{/if}>{$list_unit[cus2].name}</option>
								  {/section}{/if}
								</select>
								</td>
                                <td>{$list[cus].price_summ}</td>
                                <td>{if $list[cus].v_step!='0.0' and !empty($list[cus].v_step)}{$list[cus].price_summ/$list[cus].v_step}{else}нет объема этапа{/if}</td>
                                <td>{$list[cus].days_summ}</td>
                                <td>{$list[cus].ma_summ}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                            {assign var=all_price value=$all_price+$list[cus].price_summ}
                            {*assign var=all_v value=$all_v+$list[cus].v_summ*}
                            {assign var=all_days value=$all_days+$list[cus].days_summ}
                            {/if}
                        {/section}  {/if}  
                        </tbody>                     
                        <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td>{$all_price}</td>
                             <td></td>
                             <td>{$all_days}</td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                         </tr>
                     </tfoot>
                 </table>					
				  </div>
				</div>
	    		<br>
	    		
					<h4>Добавление этапа:</h4>
				
					<form class="form-horizontal text-primary" action="/doma/step/{$doma_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="type" value="Внутренние" />
					  <div class="form-group">
					    <label for="step_id" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="step_id" id="input3">
						      {if !empty($list_steps)}{section name=cus loop=$list_steps}
						      	{if $list_steps[cus].type == 'Внутренние'}
								  <option value="{$list_steps[cus].id}">{$list_steps[cus].name}</option>
								{/if}
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="input1" class="col-sm-4 control-label hidden-xs">Примечание:</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" name="note" id="note" placeholder="">
					    </div>
					  </div>
			          <div class="form-group">
			              <div class="col-sm-offset-4 col-sm-8p">
			                  <button type="submit" class="btn btn-success">Добавить этап</button> 
			                  <a href="/step/" class="btn btn-default">Отмена</a>
			              </div>
			          </div>
					</form>	
		    	</div> {*end tab*}
		    <div role="tabpanel" class="tab-pane fade in{if $tab=='Внешние'} active{/if}" id="vnesh">
		    <br>
				<div class="panel panel-warning">
				  <div class="panel-heading"><span class="label label-info"><strong>Внешние</strong></span></div>
				  <div class="panel-body">
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>№</th>
                             <th align="center">Наименование</th>
                             <th align="center">Объём этапа</th>
                             <th align="center">Ед. изм.</th>
                             <th align="center">Сумма, руб.</th>
                             <th align="center">Цена этапа, руб.</th>
                             <th align="center">Продолж., дни</th>
                             <th align="center">Сумма мат., руб</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                        <tbody>{if !empty($list)}
                        {assign var="all_price" value=0}
                        {*assign var="all_v" value=0*}
                        {assign var="all_days" value=0}
                        {section name=cus loop=$list}
                        	{if $list[cus].step_type == 'Внешние'}
                            <tr id="cnt_{$list[cus].id}">
                             	<td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/works/{$list[cus].step_id}/{$doma_id}/">{$list[cus].name}</a></td>
                                <td><input type="text" class="form-control" name="v_step" value="{$list[cus].v_step}" id="{$list[cus].id}_v_step"></td>
                                <td><select class="form-control" name="unit_id" id="{$list[cus].id}_unit">
							      {if !empty($list_unit)}{section name=cus2 loop=$list_unit}
									  <option value="{$list_unit[cus2].id}" {if $list[cus].unit_id  == $list_unit[cus2].id}selected{/if}>{$list_unit[cus2].name}</option>
								  {/section}{/if}
								</select>
								</td>
                                <td>{$list[cus].price_summ}</td>
                                <td>{if $list[cus].v_step!='0.0' and !empty($list[cus].v_step)}{$list[cus].price_summ/$list[cus].v_step}{else}нет объема этапа{/if}</td>
                                <td>{$list[cus].days_summ}</td>
                                <td>{$list[cus].ma_summ}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                            {assign var=all_price value=$all_price+$list[cus].price_summ}
                            {*assign var=all_v value=$all_v+$list[cus].v_summ*}
                            {assign var=all_days value=$all_days+$list[cus].days_summ}
                            {/if}
                        {/section}  {/if}  
                        </tbody>                     
                        <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td>{$all_price}</td>
                             <td></td>
                             <td>{$all_days}</td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                         </tr>
                     </tfoot>
                 </table>					
				  </div>
				</div>
	    		<br>
	    		
					<h4>Добавление этапа:</h4>
				
					<form class="form-horizontal text-primary" action="/doma/step/{$doma_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="type" value="Внешние" />
					  <div class="form-group">
					    <label for="step_id" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="step_id" id="input3">
						      {if !empty($list_steps)}{section name=cus loop=$list_steps}
						      	{if $list_steps[cus].step_type == 'Внешние'}
								  <option value="{$list_steps[cus].id}">{$list_steps[cus].name}</option>
								{/if}
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="input1" class="col-sm-4 control-label hidden-xs">Примечание:</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" name="note" id="note" placeholder="">
					    </div>
					  </div>
			          <div class="form-group">
			              <div class="col-sm-offset-4 col-sm-8p">
			                  <button type="submit" class="btn btn-success">Добавить этап</button> 
			                  <a href="/step/" class="btn btn-default">Отмена</a>
			              </div>
			          </div>
					</form>	
		    	</div> {*end tab*}
		    <div role="tabpanel" class="tab-pane fade in{if $tab=='Сети'} active{/if}" id="seti">
		    <br>
				<div class="panel panel-warning">
				  <div class="panel-heading"><span class="label label-info"><strong>Сети</strong></span></div>
				  <div class="panel-body">
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>№</th>
                             <th align="center">Наименование</th>
                             <th align="center">Объём этапа</th>
                             <th align="center">Ед. изм.</th>
                             <th align="center">Сумма, руб.</th>
                             <th align="center">Цена этапа, руб.</th>
                             <th align="center">Продолж., дни</th>
                             <th align="center">Сумма мат., руб</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                        <tbody>{if !empty($list)}
                        {assign var="all_price" value=0}
                        {*assign var="all_v" value=0*}
                        {assign var="all_days" value=0}
                        {section name=cus loop=$list}
                        	{if $list[cus].step_type == 'Сети'}
                            <tr id="cnt_{$list[cus].id}">
                             	<td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/works/{$list[cus].step_id}/{$doma_id}/">{$list[cus].name}</a></td>
                                <td><input type="text" class="form-control" name="v_step" value="{$list[cus].v_step}" id="{$list[cus].id}_v_step"></td>
                                <td><select class="form-control" name="unit_id" id="{$list[cus].id}_unit">
							      {if !empty($list_unit)}{section name=cus2 loop=$list_unit}
									  <option value="{$list_unit[cus2].id}" {if $list[cus].unit_id  == $list_unit[cus2].id}selected{/if}>{$list_unit[cus2].name}</option>
								  {/section}{/if}
								</select>
								</td>
                                <td>{$list[cus].price_summ}</td>
                                <td>{if $list[cus].v_step!='0.0' and !empty($list[cus].v_step)}{$list[cus].price_summ/$list[cus].v_step}{else}нет объема этапа{/if}</td>
                                <td>{$list[cus].days_summ}</td>
                                <td>{$list[cus].ma_summ}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                            {assign var=all_price value=$all_price+$list[cus].price_summ}
                            {*assign var=all_v value=$all_v+$list[cus].v_summ*}
                            {assign var=all_days value=$all_days+$list[cus].days_summ}
                            {/if}
                        {/section}  {/if}  
                        </tbody>                     
                        <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td>{$all_price}</td>
                             <td></td>
                             <td>{$all_days}</td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                         </tr>
                     </tfoot>
                 </table>					
				  </div>
				</div>
	    		<br>
	    		
					<h4>Добавление этапа:</h4>
				
					<form class="form-horizontal text-primary" action="/doma/step/{$doma_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="type" value="Сети" />
					  <div class="form-group">
					    <label for="step_id" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="step_id" id="input3">
						      {if !empty($list_steps)}{section name=cus loop=$list_steps}
						      	{if $list_steps[cus].step_type == 'Сети'}
								  <option value="{$list_steps[cus].id}">{$list_steps[cus].name}</option>
								{/if}
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="input1" class="col-sm-4 control-label hidden-xs">Примечание:</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" name="note" id="note" placeholder="">
					    </div>
					  </div>
			          <div class="form-group">
			              <div class="col-sm-offset-4 col-sm-8p">
			                  <button type="submit" class="btn btn-success">Добавить этап</button> 
			                  <a href="/step/" class="btn btn-default">Отмена</a>
			              </div>
			          </div>
					</form>	
		    	</div> {*end tab*}
		    <div role="tabpanel" class="tab-pane fade in{if $tab=='Благоустройство'} active{/if}" id="blago">
		    <br>
				<div class="panel panel-warning">
				  <div class="panel-heading"><span class="label label-info"><strong>Благоустройство</strong></span></div>
				  <div class="panel-body">
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>№</th>
                             <th align="center">Наименование</th>
                             <th align="center">Объём этапа</th>
                             <th align="center">Ед. изм.</th>
                             <th align="center">Сумма, руб.</th>
                             <th align="center">Цена этапа, руб.</th>
                             <th align="center">Продолж., дни</th>
                             <th align="center">Сумма мат., руб</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                        <tbody>{if !empty($list)}
                        {assign var="all_price" value=0}
                        {*assign var="all_v" value=0*}
                        {assign var="all_days" value=0}
                        {section name=cus loop=$list}
                        	{if $list[cus].step_type == 'Благоустройство'}
                            <tr id="cnt_{$list[cus].id}">
                             	<td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/works/{$list[cus].step_id}/{$doma_id}/">{$list[cus].name}</a></td>
                                <td><input type="text" class="form-control" name="v_step" value="{$list[cus].v_step}" id="{$list[cus].id}_v_step"></td>
                                <td><select class="form-control" name="unit_id" id="{$list[cus].id}_unit">
							      {if !empty($list_unit)}{section name=cus2 loop=$list_unit}
									  <option value="{$list_unit[cus2].id}" {if $list[cus].unit_id  == $list_unit[cus2].id}selected{/if}>{$list_unit[cus2].name}</option>
								  {/section}{/if}
								</select>
								</td>
                                <td>{$list[cus].price_summ}</td>
                                <td>{if $list[cus].v_step!='0.0' and !empty($list[cus].v_step)}{$list[cus].price_summ/$list[cus].v_step}{else}нет объема этапа{/if}</td>
                                <td>{$list[cus].ma_summ}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                            {assign var=all_price value=$all_price+$list[cus].price_summ}
                            {*assign var=all_v value=$all_v+$list[cus].v_summ*}
                            {assign var=all_days value=$all_days+$list[cus].days_summ}
                            {/if}
                        {/section}  {/if}  
                        </tbody>                     
                        <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td>{$all_price}</td>
                             <td></td>
                             <td>{$all_days}</td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                         </tr>
                     </tfoot>
                 </table>					
				  </div>
				</div>
	    		<br>
	    		
					<h4>Добавление этапа:</h4>
				
					<form class="form-horizontal text-primary" action="/doma/step/{$doma_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="type" value="Благоустройство" />
					  <div class="form-group">
					    <label for="step_id" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="step_id" id="input3">
						      {if !empty($list_steps)}{section name=cus loop=$list_steps}
						      	{if $list_steps[cus].step_type == 'Благоустройство'}
								  <option value="{$list_steps[cus].id}">{$list_steps[cus].name}</option>
								{/if}
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="input1" class="col-sm-4 control-label hidden-xs">Примечание:</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" name="note" id="note" placeholder="">
					    </div>
					  </div>
			          <div class="form-group">
			              <div class="col-sm-offset-4 col-sm-8p">
			                  <button type="submit" class="btn btn-success">Добавить этап</button> 
			                  <a href="/step/" class="btn btn-default">Отмена</a>
			              </div>
			          </div>
					</form>	
		    	</div> {*end tab*}
		    <div role="tabpanel" class="tab-pane fade in{if $tab=='Документация'} active{/if}" id="docum">
		    <br>
				<div class="panel panel-warning">
				  <div class="panel-heading"><span class="label label-info"><strong>Документация</strong></span></div>
				  <div class="panel-body">
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>№</th>
                             <th align="center">Наименование</th>
                             <th align="center">Объём этапа</th>
                             <th align="center">Ед. изм.</th>
                             <th align="center">Сумма, руб.</th>
                             <th align="center">Цена этапа, руб.</th>
                             <th align="center">Продолж., дни</th>
                             <th align="center">Сумма мат., руб</th>
                             <th align="center">Действие</th>
                         </tr>
                     </thead>
                        <tbody>{if !empty($list)}
                        {assign var="all_price" value=0}
                        {*assign var="all_v" value=0*}
                        {assign var="all_days" value=0}
                        {section name=cus loop=$list}
                        	{if $list[cus].step_type == 'Документация'}
                            <tr id="cnt_{$list[cus].id}">
                             	<td>{{$smarty.section.cus.iteration}}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/works/{$list[cus].step_id}/{$doma_id}/">{$list[cus].name}</a></td>
                                <td><input type="text" class="form-control" name="v_step" value="{$list[cus].v_step}" id="{$list[cus].id}_v_step"></td>
                                <td><select class="form-control" name="unit_id" id="{$list[cus].id}_unit">
							      {if !empty($list_unit)}{section name=cus2 loop=$list_unit}
									  <option value="{$list_unit[cus2].id}" {if $list[cus].unit_id  == $list_unit[cus2].id}selected{/if}>{$list_unit[cus2].name}</option>
								  {/section}{/if}
								</select>
								</td>
                                <td>{$list[cus].price_summ}</td>
                                <td>{if $list[cus].v_step!='0.0' and !empty($list[cus].v_step)}{$list[cus].price_summ/$list[cus].v_step}{else}нет объема этапа{/if}</td>
                                <td>{$list[cus].days_summ}</td>
                                <td>{$list[cus].ma_summ}</td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$list[cus].id}"><em class="fa fa-trash"></em></button> </td>
                            </tr>
                            {assign var=all_price value=$all_price+$list[cus].price_summ}
                            {*assign var=all_v value=$all_v+$list[cus].v_summ*}
                            {assign var=all_days value=$all_days+$list[cus].days_summ}
                            {/if}
                        {/section}  {/if}  
                        </tbody>                     
                        <tfoot>
                         <tr class="active">
                             <td><b>Итого:</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td>{$all_price}</td>
                             <td></td>
                             <td>{$all_days}</td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                         </tr>
                     </tfoot>
                 </table>					
				  </div>
				</div>
	    		<br>
	    		
					<h4>Добавление этапа:</h4>
				
					<form class="form-horizontal text-primary" action="/doma/step/{$doma_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="type" value="Документация" />
					  <div class="form-group">
					    <label for="step_id" class="col-sm-4 control-label hidden-xs">Наименование этапа:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="step_id" id="input3">
						      {if !empty($list_steps)}{section name=cus loop=$list_steps}
						      	{if $list_steps[cus].step_type == 'Документация'}
								  <option value="{$list_steps[cus].id}">{$list_steps[cus].name}</option>
								{/if}
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="input1" class="col-sm-4 control-label hidden-xs">Примечание:</label>
					    <div class="col-sm-8">
					      <input type="text" class="form-control" name="note" id="note" placeholder="">
					    </div>
					  </div>
			          <div class="form-group">
			              <div class="col-sm-offset-4 col-sm-8p">
			                  <button type="submit" class="btn btn-success">Добавить этап</button> 
			                  <a href="/step/" class="btn btn-default">Отмена</a>
			              </div>
			          </div>
					</form>	
		    	</div> {*end tab*}

      
		    </div>
				

	    		<br>
		 </div>
	</div>
		
</div>	
	

	


    <script type="text/javascript" src="/js/numberFormat154.js"></script>     
    <script type="text/javascript">

	
	$(document).ready(function() {    

		$(function () {
			  $('[data-toggle="tooltip"]').tooltip();

		});

		var field = '';        

		UpdateField = function(field_id, obj) {
			

			var val1 = $("#"+field_id+"_v_step").val();
			var val2 = $("#"+field_id+"_unit").val();
			var val3 = $("#"+field_id+"_sort").val();
			if (field != '') $(field).tooltip('hide');
			field = obj;
			
			
			url = '/ajax/index.php';       
            $.post(url,
            {
                'action': 'update_doma_step',
                'id': field_id,
                'val1': val1,
                'val2': val2,
                'val3': val3
            }, checkTime = function(data) {
				

            	switch(data) {
                case 'ok':
                	$(field).tooltip('show');
                    break
                default:
                	$(field).tooltip(data);
            }


			});
		}		    
		
	    
	});

    </script>
