<!--- default params --->
<cfparam name="attributes.key" 	default="" /><!--- key for resource bundles --->
<cfparam name="attributes.name" default="" />

<cfif thisTag.executionMode eq 'start'>
<cfoutput>
	<div class="control-group">
		<label class="control-label" for="#attributes.name#">
			<cfif request.context.mmRBF.keyExists(attributes.key,'tip')>
				<a href="##" rel="tooltip" title="#request.context.mmRBF.key(attributes.key,'tip')#">#request.context.mmRBF.key(attributes.key)# <i class="icon-question-sign"></i></a>
			<cfelse>
				#request.context.mmRBF.key(attributes.key)#
			</cfif>
		</label>
		<div class="controls">
			<textarea name="#attributes.name#" id="#attributes.name#"><cfif len(form[attributes.name])>#HTMLEditFormat(form[attributes.name])#<cfelse><br /></cfif></textarea>
			<script type="text/javascript" language="Javascript">
			var loadEditorCount = 0;
			jQuery('###attributes.name#').ckeditor(
				{ 
				toolbar :
		        [
		            ['Source','-','Cut','Copy','Paste','PasteText','PasteWord','-','Bold','Italic','-','Image','-','OrderedList','UnorderedList','-','Link','Unlink','-','FitWindow','ShowBlocks','-','Style','-','About']
		        ],
				height:'200',
				customConfig : 'config.js.cfm' },htmlEditorOnComplete);
			</script>
		</div>
	</div>
</cfoutput>
</cfif>