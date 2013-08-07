<cfimport prefix="ui" taglib="../../../ui" />
<cfoutput>
	<div id="msTabs-General-Tab" class="tab-pane">
		<span id="extendset-container-tabbasictop" class="extendset-container"></span>
		<div class="fieldset">

			<ui:TextInput 	key="threadsperpage"			name="settingsbean_threadsperpage"
							required="true"				validate="number"
							classlist="span2" />

			<ui:TextInput 	key="postsperpage"			name="settingsbean_postsperpage"
							required="true"				validate="number"
							classlist="span2" />


			<cfif rc.pluginConfig.getSetting('dsntype') eq "mssql">
				<input type="hidden" name="settingsbean_searchmode" value="simple" />
			<cfelse>
				<div class="control-group">
					<label class="control-label">
						<cfif request.context.mmRBF.keyExists('searchmode','tip')>
							<a href="##" rel="tooltip" title="#request.context.mmRBF.key('searchmode','tip')#">#request.context.mmRBF.key('searchmode')# <i class="icon-question-sign"></i></a>
						<cfelse>
							#request.context.mmRBF.key('searchmode')#
						</cfif>
						<cfif request.context.mmRBF.keyExists('searchmode','helptext')>
							<span class="help-inline">(request.context.mmRBF.key('searchmode','helptext'))</span>	
						</cfif>
					</label>
					<div class="controls">
						<cfset loopList = "simple,fulltext">
						<select name="settingsbean_searchmode" id="settingsbean_searchmode">
						<cfloop list=#loopList# index="iiX">
							<option value="#iiX#" <cfif form.settingsbean_searchmode eq iiX>selected</cfif>>#rc.mmRBF.key('searchmode_#iiX#')#</option>
						</cfloop>
						</select>
					</div>
				</div>
			</cfif>
		</div>
	</div>
</cfoutput>