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

		<cfset doGetForum( argumentCollection=arguments ) />
	</cffunction>


	<cffunction name="doGetForum" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var conferenceService		= getBeanFactory().getBean("ConferenceService") />
		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var userService				= getBeanFactory().getBean("userService") />
		<cfset var mmUtility				= getBeanFactory().getBean("mmUtility")>
		<cfset var pageManager				= getBeanFactory().getBean("PageManager")>
		<cfset var subscribeService			= getBeanFactory().getBean("SubscribeService")>

		<!--- event() value is set via intercepts and validateIntercept() --->
		<cfset var forumID					= $.event().getValue("forumID") />

		<cfset var forumBean				= "" />
		<cfset var conferenceBean			= "" />
		<cfset var pageBean					= pageManager.getPageBean( $,rc.MFBean.getValue("settingsBean").getThreadsPerPage() )>

		<cfset var sArgs					= StructNew() />
		<cfset var pluginEvent	 			= createEvent(rc) />
		<cfset var isSubscribed				= false />
		<cfset var idx						= 0 />

		<!--- permissions --->
		<cfif not rc.meldForumsBean.userHasReadPermissions()>
			<cflocation url="#rc.meldForumsBean.getForumWebRoot()#?ecode=2012" addtoken="false">
			<cfreturn>
		</cfif>

		<cfif len( rc.meldForumsBean.getIdent() )>
			<cfset idx = rereplace( rc.meldForumsBean.getIdent(),"[^\d]","","all" ) />
		</cfif>

		<cfset rc.lastDateIsNewFrom = userService.getLastDateIsNewFrom( $.currentUser().getUserID() ) />

		<cfif len( rc.meldForumsBean.getIdent() ) and isNumeric(idx) >
			<cfset pluginEvent.setValue("ident",rc.meldForumsBean.getIdent() ) />
			<cfset pluginEvent.setValue("idx",idx ) />
			<cfset pluginEvent.setValue("doThreads",true ) />
			<cfset pluginEvent.setValue("pageBean",pageBean ) />
			<cfset announceEvent(rc,"onMeldForumsGetForum",pluginEvent)>

			<cfif pluginEvent.valueExists('forumBean')>
				<cfset forumBean	= pluginEvent.getValue('forumBean') />
			<cfelse>
				<cfset sArgs.idx = idx />
				<cfif StructKeyExists(rc.params,"forumID") and len( rc.params.forumID )>
					<cfset sArgs.forumID = forumID />
				</cfif>
				<cfset sArgs.pageBean	= pageBean />
				<cfset sArgs.doThreads	= true />
				<cfset sArgs.siteID		= rc.siteID />
				<cfset forumBean		= forumService.getForumWithThreads( argumentCollection=sArgs )>
			</cfif>
		<cfelse>
			<cfset sArgs.forumID	= forumID />
			<cfset sArgs.pageBean	= pageBean />
			<cfset sArgs.doThreads	= true />
			<cfset sArgs.siteID		= rc.siteID />
			<cfset forumBean		= forumService.getForumWithThreads( argumentCollection=sArgs )>
		</cfif>

		<cfif forumBean.beanExists()>
			<cfset conferenceBean	= conferenceService.getConference( forumBean.getConferenceID() ) />
		<cfelse>
			<!--- 1012: forum not found --->
			<cflocation url="#rc.meldForumsBean.getForumWebRoot()#?ecode=1012" addtoken="false">
			<cfreturn>
		</cfif>

		<!--- add the pageNav to the event scope --->
		<cfset $.event().setValue("pageBean",pageBean) />

		<cfset isSubscribed = subscribeService.getIsSubscribedToForum( $.currentUser().getUserID(),forumBean.getForumID() ) />

		<cfset rc.ForumBean			= forumBean />
		<cfset rc.ConferenceBean	= conferenceBean />
		<cfset rc.pageBean			= pageBean />
		<cfset rc.isSubscribed		= isSubscribed />
	</cffunction>
</cfcomponent>