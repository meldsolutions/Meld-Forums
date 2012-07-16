<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
</cfsilent>
<cfoutput>
<cfif len( local.eventContent['pagebuttonbarupperleft'] ) or len( local.eventContent['pagebuttonbarupperright'] )>
<table class="mf-page-block mf-buttonbar">
	<tr class="mf-page-actionbar">
		<td class="mf-buttonbar-left mf-buttonbar-upper" colspan="2">
		<div>
		<cfif len( local.eventContent['pagebuttonbarupperleft'] )>
			#local.eventContent['pagebuttonbarupperleft']#
		</cfif>
		</div>
		</td>
		<td class="mf-buttonbar-right mf-buttonbar-upper">
		<div>
		<cfif len( local.eventContent['pagebuttonbarupperright'] )>
			#local.eventContent['pagebuttonbarupperright']#
		</cfif>
		</div>
		</td>
	</tr>
</table>
</cfif>
<cfif len(local.eventContent['pageheader'])>
	#local.eventContent['pageheader']#
</cfif>
</cfoutput>