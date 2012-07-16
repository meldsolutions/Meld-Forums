<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

</cfsilent><cfoutput>
<table class="postblock adminblock">
	<tr class="mf-post-info" colspan="2">
		<td class="mf-avatar">
			<cfif len( local.eventContent['avatar'] )>
				#local.eventContent['avatar']#
			<cfelseif len( local.userBean.getAvatarID() )>
			<a
				href="#rc.MFBean.getForumWebRoot()#viewprofile/#local.userBean.getUserID()#/"><img
				src="#rc.pluginConfig.getConfigBean().getContext()#/tasks/render/small/?fileID=#local.userBean.getAvatarID()#"
				class="avatar"
				alt="#local.userBean.getScreenName()# #rc.mmRBF.key('avatar')#" border="0"/></a>
			<cfelse><a
				href="#rc.MFBean.getForumWebRoot()#profile/view/#local.userBean.getUserID()#/"><img
				src="#rc.MFBean.getThemeWebRoot()#/assets/images/anonymous.png"
				width="50"
				height="50"
				class="avatar"
				alt="#rc.mmRBF.key('avatar')#"  border="0"/></a>
			</cfif>
		</td>
		<td class="mf-info" colspan="2">
			<cfif len( local.eventContent['adminmessageinfo'] )>
				#local.eventContent['adminmessageinfo']#
			<cfelse>
			<div class="col2 clearfix top">
				<div class="mf-name colLeft">
					<a href="#rc.MFBean.getProfileLink( local.userBean )#">#local.userBean.getScreenName()#</a>
				</div>
				<div class="mf-date colRight">
					#lsDateFormat(local.threadBean.getDateCreate(),session.datekeyformat)# #lsTimeFormat(local.threadBean.getDateCreate(),"short")#
				</div>
			</div>
			<div class="col2 clearfix">
				<div class="mf-count colLeft">
					#local.userBean.getPostCounter()# #rc.mmRBF.key('postcount')#
				</div>
				<div class="mf-status colRight">
					<cfif rc.MFBean.getUserCache().IsOnline( local.userBean.getUserID() )>#rc.mmRBF.key('online')#<cfelse>#rc.mmRBF.key('offline')#</cfif>
				</div>
			</div>
			</cfif>
		</td>
	</tr>
	<tr class="mf-post-contents">
		<td class="mf-content" colspan="3">
			<h3>#rc.mmRBF.key('attention')#</h3>
			<div class="message">
				<cfif len( local.eventContent['adminmessagemessage'] )>
					#local.eventContent['adminmessagemessage']#
				<cfelse>
					<cfmodule template="/#rc.pluginConfig.getPackage()#/includes/utilities/parseBBML.cfm" ConvertSmilies="false">#rc.threadbean.getAdminMessage()#</cfmodule>
				</cfif>
			</div>
		</td>
	</tr>
</table>
</cfoutput>