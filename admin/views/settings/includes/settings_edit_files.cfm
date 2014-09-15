<cfimport prefix="ui" taglib="../../../ui" />
<cfparam name="form.settingsbean_resettempdirectory" default="0" />
<cfoutput>
	
	<div id="msTabs-Files-Tab" class="tab-pane">
		<div class="fieldset">

			<ui:TextInput 	key="filesizelimit"			name="settingsbean_filesizelimit"
							required="true"				validate="number"
							classlist="span2" />

			<ui:TextInput 	key="allowedextensions"		name="settingsbean_allowedextensions" />

			<ui:TextInput 	key="basetempdir"			name="settingsbean_basetempdir" placeholder="bob" />

			<ui:Checkbox 	key="resettempdirectory"	name="settingsbean_resettempdirectory" value="1"/>

		</div>

	</div>


</cfoutput>