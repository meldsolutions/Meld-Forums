<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Permissions">
		<h3>#rc.mmRBF.key('permissions')#</h3>
		<ul class="form">
			<li class="first">
				<label for="settingsbean_permissiongroups">#rc.mmRBF.key('permissiongroups')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('permissiongroups','tip')#</span>&nbsp;</a></label>
				<select name="settingsbean_permissiongroups" size="8" multiple="multiple" class="multiSelect" id="settingsbean_permissiongroups">
				<optgroup label="#htmlEditFormat(rc.mmRBF.key('globalsettings'))#">
					<option value="RestrictAll" <cfif form.settingsbean_permissiongroups eq 'RestrictAll'>selected</cfif>>#rc.mmRBF.key('restrictall')#</option>
				</optgroup>
				<cfif rc.qGroupsPublic.recordcount>
					<optgroup label="#rc.mmRBF.key('membergroups')#">
						<cfloop query="rc.qGroupsPublic">
						<option value="#groupname#" <cfif listfind(form.settingsbean_permissiongroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				<cfif rc.qGroupsPrivate.recordcount>
					<optgroup label="#rc.mmRBF.key('admingroups')#">
						<cfloop query="rc.qGroupsPrivate">
						<option value="#groupname#" <cfif listfind(form.settingsbean_permissiongroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
			</select>
			</li>
		</ul>
	</div>
</cfoutput>