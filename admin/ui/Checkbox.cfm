<cfparam name="attributes.key" 		default="" /><!--- key for resource bundles --->
<cfparam name="attributes.name" 	default="" />
<cfparam name="attributes.value"	default="1" />

<cfif thisTag.executionMode eq 'start'>
<cfoutput>
	<div class="control-group">
		<label class="control-label">
			<cfif request.context.mmRBF.keyExists(attributes.key,'tip')>
				<a href="##" rel="tooltip" title="#request.context.mmRBF.key(attributes.key,'tip')#">#request.context.mmRBF.key(attributes.key)# <i class="icon-question-sign"></i></a>
			<cfelse>
				#request.context.mmRBF.key(attributes.key)#
			</cfif>
		</label>
		<div class="controls">
			<label for="#attributes.name#" class="checkbox"><input name="#attributes.name#" id="#attributes.name#" type="checkbox" value="#attributes.value#" class="checkbox" 
			<cfif listFindNoCase(form[attributes.name], attributes.value)>checked</cfif>
			> #request.context.mmRBF.key(attributes.key)#</label>
		</div>
	</div>

</cfoutput>
</cfif>






<!--- 
<li class="checkbox padded">
	<input class="checkbox" type="checkbox" name="conferencebean_isactive" id="conferencebean_isactive" value="1" <cfif form.conferencebean_isactive>CHECKED</cfif>/>
	<label for="conferencebean_isactive">#rc.mmRBF.key('isactive')#<a href="##" class="tooltip"><span>#rc.mmRBF.key('isactive','tip')#</span>&nbsp;</a></label>
</li> --->
