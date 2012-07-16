<cfsilent>
	
	<!--- rc --->
	<!--- headers --->
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui-tabs.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui.cfm">
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body" class="section">
	<!-- CONTENT HERE -->
	<form id="meld-edit-form" class="meld-form" method="post" action="index.cfm" onsubmit="return validate(this)">
	<input type="hidden" name="action" value="settings.edit">
	<input type="hidden" name="settingsID" value="#rc.settingsBean.getSettingsID()#">
	<div id="meld-body">
		<!-- CONTENT HERE -->
		<div id="msTabs">
			<ul>
				<li><a id="msTabs-General-Tab" href="##msTabs-General">#rc.mmRBF.key('general')#</a></li>
				<li><a id="msTabs-Permissions-Tab" href="##msTabs-Permissions">#rc.mmRBF.key('permissions')#</a></li>
				<li><a id="msTabs-Files-Tab" href="##msTabs-Files">#rc.mmRBF.key('files')#</a></li>
				<li><a id="msTabs-Theme-Tab" href="##msTabs-Theme">#rc.mmRBF.key('Theme')#</a></li>
			</ul>
			<div id="msTabs-panels">
				#view("settings/includes/settings_edit_general")#
				#view("settings/includes/settings_edit_permissions")#
				#view("settings/includes/settings_edit_files")#
				#view("settings/includes/settings_edit_theme")#
			</div>
			<div>
				<ul class="form-buttons">
					<li><input name="btaction" type="submit" class="submit ui-state-default" value="cancel"></li>
					<li><input name="btaction" type="submit" class="submit ui-state-default" value="update"></li>
				</ul>
			</div>
		</div>	
	</div>	
	</form>
</div>

<!--- end content --->
</cfoutput> 