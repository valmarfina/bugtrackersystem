<!-- editUser.cfm -->
<cfparam name="session.isLoggedIn" default="false">
<cfparam name="session.userID" default="0">
<cfparam name="session.firstName" default="">
<cfparam name="session.lastName" default="">
<cfset message = "">

<cfif NOT session.isLoggedIn>
    <cflocation url="index.cfm" addtoken="no">
</cfif>

<cfset updateOccurred = false>
<cfif IsDefined("form.submit")>
    <cfquery name="getUser" datasource="CFbugtrackingdb">
        SELECT first_name, last_name, password_hash
        FROM public.users
        WHERE user_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.userID#">
    </cfquery>
    
    <cfif getUser.recordCount EQ 1>
        <cfif form.old_password NEQ "" AND Hash(form.old_password, 'SHA-256') EQ getUser.password_hash>
            <cfif form.first_name NEQ session.firstName OR form.last_name NEQ session.lastName>
                <cfset updateOccurred = true>
                <cfquery datasource="CFbugtrackingdb">
                    UPDATE public.users
                    SET 
                        first_name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.first_name#">,
                        last_name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.last_name#">
                    WHERE user_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.userID#">
                </cfquery>
            </cfif>
            
            <cfif Len(Trim(form.new_password)) GT 0>
                <cfset updateOccurred = true>
                <cfquery datasource="CFbugtrackingdb">
                    UPDATE public.users
                    SET password_hash = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Hash(form.new_password, 'SHA-256')#">
                    WHERE user_id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#session.userID#">
                </cfquery>
            </cfif>
            
            <cfif updateOccurred>
                <cfset message = "Изменения успешно сохранены.">
            <cfelse>
                <cfset message = "Данные остались прежними.">
            </cfif>
        <cfelse>
            <cfset message = "Неверный старый пароль.">
        </cfif>
    </cfif>
</cfif>

<cfoutput>
<html>
<head>
    <title>edit user</title>
    <link rel="stylesheet" href="styles/editUser.css?v=2">
    <script>
        window.onload = function() {
            var message = '#JSStringFormat(message)#';
            if (message.length > 0) {
                alert(message);
            }
        };
    </script>
</head>
<body>
            <div class="navigation-bar">
  <div class="nav-links">
    <a href="errors.cfm">ALL BUGS</a>
    <a href="addNewBug.cfm">ADD NEW BUG</a>
    <a href="users.cfm">USERS</a>
    <a href="history.cfm">HISTORY</a>
  </div>
  

  <div class="user-menu">
    <span class="user-name">#session.firstName# #session.lastName#</span>
    <div class="user-actions">
<a href="editUser.cfm" class="user-action-link">Редактировать учетные данные</a>
<a href="logout.cfm" class="user-action-link">Выход</a>
    </div>
  </div>
</div>
    <div class="edit-form-container">
        <form id="editUserForm" method="post" action="editUser.cfm">
            <label for="first_name">Имя:</label>
            <input type="text" id="first_name" name="first_name" required value="#session.firstName#">

            <label for="last_name">Фамилия:</label>
            <input type="text" id="last_name" name="last_name" required value="#session.lastName#">

            <label for="old_password">Старый пароль:</label>
            <input type="password" id="old_password" name="old_password" required>

            <label for="new_password">Новый пароль:</label>
            <input type="password" id="new_password" name="new_password" required>

            <input type="submit" name="submit" value="Сохранить изменения">
        </form>
    </div>
</body>
<footer class="site-footer">
  <p>&copy; 2024 Bug Tracker System by Valeriya Marfina</p>
</footer>
</html>
<script>
    function validateForm() {
        var oldPassword = document.getElementById('old_password').value;
        var firstName = document.getElementById('first_name').value;
        var lastName = document.getElementById('last_name').value;
        var newPassword = document.getElementById('new_password').value;
        
        if (firstName === '#JSStringFormat(session.firstName)#' && 
            lastName === '#JSStringFormat(session.lastName)#' &&
            newPassword === '') {
            alert('Нет изменений для сохранения.');
            return false;
        } else if (oldPassword === '') {
            alert('Пожалуйста, введите ваш старый пароль для подтверждения изменений.');
            return false;
        }
        return true;
    }
</script>
</cfoutput>
