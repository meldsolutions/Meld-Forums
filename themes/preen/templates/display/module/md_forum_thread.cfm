<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfparam name="attributes.type" default="#local.threadBean.getTypeID()#">
	<cfparam name="attributes.rowClass" default="">
	<cfparam name="attributes.showPostTitle" default="false">

	<cfif attributes.row eq 1>
		<cfset attributes.rowclass="first">
	<cfelseif  attributes.count eq attributes.row>
		<cfset attributes.rowclass="last">
	</cfif>
	<cfif attributes.row mod 2 eq 0>
		<cfset attributes.rowclass= attributes.rowclass & " alt">
	</cfif>
</cfsilent><cfoutput>

<tr class="mf-thread-pod type#attributes.type# #attributes.rowClass#">
	<td class="mf-block-icon">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumthreadicon'])>
			#local.eventContent['forumthreadicon']#
		<cfelseif  attributes.type eq 0>
			#rc.MFBean.getThreadViewIcon( local.threadBean )#
		<cfelse>
			<div class="mf-icon type#attributes.type#" title="#rc.mmRBF.key('threadtype#attributes.type#')#">&nbsp;</div>
		</cfif>
		</span>
	</td>
	<td class="mf-block-info">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumthreadbody'])>
			#local.eventContent['forumthreadbody']#
		<cfelse>
			<h4><a href="#rc.MFBean.getThreadLink(local.threadBean)#/">#local.threadBean.getTitle()#</a></h4>
			<cfif len( local.threadBean.getMessage() )>
			<div class="message">#local.threadBean.getMessage()#</div>
			</cfif>
		</cfif>
		<cfif len(local.eventContent['forumthreadbodyextra'])>
			#local.eventContent['forumthreadbodyextra']#
		</cfif>
		</span>
	</td>
	<td class="mf-block-stats">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumthreadstats'])>
			#attributes.eventContent['forumthreadstats']#
		<cfelse>
			<span class="mf-stat">#rc.mmRBF.key('posts')#: #local.threadBean.getPostCounter()#</span>
			<span class="mf-stat">#rc.mmRBF.key('views')#: #local.threadBean.getViewCounter()#</span>
		</cfif>
		</span>
	</td>
	<td class="mf-block-lastpost">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['forumthreadlastpost'])>
			#attributes.eventContent['forumthreadlastpost']#
		<cfelseif not isSimpleValue( local.threadBean.getLastPost() )>
			<cfset local.postbean = local.threadBean.getLastPost() />
			<cfmodule template="md_lastpost.cfm" local="#attributes.local#" showPostTitle="#attributes.showPostTitle#" postBean="#local.threadBean.getLastPost()#">
		</cfif>
		</span>
	</td>
</tr>
</cfoutput>