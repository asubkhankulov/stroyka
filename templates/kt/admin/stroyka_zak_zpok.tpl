            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="well well-sm">
					<a href="/stroyka/">Стройка</a> / <a href="/stroyka/view/{$uchastok_id}/">в {$info.poselok} на участке {$info.uchastok}</a>  - заказ: <span class="label label-info">Срок обеспечения материалом в {$info.poselok} дней - {$info.obes_days}</span>
				</div>                   
{include file='dop_menu.tpl'}        

<hr>        
				<div class="well well-sm">
					Редактирование документа:
				</div>  
	
<hr> 
				<div class="panel panel-info">
				  <div class="panel-heading"><span class="label label-info"><strong>Заказ покупателя №{$zpok[0].zpok_id} от {$zpok[0].doc_date}</strong></span></div>
				  <div class="panel-body">
					<div class="table-responsive{if empty($zpok)} hidden{/if}">
	                    <table class="table table-striped table-bordered table-list">
		                   <thead>
		                        <tr class="info" align="center">
		                        	<th>#</th>
	                                <th align="center">Материал</th>
	                                <th align="center">Необх. дата зак.</th>
	                                <th align="center">Количество, шт.</th>
	                                <th align="center">Необх. дата пост.</th>
	                                <th align="center">Цена, руб.</th>
	                                <th align="center">Сумма, руб.</th>
	                                <th>
	                                    <center><em class="fa fa-cog"></em></center>
	                                </th>
	                                
		                        </tr>
	
		                   </thead>
	                    
	
	                        <tbody>{if !empty($zpok)}
	                        {assign var="all_kol" value=0}
	                        {assign var="all_summ" value=0}
	                        
	                        {section name=zpo loop=$zpok}
	                            <tr id="zpost_{$zpok[zpo].id}">
	                                <td>{{$smarty.section.zpo.iteration}}</td>
	                                <td>{$zpok[zpo].material}</td>
	                                <td>{$zpok[zpo].zakupkadate}</td>
	                                <td><input type="text" class="form-control" name="kol" value="{$zpok[zpo].kol}" id="{$zpok[zpo].id}_kol"></td>
	                                <td>{$zpok[zpo].postup_date}</td>
	                                <td><input type="text" class="form-control" name="price" value="{$zpok[zpo].doc_price}" id="{$zpok[zpo].id}_price"></td>
	                                <td>{$zpok[zpo].kol*$zpok[zpo].doc_price}</td>
	                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$zpok[zpo].id},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$zpok[zpo].id}"><em class="fa fa-trash"></em></button></td>
	                            </tr>
	                            {assign var=all_summ value=$all_summ+$zpok[zpo].kol*$zpok[zpo].doc_price}
	                            {assign var=all_kol value=$all_kol+$zpok[zpo].kol}
	                        {/section}  {/if}  
	                        </tbody>
	                        <tfoot>
	                         <tr class="active">
	                             <td><b>Итого:</b></td>
	                             <td></td>
	                             <td>{$all_kol}</td>
	                             <td></td>
	                             <td>{$all_summ}</td>
	                             <td class="info" id="flsumm"></td>
	                         </tr>
	                     </tfoot>	                        
	                    </table>
                    </div>					
				  </div>
				</div>
                
						<h4>Добавить товар в документ:</h4>
				
					<form class="form-horizontal text-primary" action="/stroyka/zak/{$uchastok_id}/{$zpok_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
					  <div class="form-group">
					    <label for="step_id" class="col-sm-4 control-label hidden-xs">Товар:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="step_id" id="input3">
						      {if !empty($list)}{section name=cus loop=$list}
								  <option value="{$list[cus].id}">{$list_steps[cus].name}</option>
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
			                  <button type="submit" class="btn btn-success">Добавить</button> 
			                  <button type="reset" class="btn btn-success">Отмена</button>
			              </div>
			          </div>
					</form>	
	
		                
            </div>
      
<div class="modal fade" tabindex="-1" role="dialog" id="deldlg" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog">
    <div class="modal-content modal-sm">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Диалог</h4>
      </div>
      <div class="modal-body">
        <p id="success-alert">Удаляем?&hellip;</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Нет</button>
        <button type="button" class="btn btn-primary" id="Del">Да</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

    <script type="text/javascript">
	$(document).ready(function() {            

		    var cnt_id = 0;

			$(function () {
				  $('[data-toggle="tooltip"]').tooltip()
			});
			    
			var field = '';        

			UpdateField = function(field_id, obj) {
				
				var val1 = $("#"+field_id+"_price").val();
				var val2 = $("#"+field_id+"_kol").val();
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_zpok',
	                'id': field_id,
	                'price': val1,
	                'kol': val2
	            }, checkTime = function(data) {
					

	            	switch(data) {
	                case 'ok':
	                	$(field).tooltip('show');
	                	window.location = '/stroyka/zak/{$uchastok_id}/{$zpok_id}/';
	                    break
	                default:
	                	$(field).tooltip(data);
	            }


				});
			}

		    $("#deldlg").on('shown.bs.modal', function (event) {
		    	  var button = $(event.relatedTarget) // Button that triggered the modal
		    	  cnt_id = button.data('whatever') // Extract info from data-* attributes
		    });

		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_from_zpok',
			            'id': cnt_id
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data == 'ok')  { 
			        		 $('#deldlg').modal('hide');
			        		 $('#zpost_'+cnt_id).hide();
			        		 
				         }
			        	 else { //alert(data);
			        	 	$("#success-alert").text('Произошла ошибка: ' + data);
			        	 }
			        	 

					}

					);

			    }
		  });

	});

    </script>            