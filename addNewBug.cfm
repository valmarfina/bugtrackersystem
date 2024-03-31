<!-- addNewBug.cfm -->
<cfset message = "">

<cfif NOT session.isLoggedIn>
    <cflocation url="index.cfm" addtoken="no">
</cfif>

<cfif IsDefined("form.submit")>
    <cfquery name="addNewBug" datasource="CFbugtrackingdb">
        INSERT INTO public.errors (
            entry_date,
            short_description,
            detailed_description,
            reported_by,
            status,
            urgency,
            criticality
        )
        VALUES (
            CURRENT_TIMESTAMP,
            <cfqueryparam value="#form.short_description#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#form.detailed_description#" cfsqltype="CF_SQL_VARCHAR">,
            <cfqueryparam value="#session.user_id#" cfsqltype="CF_SQL_INTEGER">,
            'New',
            <cfqueryparam value="#form.urgency#" cfsqltype="CF_SQL_VARCHAR">::error_urgency,
            <cfqueryparam value="#form.criticality#" cfsqltype="CF_SQL_VARCHAR">::error_criticality
        )
    </cfquery>
    
    <cfset message = "Баг успешно добавлен.">
</cfif>

<cfoutput>
<!DOCTYPE html>
<html>
<head>
    <title>add new bug</title>
    <link rel="stylesheet" href="styles/addNewBug.css?v=1">
</head>
<body>
        <cfoutput>
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
        </cfoutput>


    <div class="add-bug-form-container">
        <h1>ADD NEW BUG</h1>
        <form id="addNewBugForm" method="post" action="">
            <label for="short_description">Title:</label>
            <input type="text" id="short_description" name="short_description" required>

            <label for="detailed_description">Description:</label>
            <textarea id="detailed_description" name="detailed_description" required></textarea>

            <label for="urgency">Срочность:</label>
            <select id="urgency" name="urgency">
                <option value="Очень срочно">Очень срочно</option>
                <option value="Срочно">Срочно</option>
                <option value="Не срочно">Не срочно</option>
                <option value="Совсем не срочно">Совсем не срочно</option>
            </select>

            <label for="criticality">Критичность:</label>
            <select id="criticality" name="criticality">
                <option value="Авария">Авария</option>
                <option value="Критично">Критично</option>
                <option value="Не критично">Не критично</option>
                <option value="Запрос на изменение">Запрос на изменение</option>
            </select>

            <input type="submit" name="submit" value="Создать">
        </form>
    </div>
    <script>
        window.onload = function() {
            var message = '#JSStringFormat(message)#';
            if (message.length > 0) {
                alert(message);
            }
        };
    </script>
</body>
<footer class="site-footer">
    <p>&copy; 2024 Bug Tracker System by Valeriya Marfina</p>
</footer>
</html>
</cfoutput>
