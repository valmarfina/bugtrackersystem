<!-- errors.cfm -->
<cfparam name="session.sortOrder" default="DESC">
<cfparam name="session.sortOrderID" default="DESC">
<cfparam name="session.sortOrderDate" default="DESC">

<cfif NOT IsDefined("session.isLoggedIn") OR NOT session.isLoggedIn>
  <cflocation url="index.cfm" addtoken="no">
</cfif>

<cfif IsDefined("URL.toggleSort")>
    <cfset session.sortOrderID = (session.sortOrderID EQ "ASC") ? "DESC" : "ASC">
</cfif>

<cfif IsDefined("URL.toggleSortDate")>
    <cfset session.sortOrderDate = (session.sortOrderDate EQ "ASC") ? "DESC" : "ASC">
</cfif>

<cfset sortConditions = []>
<cfif IsDefined("URL.toggleSort")>
    <cfset ArrayAppend(sortConditions, "error_id " & session.sortOrderID)>
</cfif>
<cfif IsDefined("URL.toggleSortDate")>
    <cfset ArrayAppend(sortConditions, "entry_date " & session.sortOrderDate)>
</cfif>

<cfset sortString = sortConditions.len() ? ArrayToList(sortConditions, ", ") : "entry_date DESC">

<cfquery name="getErrors" datasource="CFbugtrackingdb">
    SELECT error_id, status, urgency, criticality, short_description, entry_date
    FROM public.errors
    ORDER BY #sortString#
</cfquery>

<!DOCTYPE html>
<html>
<head>
  <title>bugs sheet</title>
  <link rel="stylesheet" href="styles/errors.css?v=1">
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

  <h2>BUGS</h2>
  <table>
    <thead>
      <tr>
        <th><a href="errors.cfm?toggleSort=yes">ID ошибки</a></th>
        <th>статус</th>
        <th>срочность</th>
        <th>критичность</th>
        <th>описание</th>
        <th><a href="errors.cfm?toggleSortDate=yes">Обновление</a></th>
      </tr>
    </thead>
    <tbody>
      <cfoutput query="getErrors">
        <tr>
          <td><a href="bugDetail.cfm?error_id=#error_id#">#error_id#</a></td>
          <td>#status#</td>
          <td>#urgency#</td>
          <td>#criticality#</td>
          <td>#short_description#</td>
          <td>#DateTimeFormat(entry_date, "dd.mm.yyyy HH:nn")#</td>
        </tr>
      </cfoutput>
    </tbody>
  </table>
</body>
  <footer class="site-footer">
    <p>&copy; 2024 Bug Tracker System by Valeriya Marfina</p>
  </footer>
</html>