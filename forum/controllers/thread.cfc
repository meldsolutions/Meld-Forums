<!---
This file is part of the Meld Forums application.

Meld Forums is licensed under the GPL 2.0 license
Copyright (C) 2010 2011 Meld Solutions Inc. http://www.meldsolutions.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, version 2 of that license..

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

--->
<cfcomponent extends="controller">

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="new" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doCreateNewThread( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetNewThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif isDefined("form.btAction") and btAction eq rc.mmRBF.key('submit')>
			<cfset doUpdateEditThread( argumentCollection=arguments ) />
		<cfelseif isDefined("form.btAction") and btAction eq rc.mmRBF.key('delete')> <!--- and form.btActionConfirm eq "confirm">--->
			<cfset doDeleteThread( argumentCollection=arguments ) />
		</cfif>

		<cfset doGetEditThread( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doDeleteThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />

		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserCreateThread()>
			<cfset getErrorManager().addErrorByCode(2016)>
			<cfreturn>
		</cfif>

		<cfset threadBean		= threadService.getThread( rc.threadID ) />

		<cfif not threadBean.beanExists()>
			<cfset getErrorManager().addErrorByCode(1013)>
			<cfreturn>
		</cfif>

		<cfset forumBean		= forumService.getForum( threadBean.getForumID() ) />

		<!--- forum exists --->
		<cfif not forumBean.beanExists()>
			<cfset getErrorManager().addErrorByCode(1012)>
			<cfreturn>
		</cfif>
		
		<cfset threadService.deleteThread( rc.threadID ) />

		<cflocation url="#rc.MFBean.getForumLink( forumBean )#/" addtoken="false">
	</cffunction>
	

	<cffunction name="doGetThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var pageManager				= getBeanFactory().getBean("PageManager")>
		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>

		<!--- event() value is set via intercepts and validateIntercept() --->
		<cfset var threadID					= $.event().getValue("threadID") />

		<cfset var settingsBean				= rc.MFBean.getValue("settingsBean") />
		<cfset var forumBean				= "" />
		<cfset var threadBean				= "" />
		<cfset var pageBean					= pageManager.getPageBean( $,rc.MFBean.getValue("settingsBean").getPostsPerPage() )>
		<cfset var subscribed				= false>

		<cfset var iiX						= "" />
		<cfset var sArgs					= StructNew() />
		<cfset var MFEvent		 			= createEvent(rc) />

		<cfset var isSubscribed				= false>
		<cfset var aIntercept				= rc.MFBean.getIntercept() />

		<!--- permissions --->
		<cfif not rc.MFBean.userHasReadPermissions()>
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=2013" addtoken="false">
			<cfreturn>
		</cfif>

		<cfif len( rc.MFBean.getIdent() )>
			<cfset idx = rereplace( rc.MFBean.getIdent(),"[^\d]","","all" ) />
		</cfif>

		<cfif len( rc.MFBean.getIdent() ) and isNumeric(idx) >
			<cfset MFEvent.setValue("ident",rc.MFBean.getIdent() ) />
			<cfset MFEvent.setValue("idx",idx ) />
			<cfset MFEvent.setValue("doPosts",true ) />
			<cfset MFEvent.setValue("pageBean",pageBean ) />
			<cfset announceEvent(rc,"onMeldForumsGetThread",MFEvent)>

			<cfif MFEvent.valueExists('threadBean') and not isSimpleValue( MFEvent.getValue('threadBean') )>
				<cfset threadBean	= MFEvent.getValue('threadBean') />
			<cfelse>
				<cfset sArgs.idx = idx />
				<cfif StructKeyExists(rc.params,"threadID") and len( rc.params.threadID )>
					<cfset sArgs.threadID = threadID />
				</cfif>
				<cfset sArgs.pageBean	= pageBean />
				<cfset sArgs.doPosts	= true />
				
				<cfset threadBean		= threadService.getThreadWithPosts( argumentCollection=sArgs )>
			</cfif>
		<cfelse>
			<!--- get the threadBean --->
			<cfset sArgs.threadID		= threadID />
			<cfset sArgs.pageBean		= pageBean />
			<cfset sArgs.doPosts		= true />
			
			<cfset threadBean			= threadService.getThreadWithPosts( argumentCollection=sArgs )>
		</cfif>
		
		<cfif threadBean.beanExists()>
			<cfset forumBean		= forumService.getForum( threadBean.getForumID() ) />
		<cfelse>
			<!--- 1013: thread not found --->
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=1013" addtoken="false">
			<cfreturn>
		</cfif>
		<!--- ensure the forum exists --->
		<cfif not forumBean.beanExists()>
			<!--- 1012: forum not found --->
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=1012" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset rc.MFBean.setThreadViewed( threadBean ) />

		<!--- add the pageNav to the event scope --->
		<cfset $.event().setValue("pageBean",pageBean) />

		<cfset isSubscribed = subscribeService.getIsSubscribedToThread( $.currentUser().getUserID(),threadBean.getThreadID() ) />

		<cfset rc.ThreadBean		= threadBean />
		<cfset rc.ForumBean			= forumBean />
		<cfset rc.pageBean			= pageBean />
		<cfset rc.isSubscribed		= isSubscribed />
	</cffunction>

	<cffunction name="doGetNewThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var mmUtility				= getBeanFactory().getBean("mmUtility")>

		<cfset var sArgs					= StructNew() />

		<cfset var threadBean				= "" />
		<cfset var forumID					= "" />
		<cfset var aIntercept				= rc.MFBean.getIntercept() />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserCreateThread()>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=2001" addtoken="false">
			<cfreturn>
		</cfif>

		<cfif ArrayLen(aIntercept) lt 3>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset forumID = aIntercept[3] />

		<cfset sArgs.forumID				= forumID />
		<cfset threadBean					= threadService.createThread( argumentCollection=sArgs ) />

		<cfset rc.ThreadBean		= threadBean />
		<cfset rc.configurationBean	= rc.MFBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="doCreateNewThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var forumService			= getBeanFactory().getBean("forumService") />
		<cfset var threadService		= getBeanFactory().getBean("threadService") />
		<cfset var postService			= getBeanFactory().getBean("postService") />
		<cfset var userService			= getBeanFactory().getBean("userService") />
		<cfset var mmUtility			= getBeanFactory().getBean("mmUtility")>
		<cfset var mmFileUpload			= getBeanFactory().getBean("mmFileUpload") />

		<cfset var subscribeService		= getBeanFactory().getBean("SubscribeService")>
		<cfset var userBean				= rc.MFBean.getUserCache().getUser( $.currentUser().getUserID() )>

		<cfset var sArgs				= StructNew() />

		<cfset var postBean				= "" />
		<cfset var forumBean			= "" />
		<cfset var threadBean			= "" />
		<cfset var configurationBean	= "" />

		<cfset var forumID				= $.event().getValue("forumID") />
		<cfset var attachmentID			= "" />

		<cfset var MFEvent					= rc.mmEvents.createEvent( rc.$ ) />

		<cfparam name="rc.typeID" default="0" />

		<cfset sArgs.forumID			= forumID />

		<cfset forumBean				= forumService.getForum( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserCreateThread()>
			<cfset getErrorManager().addErrorByCode(2016)>
			<cfreturn>
		</cfif>

		<!--- forum exists --->
		<cfif not forumBean.beanExists()>
			<cfset getErrorManager().addErrorByCode(1012)>
			<cfreturn>
		</cfif>

		<!--- content check --->
		<cfif not len( form.message )>
			<cfset getErrorManager().addErrorByCode(1055)>
			<cfreturn>
		</cfif>

		<!--- new thread --->
		<cfset sArgs.siteID			= rc.siteID />
		<cfset sArgs.title			= mmUtility.cleanHTML( form.title ) />
		<cfset sArgs.userID			= $.currentUser().getUserID() />
		<cfset sArgs.isActive		= 1 />

		<!--- moderator fields --->
		<cfif rc.MFBean.UserHasModeratePermissions()>
			<cfset sArgs.IsAnnouncement		= $.event().getValue("doSetAnnouncement") eq 1>
			<cfset sArgs.IsClosed			= $.event().getValue("doSetClosed") eq 1>
			<cfset sArgs.typeID				= rc.typeID>
			<cfset sArgs.adminID			= $.currentUser().getUserID()>
		</cfif>

		<cfset threadBean			= threadService.createThread( argumentCollection=sArgs ) />

		<!--- new post --->
		<cfset sArgs.message		= mmUtility.cleanHTML( form.message ) />
		<cfset sArgs.threadID		= threadBean.getThreadID() />
		<cfset postBean				= postService.createPost( argumentCollection=sArgs ) />


		<cfset MFEvent.setValue('message',form.message ) />
		<cfset MFEvent.setValue('postBean',postBean ) />
		<cfset MFEvent.setValue('userID',sArgs.userID ) />
		<cfset MFEvent.setValue('threadBean',threadBean ) />

		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsBeforeCreateThread",MFEvent ) />

		<cftry>
			<cftransaction>
				<cfset postService.savePost( postBean )>
				<cfset threadService.saveThread( threadBean,postBean )>
				<cfset forumService.updateThreadCounter( threadBean.getForumID() )>
				<cfset forumService.setLastPostID( threadBean.getForumID(),postBean.getPostID() )>
				<cfset userService.userAddedThread( threadBean.getUserID(),threadBean.getThreadID(),rc.siteID ) />
			</cftransaction>
			<cfif not getErrorManager().hasErrors()>
				<cfif isDefined("form.NEWATTACHMENT") and len(form.NEWATTACHMENT)>
					<cfset sArgs.rc					= arguments.rc />
					<cfset sArgs.postID				= postBean.getPostID() />
					<cfset sArgs.configurationBean	= rc.MFBean.getConfigurationBean() />
					<cfset attachmentID				= doFileAttachment( argumentCollection=sArgs )>
					<cfset postBean.setAttachmentID( attachmentID ) />
				</cfif>
				<cfif len( attachmentID )>
					<cfset postService.updatePost( postBean )>
				</cfif>
			</cfif>

			<cfcatch type="custom">
				<cfif len( attachmentID )>
					<cfset mmFileUpload.deleteFile( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError(cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
			<cfcatch>
				<cfif len( attachmentID )>
					<cfset mmFileUpload.deleteFile( attachmentID ) />
				</cfif>
				<cfset getErrorManager().addError(cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
				<cfreturn>
			</cfcatch>
		</cftry>

		<cfif not getErrorManager().hasErrors()>
			<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsBeforeCreateThread",MFEvent ) />
		</cfif>
			
		<cfif not getErrorManager().hasErrors()>
			<cfset MFEvent.setValue('subscriptionsProcessed',0 ) />
			<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsAfterCreateNewPost",MFEvent ) />
			<cfset subscriptionText	= rc.mmEvents.renderEvent( rc.$,"onMeldForumsSubscriptionMessage",MFEvent ) />

			<cfset rc.cleanMessage		= mmUtility.stripBBML( form.message ) />
			<cfset rc.postBean			= postBean />
			<cfset rc.threadBean		= threadBean />
			<cfset rc.userBean			= userBean />
			<cfset rc.siteID			= rc.siteID />
			<cfset rc.forumBean 		= forumService.getBeanByAttributes( rc.threadBean.getForumID() ) />
			<cfset rc.notifyType		= "thread" />
			<cfset rc.postLink			= $.siteConfig().getDomain() & $.globalConfig().getContext() & rc.MFBean.getPostLink(rc.threadBean,rc.postBean) & "/?pp=#rc.postBean.getPostPosition()###p#rc.postBean.getPostPosition()#" />
			<cfset rc.unsubLink			= $.siteConfig().getDomain() & $.globalConfig().getContext() & rc.MFBean.getSubscribeLink(rc.threadBean.getThreadID(),"thread",1) />

			<cfif not len(subscriptionText)>
				<cfif fileExists(expandPath('/MeldForums/') & "includes/custom/subscriptionText.cfm" )>
					<cfsavecontent variable="subscriptionText">
						<cfoutput><cfinclude template="/MeldForums/includes/custom/subscriptionText.cfm" /></cfoutput>
					</cfsavecontent>
				<cfelse>
					<cfsavecontent variable="subscriptionText">
						<cfoutput><cfinclude template="/MeldForums/includes/templates/subscriptionText.cfm" /></cfoutput>
					</cfsavecontent>
				</cfif>
			</cfif>

			<cfset MFEvent.setValue('subscriptionText',subscriptionText ) />
			<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsBeforeProcessSubscriptions",MFEvent ) />

			<cfset rc.subscriptionText	= MFEvent.getValue('subscriptionText') />

			<cfif not MFEvent.getValue('subscriptionsProcessed' )>
				<cfset subscribeService.processSubscriptions( argumentCollection=rc )>
				<cfset MFEvent.setValue('subscriptionsProcessed',1 ) />
			</cfif>
			<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsAfterProcessSubscriptions",MFEvent ) />
		</cfif>

		<cfif not getErrorManager().hasErrors()>
			<cfset rc.MFBean.getUserCache().purgeUser($.currentUser().getUserID()) />
			<cfset threadBean		= threadService.getThread( threadID=threadBean.getThreadID() )>
			<cflocation url="#rc.MFBean.getThreadLink( threadBean )#/" addtoken="false">
		</cfif>
	</cffunction>

	<cffunction name="doGetEditThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var mmUtility				= getBeanFactory().getBean("mmUtility")>

		<cfset var sArgs					= StructNew() />

		<cfset var threadBean				= "" />
		<cfset var postBean					= "" />
		<cfset var threadID					= "" />
		<cfset var aIntercept				= rc.MFBean.getIntercept() />

		<cfparam name="rc.typeID" default="0" />

		<cfif ArrayLen(aIntercept) lt 3>
			<cflocation url="#rc.MFBean.getForumWebRoot()#/?ecode=1014" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset threadID = aIntercept[3] />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.CanUserCreateThread()>
			<cflocation url="#rc.MFBean.getThreadLink( threadBean )#/?ecode=2001" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset sArgs.threadID			= threadID />
		<cfset threadBean				= threadService.getThread( argumentCollection=sArgs ) />

		<cfif not threadBean.beanExists()>
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=1013" addtoken="false">
			<cfreturn>
		</cfif>

		<cfset sArgs.postPostiion		= 0 />
		<cfset postBean					= postService.getBeanByAttributes( argumentCollection=sArgs ) />

		<cfset rc.ThreadBean			= threadBean />
		<cfset rc.PostBean				= postBean />
		<cfset rc.configurationBean		= rc.MFBean.getConfigurationBean() />
	</cffunction>


	<cffunction name="doUpdateEditThread" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var userService				= getBeanFactory().getBean("userService") />
		<cfset var mmUtility				= getBeanFactory().getBean("mmUtility")>

		<cfset var sArgs					= StructNew() />
		<cfset var threadBean				= "" />
		<cfset var threadID					= $.event().getValue("threadID") />
		<cfset var MFEvent					= rc.mmEvents.createEvent( rc.$ ) />

		<cfset sArgs.threadID				= threadID />
		<cfset threadBean					= threadService.getThread( argumentCollection=sArgs ) />

		<!--- perm --->
		<cfif not $.currentUser().isLoggedIn() or not rc.MFBean.canUserEditThread( threadBean )>
			<cfset getErrorManager().addErrorByCode(2013)>
			<cfreturn>
		</cfif>

		<!--- threadBean exists --->
		<cfif not threadBean.beanExists()>
			<cfset getErrorManager().addErrorByCode(1013)>
			<cfreturn>
		</cfif>

		<cfset sArgs.title			= mmUtility.cleanHTML( form.title ) />

		<!--- moderator fields --->
		<cfif rc.MFBean.UserHasModeratePermissions()>
			<cfset sArgs.IsActive			= $.event().getValue("doSetActive") eq 1>
			<cfset sArgs.IsDisabled			= $.event().getValue("doSetDisabled") eq 1>
			<cfset sArgs.IsAnnouncement		= $.event().getValue("doSetAnnouncement") eq 1>
			<cfset sArgs.IsClosed			= $.event().getValue("doSetClosed") eq 1>
			<cfset sArgs.typeID				= rc.typeID>

			<cfif $.event().getValue("doAddAdminMessage") eq 1>
				<cfset sArgs.adminMessage = message>
			<cfelse>
				<cfset sArgs.adminMessage = "">
			</cfif>

			<cfset sArgs.adminID			= $.currentUser().getUserID()>
		</cfif>

		<cfset threadBean.updateMemento( sArgs ) />

		<cfset MFEvent.setValue('message',form.message ) />
		<cfset MFEvent.setValue('userID',$.currentUser().getUserID() ) />
		<cfset MFEvent.setValue('threadBean',threadBean ) />

		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsBeforeUpdateThread",MFEvent ) />

		<cftry>
			<cfset threadService.updateThread( threadBean )>
			<cfcatch type="custom">
				<cfset getErrorManager().addError(cfcatch.message,"custom",cfcatch.errorcode,cfcatch.detail)>
			</cfcatch>
			<cfcatch>
				<cfset getErrorManager().addError(cfcatch.message,cfcatch.type,cfcatch.errorcode,cfcatch.detail)>
			</cfcatch>
		</cftry>

		<cfif not getErrorManager().hasErrors()>
			<cflocation url="#rc.MFBean.getThreadLink( threadBean )#/" addtoken="false">
		</cfif>
	</cffunction>

	<cffunction name="doFileAttachment" returntype="string" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">
		<cfargument name="postID" type="uuid" required="true">
		<cfargument name="configurationBean" type="any" required="true">

		<cfset var mmFileUpload			= getBeanFactory().getBean("mmFileUpload") />
		<cfset var sArgs				= StructNew() />
		<cfset var fileID				= "" />
		<cfset var fileUploadBean		= "" />

		<cfset sArgs.contentID			= arguments.postID>
		<cfset sArgs.moduleID			= rc.pluginConfig.getModuleID()>
		<cfset sArgs.siteID				= rc.siteID />

		<cfset sArgs.FileSizeLimit		= configurationBean.getFilesizeLimit() />
		<cfset sArgs.AllowedExtensions	= configurationBean.getAllowAttachmentExtensions() />
		<cfset sArgs.DoClearPrevious	= true />

		<cfset fileUploadBean			= mmFileUpload.createFileUploadBean( argumentCollection=sArgs ) />
		<cfset fileID 					= mmFileUpload.uploadFile( "NEWATTACHMENT",fileUploadBean )>

		<cfreturn fileID />
	</cffunction>
	
</cfcomponent>