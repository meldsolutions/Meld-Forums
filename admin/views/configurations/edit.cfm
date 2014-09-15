<cfimport prefix="ui" taglib="../../ui" />
<cfsilent>
	
	<!--- rc --->
	<!--- headers --->
	<cfinclude template="headers/jquery-configuration-showhide.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui-tabs.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui.cfm">
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
	<div class="row">
		<div class="span12">
			#view("/global/bc")#
		</div>
	</div>
	<!-- CONTENT HERE -->
<cfif rc.configurationBean.getBeanExists()>
	<form action="#buildURL('admin:configurations.edit?btaction=update')#" method="post">	
<cfelse>
	<form action="#buildURL('admin:configurations.edit?btaction=save')#" method="post">	
</cfif>
<input type="hidden" name="configurationID" value="#rc.configurationBean.getconfigurationID()#">

<div class="tabbable tabs-left">

	<ul class="nav nav-tabs tabs initActiveTab">
		<li><a href="##tabBasic" 		data-toggle="tab"><span>#rc.mmRBF.key('general')#</span></a></li>
		<li><a href="##tabPermissions"	data-toggle="tab"><span>#rc.mmRBF.key('permissions')#</span></a></li>
		<li><a href="##tabOptions" 		data-toggle="tab"><span>#rc.mmRBF.key('options')#</span></a></li>
	</ul>

	<div class="tab-content row-fluid">

		#view("configurations/includes/configurations_edit_general")#
		#view("configurations/includes/configurations_edit_permissions")#
		#view("configurations/includes/configurations_edit_options")#

		<div class="load-inline tab-preloader"></div>

		<div class="form-actions">
		
			<a href="#buildURL('admin:configurations.default')#" class="btn"><i class="icon-remove"></i> Cancel</a>
			<button type="submit" class="btn" ><i class="icon-check"></i> save</button>
			 
		</div><!--- /form-actions --->
	</div>
</form>
<!--- end content --->
</cfoutput> 