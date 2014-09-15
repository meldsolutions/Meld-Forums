<cfimport prefix="ui" taglib="../../../ui" />
<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="tabOptions" class="tab-pane">
		<span id="extendset-container-tabbasictop" class="extendset-container"></span>
		<div class="fieldset">

			<cfif not rc.configurationBean.getIsMaster()>
				<ui:Checkbox key="active" name="configurationbean_isactive" />
			<cfelse>
				<input type="hidden" name="configurationbean_isactive" id="configurationbean_isactive" value="1" />
			</cfif>

			<ui:Checkbox key="AllowAvatars" name="configurationbean_doavatars" />


			<ui:Checkbox key="Allowattachments" name="configurationbean_doattachments" />

			<!--- allowed extentions --->
			<ui:TextInput 	key="allowedextensionslist"	name="configurationbean_allowattachmentextensions"
							helptext="#rc.mmRBF.key('masterallowedextensions')#: #rc.settingsBean.getAllowedExtensions()#" />

			<!--- filesize limits --->
			<ui:TextInput 	key="filesizeLimit"			name="configurationbean_filesizeLimit"
							required="true"				validate="number"
							classlist="span2" />


			<!--- <legend>#rc.mmRBF.key('imageattachments')#</legend> --->
			<!--- inline images allowed? --->
			<ui:Checkbox key="InlineImageAttachments" 	name="configurationbean_doInlineImageAttachments" />


			<!--- width max limit --->
			<ui:TextInput 	key="ImageWidthLimit"		name="configurationbean_ImageWidthLimit"
							required="true"				validate="number"
							classlist="span2" />

			<!--- height max limit --->
			<ui:TextInput 	key="ImageHeightLimit"		name="configurationbean_ImageHeightLimit"
							required="true"				validate="number"
							classlist="span2" />
		</div>
	</div>
</cfoutput>