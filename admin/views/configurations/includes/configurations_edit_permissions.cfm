<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Permissions">
		<h3>#rc.mmRBF.key('permissions')#</h3>
		<ul class="form">
			<li class="first checkbox">
				<input class="checkbox" type="checkbox" name="configurationbean_doClosed" id="configurationbean_doClosed" value="1" <cfif form.configurationbean_doClosed>checked</cfif>/>
				<label for="configurationbean_doClosed">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('doClosed','tip')#</span>#rc.mmRBF.key('doClosed')#</a>
				</label>
			</li>
		</ul>
		<ul class="form">
			<li class="first">
				<a href="##" class="tooltip"><span>#rc.mmRBF.key('accesspermissions','tip')#</span><strong>#rc.mmRBF.key('accesspermissions')#</strong></a>
			</li>
			<li class="checkbox padded">
				<label for="configurationbean_dorestrictread">#rc.mmRBF.key('RestrictReadGroups')#</label>
				<div id="showhide-dorestrictread">
				<select name="configurationbean_RestrictReadGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictReadGroups">
				<optgroup label="#htmlEditFormat(rc.mmRBF.key('globalconfiguration'))#">
					<option value="RestrictAll" <cfif form.configurationbean_RestrictReadGroups eq 'RestrictAll'>selected</cfif>>#rc.mmRBF.key('restrictall')#</option>
					<option value="" <cfif form.configurationbean_RestrictReadGroups eq ''>selected</cfif>>#rc.mmRBF.key('allowall')#</option>
				</optgroup>
				<cfif rc.qGroupsPublic.recordcount>
					<optgroup label="#rc.mmRBF.key('membergroups')#">
						<cfloop query="rc.qGroupsPublic">
						<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictReadGroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				<cfif rc.qGroupsPrivate.recordcount>
					<optgroup label="#rc.mmRBF.key('admingroups')#">
						<cfloop query="rc.qGroupsPrivate">
						<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictReadGroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				</select>
				</div>
			</li>
			<li class="checkbox padded">
				<label for="configurationbean_dorestrictcontribute">#rc.mmRBF.key('RestrictContributeGroups')#</label>
				<div id="showhide-dorestrictcontribute">
				<select name="configurationbean_RestrictContributeGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictContributeGroups">
				<optgroup label="#htmlEditFormat(rc.mmRBF.key('globalconfiguration'))#">
					<option value="RestrictAll" <cfif form.configurationbean_RestrictContributeGroups eq 'RestrictAll'>selected</cfif>>#rc.mmRBF.key('restrictall')#</option>
					<option value="" <cfif form.configurationbean_RestrictContributeGroups eq ''>selected</cfif>>#rc.mmRBF.key('allowall')#</option>
				</optgroup>
				<cfif rc.qGroupsPublic.recordcount>
					<optgroup label="#rc.mmRBF.key('membergroups')#">
						<cfloop query="rc.qGroupsPublic">
						<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictContributeGroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				<cfif rc.qGroupsPrivate.recordcount>
					<optgroup label="#rc.mmRBF.key('admingroups')#">
						<cfloop query="rc.qGroupsPrivate">
						<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictContributeGroups,groupname)>selected</cfif>>#groupname#</option>
						</cfloop>
					</optgroup>
				</cfif>
				</select>
				</div>
			</li>
			<li class="checkbox padded last">
				<label for="configurationbean_dorestrictmoderate">#rc.mmRBF.key('RestrictModerateGroups')#</label>
				<div id="showhide-dorestrictmoderate">
					<select name="configurationbean_RestrictModerateGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictModerateGroups">
					<optgroup label="#htmlEditFormat(rc.mmRBF.key('globalconfiguration'))#">
						<option value="RestrictAll" <cfif form.configurationbean_RestrictModerateGroups eq 'RestrictAll'>selected</cfif>>#rc.mmRBF.key('restrictall')#</option>
						<option value="" <cfif form.configurationbean_RestrictModerateGroups eq ''>selected</cfif>>#rc.mmRBF.key('allowall')#</option>
					</optgroup>
					<cfif rc.qGroupsPublic.recordcount>
						<optgroup label="#rc.mmRBF.key('membergroups')#">
							<cfloop query="rc.qGroupsPublic">
							<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictModerateGroups,groupname)>selected</cfif>>#groupname#</option>
							</cfloop>
						</optgroup>
					</cfif>
					<cfif rc.qGroupsPrivate.recordcount>
						<optgroup label="#rc.mmRBF.key('admingroups')#">
							<cfloop query="rc.qGroupsPrivate">
							<option value="#groupname#" <cfif listfind(form.configurationbean_RestrictModerateGroups,groupname)>selected</cfif>>#groupname#</option>
							</cfloop>
						</optgroup>
					</cfif>
					</select>
				</div>
			</li>
		</ul>
	</div>
</cfoutput>