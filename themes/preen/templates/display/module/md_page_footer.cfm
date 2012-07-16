<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
</cfsilent>
<cfoutput>
<cfif len( local.eventContent['pagebuttonbarlowerleft'] ) or len( local.eventContent['pagebuttonbarlowerright'] )>
<table class="mf-page-block mf-buttonbar">
	<tr class="mf-page-actionbar">
		<td class="mf-buttonbar-left mf-buttonbar-lower" colspan="2">
		<div>
		<cfif len( local.eventContent['pagebuttonbarlowerleft'] )>
			#local.eventContent['pagebuttonbarlowerleft']#
		</cfif>
		</div>
		</td>
		<td class="mf-buttonbar-right mf-buttonbar-lower">
		<div>
		<cfif len( local.eventContent['pagebuttonbarlowerright'] )>
			#local.eventContent['pagebuttonbarlowerright']#
		</cfif>
		</div>
		</td>
	</tr>
</table>
</cfif>
<cfif len(local.eventContent['pagefooter'])>
	#local.eventContent['pagefooter']#
</cfif>
</cfoutput>