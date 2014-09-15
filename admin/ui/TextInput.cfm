<!--- default params --->
<cfparam name="attributes.key" 			default="" /><!--- resource bundle key for the title label --->
<cfparam name="attributes.helptext" 	default="" /><!--- resource bundle key for the inline help text, shown beside label --->
<cfparam name="attributes.name" 		default="" />
<cfparam name="attributes.placeholder"	default="" />
<cfparam name="attributes.required" 	default="false" />
<cfparam name="attributes.validate"	 	default="" />
<cfparam name="attributes.classlist" 	default="span12" />

<cfif thisTag.executionMode eq 'start'>
<cfoutput>
	<div class="control-group">
		<label class="control-label" for="#attributes.name#">
			<cfif request.context.mmRBF.keyExists(attributes.key,'tip')>
				<a href="##" rel="tooltip" title="#request.context.mmRBF.key(attributes.key,'tip')#">#request.context.mmRBF.key(attributes.key)# <i class="icon-question-sign"></i></a>
			<cfelse>
				#request.context.mmRBF.key(attributes.key)#
			</cfif>
			<cfif len(trim(attributes.helptext))>
				<span class="help-inline">(#attributes.helptext#)</span>	
			</cfif>
		</label>
		<div class="controls">
			<input type="text" id="#attributes.name#" name="#attributes.name#" value="#form[attributes.name]#"  maxlength="255" class="#attributes.classlist#"
			<cfif request.context.mmRBF.keyExists('#attributes.key#','validation')>data-message="#request.context.mmRBF.key(attributes.key,'validation')#"</cfif>
			<cfif attributes.required >data-required="true" required="true"</cfif>
			<cfif len(trim(attributes.validate)) >data-validate="#attributes.validate#"</cfif>
			<cfif len(trim(attributes.placeholder)) >placeholder="#attributes.placeholder#"</cfif>
			/>
		</div>
	</div>
</cfoutput>

</cfif>