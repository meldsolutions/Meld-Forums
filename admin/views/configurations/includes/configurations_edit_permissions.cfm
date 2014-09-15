<cfimport prefix="ui" taglib="../../../ui" />
<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="tabPermissions" class="tab-pane">
		<span id="extendset-container-tabbasictop" class="extendset-container"></span>
		<div class="fieldset">
			<ui:Checkbox key="doClosed"	name="configurationbean_doClosed" />
		
			<div class="control-group">
				<label class="control-label" for="RestrictReadGroups">
					<cfif request.context.mmRBF.keyExists('RestrictReadGroups','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('RestrictReadGroups','tip')#">#request.context.mmRBF.key('RestrictReadGroups')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('RestrictReadGroups')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('RestrictReadGroups','tip')>
						<span class="help-inline">(#request.context.mmRBF.key('RestrictReadGroups','tip')#)</span>	
					</cfif>
				</label>



				<div class="controls">
					<select name="configurationbean_RestrictReadGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictReadGroups">
					<option value="RestrictAll" <cfif form.configurationbean_RestrictReadGroups eq 'RestrictAll'>selected</cfif>>#rc.mmRBF.key('restrictall')#</option>
					<option value="" <cfif form.configurationbean_RestrictReadGroups eq ''>selected</cfif>>#rc.mmRBF.key('allowall')#</option>
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
			</div>
		
			<div class="control-group">
				<label class="control-label" for="RestrictContributeGroups">
					<cfif request.context.mmRBF.keyExists('RestrictContributeGroups','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('RestrictContributeGroups','tip')#">#request.context.mmRBF.key('RestrictContributeGroups')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('RestrictContributeGroups')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('RestrictContributeGroups','tip')>
						<span class="help-inline">(#request.context.mmRBF.key('RestrictContributeGroups','tip')#)</span>	
					</cfif>
				</label>
				<div class="controls">
					<select name="configurationbean_RestrictContributeGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictContributeGroups">
					<option value="RestrictAll" <cfif form.configurationbean_RestrictContributeGroups eq 'RestrictAll'>selected</cfif>>#rc.mmRBF.key('restrictall')#</option>
					<option value="" <cfif form.configurationbean_RestrictContributeGroups eq ''>selected</cfif>>#rc.mmRBF.key('allowall')#</option>
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
			</div>
		
			<div class="control-group">
				<label class="control-label" for="RestrictModerateGroups">
					<cfif request.context.mmRBF.keyExists('RestrictModerateGroups','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('RestrictModerateGroups','tip')#">#request.context.mmRBF.key('RestrictModerateGroups')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('RestrictModerateGroups')#
					</cfif>
				</label>
				<div class="controls">
					<select name="configurationbean_RestrictModerateGroups" size="8" multiple="multiple" class="multiSelect" id="configurationbean_RestrictModerateGroups">
						<option value="RestrictAll" <cfif form.configurationbean_RestrictModerateGroups eq 'RestrictAll'>selected</cfif>>#rc.mmRBF.key('restrictall')#</option>
						<option value="" <cfif form.configurationbean_RestrictModerateGroups eq ''>selected</cfif>>#rc.mmRBF.key('allowall')#</option>
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
			</div>
	
		</div>

	</div>


</cfoutput>