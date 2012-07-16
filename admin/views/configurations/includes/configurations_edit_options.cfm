<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-Options">
		<h3>#rc.mmRBF.key('options')#</h3>
		<ul class="form">
			<cfif not rc.configurationBean.getIsMaster()>
			<li class="first checkbox">
				<input class="checkbox" type="checkbox" name="configurationbean_isactive" id="configurationbean_isactive" value="1" <cfif form.configurationbean_isactive>CHECKED</cfif> />
				<label for="configurationbean_isactive">#rc.mmRBF.key('active')#</label>
			</li>
			<li class="checkbox padded">
			<cfelse>
			<input type="hidden" name="configurationbean_isactive" id="configurationbean_isactive" value="1" />
			<li class="checkbox first">
			</cfif>
				<input class="checkbox" type="checkbox" name="configurationbean_doavatars" id="configurationbean_doavatars" value="1" <cfif form.configurationbean_doavatars>CHECKED</cfif> />
				<label for="configurationbean_doavatars">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('AllowAvatars','tip')#</span>#rc.mmRBF.key('AllowAvatars')#</a>
				</label>
			</li>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="configurationbean_doattachments" id="configurationbean_doattachments" value="1" <cfif form.configurationbean_doattachments>CHECKED</cfif> />
				<label for="configurationbean_doattachments">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('Allowattachments','tip')#</span>#rc.mmRBF.key('Allowattachments')#</a>
				</label>
			</li>
			<li>
				<label for="configurationbean_allowattachmentextensions">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('allowedextensionslist','tip')#</span>#rc.mmRBF.key('allowedextensionslist')#</a>
				</label>
				<input class="text" type="text" name="configurationbean_allowattachmentextensions" id="configurationbean_allowattachmentextensions" value="#form.configurationbean_allowattachmentextensions#" size="100" maxlength="250" data-required="true" data-validate="string" data-message="#rc.mmRBF.key('allowedextensionslist','validation')#" />
				<div>(#rc.mmRBF.key('masterallowedextensions')#: #rc.settingsBean.getAllowedExtensions()#)</div>
			</li>
			<li class="last">
				<label for="configurationbean_filesizeLimit">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('filesizeLimit','tip')#</span>#rc.mmRBF.key('filesizeLimit')#</a>
				</label>
				<input class="text tiny" type="text" name="configurationbean_filesizeLimit" id="configurationbean_filesizeLimit" value="#form.configurationbean_filesizeLimit#" size="20" maxlength="5" data-required="true" data-validate="number" data-message="#rc.mmRBF.key('filesizeLimit','validation')#" />
			</li>
		</ul
		<ul class="form">
			<fieldset>
				<legend>#rc.mmRBF.key('imageattachments')#</legend>
			<li class="checkbox padded">
				<input class="checkbox" type="checkbox" name="configurationbean_doInlineImageAttachments" id="configurationbean_doInlineImageAttachments" value="1" <cfif form.configurationbean_doInlineImageAttachments>CHECKED</cfif> />
				<label for="configurationbean_doInlineImageAttachments">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('InlineImageAttachments','tip')#</span>#rc.mmRBF.key('InlineImageAttachments')#</a>
				</label>
			</li>
			<li>
				<label for="configurationbean_ImageWidthLimit">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('ImageWidthLimit','tip')#</span>#rc.mmRBF.key('ImageWidthLimit')#</a>
				</label>
				<input class="text tiny" type="text" name="configurationbean_ImageWidthLimit" id="configurationbean_ImageWidthLimit" value="#form.configurationbean_ImageWidthLimit#" size="20" maxlength="5" data-required="true" data-validate="number" data-message="#rc.mmRBF.key('ImageWidthLimit','validation')#" />
			</li>
			<li class="last">
				<label for="configurationbean_ImageHeightLimit">
					<a href="##" class="tooltip"><span>#rc.mmRBF.key('ImageHeightLimit','tip')#</span>#rc.mmRBF.key('ImageHeightLimit')#</a>
				</label>
				<input class="text tiny" type="text" name="configurationbean_ImageHeightLimit" id="configurationbean_ImageHeightLimit" value="#form.configurationbean_ImageHeightLimit#" size="20" maxlength="5" data-required="true" data-validate="number" data-message="#rc.mmRBF.key('ImageHeightLimit','validation')#" />
			</li>
			</fieldset>
		</ul>
	</div>
</cfoutput>