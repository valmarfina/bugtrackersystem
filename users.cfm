<!-- users.cfm -->
<cfif NOT session.isLoggedIn>
    <cflocation url="index.cfm" addtoken="no">
</cfif>

<cfquery name="getUsers" datasource="CFbugtrackingdb">
    SELECT user_id, account, first_name, last_name
    FROM public.users
</cfquery>

<!DOCTYPE html>
<html>
    <head>
        <title>users sheet</title>
        <link rel="stylesheet" href="styles/users.css?v=2">
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

        <h2>USERS</h2>
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Account</th>
                    <th>Name</th>
                </tr>
            </thead>

            <tbody>
                <cfoutput query="getUsers">
                    <tr>
                        <td>#user_id#</td>
                        <td>@#account#</td>
                        <td>#first_name# #last_name#</td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>
    </body>
    <footer class="site-footer">
        <p>&copy; 2024 Bug Tracker System by Valeriya Marfina</p>
    </footer>
</html>