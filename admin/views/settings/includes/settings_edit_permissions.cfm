<cfimport prefix="ui" taglib="../../../ui" />
<cfoutput>
	<div id="msTabs-Permissions-Tab" class="tab-pane">
		<div class="fieldset">
		
			<div class="control-group">
				<label class="control-label" for="PermissionGroups">
					<cfif request.context.mmRBF.keyExists('PermissionGroups','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('PermissionGroups','tip')#">#request.context.mmRBF.key('PermissionGroups')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('PermissionGroups')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('PermissionGroups','tip')>
						<span class="help-inline">(#request.context.mmRBF.key('PermissionGroups','tip')#)</span>	
					</cfif>
				</label>

				<div class="controls">
					<select name="settingsbean_PermissionGroups" size="8" multiple="multiple" class="multiSelect" id="settingsbean_PermissionGroups">
					<option value="RestrictAll" <cfif form.settingsbean_PermissionGroups eq 'RestrictAll'>selected</cfif>>#rc.mmRBF.key('superusers')#</option>
					<cfif rc.qGroupsPublic.recordcount>
						<optgroup label="#rc.mmRBF.key('membergroups')#">
							<cfloop query="rc.qGroupsPublic">
							<option value="#groupname#" <cfif listfind(form.settingsbean_PermissionGroups,groupname)>selected</cfif>>#groupname#</option>
							</cfloop>
						</optgroup>
					</cfif>
					<cfif rc.qGroupsPrivate.recordcount>
						<optgroup label="#rc.mmRBF.key('admingroups')#">
							<cfloop query="rc.qGroupsPrivate">
							<option value="#groupname#" <cfif listfind(form.settingsbean_PermissionGroups,groupname)>selected</cfif>>#groupname#</option>
							</cfloop>
						</optgroup>
					</cfif>
					</select>
				</div>
			</div>
		</div>
	</div>
</cfoutput>