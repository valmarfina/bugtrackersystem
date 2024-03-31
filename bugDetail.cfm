<!-- bugDetail.cfm -->
<cfparam name="URL.error_id" default="0">

<cfif NOT IsDefined("session.isLoggedIn") OR NOT session.isLoggedIn>
  <cflocation url="index.cfm" addtoken="no">
</cfif>

<cfquery name="getErrorDetail" datasource="CFbugtrackingdb">
  SELECT e.error_id, e.status, e.urgency, e.criticality, e.short_description, e.detailed_description, e.entry_date, u.first_name, u.last_name
  FROM public.errors e
  JOIN public.users u ON e.reported_by = u.user_id
  WHERE e.error_id = <cfqueryparam value="#URL.error_id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>


<cfquery name="getErrorHistory" datasource="CFbugtrackingdb">
  SELECT eh.history_id, eh.error_id, eh.action_date, eh.action, eh.comment, u.first_name, u.last_name
  FROM public.error_history eh
  LEFT JOIN public.users u ON eh.actioned_by = u.user_id
  WHERE eh.error_id = <cfqueryparam value="#URL.error_id#" cfsqltype="CF_SQL_INTEGER">
  ORDER BY eh.action_date DESC
</cfquery>

<cfquery name="getCurrentStatus" datasource="CFbugtrackingdb">
  SELECT status
  FROM public.errors
  WHERE error_id = <cfqueryparam value="#URL.error_id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfset currentStatus = getCurrentStatus.status>

<cfscript>
    availableStatuses = {};
    availableStatuses['New'] = {'Open': 'Назначение'};
    availableStatuses['Open'] = {'Resolved': 'Решение'};
    availableStatuses['Resolved'] = {'Open': 'Перепоручение', 'Verified': 'Проверка'};
    availableStatuses['Verified'] = {'Open': 'Перепоручение', 'Closed': 'Закрытие'};

    selectedAction = "";
</cfscript>


<!DOCTYPE html>
<html>
<head>
  <cfoutput>
    <title>BUG №#URL.error_id#</title>
    <input type="hidden" id="currentStatus" value="#currentStatus#">
  </cfoutput>
  <link rel="stylesheet" href="styles/bugDetail.css?v=2">
  <script>
    function showModal() {
      var currentStatus = document.getElementById('currentStatus').value;
      if (currentStatus === 'Closed') {
        document.getElementById('modalContent').innerHTML = '<p>Bug Closed</p><button onclick="hideModal();">OK</button>';
        document.getElementById('editModal').style.display = 'block';
      } else {
        document.getElementById('editModal').style.display = 'block';
      }
    }

    function hideModal() {
      document.getElementById('editModal').style.display = 'none';
    }
  </script>
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

  <cfif getErrorDetail.recordCount>
    <cfoutput query="getErrorDetail">
      <h2>BUG №#URL.error_id#</h2>
      <p class="created-by"><small>created by #getErrorDetail.first_name# #getErrorDetail.last_name#</small></p>
      <p><strong>DESCRIPTION:</strong></p>
      <p><strong>Дата:</strong> #DateTimeFormat(getErrorDetail.entry_date, "dd.mm.yyyy HH:nn")#</p>
      <p><strong>Статус:</strong> #getErrorDetail.status#</p>
      <p><strong>Срочность:</strong> #getErrorDetail.urgency#</p>
      <p><strong>Критичность:</strong> #getErrorDetail.criticality#</p>
      <p><strong>Краткое описание:</strong> #getErrorDetail.short_description#</p>
      <p><strong>Подробное описание:</strong> #getErrorDetail.detailed_description#</p>
    </cfoutput>

    <cfoutput>
      <button id="editBtn" class="edit-button" onclick="showModal();">Изменить баг</button>
      <h3>BUG HISTORY</h3>

      <div id="editModal" class="modal" style="display: none;">
        <div class="modal-content" id="modalContent">
          <span class="close" onclick="hideModal();">&times;</span>
          <!-- Conditional content based on status -->
          <cfif currentStatus IS NOT 'Closed'>
            <form id="editBugForm" method="post" action="updateBug.cfm">
              <input type="hidden" name="error_id" value="#URL.error_id#">
              <label for="status">Статус ошибки:</label>
              <select name="status" id="status">
                <cfloop collection="#availableStatuses[currentStatus]#" item="key">
                  <option value="#key#">#key#</option>
                </cfloop>
              </select>
              <label for="comment">Комментарий:</label>
              <textarea name="comment" id="comment" required></textarea>
              <input type="submit" value="Изменить">
            </form>
          <cfelse>
            <p>Bug Closed</p>
            <button onclick="hideModal();">OK</button>
          </cfif>
        </div>
      </div>
    </cfoutput>

    <cfif getErrorHistory.recordCount>
      <table>
        <thead>
          <tr>
            <th>ID истории</th>
            <th>Дата действия</th>
            <th>Действие</th>
            <th>Комментарий</th>
            <th>Ответственный</th>
          </tr>
        </thead>
        <tbody>
          <cfoutput query="getErrorHistory">
            <tr>
              <td>#history_id#</td>
              <td>#DateTimeFormat(action_date, "dd.mm.yyyy HH:nn")#</td>
              <td>#action#</td>
              <td>#comment#</td>
              <td>#first_name# #last_name#</td>
            </tr>
          </cfoutput>
        </tbody>
      </table>
    <cfelse>
      <p>История изменений отсутствует.</p>
    </cfif>
  <cfelse>
    <p>Ошибка с ID #URL.error_id# не найдена.</p>
  </cfif>
</body>
<footer class="site-footer">
  <p>&copy; 2024 Bug Tracker System by Valeriya Marfina</p>
</footer>
</html>
