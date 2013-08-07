<cfimport prefix="ui" taglib="../../ui" />
<cfsilent>
	
	<!--- rc --->
	<!--- headers --->
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui-tabs.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui.cfm">
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
	<!-- CONTENT HERE -->
	<form action="#buildURL('admin:settings.edit?btaction=update')#" method="post">	
	<input type="hidden" name="settingsID" value="#rc.settingsBean.getSettingsID()#">
		<!-- CONTENT HERE -->
	<div class="tabbable tabs-left">
	
		<ul class="nav nav-tabs tabs initActiveTab">
			<li><a href="##msTabs-General-Tab" 			data-toggle="tab"><span>#rc.mmRBF.key('general')#</span></a></li>
			<li><a href="##msTabs-Permissions-Tab" 		data-toggle="tab"><span>#rc.mmRBF.key('permissions')#</span></a></li>
			<li><a href="##msTabs-Files-Tab" 			data-toggle="tab"><span>#rc.mmRBF.key('files')#</span></a></li>
			<li><a href="##msTabs-Avatar-Tab" 			data-toggle="tab"><span>#rc.mmRBF.key('avatar')#</span></a></li>
			<li><a href="##msTabs-Theme-Tab"	 		data-toggle="tab"><span>#rc.mmRBF.key('theme')#</span></a></li>
		</ul>

		<div class="tab-content row-fluid">
			#view("settings/includes/settings_edit_general")#
			#view("settings/includes/settings_edit_permissions")#
			#view("settings/includes/settings_edit_files")#
			#view("settings/includes/settings_edit_avatar")#
			#view("settings/includes/settings_edit_theme")#
			

			<div class="load-inline tab-preloader"></div>
	
			<div class="form-actions">
				<button type="submit" class="btn" ><i class="icon-check"></i> save</button>
			</div>	
		</div>
	</div>
	</form>

<!--- end content --->
</cfoutput> 