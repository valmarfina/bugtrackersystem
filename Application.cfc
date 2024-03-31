component {
    this.name = "bugtrackersystem"; 
    this.sessionManagement = true; // Включение управления сессиями
    this.sessionTimeout = createTimeSpan(0, 2, 0, 0); // Время жизни сессии 2 часа

    //onSessionStart вызывается при создании каждой новой сессии
    public void function onSessionStart() {
        session.isLoggedIn = false; // авторизован юзер или нет
    }
}
