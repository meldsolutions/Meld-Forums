<cfsilent>
	
	<!--- rc --->
	<!--- headers --->
	<cfinclude template="headers/jquery-configuration-showhide.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui-tabs.cfm">
	<cfinclude template="/#rc.pluginConfig.getPackage()#/admin/includes/headers/jquery-ui.cfm">
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
<div id="meld-body">
	<!-- CONTENT HERE -->
<form id="meld-edit-form" class="meld-form" method="post" action="index.cfm">
<input type="hidden" name="action" value="configurations.edit">
<input type="hidden" name="configurationID" value="#rc.configurationBean.getconfigurationID()#">
<div id="msTabs">
	<ul>
		<li><a id="msTabs-General-Tab" href="##msTabs-General">#rc.mmRBF.key('general')#</a></li>
		<li><a id="msTabs-Permissions-Tab" href="##msTabs-Permissions">#rc.mmRBF.key('permissions')#</a></li>
		<li><a id="msTabs-Options-Tab" href="##msTabs-Options">#rc.mmRBF.key('options')#</a></li>
	</ul>
	<div id="msTabs-panels">
		#view("configurations/includes/configurations_edit_general")#
		#view("configurations/includes/configurations_edit_permissions")#
		#view("configurations/includes/configurations_edit_options")#
	</div>
	<div>
		<ul class="form-buttons">
			<li><input name="btaction" type="submit" class="submit ui-state-default" value="cancel"></li>
			<cfif rc.configurationBean.beanExists()>
				<li><input name="btaction" type="submit" class="submit ui-state-default" value="update"></li>
				<li class="right">
					<input type="hidden" id="btdeleteconfirm" name="btdeleteconfirm" value="" />
					<!--- cannot delete the master --->
					<cfif not rc.configurationBean.getIsMaster()>
						<input data-delete="#rc.mmRBF.key('delete')#" data-cancel="#rc.mmRBF.key('cancel')#" data-title="#rc.mmRBF.key('delete')#" data-message="#rc.mmRBF.key('deleteconfiguration-msg')#" id="btdelete" name="btaction" type="submit" class="submit ui-state-highlight" value="delete">
					</cfif>
				</li>
			<cfelse>
				<li><input name="btaction" type="submit" class="submit ui-state-default" value="save"></li>
			</cfif>
		</ul>
	</div>
</div>	
</form>
<!--- end content --->
</cfoutput> 