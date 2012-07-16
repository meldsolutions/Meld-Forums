<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-General">
		<input type="hidden" name="themebean_blather" value="1">
		<input type="hidden" name="themebean_bla" value="1">
		<input type="hidden" name="themebean_ber" value="1">
		<h3>#rc.mmRBF.key('general')#</h3>
		<ul class="form">
			<li class="first">
				<label for="settingsbean_threadsperpage">#rc.mmRBF.key('threadsperpage')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('threadsperpage','tip')#</span>&nbsp;</a></label>
				<input class="text tiny" type="text" name="settingsbean_threadsperpage" id="settingsbean_threadsperpage" value="#form.settingsbean_threadsperpage#" size="10" maxlength="5" data-required="true" data-validate="numeric" data-message="#rc.mmRBF.key('threadsperpage','validation')#" />
			</li>
			<li>
				<label for="settingsbean_postsperpage">#rc.mmRBF.key('postsperpage')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('postsperpage','tip')#</span>&nbsp;</a></label>
				<input class="text tiny" type="text" name="settingsbean_postsperpage" id="settingsbean_postsperpage" value="#form.settingsbean_postsperpage#" size="10" maxlength="5" data-required="true" data-validate="numeric" data-message="#rc.mmRBF.key('postsperpage','validation')#" />
			</li>
			<li>
				<label for="settingsbean_searchmode">#rc.mmRBF.key('searchmode')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('searchmode','tip')#</span>&nbsp;</a></label>
				<cfif rc.pluginConfig.getSetting('dsntype') eq "mssql">
					<cfset loopList = "simple">
				<cfelse>
					<cfset loopList = "simple,fulltext">
				</cfif>
				<select name="settingsbean_searchmode" id="settingsbean_searchmode">
					<cfloop list=#loopList# index="iiX">
						<option value="#iiX#" <cfif form.settingsbean_searchmode eq iiX>selected</cfif>>#rc.mmRBF.key('searchmode_#iiX#')#</option>
					</cfloop>
				</select>
			</li>
		</ul>
	</div>
</cfoutput>