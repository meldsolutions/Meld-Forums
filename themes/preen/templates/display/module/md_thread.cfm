<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
</cfsilent><cfoutput>
	<tr class="mf-thread-block">
		<th colspan="2" class="mf-masthead">
			<span class="mf-wrapper">
			<cfif len(local.eventContent['threaddescription'])>
				#local.eventContent['threaddescription']#
			<cfelse>
				<h3>#attributes.threadbean.getTitle()#</h3>
			</cfif>
			</span>
		</th>
	</tr>
	<cfif rc.MFBean.isThreadLocked( attributes.threadbean )
		and
		( attributes.threadbean.getIsDisabled() or not attributes.threadbean.getIsActive() or attributes.threadbean.getIsClosed() )>
	<tr class="mf-thread-notice">
		<th colspan="2" class="mf-masthead">
			<span class="mf-wrapper">
			<cfif len(local.eventContent['threadclosed'])>
				#local.eventContent['threadclosed']#
			<cfelse>
				<cfif attributes.threadbean.getIsDisabled() or not attributes.threadbean.getIsActive()><p>#rc.mmRBF.key('threaddisabled')#</p></cfif>
				<cfif attributes.threadbean.getIsClosed()><p>#rc.mmRBF.key('threadclosed')#</p></cfif>
			</cfif>
			</span>
		</th>
	</tr>
	</cfif>
</cfoutput>