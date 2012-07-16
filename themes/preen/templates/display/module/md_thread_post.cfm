<cfsilent>
	<cfset local	= attributes.local />
	<cfset rc		= local.rc />

	<cfparam name="attributes.rowClass" default="">
	<cfif attributes.row eq 1>
		<cfset attributes.rowclass="first">
	<cfelseif  attributes.count eq attributes.row>
		<cfset attributes.rowclass="last">
	</cfif>
	<cfif attributes.row mod 2 eq 0>
		<cfset attributes.rowclass= attributes.rowclass & " alt">
	</cfif>
</cfsilent><cfoutput>

<cfif not local.postBean.getisDisabled() or rc.MFBean.userHasModeratePermissions()>
<table class="mf-post-block" id="pst#local.postBean.getpostPosition()#">
	<tr class="mf-post-info" colspan="2">
		<td class="mf-avatar">
			<cfif len( local.eventContent['avatar'] )>
				#local.eventContent['avatar']#
			<cfelse>
			#rc.MFBean.getAvatarImage(userBean=local.postUserBean,height=rc.MFBean.getTheme().getAvatarSmallHeight(),width=rc.MFBean.getTheme().getAvatarSmallWidth(),doLink=true)#
			</cfif>
		</td>
		<td class="mf-info" colspan="2">
			<a style="position: absolute" name="p#local.postBean.getpostPosition()#">&nbsp;</a>
			<cfif len( local.eventContent['postinfo'] )>
				#local.eventContent['postinfo']#
			<cfelse>
			<div class="col2 clearfix top">
				<div class="mf-name colLeft">
					<a href="#rc.MFBean.getProfileLink( local.postUserBean )#">#local.postUserBean.getScreenName()#</a>
				</div>
				<div class="mf-date colRight">
					#lsDateFormat(local.postBean.getDateCreate(),session.datekeyformat)# #lsTimeFormat(local.postBean.getDateCreate(),"short")#
				</div>
			</div>
			<div class="col2 clearfix">
				<div class="mf-count colLeft">
					#local.postUserBean.getPostCounter()# #rc.mmRBF.key('postcount')#
				</div>
				<div class="mf-status colRight">
					<cfif rc.MFBean.getUserCache().IsOnline( local.postUserBean.getUserID() )>#rc.mmRBF.key('online')#<cfelse>#rc.mmRBF.key('offline')#</cfif>
				</div>
			</div>
			</cfif>
		</td>
	</tr>
	<cfif len( local.eventContent['postbuttonbarupperleft'] ) or len( local.eventContent['postbuttonbarupperright'] )>
	<tr class="mf-post-actionbar">
		<td class="mf-buttonbar-left mf-buttonbar-upper" colspan="2">
		<div>
		<cfif len( local.eventContent['postbuttonbarupperleft'] )>
			#local.eventContent['postbuttonbarupperleft']#
		</cfif>
		</div>
		</td>
		<td class="mf-buttonbar-right mf-buttonbar-lower">
		<div>
		<cfif len( local.eventContent['postbuttonbarupperright'] )>
			#local.eventContent['postbuttonbarupperright']#
		</cfif>
		</div>
		</td>
	</tr>
	</cfif>
	<tr class="mf-post-contents">
		<td class="mf-content" colspan="3">
			<cfif local.postBean.getisDisabled()>
				<div class="attention">
				<cfif len( local.eventContent['postdisabled'] )>
					#local.eventContent['postdisabled']#
				<cfelse>
					<h4>#rc.mmRBF.key('disabled')#</h4>
				</cfif>
				</div>
			</cfif>
			<cfif len(local.postBean.getMessage())>
				<div class="message">
				<cfif len( local.eventContent['postmessage'] )>
					#local.eventContent['postmessage']#
				<cfelse>
					<cfmodule template="/#rc.pluginConfig.getPackage()#/includes/utilities/parseBBML.cfm" ConvertSmilies="false">#local.postBean.getMessage()#</cfmodule>
				</cfif>
				</div>
			</cfif>
			<cfif local.postBean.getDateCreate() neq local.postBean.getDateLastUpdate()>
				<div class="attention">
				<cfif len( local.eventContent['postupdated'] )>
					#local.eventContent['postupdated']#
				<cfelse>
					#rc.mmRBF.key('lastedited')#: #lsDateFormat(local.postBean.getDateLastUpdate(),session.datekeyformat)# #lsTimeFormat(local.postBean.getDateLastUpdate(),"short")#
				</cfif>
				</div>
			</cfif>
			<cfif local.postBean.getIsModerated()>
				<div class="attention">
				<cfif len( local.eventContent['postmoderated'] )>
					#local.eventContent['postmoderated']#
				<cfelse>
					#rc.mmRBF.key('datemoderated')#: #lsDateFormat(local.postBean.getDateModerated(),session.datekeyformat)# #lsTimeFormat(local.postBean.getDateModerated(),"short")#
				</cfif>
				</div>
			</cfif>
		</td>
	</tr>
	<cfif len( local.postBean.getAttachmentID() ) and not local.postBean.getDoBlockAttachment()>
	<tr class="mf-post-attachment">
		<td class="mf-content" colspan="3">
			<cfif len( local.eventContent['postattachment'] )>
				#local.eventContent['postattachment']#
			<cfelse>
				<cfmodule template="md_post_attachment.cfm" local="#attributes.local#" postbean="#local.postBean#">
			</cfif>
		</td>
	</tr>
	</cfif>
	<cfif len( local.eventContent['postsignature'] )>
	<tr class="mf-post-signature">
		<td class="mf-content" colspan="3">
			<div>
			#local.eventContent['postsignature']#
			</div>
		</td>
	</tr>
	</cfif>
	<tr class="mf-post-actionbar">
		<td class="mf-post-position">
			<cfif len( local.eventContent['postposition'] )>
				#local.eventContent['postposition']#
			<cfelseif local.postBean.getpostPosition() gt 0>
				<a href="#rc.MFBean.getThreadLink(rc.threadBean)#/?c=#rc.pageBean.getCount()#&pp=#local.postBean.getPostPosition()###p#local.postBean.getPostPosition()#" title="#rc.mmRBF.key('permalink')#">###local.postBean.getpostPosition()#</a>
			<cfelse>
				&nbsp;
			</cfif>
		</td>
		<td class="mf-buttonbar-left mf-buttonbar-lower">
		<div>
		<cfif len( local.eventContent['postbuttonbarlowerleft'] )>
			#local.eventContent['postbuttonbarlowerleft']#
		</cfif>
		</div>
		</td>
		<td class="mf-buttonbar-right mf-buttonbar-lower">
		<div>
		<cfif len( local.eventContent['postbuttonbarlowerright'] )>
			#local.eventContent['postbuttonbarlowerright']#
		<cfelseif rc.MFBean.isLoggedIn()>
		#rc.MFBean.getReplyPostButton(local.postBean,rc.threadbean)#
		#rc.MFBean.getReplyPostButton(local.postBean,rc.threadbean,true)#
		#rc.MFBean.getEditPostButton(local.postBean,rc.threadbean)#
		</cfif>
		</div>
		</td>
	</tr>
</table>
</cfif>
</cfoutput>