<cfsilent>
	<!--- rc --->
	<!--- headers --->
	<cfinclude template="headers/jquery-datatable-conference.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-datatable.cfm">
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
		<!-- CONTENT HERE -->
		#view("conferences/includes/default_list")#
<!--- end content --->
</cfoutput> 