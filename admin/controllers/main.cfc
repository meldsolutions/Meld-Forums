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
	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var pluginEvent 			= createEvent(rc) />
		<cfset var pluginManager		= rc.$.getBean('pluginManager') />

		<cfset rc.renderDashboard		= "" />

		<cfset pluginEvent.setValue('siteID',rc.siteID ) />
		<cfset rc.renderDashboard		= pluginManager.renderEvent( "onMeldForumsDashboardRender",pluginEvent )>

		<cfset  actionGetDashboard( arguments.rc )>
	</cffunction>

	<cffunction name="actionGetDashboard" access="private" returntype="void">
		<cfargument name="rc" type="struct" required="true">

		<cfset var configurationService		= getBeanFactory().getBean("configurationService") />
		<cfset var forumService				= getBeanFactory().getBean("forumService") />
		<cfset var conferenceService		= getBeanFactory().getBean("conferenceService") />
		<cfset var threadService			= getBeanFactory().getBean("threadService") />
		<cfset var postService				= getBeanFactory().getBean("postService") />
		<cfset var userService				= getBeanFactory().getBean("userService") />

		<cfset var settingsManager			= getBeanFactory().getBean("MeldForumsSettingsManager") />
		<cfset var forumManager				= getBeanFactory().getBean("MeldForumsManager") />
		<cfset var pageManager				= getBeanFactory().getBean("PageManager") />
		<cfset var requestManager			= getBeanFactory().getBean("MeldForumsRequestManager") />
		<cfset var pageBean					= pageManager.getPageBean(rc.$) />
		<cfset var sArgs					= StructNew() />

		<cfset rc.MeldForumsBean			= requestManager.getMeldForumsBean(rc.$) />
		<cfset rc.MeldForumsBean.setForumWebRoot( forumManager.getForumRoot(rc.$,rc.pluginConfig.getModuleID()) ) />

		<cfset rc.settingsBean				= settingsManager.getSiteSettings( rc.siteID ) />
		<cfset rc.conferenceCount			= conferenceService.getCount( siteID = rc.siteID ) />
		<cfset rc.forumCount				= conferenceService.getCount( siteID = rc.siteID ) />
		<cfset rc.threadCount				= threadService.getCount( siteID = rc.siteID ) />
		<cfset rc.postCount					= postService.getCount( siteID = rc.siteID ) />

		<!--- recent posts --->
		<cfset pageBean.setSize( 20 ) />
		<cfset rc.aPosts = postService.getRecentActivity( pageBean ) />

		<!--- recent users --->
		<cfset pageBean.setSize( 20 ) />
		<cfset sArgs					= StructNew() />
		<cfset sArgs.siteID				= rc.siteID />
		<cfset sArgs.pageBean			= pageBean />
		<cfset sArgs.orderBy			= "dateLastAction DESC" />

		<cfset rc.aUsers = userService.getUsers( argumentCollection=sArgs ) />
	</cffunction>

</cfcomponent>