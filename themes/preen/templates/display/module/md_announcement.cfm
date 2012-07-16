<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

</cfsilent><cfoutput>
<tr class="mf-forum-announcement-block clearfix">
	<td colspan="#local.columns#" class="mf-masthead">
		<cfif len(local.eventContent['announcementdescription'])>
			#local.eventContent['announcementdescription']#
		<cfelse>
		<h4>#rc.mmRBF.key('announcements')#</h4>
		</cfif>
	</td>
</tr>
<tr class="mf-headings">
	<cfif len(local.eventContent['announcementcolumns'])>
		#local.eventContent['announcementcolumns']#
	<cfelse>
		<th class="mf-block-icon mf-heading">&nbsp;</th>
		<th colspan="2" class="mf-block-info mf-heading">&nbsp;</th>
		<th class="mf-block-stats mf-heading">#rc.mmRBF.key('stats')#</th>
		<th class="mf-block-lastpost mf-heading">#rc.mmRBF.key('lastupdate')#</th>
	</cfif>
</tr>
</cfoutput>