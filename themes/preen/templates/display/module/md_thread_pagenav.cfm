<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<!---<cfset attributes.user = attributes.userCache.getUser( attributes.threadbean.getUserID() )>--->
</cfsilent><cfoutput>
<table class="mf-paging">
	<tr>
		<td class="mf-paging-pages">
			#rc.pagebean.getNav()#
		</td>
	<cfif not isSimpleValue(rc.MFBean)>
		<td class="mf-buttonbar-right">
			<div>
			#rc.MFBean.getSubscribeButton(rc.threadbean.getThreadID(),"thread", rc.isSubscribed )#
			#rc.MFBean.getNewPostButton(rc.threadbean)#
			#rc.MFBean.getEditThreadButton(rc.threadbean)#
			</div>
		</td>
	</cfif>
	</tr>
</table>
</cfoutput>