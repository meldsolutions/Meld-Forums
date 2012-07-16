<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

</cfsilent><cfoutput>
<tr class="forumhead clearfix">
	<th colspan="#local.columns#" class="mf-masthead">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumdescription'])>
			#local.eventContent['forumdescription']#
		<cfelse>
		<h3>#local.forumBean.getTitle()#</h3>
		<cfif len( local.forumBean.getDescription() )>
			<div class="description">#local.forumBean.getDescription()#</div>
		</cfif>
		</cfif>
		</span>
	</th>
</tr>
<tr class="mf-headings">
	<cfif len(local.eventContent['forumcolumns'])>
		#local.eventContent['forumcolumns']#
	<cfelse>
	<th class="mf-block-icon mf-heading">&nbsp;</td>
	<th class="mf-block-info mf-heading">#rc.mmRBF.key('thread')#</td>
	<th class="mf-block-stats mf-heading">#rc.mmRBF.key('stats')#</td>
	<th class="mf-block-lastpost mf-heading">#rc.mmRBF.key('lastpost')#</td>
	</cfif>
</tr>
</cfoutput>