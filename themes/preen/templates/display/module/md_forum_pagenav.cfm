<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

</cfsilent><cfoutput>
<table class="mf-paging">
	<tr>
		<td class="mf-paging-pages">
			#rc.pagebean.getNav()#
		</td>
	<cfif not isSimpleValue(rc.MFBean)>
		<td class="mf-buttonbar-right">
			<div>
			#rc.MFBean.getSubscribeButton(rc.forumbean.getForumID(),"forum",rc.isSubscribed )#
			#rc.MFBean.getNewThreadButton(rc.forumbean)#
			</div>
		</td>
	</cfif>

	</tr>
</table>
</cfoutput>