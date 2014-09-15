<cfimport prefix="ui" taglib="../../../ui" />
<cfoutput>
	<div id="msTabs-Config" class="tab-pane">
		<span id="extendset-container-tabbasictop" class="extendset-container"></span>

		<div class="fieldset">

			<!--- active --->
			<ui:Checkbox key="isactive" 		name="conferencebean_isactive" />

			<div class="control-group">
				<label class="control-label">
					<cfif request.context.mmRBF.keyExists('configuration','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('configuration','tip')#">#request.context.mmRBF.key('configuration')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('configuration')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('configuration','helptext')>
						<span class="help-inline">#(request.context.mmRBF.key('configuration','helptext'))#</span>
					</cfif>
				</label>
				<div class="controls">
					<select name="conferencebean_configurationid">
						<option value="">#rc.mmRBF.key('inherit')#</option>
						<cfloop from="1" to="#ArrayLen(rc.aConfiguration)#" index="local.iiX">
							<option value="#rc.aConfiguration[local.iiX].getConfigurationID()#" <cfif rc.aConfiguration[local.iiX].getConfigurationID() eq form.conferencebean_configurationid>SELECTED</cfif>>#rc.aConfiguration[local.iiX].getName()#</option>
						</cfloop>
					</select>
				</div>
			</div>
		</div>
	</div>
</cfoutput>