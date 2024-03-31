<!-- history.cfm -->
<cfif NOT session.isLoggedIn>
    <cflocation url="index.cfm" addtoken="no">
</cfif>

<cfif NOT IsDefined("session.isLoggedIn") OR NOT session.isLoggedIn>
  <cflocation url="index.cfm" addtoken="no">
</cfif>

<cfquery name="getErrorHistory" datasource="CFbugtrackingdb">
    SELECT eh.error_id, eh.action_date, eh.action, eh.comment, u.first_name, u.last_name
    FROM public.error_history eh
    LEFT JOIN public.users u ON eh.actioned_by = u.user_id
    ORDER BY eh.action_date DESC
</cfquery>


<!DOCTYPE html>
<html>
    <head>
        <title>history sheet</title>
        <link rel="stylesheet" href="styles/history.css?v=2">
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

        <h2>HISTORY</h2>
        <table>
            <thead>
                <tr>
                    <th>Error ID</th>
                    <th>Action Date</th>
                    <th>Action</th>
                    <th>Comment</th>
                    <th>Actioned By</th>
                </tr>
            </thead>

            <tbody>
                <cfoutput query="getErrorHistory">
                    <tr>
                        <td><a href="bugDetail.cfm?error_id=#error_id#">#error_id#</a></td>
                        <td>#DateTimeFormat(action_date, "dd.mm.yyyy HH:nn")#</td>
                        <td>#action#</td>
                        <td>#comment#</td>
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