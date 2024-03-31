<!-- index_action.cfm -->
<cftry>
  <cfquery name="getUser" datasource="CFbugtrackingdb">
    SELECT user_id, password_hash, first_name, last_name
    FROM public.users
    WHERE account = <cfqueryparam value="#form.username#" cfsqltype="CF_SQL_VARCHAR">
  </cfquery>
  
  <cfif getUser.recordCount>
    <cfset inputHash = hash(form.password, 'SHA-256')>
    
    <cfif getUser.password_hash EQ inputHash>
      <cfset session.isLoggedIn = true>
      <cfset session.user_id = getUser.user_id> 
      <cfset session.firstName = getUser.first_name>
      <cfset session.lastName = getUser.last_name>
      <cflocation url="errors.cfm" addtoken="no">
    <cfelse>
      <cfoutput>Ошибка: неверный логин или пароль.</cfoutput>
    </cfif>
  <cfelse>
    <cfoutput>Ошибка: неверный логин или пароль.</cfoutput>
  </cfif>
  
  <cfcatch type="database">
    <cfoutput>Ошибка при выполнении запроса: #cfcatch.message#</cfoutput>
  </cfcatch>
</cftry>
