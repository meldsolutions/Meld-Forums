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

		<cfset var settingsManager		= getBeanFactory().getBean("MeldForumsSettingsManager") />
		<cfset var settingsService		= getBeanFactory().getBean("settingsService") />
		<cfset var mmBreadCrumbs		= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle		= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var settingsBean			= "" />
		<cfset var sArgs				= StructNew() />

		<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('settings'),"" )>

		<!--- Settings are by siteID --->
		<cfset sArgs = StructNew() />
		<cfset sArgs.siteID = rc.siteID>
		<cfset settingsBean		= settingsService.getSettings( argumentCollection=sArgs ) />

		<!--- Settings are by siteID; if settingsBean does not exist, call the function to create the site settingsBean --->
		<cfif not settingsBean.beanExists()>
			<cfset settingsService.createSettingsForSite( argumentCollection=sArgs )>
			<cfset settingsBean	= settingsService.getSettings( argumentCollection=sArgs ) />
		</cfif>

		<cfset rc.settingsBean	= settingsBean />
		<cfset rc.themename			= settingsManager.getSiteSettings( rc.siteID ).getThemeBean().getName() />
	</cffunction>

	<cffunction name="config" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var resp = structNew() />
		<cfset var remoteManager = getBeanFactory().getBean("MeldForumsRemote") />

		<cfif not rc.$.currentUser().isPrivateUser()>
			<cflocation url="?">
		</cfif>

		<cfset resp = remoteManager.getConfigurationList( argumentCollection=url ) />

		<cfset rc.resp = resp />		
	</cffunction>

	<cffunction name="conf" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var resp = structNew() />
		<cfset var remoteManager = getBeanFactory().getBean("MeldForumsRemote") />

		<cfif not rc.$.currentUser().isPrivateUser()>
			<cflocation url="?">
		</cfif>

		<cfset resp = remoteManager.getConferenceList( argumentCollection=url ) />

		<cfset rc.resp = resp />		
	</cffunction>

	<cffunction name="forum" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var resp = structNew() />
		<cfset var remoteManager = getBeanFactory().getBean("MeldForumsRemote") />

		<cfif not rc.$.currentUser().isPrivateUser()>
			<cflocation url="?">
		</cfif>

		<cfset resp = remoteManager.getForumList( argumentCollection=url ) />

		<cfset rc.resp = resp />		
	</cffunction>
	
</cfcomponent>