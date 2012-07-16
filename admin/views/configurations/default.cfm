<cfsilent>
	
	<!--- rc --->
	<!--- headers --->
	<cfinclude template="headers/jquery-datatable-configuration.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-datatable.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui.cfm">
	<cfoutput>
	</cfoutput>
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
	#view("configurations/includes/default_list")#
</div>	
<!--- end content --->
</cfoutput> 