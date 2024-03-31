<!-- logout.cfm -->
<cfset StructDelete(session, "isLoggedIn")>
<cflocation url="index.cfm" addtoken="no">
