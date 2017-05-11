	 <div class="row">
	    <div class="btn-group btn-group-justified" role="group" aria-label="...">
	      <div class="btn-group" role="group">
	        <a href="/orders/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == ''}primary{else}default{/if}" role="button"><i class="fa fa-book" aria-hidden="true"></i> <span class="hidden-xs">Текущие заказы</span></a>
	      </div>
	      <div class="btn-group" role="group">
	        <a href="/orders/view/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'view'}primary{else}default{/if}" role="button"><i class="fa fa-book" aria-hidden="true"></i> <span class="hidden-xs">Сводная информация</span></a>
	      </div>
	    </div>                 
	</div>