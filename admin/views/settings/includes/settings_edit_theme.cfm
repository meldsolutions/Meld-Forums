<cfimport prefix="ui" taglib="../../../ui" />
<cfoutput>
	
	<div id="msTabs-Theme-Tab" class="tab-pane">

		<div class="fieldset">

			<div class="control-group">
				<label class="control-label">
					<cfif request.context.mmRBF.keyExists('theme','tip')>
						<a href="##" rel="tooltip" title="#request.context.mmRBF.key('theme','tip')#">#request.context.mmRBF.key('theme')# <i class="icon-question-sign"></i></a>
					<cfelse>
						#request.context.mmRBF.key('theme')#
					</cfif>
					<cfif request.context.mmRBF.keyExists('theme','helptext')>
						<span class="help-inline">(request.context.mmRBF.key('theme','helptext'))</span>	
					</cfif>
				</label>
				<div class="controls">
				<select name="settingsbean_themeID" id="settingsbean_themeID">
				<cfloop from="1" to="#arrayLen(rc.aThemes)#" index="local.iiX">
					<option value="#rc.aThemes[local.iiX].getThemeID()#"<cfif rc.aThemes[local.iiX].getThemeID() eq form.settingsbean_themeID> SELECTED</cfif>>#rc.aThemes[local.iiX].getName()#</option>
				</cfloop>
				</select>
				</div>
			</div>
		</div>
	</div>

</cfoutput>