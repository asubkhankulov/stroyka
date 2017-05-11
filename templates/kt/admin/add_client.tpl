<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Добавление клиента</h1>
                <h4>Профиль пользователя клиента</h4>
                <hr>
                <form class="form-horizontal" action="/index/add/" method="POST">
                   <input type="hidden" name="action" value="add" />
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Логин</span>
									<input type="text" class="form-control input-sm" name="login" id="login" placeholder="Придумайте логин" required autofocus/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Фамилия</span>
									<input type="text" class="form-control input-sm" name="login_fam" id="login_fam" placeholder="Укажите фамилию"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Имя</span>
									<input type="text" class="form-control input-sm" name="login_name" id="login_name" placeholder="Укажите имя"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Отчество</span>
									<input type="text" class="form-control input-sm" name="login_otch" id="login_otch" placeholder="Укажите отчество"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">E-mail</span>
									<input type="email" id="inputEmail" class="form-control input-sm" name="login_mail" placeholder="Укажите E-mail" required />
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Телефон</span>
									<input type="text" class="form-control input-sm" name="login_tel" id="login_tel" placeholder="Укажите телефон"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Пароль</span>
									<input type="password" class="form-control input-sm" name="pass" id="pass" placeholder="Придумайте пароль" required/>
								</div>
							</div>
						</div>      
						<div class="checkbox">
							<label>
								<input type="checkbox" name="is_admin" id="is_admin"> - сделать администратором?
							</label>
						</div>
                   
                        <h4>Профиль пользователя клиента</h4>
                        <hr>
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Договор</span>
									<input type="text" class="form-control input-sm" name="dogovor" id="dogovor" placeholder="Номер договора"/>&nbsp;от&nbsp;<input type="text" class="form-control" name="dogovor_date" id="datetimepicker_dog" value="">
								</div>
							</div>
						</div>                   
                        
                        <hr>
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Наименование организации</span>
									<input type="text" class="form-control input-sm" name="comp_name" id="comp_name" placeholder="Например ООО Клиент"/ required>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Должность руководителя</span>
									<input type="text" class="form-control input-sm" name="director" id="director" placeholder="Например Генеральный диретор"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Ф.И.О. руководителя</span>
									<input type="text" class="form-control input-sm" name="director_fio" id="director_fio" placeholder="Например Иванов Иван Иванович"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Действует на основании</span>
									<input type="text" class="form-control input-sm" name="ustav" id="ustav" placeholder="Например Устава"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Юридический адрес</span>
									<input type="text" class="form-control input-sm" name="ur_address" id="ur_address" placeholder="Точный адрес с индексом"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Фактический адрес</span>
									<input type="text" class="form-control input-sm" name="fact_address" id="fact_address" placeholder="Точный адрес с индексом"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Почтовый адрес</span>
									<input type="text" class="form-control input-sm" name="post_address" id="post_address" placeholder="Точный адрес с индексом"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">ИНН</span>
									<input type="text" class="form-control input-sm" name="inn" id="inn" placeholder="Укажите ИНН"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">КПП</span>
									<input type="text" class="form-control input-sm" name="kpp" id="kpp" placeholder="Укажите КПП"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">ОКПО</span>
									<input type="text" class="form-control input-sm" name="okpo" id="okpo" placeholder="Укажите ОКПО"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">ОГРН</span>
									<input type="text" class="form-control input-sm" name="ogrn" id="ogrn" placeholder="Укажите ОГРН"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Банк</span>
									<input type="text" class="form-control input-sm" name="bank" id="bank" placeholder="Укажите Банк"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">БИК</span>
									<input type="text" class="form-control input-sm" name="bik" id="bik" placeholder="Укажите БИК"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Расчётный счёт (р/с)</span>
									<input type="text" class="form-control input-sm" name="rs" id="rs" placeholder="Укажите р/с"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Корреспондентский счёт (к/с)</span>
									<input type="text" class="form-control input-sm" name="ks" id="ks" placeholder="Укажите к/с"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Телефон</span>
									<input type="text" class="form-control input-sm" name="comp_tel" id="comp_tel" placeholder="Укажите телефон"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Адрес E-mail</span>
									<input type="text" class="form-control input-sm" name="comp_mail" id="comp_mail" placeholder="Укажите e-mail"/>
								</div>
							</div>
						</div>                   
						<div class="form-group">
							<div class="col-sm-10">
								<div class="input-group col-sm-10">
									<span class="input-group-addon hidden-xs">Официальный сайт</span>
									<input type="text" class="form-control input-sm" name="comp_url" id="comp_url" placeholder="Укажите сайт"/>
								</div>
							</div>
						</div>                   

                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10p">
                            <button type="submit" class="btn btn-success">Добавить клиента</button> 
                            <a href="/index/" class="btn btn-default">Отмена</a>
                        </div>
                    </div>
                </form>
               <!--  <p><a href="#" class="btn btn-success"><i class="fa fa-user-plus" aria-hidden="true"></i> Добавить клиента</a></p> -->
</div>
    <script type="text/javascript">

	
	$(document).ready(function() {    

        $('#datetimepicker_dog').datetimepicker({
        	format: 'YYYY-MM-DD',
        	//defaultDate: "{$docs.mindate}",
            //minDate: "{$docs.mindate}",
            locale: 'ru'
        });

    });

    </script>
