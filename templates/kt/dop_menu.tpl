	 <div class="row">
	    <div class="btn-group btn-group-justified" role="group" aria-label="...">
	      <div class="btn-group" role="group">
	        <a href="/index/counters/{$cnt_id}/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'counters'}primary{else}default{/if}" role="button"><i class="fa fa-book" aria-hidden="true"></i> <span class="hidden-xs">Информация</span></a>
	      </div>
	      <div class="btn-group" role="group">
	        <a href="/index/info/{$cnt_id}/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'info'}primary{else}default{/if}" role="button"><i class="fa fa-calculator" aria-hidden="true"></i> <span class="hidden-xs">Отчёты</span></a>
	      </div>
	    </div>                 
	</div>