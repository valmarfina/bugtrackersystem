<!-- register.cfm -->
<cfset message = "">
<!DOCTYPE html>
<html lang="ru">
  <head>
    <meta charset="UTF-8">
    <title>Регистрация</title>
    <link rel="stylesheet" href="styles/register.css">
  </head>

  <body>
    <div class="login-container">
      <h2>REGISTRATION</h2>
      <form action="register_action.cfm" method="post" class="form-group">
        <div class="form-group">
          <label for="username">Введите имя пользователя</label>
          <input type="text" id="username" name="username" placeholder="username" required>
        </div>

        <div class="form-group">
          <label for="firstname">Введите имя</label>
          <input type="text" id="firstname" name="firstname" placeholder="firstname" required>
        </div>

        <div class="form-group">
          <label for="lastname">Введите фамилию</label>
          <input type="text" id="lastname" name="lastname" placeholder="lastname" required>
        </div>

        <div class="form-group">
          <label for="password">Придумайте пароль</label>
          <input type="password" id="password" name="password" placeholder="password" required>
        </div>

        <input type="submit" class="login-button" value="Зарегистрироваться">
      </form>
    </div>
<cfif IsDefined("session.errorMessage") and session.errorMessage NEQ "">
    <script>
    window.onload = function() {
        var message = "<cfoutput>#JSStringFormat(session.errorMessage)#</cfoutput>";
        if (message.length > 0) {
            alert(message);
            location.reload()
        }
    };
    </script>
    <cfset session.errorMessage = "">
</cfif>
  </body>

  <footer class="site-footer">
    <p>&copy; 2024 Bug Tracker System by Valeriya Marfina</p>
  </footer>
</html>
