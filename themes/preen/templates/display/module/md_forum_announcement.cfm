<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />
	<cfset attributes.type = 2 />

	<cfparam name="attributes.type" default="#local.threadBean.getTypeID()#">
	<cfparam name="attributes.rowClass" default="">
	<cfset attributes.user = rc.MFBean.getUser( local.threadBean.getUserID() )>

	<cfif attributes.row eq 1>
		<cfset attributes.rowclass="first">
	<cfelseif  attributes.count eq attributes.row>
		<cfset attributes.rowclass="last">
	</cfif>
	<cfif attributes.row mod 2 eq 0>
		<cfset attributes.rowclass= attributes.rowclass & " alt">
	</cfif>
</cfsilent><cfoutput>
<tr class="mf-thread-pod type#attributes.type# #attributes.rowClass# clearfix">
	<td class="mf-block-icon">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumannouncementicon'])>
			#local.eventContent['forumannouncementicon']#
		<cfelse>
			<div class="mf-icon type#attributes.type#" title="#rc.mmRBF.key('threadtype#attributes.type#')#">&nbsp;</div>
		</cfif>
		</span>
	</td>
	<td colspan="2" class="mf-block-info">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumannouncementbody'])>
			#local.eventContent['forumannouncementbody']#
		<cfelse>
			<h4><a href="#rc.MFBean.getThreadLink(local.threadBean)#/">#local.threadBean.getTitle()#</a></h4>
			<cfif len( local.threadBean.getMessage() )><td class="message">#local.threadBean.getMessage()#</td></cfif>
		</cfif>
		</span>
	</td>
	<td class="mf-block-stats">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumannouncementstats'])>
			#attributes.eventContent['forumannouncementstats']#
		<cfelse>
			<span class="mf-stat">#rc.mmRBF.key('views')#: #local.threadBean.getViewCounter()#</span>
		</cfif>
		</span>
	</td>
	<td class="mf-block-lastpost">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumannouncementlastpost'])>
			#attributes.eventContent['forumannouncementlastpost']#
		<cfelse>
			<ul class="meta">
				<li>#lsDateFormat(local.threadBean.getDateLastUpdate(),session.datekeyformat)# #lsTimeFormat(local.threadBean.getDateLastUpdate(),"short")#</li>
				<li><span class="heading">#rc.mmRBF.key('author')#:</span><cfif attributes.user.beanExists()><a href="#rc.MFBean.getProfileLink(attributes.user)#">#attributes.user.getScreenName()#</a></cfif></li>
			</ul>
		</cfif>
		</span>
	</td>
</tr>
</cfoutput>