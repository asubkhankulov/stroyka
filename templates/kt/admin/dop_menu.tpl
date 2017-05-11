	 <div class="row">
	    <div class="btn-group btn-group-justified" role="group" aria-label="...">
	      <div class="btn-group" role="group">
	        <a href="/stroyka/view/{$uchastok_id}/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'view' or $smarty.const.MODULE_DOP == 'view'}primary{else}default{/if}" role="button"><i class="fa fa-book" aria-hidden="true"></i> <span class="hidden-xs">Сводная информация</span></a>
	      </div>
	      <div class="btn-group" role="group">
	        <a href="/stroyka/plan/{$uchastok_id}/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'plan'}primary{else}default{/if}" role="button"><i class="fa fa-calculator" aria-hidden="true"></i> <span class="hidden-xs">Планирование работ</span></a>
	      </div>
	      <div class="btn-group" role="group">
	        <a href="/stroyka/real/{$uchastok_id}/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'real'}primary{else}default{/if}" role="button"><i class="fa fa-calculator" aria-hidden="true"></i> <span class="hidden-xs">Выполнение</span></a>
	      </div>
	      <div class="btn-group" role="group">
	        <a href="/stroyka/zak/{$uchastok_id}/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'zak'}primary{else}default{/if}" role="button"><i class="fa fa-calculator" aria-hidden="true"></i> <span class="hidden-xs">Заказ</span></a>
	      </div>
	    </div>                 
	</div>