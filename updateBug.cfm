<!-- updateBug.cfm -->
<cfif NOT IsDefined("session.isLoggedIn") OR NOT session.isLoggedIn>
    <cflocation url="index.cfm" addtoken="no">
</cfif>

<cfparam name="form.error_id" default="0">
<cfparam name="form.status" default="">
<cfparam name="form.comment" default="">

<!-- текущий статус ошибки -->
<cfquery name="getCurrentStatus" datasource="CFbugtrackingdb">
    SELECT status
    FROM public.errors
    WHERE error_id = <cfqueryparam value="#form.error_id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfset currentStatus = getCurrentStatus.status>

<!-- доступные статусы и соответствующие действия на основе текущего статуса -->
<cfscript>
    availableStatuses = {};
    availableStatuses['New'] = {'Open': 'Назначение'};
    availableStatuses['Open'] = {'Resolved': 'Решение'};
    availableStatuses['Resolved'] = {'Open': 'Перепоручение', 'Verified': 'Проверка'};
    availableStatuses['Verified'] = {'Open': 'Перепоручение', 'Closed': 'Закрытие'};

    selectedAction = availableStatuses[currentStatus][form.status];
</cfscript>

<cfquery datasource="CFbugtrackingdb">
    UPDATE public.errors
    SET status = <cfqueryparam value="#form.status#" cfsqltype="CF_SQL_VARCHAR">::error_status
    WHERE error_id = <cfqueryparam value="#form.error_id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfquery datasource="CFbugtrackingdb">
    INSERT INTO public.error_history (error_id, action_date, action, comment, actioned_by)
    VALUES (
        <cfqueryparam value="#form.error_id#" cfsqltype="CF_SQL_INTEGER">,
        CURRENT_TIMESTAMP,
        <cfqueryparam value="#selectedAction#" cfsqltype="CF_SQL_VARCHAR">::error_action,
        <cfqueryparam value="#form.comment#" cfsqltype="CF_SQL_VARCHAR">,
        <cfqueryparam value="#session.user_id#" cfsqltype="CF_SQL_INTEGER">
    )
</cfquery>

<cflocation url="bugDetail.cfm?error_id=#form.error_id#" addtoken="no">
