	 <div class="row">
	    <div class="btn-group btn-group-justified" role="group" aria-label="...">
	      <div class="btn-group" role="group">
	        <a href="/zakup/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == '' or $smarty.const.MODULE_DOP == 'edit'}primary{else}default{/if}" role="button"><i class="fa fa-book" aria-hidden="true"></i> <span class="hidden-xs">Создание закупки</span></a>
	      </div>
	      <div class="btn-group" role="group">
	        <a href="/zakup/view/" class="btn btn-lg btn-{if $smarty.const.MODULE_DOP == 'view'}primary{else}default{/if}" role="button"><i class="fa fa-book" aria-hidden="true"></i> <span class="hidden-xs">Список закупок</span></a>
	      </div>
	    </div>                 
	</div>