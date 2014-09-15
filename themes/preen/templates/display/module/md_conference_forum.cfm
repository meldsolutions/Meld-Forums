<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfparam name="attributes.rowClass" default="">

	<cfparam name="rc.showPostcount" default="true">
	<cfparam name="rc.showPostTitle" default="true">

	<cfif attributes.row eq 1>
		<cfset attributes.rowclass="first">
	<cfelseif  attributes.count eq attributes.row>
		<cfset attributes.rowclass="last">
	</cfif>
	<cfif attributes.row mod 2 eq 0>
		<cfset attributes.rowclass= attributes.rowclass & " alt">
	</cfif>

</cfsilent><cfoutput>
<tr class="mf-forum-pod #attributes.rowClass#" id="mf-forum-#rereplaceNoCase(local.forumBean.getTitle(),"[^[:alnum:]]","","all")#">
	<td class="mf-block-icon">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['conferenceforumicon'])>
			#local.eventContent['conferenceforumicon']#
		<cfelse>
			<img src="#rc.MFBean.getThemeWebRoot()#assets/images/icons/folder_new.gif" alt="folder" />
		</cfif>
		</span>
	</td>
	<td class="mf-block-info">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['conferenceforumheading'])>
			#local.eventContent['conferenceforumheading']#
		<cfelse>
			<h4><a href="#rc.MFBean.getForumLink(local.forumBean)#/">#local.forumBean.getTitle()#</a></h4>
			<cfif len( local.forumBean.getDescription() )>#local.forumBean.getDescription()#</cfif>
		</cfif>
		</span>
	</td>
	<td class="mf-block-stats">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['conferenceforumcolumns'])>
			#local.eventContent['conferenceforumcolumns']#
		<cfelse>
			<span class="mf-stat">#rc.mmRBF.key('threads')#: #local.forumBean.getThreadCounter()#</span>
			<span class="mf-stat">#rc.mmRBF.key('posts')#: #local.forumBean.getPostCount()#</span>
			<span class="mf-stat">#rc.mmRBF.key('views')#: #local.forumBean.getViewCount()#</span>
		</cfif>
		</span>
	</td>
	<td class="mf-block-lastpost">
		<span class="mf-wrapper">
		<cfif len(local.eventContent['conferenceforumlastpost'])>
			#local.eventContent['conferenceforumlastpost']#
		<cfelseif not isSimpleValue( local.forumBean.getLastPost() )>
			<cfmodule template="md_lastpost.cfm" local="#local#" showPostTitle="#rc.showPostTitle#" postBean="#local.forumBean.getLastPost()#">
		</cfif>
		</span>
	</td>
</tr>
</cfoutput>