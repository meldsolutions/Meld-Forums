<cfsilent>
	<cfset rc = rc>
</cfsilent>
<cfoutput>
	<div id="msTabs-General">
		<h3>#rc.mmRBF.key('general')#</h3>
		<ul class="form">
			<li class="first">
				<label for="configurationbean_name">#rc.mmRBF.key('name')#</label>
				<input class="text" type="text" name="configurationbean_name" id="configurationbean_name" value="#form.configurationbean_name#" size="30" maxlength="100" data-required="true" data-validate="string" data-message="#rc.mmRBF.key('configurationname','validation')#" />
			</li>
			<li class="last">
			<label for="configurationbean_description">#rc.mmRBF.key('description')#: </label>
			<textarea name="configurationbean_description" id="configurationbean_description"><cfif len(form.configurationbean_description)>#HTMLEditFormat(form.configurationbean_description)#<cfelse><br /></cfif></textarea>
			<script type="text/javascript" language="Javascript">
			var loadEditorCount = 0;
			jQuery('##configurationbean_description').ckeditor(
				{ 
				toolbar :
		        [
		            ['Source','-','Cut','Copy','Paste','PasteText','PasteWord','-','Bold','Italic','-','Image','-','OrderedList','UnorderedList','-','Link','Unlink','-','FitWindow','ShowBlocks','-','Style','-','About']
		        ],
				height:'200',
				customConfig : 'config.js.cfm' },htmlEditorOnComplete);
			</script>
			</li>
		</ul>
	</div>
</cfoutput>