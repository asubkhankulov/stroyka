<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<h4  class="page-header">Список приборов учёта</h4>
	
	<div class="row">
	
             <div class="table-responsive{if empty($list)} hidden{/if}">
                 <table class="table table-striped table-bordered table-list">
                     <thead>
                         <tr>
                             <th style="width: 5%">№</th>
                             <th  align="center">Наименование прибора</th>
                             <th  align="center">Место установки</th>
                             <th  align="center">Статус*</th>
                             <th  align="center">Заводской номер</th>
                             <th  align="center">Дата поверки</th>
                             <th  align="center">Тип измеряемой жидкости</th>
                             <th  align="center">Баланс SIM-карты, руб.</th>
                             <th  align="center">Суммарный расход, м3</th>
                             <th>
                                 <center><em class="fa fa-cog"></em></center>
                             </th>
                         </tr>
                     </thead>
                     <tbody>{if !empty($list)}
                     {section name=cus loop=$list}
                         <tr id="cnt_{$list[cus].id}">
                             <td>{$smarty.section.cus.iteration}</td>
                             <td>{$list[cus].pribor}</td>
                             <td>{$list[cus].mesto_ustanovki}</td>
                             <td><span {if $list[cus].maxdate == $today}class="label label-success" title="Есть данные за текущие сутки" {else}class="label label-default" title="Нет данных за текущие сутки"{/if}" data-toggle="tooltip" data-placement="top">{if $list[cus].maxdate == $today}Работает{else}Не работает{/if}</span></td>
                             <td>{$list[cus].serial_number}</td>
                             <td>{$list[cus].data_poverki|date_format:"%d.%m.%Y"}
                             {if $list[cus].days_to_poverka < 90}
                             <span data-toggle="popover" data-placement="auto top" data-html="true" data-trigger="hover" title="" data-content="{if $list[cus].days_to_poverka <= 0}Срок поверки расходомера <strong>закончился {$list[cus].next_poverka} г</strong>.</br>
Для помощи в проведении поверки можете позвонить по телефону  </br><strong>+7 (499) 110-47-01</strong></br>
или написать письмо на электронную почту: <strong><a href='mailto:info@odis24.ru'>info@odis24.ru</a></strong>{else}Срок поверки расходомера <strong>закончится {$list[cus].next_poverka} г</strong>.</br>
Для помощи в проведении поверки можете позвонить по телефону  </br><strong>+7 (499) 110-47-01</strong></br>
или написать письмо на электронную почту: <strong><a href='mailto:info@odis24.ru'>info@odis24.ru</a></strong>{/if}" style="color:red;cursor: pointer"><i class="glyphicon glyphicon-warning-sign" aria-hidden="true"></i></span>{/if}</td>
                             <td>{$list[cus].type_izm}</td>
                             <td>{$list[cus].balans|default:"нет данных"}</td>
                             <td>{if $inf_balance>0}{$list[cus].mx|replace:',':' '|default:"нет данных"}{else}****{/if}</td>
                             <td align="center"> <a href="/index/counters/{$list[cus].id}/" class="btn btn-success" title="Редактировать" >Подробнее</a></td>
                         </tr>
                     {/section}  {/if}  
                     </tbody>
                 </table>
			</div>
			
			<div class="well well-sm">
				<span class="label label-success">Работает</span> - Есть данные со счётчика за текущие сутки;</br>
				<span class="label label-default">Не работает</span> - Нет данных со счётчика за текущие сутки;
			</div>
			
		<div class="well well-lg{if !empty($list)} hidden{/if}">Пока нет ни одной записи.</div>			
	
	</div>
	
    <script type="text/javascript">
	$(document).ready(function() {    

		$(function () {
			  $('[data-toggle="popover"]').popover()
			})

	});

    </script>	