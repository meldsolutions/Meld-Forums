<cfsilent>
	
	<!--- rc --->
	<!--- headers --->
	<cfoutput>
	</cfoutput>
</cfsilent><cfoutput>
<!--- global menu --->
<!--- begin content --->
	<div class="row">
		<div class="span12">
			<a href="#buildURL('admin:settings.edit')#" title="#rc.mmRBF.key('editsettings','tip')#" class="btn pull-right"><i class="icon-plus-sign"></i> #rc.mmRBF.key('editsettings')#</a>
		</div>
	</div>
	<!-- CONTENT HERE -->
	#view("settings/includes/default_view_settings")#
<!--- end content --->
</cfoutput> 