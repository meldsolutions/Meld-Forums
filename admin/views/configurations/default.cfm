<cfimport prefix="ui" taglib="../../ui" />

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
<div class="row">
	<div class="span12">
	<a href="#buildURL('admin:configurations.edit')#&copy=true&ConfigurationID=00000000-0000-0000-0000000000000001" title="#rc.mmRBF.key('addnewconfiguration','tip')#" class="btn pull-right"><i class="icon-plus-sign"></i> #rc.mmRBF.key('addnewconfiguration')#</a>
	</div>
</div>
<br/>
	<!-- CONTENT HERE -->
	#view("configurations/includes/default_list")#
	</div>	
</div>	
<!--- end content --->
</cfoutput> 