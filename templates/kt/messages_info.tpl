            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            {if !empty($list)}
                <h4 class="page-header">Список сообщений <small>для {$list[0].ln} ({$list[0].cn})</small></h4>
<div class="panel panel-{if $smarty.session.userid == $list[0].user_id}primary{else}default{/if}">
  <div class="panel-heading">Тема: {$list[0].name} <small class="pull-right">{if $smarty.session.userid == $list[0].user_id}(Вы){else}{$list[0].login_name}{/if} создана: {$list[0].date|date_format:"%d.%m.%Y %H:%M:%S"}</small></div>
  <div class="panel-body">
    {$list[0].text|nl2br}
  </div>
</div>
{if isset($list[1])}
{section name=cus loop=$list start=1}
<div class="panel panel-{if $smarty.session.userid == $list[cus].user_id}primary{else}default{/if}">
  <div class="panel-heading">От: {if $smarty.session.userid == $list[cus].user_id}Вы{else}{$list[cus].login_name} ({$list[cus].comp_name}){/if} <small class="pull-right">создан: {$list[cus].date|date_format:"%d.%m.%Y %H:%M:%S"}</small></div>
  <div class="panel-body">
    {$list[cus].text|nl2br}
  </div>
</div>
{/section} 
{/if}

<hr>
    <form action="/messages/{$id}/" method="POST">
   	<input type="hidden" name="action" value="add" />
   	<input type="hidden" name="to_user_id" value="{$list[0].to_user_id}" />
      <div class="modal-body">
          <div class="form-group">
            <label for="text" class="control-label">Ответ:</label>
            <textarea class="form-control" name="text" id="text" required></textarea>
          </div>
      </div>
      <div class="modal-footer">
        <button type="reset" class="btn btn-default" data-dismiss="modal">Отмена</button>
        <button type="submit" class="btn btn-primary">Отправить!</button>
      </div>
    </form>
	          
	          {else}
	          <div class="well well-lg">Нет доступа!</div>	
	          {/if}      
            </div>
