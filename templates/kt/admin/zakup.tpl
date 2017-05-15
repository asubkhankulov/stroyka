            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
{include file='dop_menu_zakup.tpl'} 
<hr>        
      <form class="form-inline" role="form">
	  <div class="form-group">
	    <label for="type_material">Тип материала:</label>
		<select class="form-control" name="type_material" id="type_material">
			<option value="0">без фильтра</option>
			{html_options values=$list_type_val output=$list_type_name selected=''}
		</select>
	    <button type="text" class="btn btn-success btn-sm" onclick="return SelectType()">Применить</button>
	  </div>
	  <div class="form-group pull-right">
	  	  	<div class="pull-right"><button type="text" class="btn btn-danger btn-sm" onclick="return MakeZpost(this)">Создать заказ</button></div>
	  		<div class="pull-right"><button type="text" class="btn btn-success btn-sm" onclick="return MakeZpost__(this)" disabled>Распределить по заказам</button></div>
	  </div>
	  
	</form>	
					<hr>
			<form action="/zakup/" method="POST" id="zpostt" class="form-inline" >
			<input type="hidden" name="action" value="zpost" />
			  <div class="form-group">
			    <label for="vendors_id">Поставщик:</label>
				<select class="form-control" name="vendors_id">
					<option value="0">не выбран</option>
					{html_options values=$list_ven_val output=$list_ven_name selected='0'}
				</select>
			  </div>
                 <table class="table table-bordered" id="htmltable1">
                     <thead>
                         <tr class="info" align="center">
                             <th>#</th>
                             <th>Материал</th>
                             <th align="center">Тип</th>
                             {foreach from=$uchastki key=uchID item=i}
							  <th align="center">{$i.name}: {$i.pos} / {$i.prorab}</th>
							{/foreach}
                             
                             <th align="center">Итого в заявках</th>
                             <th align="center">Итого закуплено</th>
                         </tr>
                     </thead>
                     <tbody>
					{if !empty($all_data)}
                        {foreach from=$all_data key=matID item=alld name=alm}
                            <tr class="mat_type_{$alld.mat_type_id} mat_all">
                                {*<td><input type="checkbox" value="{$mat_all[$matID]}" name="zakup[{$matID}]"></td>*}
                                <td>{{$smarty.foreach.alm.iteration}}</td>
                                <td><a href="#" title="перейти">{$alld.name}</a></td>
                                <td class="zak_matt">{$alld.type}</td>
		                             {foreach from=$uchastki key=uchID item=i}
									  	<td>
									  		{if isset($mat_uch[$matID][$uchID])}
									  			{foreach from=$mat_uch[$matID][$uchID] key=z item=zpoki}
									  				<input type="checkbox" class="mat_{$matID}" value="{$zpoki.kol}" name="zpost_uch[{$zpoki.dzm_id}]"> заявка {$zpoki.zpok} / {$zpoki.kol} {$zpoki.un}<br>
									  			{/foreach}
									  		{else}
									  		-
									  		{/if}
									  	</td>
									 {/foreach}
                                
                                <td>{$mat_all[$matID]}</td>
                                <td>{$alld.zakup_kol}</td>
                            </tr>
                        {/foreach}  {/if}                      
                        </tbody>
                    {* <tfoot>
                         <tr class="active">
                             <td><b>Итого</b></td>
                             <td></td>
                             <td></td>
                             <td></td>
                             <td class="info" id="flsumm"></td>
                             <td></td>
                             <td></td>
                         </tr>
                     </tfoot>*}
                 </table>
               </form>
                 
	<div class="well well-sm">
					<span class="label label-info">Список заказов постащику (ЗПОСТ):</span>
				</div>  	
	
                <div class="table-responsive{if empty($zpost)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
	                   <thead>
	                        <tr class="info" align="center">
	                        	<th>#</th>
	                        	<th style="width: 5%">№ док.</th>
                                <th align="center">Дата</th>
                                <th align="center">Поставщик</th>
                                <th align="center">Количество материалов в заказе</th>
                                <th align="center">Сумма, руб.</th>
                                <th align="center">Статус</th>
                                <th align="center">Примечание</th>
                                <th align="center">Ответственный</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                                
	                        </tr>

	                   </thead>
                    

                        <tbody>{if !empty($zpost)}
                        {section name=zpo loop=$zpost}
                            <tr id="zpost_{$zpost[zpo].id}">
                                <td>{{$smarty.section.zpo.iteration}}</td>
                                <td>{$zpost[zpo].id}</td>
                                <td><a href="/zakup/edit/{$zpost[zpo].id}/">{$zpost[zpo].doc_date}</a></td>
                                <td>{$zpost[zpo].vendor}</td>
                                <td>{$zpost[zpo].kols}</td>
                                <td>{$zpost[zpo].all_summ}</td>
                                <td></td>
                                <td></td>
                                <td>{$zpost[zpo].username}</td>
                                <td align="center"> <a href="/zakup/edit/{$zpost[zpo].id}/" role="button" class="btn btn-default" title="Редактировать"><em class="fa fa-pencil"></em></a> <button type="button" class="btn btn-danger" title="Удалить" data-toggle="modal" data-target="#deldlg" data-whatever="{$zpost[zpo].id}"><em class="fa fa-trash"></em></button></td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    </div>	
	                 
	
		                
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
		    var cnt_kol = 0;

			$(function () {
				  $('[data-toggle="tooltip"]').tooltip()
			});
			    
			var countChecked = function() {
				cnt_kol = $( "input:checked" ).length;
			};
		 	countChecked();
				 
			$( "input[type=checkbox]" ).on( "click", countChecked );

		    $("#deldlg").on('shown.bs.modal', function (event) {
		    	  var button = $(event.relatedTarget) // Button that triggered the modal
		    	  cnt_id = button.data('whatever') // Extract info from data-* attributes
		    });

			SelectType = function() {
				
				var val = $("#type_material").val();
				
				if (val == 0) {
					$('tr.mat_all').show();
				}
				else {
					$('tr.mat_all').hide();
					$('tr.mat_type_'+val).toggle();
				}
				return false;
				

			}

			MakeZpost = function(obj) {
				
				countChecked();
				//alert(cnt_kol);
				if (cnt_kol > 0) {
					$(obj).removeClass('hidden');
					
					$( "#zpostt" ).submit();
				}
				else {
					alert('Нет позиций для заказа! Установите галку!');
					$(obj).removeClass('hidden');
				}

				

				return false;
				

			}
		    

		
		    $('#Del').click(function() {
		
			    if (cnt_id != 0) {
					url = '/ajax/index.php';       
			        $.post(url,
			        {
			            'action': 'del_zpost',
			            'id': cnt_id
			        }, checkTime = function(data) {
			        	 //console.log(data);
			        	 if (data == 'ok')  { 
			        		 $('#deldlg').modal('hide');
			        		 $('#zpost_'+cnt_id).hide();
			        		 //cnt_sum = cnt_sum - 1;
			        		 window.location = '/zakup/';
			        		 
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