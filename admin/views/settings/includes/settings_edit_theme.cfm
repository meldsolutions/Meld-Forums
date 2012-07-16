<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Theme">
		<h3>#rc.mmRBF.key('theme')#</h3>
		<ul class="form">
			<li class="first">
				<label for="settingsbean_themeID">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('theme','tip')#</span>#rc.mmRBF.key('theme')#</a>
				</label>
				<select name="settingsbean_themeID" id="settingsbean_themeID">
				<cfloop from="1" to="#arrayLen(rc.aThemes)#" index="local.iiX">
					<option value="#rc.aThemes[local.iiX].getThemeID()#"<cfif rc.aThemes[local.iiX].getThemeID() eq form.settingsbean_themeID> SELECTED</cfif>>#rc.aThemes[local.iiX].getName()#</option>
				</cfloop>
				</select>
			</li>
		</ul>
	</div>
</cfoutput>