<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Config">
		<h3>#rc.mmRBF.key('configuration')#</h3>
		<ul class="form">
			<li class="first">
				<label for="forumbean_name">#rc.mmRBF.key('configurationname')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('configurationname','tip')#</span>&nbsp;</a></label>
				<select name="forumbean_configurationid">
					<option value="">#rc.mmRBF.key('inherit')#</option>
					<cfloop from="1" to="#ArrayLen(rc.aConfiguration)#" index="local.iiX">
						<option value="#rc.aConfiguration[local.iiX].getConfigurationID()#"<cfif rc.aConfiguration[local.iiX].getConfigurationID() eq form.forumbean_configurationid>SELECTED</cfif>>#rc.aConfiguration[local.iiX].getName()#</option>
					</cfloop>
				</select>
			</li>
		</ul>
	</div>
</cfoutput>