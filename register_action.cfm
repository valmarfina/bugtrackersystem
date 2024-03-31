  <!-- register_action.cfm -->
  <cftry>
  <cfif LEN(TRIM(form.username)) AND LEN(TRIM(form.firstname)) AND LEN(TRIM(form.lastname)) AND LEN(TRIM(form.password))>
    <!-- Проверка на валидность имени и фамилии (должны содержать только буквы) -->
    <cfif REFind("^[A-Za-zА-Яа-яЁё\s]+$", form.firstname) and REFind("^[A-Za-zА-Яа-яЁё\s]+$", form.lastname)>
      <!-- Проверка на валидность username (только английские буквы, цифры и нижнее подчеркивание) -->
      <cfif REFind("^[A-Za-z0-9_]+$", form.username)>
        <!-- Проверка, существует ли уже такой username -->
        <cfquery name="checkUsername" datasource="CFbugtrackingdb">
          SELECT account
          FROM public.users
          WHERE account = <cfqueryparam value="#form.username#" cfsqltype="CF_SQL_VARCHAR">
        </cfquery>

        <!-- вернул ли запрос какие-либо строки -->
        <cfif checkUsername.recordCount eq 0>
          <!--  записей нет, значит username свободен, и мы можем продолжить регистрацию -->
          <cfquery datasource="CFbugtrackingdb">
            INSERT INTO public.users (account, first_name, last_name, password_hash)
            VALUES (
              <cfqueryparam value="#form.username#" cfsqltype="CF_SQL_VARCHAR">,
              <cfqueryparam value="#form.firstname#" cfsqltype="CF_SQL_VARCHAR">,
              <cfqueryparam value="#form.lastname#" cfsqltype="CF_SQL_VARCHAR">,
              <cfqueryparam value="#hash(form.password, 'SHA-256')#" cfsqltype="CF_SQL_VARCHAR">
            );
          </cfquery>
          <cfset session.errorMessage = "Вы успешно зарегестрированы в систему!">
          <cflocation url="index.cfm?status=success" addtoken="no">
        <cfelse>
          <!--  запись с таким username уже есть, выводим сообщение об ошибке -->
          <cfset session.errorMessage = "Ошибка при регистрации: Username уже занят.">
          <cflocation url="register.cfm" addtoken="no">
        </cfif>
      <cfelse>
        <!--  username невалиден -->
        <cfset session.errorMessage = "Ошибка регистрации: Username должен содержать только английские буквы, цифры и нижнее подчеркивание">
        <cflocation url="register.cfm" addtoken="no">
      </cfif>
    <cfelse>
      <!-- имя или фамилия не валидны-->
      <cfset session.errorMessage = "Ошибка регистрации: Имя и фамилия должны содержать только буквы.">
      <cflocation url="register.cfm" addtoken="no">
    </cfif>
  <cfelse>
    <!-- одно из полей пусто -->
    <cfset session.errorMessage = "Ошибка регистрации: Все поля должны быть заполнены">
    <cflocation url="register.cfm" addtoken="no">
  </cfif>

  <!-- Обработка исключений -->
  <cfcatch type="database">
    <cfset session.errorMessage = "Ошибка при добавлении пользователя" + cfcatch.message>
    <cflocation url="register.cfm" addtoken="no">
  </cfcatch>
</cftry>
