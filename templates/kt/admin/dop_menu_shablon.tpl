	 <div class="row">
	    <div class="btn-group btn-group-justified" role="group" aria-label="...">
	      <div class="btn-group" role="group">
	        <a href="/doma/step/{$doma_id}/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'view' or $smarty.const.MODULE_DOP == 'step'}primary{else}default{/if}" role="button"><i class="fa fa-book" aria-hidden="true"></i> <span class="hidden-xs">Сводная информация по шаблону</span></a>
	      </div>
	      <div class="btn-group" role="group">
	        <a href="/doma/plan/{$doma_id}/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'plan'}primary{else}default{/if}" role="button"><i class="fa fa-calculator" aria-hidden="true"></i> <span class="hidden-xs">Планирование работ в шаблоне</span></a>
	      </div>
	</div>