
<cfif thisTag.executionMode eq 'start'>
	<cfparam name="attributes.key" default="" />

	<cfif request.context.mmRBF.keyExists('#attributes.key#','tip')>
		<cfoutput><a href="##" rel="tooltip" title="#request.context.mmRBF.key('#attributes.key#','tip')#">#request.context.mmRBF.key('#attributes.key#')# <i class="icon-question-sign"></i></a></cfoutput>
	<cfelse>
		<cfoutput>#request.context.mmRBF.key('#attributes.key#')#</cfoutput>
	</cfif>


</cfif>