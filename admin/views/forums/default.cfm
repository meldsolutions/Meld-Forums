<cfsilent>
	<!--- rc --->
	<!--- headers --->
	<cfinclude template="headers/jquery-datatable-forums.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-datatable.cfm">
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
	<cfif not rc.hasConferences>
		<div class="error">
		#rc.mmRBF.key('createconferencesfirst','error')#
		</div>
	<cfelse>
		#view("forums/includes/default_list")#
	</cfif>
</div>	
<!--- end content --->
</cfoutput> 