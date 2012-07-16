<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

</cfsilent><cfoutput>
<tr class="searchhead clearfix">
	<th colspan="#local.columns#" class="mf-masthead">
		<span class="mf-wrapper">
		<h3>#rc.mmRBF.key('searchresults')#</h3>
		</span>
	</th>
</tr>
<tr class="mf-headings">
	<cfif len(local.eventContent['searchcolumns'])>
		#local.eventContent['searchcolumns']#
	<cfelse>
	<th class="mf-block-icon mf-heading">&nbsp;</td>
	<th class="mf-block-info mf-heading">#rc.mmRBF.key('thread')#</td>
	<th class="mf-block-stats mf-heading">#rc.mmRBF.key('stats')#</td>
	<th class="mf-block-lastpost mf-heading">#rc.mmRBF.key('firstmatch')#</td>
	</cfif>
</tr>
</cfoutput>