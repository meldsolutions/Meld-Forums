<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
</cfsilent><cfoutput>
<table class="mf-paging">
	<tr>
		<td class="mf-paging-pages">
			#rc.pagebean.getNav()#
		</td>
	</tr>
</table>
</cfoutput>