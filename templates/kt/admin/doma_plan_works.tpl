            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<div class="well well-sm">
		<a href="/doma/">Типы построек</a> / {$info.name}  - планирование графика работ:
	</div>                

{include file='dop_menu_shablon.tpl'}       

<hr>        
 	<div class="well well-sm">
		Смещение - задаётся количество дней от начала первой работы.<br>
		п/н - последовательность выполнения работ
	</div>               

                <div class="table-responsive{if empty($list)} hidden{/if}">
                    <table class="table table-striped table-bordered table-list">
                        <thead>
                            <tr>
                                <th>№</th>
                                <th style="width: 5%" align="center">п/н</th>
                                <th style="width: 3%" align="center">Смещение</th>
                                <th align="center">Тип</th>
                                <th align="center">Этап</th>
                                <th align="center">Наименование работы</th>
                                <th style="width: 5%" align="center">Объём работ</th>
                                <th align="center">Ед. изм.</th>
                                <th style="width: 5%" align="center">Продолж., дни</th>
                                <th align="center">Дата нач.</th>
                                <th align="center">Дата оконч.</th>
                                <th align="center">Примечание</th>
                                <th>
                                    <center><em class="fa fa-cog"></em></center>
                                </th>
                            </tr>
                        </thead>
                        <tbody>{if !empty($list)}
                        {section name=cus loop=$list}
                            <tr id="cnt_{$list[cus].id}">
                                <td>{{$smarty.section.cus.iteration}}</td>
                                <td><input type="text" class="form-control" name="sort" value="{$list[cus].sort}" id="{$list[cus].id}_sort"></td>
                                <td><input type="text" class="form-control" name="shift1" value="{$list[cus].shift1}" id="{$list[cus].id}_shift1"></td>
                                <td>{$list[cus].dom_type}</td>
                                <td>{$list[cus].step}</td>
                                <td id="cntval_{$list[cus].id}"><a href="/doma/materials/{$list[cus].work_id}/{$step_id}/{$doma_id}/">{$list[cus].work}</a></td>
                                <td><input type="text" class="form-control" name="v_work" value="{$list[cus].v_work}" id="{$list[cus].id}_v_work" readonly></td>
                                <td>{$list[cus].unit}</td>
                                <td><input type="text" class="form-control" name="days" value="{$list[cus].days}" id="{$list[cus].id}_days" readonly></td>
                                <td><input type="text" class="form-control" name="date_nach" value="{$list[cus].datestart}" id="{$list[cus].id}_dn" readonly></td>
                                <td><input type="text" class="form-control" name="date_okonch" value="{$list[cus].dateend}" id="{$list[cus].id}_do" readonly></td>
                                <td><input type="text" class="form-control" name="note" value="{$list[cus].note}" id="{$list[cus].id}_note"></td>
                                <td align="center"> <button class="btn btn-primary" type="button" onclick="UpdateField({$list[cus].id},this);" data-toggle="tooltip" data-placement="top" data-trigger="manual" title="Сохранено..."><i class="fa fa-floppy-o" aria-hidden="true"></i></button>  </td>
                            </tr>
                        {/section}  {/if}  
                        </tbody>
                    </table>
                    </div>
	

	
		                
            </div>
      


    <script type="text/javascript">
	$(document).ready(function() {            

		    var cnt_id = 0;
		    var cnt_sum = {$cnt_sum|default:0};

			$(function () {
				  $('[data-toggle="tooltip"]').tooltip()
			});
			    

		    
	
		    $("#deldlg").on('shown.bs.modal', function (event) {
		    	  var button = $(event.relatedTarget) // Button that triggered the modal
		    	  cnt_id = button.data('whatever') // Extract info from data-* attributes
		    });

		
			var field = '';        

			UpdateField = function(field_id, obj) {
				

				var val1 = $("#"+field_id+"_sort").val();
				var val2 = $("#"+field_id+"_shift1").val();
				if (field != '') $(field).tooltip('hide');
				field = obj;
				
				
				url = '/ajax/index.php';       
	            $.post(url,
	            {
	                'action': 'update_work_plansort',
	                'id': field_id, 
	                'val1': val1,
	                'val2': val2
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
	});

    </script>            