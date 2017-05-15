            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
{include file='dop_menu_zakup.tpl'}        

<hr>        
				<div class="well well-sm">
					Редактирование документа:
				</div>  
	
<hr> 
				<div class="panel panel-info">
				  <div class="panel-heading"><span class="label label-info"><strong>Заказ поставщику №{$zpok[0].zpost_id} от {$zpok[0].doc_date}</strong></span></div>
				  <div class="panel-body">
					<div class="table-responsive{if empty($zpok)} hidden{/if}">
					<form class="form-inline" role="form">			  
						<div class="form-group">
					    <label for="vendors_id">Поставщик:</label>
						<select class="form-control" name="vendors_id" id="vendors_id">
							<option value="0">не выбран</option>
							{html_options values=$list_ven_val output=$list_ven_name selected=$zpok[0].vendor_id}
						</select>
					  </div>
					  <button class="btn btn-primary" type="button" onclick="UpdateVendor(this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button>
				   </form>	
					<hr>
	                    <table class="table table-striped table-bordered table-list">
		                   <thead>
		                        <tr class="info" align="center">
		                        	<th>#</th>
	                                <th align="center">Материал</th>
	                                <th align="center">Заявка</th>
	                                <th align="center">Участок/Склад</th>
	                                <th align="center">Необх. дата зак.</th>
	                                <th align="center">Количество, ед.изм.</th>
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
	                                <td>{$zpok[zpo].zpok_id|default:'нет'}</td>
	                                <td>{$zpok[zpo].sklad}</td>
	                                <td>{$zpok[zpo].zakupkadate|default:'-'}</td>
	                                <td>{if $zpok[zpo].zpok_id>0}{$zpok[zpo].kol}{else}<input type="text" class="form-control" name="kol" value="{$zpok[zpo].kol}" id="{$zpok[zpo].id}_kol">{/if}, {$zpok[zpo].unit}</td>
	                                <td>{$zpok[zpo].postup_date|default:'-'}</td>
	                                <td><input type="text" class="form-control" name="price" value="{$zpok[zpo].doc_price}" id="{$zpok[zpo].id}_price"></td>
	                                <td>{$zpok[zpo].kol*$zpok[zpo].doc_price}</td>
	                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$zpok[zpo].id},{$zpok[zpo].zpok_id|default:0},this);" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$zpok[zpo].id}"><em class="fa fa-trash"></em></button></td>
	                            </tr>
	                            {assign var=all_summ value=$all_summ+$zpok[zpo].kol*$zpok[zpo].doc_price}
	                            {assign var=all_kol value=$all_kol+$zpok[zpo].kol}
	                        {/section}  {/if}  
	                        </tbody>
	                        <tfoot>
	                         <tr class="active">
	                             <td><b>Итого:</b></td>
	                             <td></td>
	                             <td></td>
	                             <td></td>
	                             <td></td>
	                             <td>{$all_kol}</td>
	                             <td></td>
	                             <td></td>
	                             <td>{$all_summ}</td>
	                             <td class="info" id="flsumm"></td>
	                         </tr>
	                     </tfoot>	                        
	                    </table>
                    </div>					
				  </div>
				</div>
                
						<h4>Добавить товар в документ (произвольный, не привязанный к работам/заявкам):</h4>
				
					<form class="form-horizontal text-primary" action="/zakup/edit/{$zpost_id}/" method="POST">
						<input type="hidden" name="action" value="add" />
						<input type="hidden" name="vendors_id" value="$zpok[0].vendor_id" />
					  <div class="form-group">
					    <label for="uchastok_id" class="col-sm-4 control-label hidden-xs">Участок/Склад:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="uchastok_id">
						      {if !empty($list_sklad)}{section name=cus2 loop=$list_sklad}
								  <option value="{$list_sklad[cus2].id}">{$list_sklad[cus2].name}</option>
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="material_id" class="col-sm-4 control-label hidden-xs">Материал:</label>
					    <div class="col-sm-8">
				           	<select class="form-control" name="material_id">
						      {if !empty($list)}{section name=cus loop=$list}
								  <option value="{$list[cus].id}">{$list[cus].name}</option>
							  {/section}{/if}
							</select>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="input1" class="col-sm-4 control-label hidden-xs">Количество:</label>
					    <div class="col-sm-8">
					      <input type="number" class="form-control" name="kol" value="1" min="0">
					    </div>
					  </div>					  
			          <div class="form-group">
			              <div class="col-sm-offset-4 col-sm-8p">
			                  <button type="submit" class="btn btn-success">Добавить</button> 
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

			UpdateField = function(field_id, zpok_id, obj) {
				
				var val1 = $("#"+field_id+"_price").val();
				if (zpok_id == 0){
					var val2 = $("#"+field_id+"_kol").val();
				}
				else {
					var val2 = 0;
				}
				
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_zpost_value',
	                'id': field_id,
	                'price': val1,
	                'kol': val2
	            }, checkTime = function(data) {
					

	            	switch(data) {
	                case 'ok':
	                	$(field).tooltip('show');
	                	//window.location = '/zakup/edit/{$zpok[0].zpost_id}/';
	                    break
	                default:
	                	$(field).tooltip(data);
	            }


				});
			}
			
			UpdateVendor = function(obj) {
				field = obj;
				var val1 = $( "#vendors_id option:selected" ).val();
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_zpost_vendor',
	                'id': {$zpok[0].zpost_id|default:'0'},
	                'vendors_id': val1
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

		    $("#deldlg").on('shown.bs.modal', function (event) {
		    	  var button = $(event.relatedTarget) // Button that triggered the modal
		    	  cnt_id = button.data('whatever') // Extract info from data-* attributes
		    });

		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_from_zpost',
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