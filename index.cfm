<!-- index.cfm -->
<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<title>Авторизация</title>
<link rel="stylesheet" href="styles/index.css?v=2">
</head>
<body>

<div class="login-container">
  <h2>BUG TRACKER</h2>
  <cfform action="index_action.cfm" method="post">
    <div class="form-group">
      <label for="username">username</label>
      <input type="text" id="username" name="username" placeholder="Введите имя пользователя" required>
    </div>
    <div class="form-group">
      <label for="password">password</label>
      <input type="password" id="password" name="password" placeholder="Введите пароль" required>
    </div>
    <input type="submit" class="login-button main-action" value="Войти">
    <a href="register.cfm" class="registration-link">Зарегистрироваться</a>
  </cfform>
</div>

</body>
<footer class="site-footer">
  <p>&copy; 2024 Bug Tracker System by Valeriya Marfina</p>
</footer>
</html>
