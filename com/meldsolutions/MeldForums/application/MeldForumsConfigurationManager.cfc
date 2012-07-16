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
<cfcomponent displayname="MeldForumsConfigurationManager" hint="Configurations for MeldForums" output="false">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldForumsConfigurationManager">
		<cfset variables.instance.ConfigurationConferenceKey = StructNew()>
		<cfset variables.instance.ConfigurationForumKey =StructNew()>
		<cfreturn this/>
	</cffunction>

	<cffunction name="initConfiguration" returntype="any" access="public" output="false">
		<cfargument name="$">

		<cfset var forumID = "">
		<cfset var conID = "">
		
		<cfif $.event().valueExists('conferenceID') and len( $.event().getValue("conferenceID") )>
			<cfreturn getConfigurationByConferenceID( $.event().getValue("conferenceID") )>
		<cfelseif $.event().valueExists('forumID') and len( $.event().getValue("forumID") )>
			<cfreturn getConfigurationByForumID( $.event().getValue("forumID") )>
		<cfelseif $.event().valueExists('threadID') and  len( $.event().getValue("threadID") )>
			<cfset forumID = getThreadService().getForumIDByThreadID( $.event().getValue("threadID") ) />
			<cfif len( forumID )>
				<cfreturn getConfigurationByForumID( forumID )>
			<cfelse>
				<cfreturn getConfigurationByID('00000000-0000-0000-0000000000000001')>
			</cfif>
		<cfelseif $.event().valueExists("postID") and  len( $.event().getValue("postID") )>
			<cfset forumID = getPostService().getForumIDByPostID( $.event().getValue("postID") ) /> 	
			<cfif len( forumID )>
				<cfreturn getConfigurationByForumID( forumID )>
			<cfelse>
				<cfreturn getConfigurationByID('00000000-0000-0000-0000000000000001')>
			</cfif>
		<cfelse>
			<!--- default --->
			<cfreturn getConfigurationByID('00000000-0000-0000-0000000000000001')>
		</cfif>
	</cffunction>

	<cffunction name="getConfigurationByConferenceID" returntype="any" access="public" output="false">
		<cfargument name="conferenceID" type="uuid" required="true" />

		<cfset var conferenceBean	= "">

		<cfif not StructKeyExists(variables.instance.ConfigurationConferenceKey,arguments.conferenceID)>
			<cfset conferenceBean = getConferenceService().getConference( arguments.conferenceID )>
			<cfif conferenceBean.beanExists()>
				<cfset variables.instance.ConfigurationConferenceKey[arguments.conferenceID] = conferenceBean.getActiveConfigurationID()>
				<cfset ConfigurationID = variables.instance.ConfigurationConferenceKey[arguments.conferenceID]>
			<cfelse>
				<cfset ConfigurationID = "00000000-0000-0000-0000000000000001">
			</cfif>
		<cfelse>
			<cfset ConfigurationID = variables.instance.ConfigurationConferenceKey[arguments.conferenceID]>
		</cfif>

		<cfreturn getConfigurationByID( ConfigurationID )>
	</cffunction>

	<cffunction name="getConfigurationByForumID" returntype="any" access="public" output="false">
		<cfargument name="forumID" type="uuid" required="true" />

		<cfset var ConfigurationID	= "">
		<cfset var forumBean		= "">

		<cfif not StructKeyExists(variables.instance.ConfigurationForumKey,forumID)>
			<cfset forumBean = getForumService().getForum( arguments.forumID )>
			<cfif forumBean.beanExists()>
				<cfset variables.instance.ConfigurationForumKey[arguments.forumID] = forumBean.getActiveConfigurationID()>
				<cfset ConfigurationID = variables.instance.ConfigurationForumKey[arguments.forumID]>
			<cfelse>
				<cfset ConfigurationID = "00000000-0000-0000-0000000000000001">
			</cfif>
		<cfelse>
			<cfset ConfigurationID = variables.instance.ConfigurationForumKey[arguments.forumID]>
		</cfif>

		<cfreturn getConfigurationByID( ConfigurationID )>
	</cffunction>

	<cffunction name="getConfigurationByID" returntype="any" access="public" output="false">
		<cfargument name="configurationID" type="uuid" required="true" />

		<cfif not StructKeyExists(variables.instance,"Configuration")>
			<cfset setAllConfigurations()>
		</cfif>

		<cfif not StructKeyExists(variables.instance.ConfigurationKey,arguments.configurationID)>
			<cfset getConfigurationService().removeNonexistantID(arguments.configurationID)>
			<cfreturn variables.instance.Configuration[variables.instance.ConfigurationKey['00000000-0000-0000-0000000000000001']]>
		</cfif>

		<cfreturn variables.instance.Configuration[variables.instance.ConfigurationKey[arguments.configurationID]]>
	</cffunction>

	<cffunction name="getAllConfigurations" returntype="array" access="public" output="false">
		<cfargument name="siteID" type="string" required="false" />

		<cfif not StructKeyExists(variables.instance,"Configuration")>
			<cfset setAllConfigurations()>
		</cfif>
		<cfif isDefined("arguments.siteID")>
			<cfreturn getSiteConfigurations(arguments.siteID)>
		<cfelse>
			<cfreturn variables.instance.Configuration>
		</cfif>
	</cffunction>

	<cffunction name="setAllConfigurations" returntype="void" access="public" output="false">
		
		<cfset var iiX = "">

		<cflock type="exclusive" timeout="15">
			<cfset variables.instance.Configuration = getConfigurationService().getConfigurations()>
			<cfset variables.instance.ConfigurationKey = StructNew()>
			<cfset variables.instance.ConfigurationConferenceKey = StructNew()>
			<cfset variables.instance.ConfigurationForumKey =StructNew()>

	
			<cfloop from="1" to="#arrayLen(variables.instance.Configuration)#" index="iiX">
				<cfset variables.instance.ConfigurationKey[variables.instance.Configuration[iiX].getConfigurationID()] = iiX>
			</cfloop>
		</cflock>
	</cffunction>

	<cffunction name="getSiteConfigurations" returntype="array" access="public" output="false">
		<cfargument name="siteID" type="string" required="false" />

		<cfset var iiX = "">
		<cfset var aList = ArrayNew(1)>

		<cfloop from="1" to="#arrayLen(variables.instance.Configuration)#" index="iiX">
			<cfif variables.instance.Configuration[iiX].getSiteID() eq arguments.siteID or variables.instance.Configuration[iiX].getIsMaster()>
				<cfset arrayAppend(aList,variables.instance.Configuration[iiX])>
			</cfif>
		</cfloop>
		<cfreturn aList>
	</cffunction>

	<cffunction name="setConfigurationService" access="public" returntype="any" output="false">
		<cfargument name="ConfigurationService" type="any" required="true">
		<cfset variables.ConfigurationService = arguments.ConfigurationService>
	</cffunction>
	<cffunction name="getConfigurationService" access="public" returntype="any" output="false">
		<cfreturn variables.ConfigurationService>
	</cffunction>

	<cffunction name="setConferenceService" access="public" returntype="any" output="false">
		<cfargument name="ConferenceService" type="any" required="true">
		<cfset variables.ConferenceService = arguments.ConferenceService>
	</cffunction>
	<cffunction name="getConferenceService" access="public" returntype="any" output="false">
		<cfreturn variables.ConferenceService>
	</cffunction>

	<cffunction name="setForumService" access="public" returntype="any" output="false">
		<cfargument name="ForumService" type="any" required="true">
		<cfset variables.ForumService = arguments.ForumService>
	</cffunction>
	<cffunction name="getForumService" access="public" returntype="any" output="false">
		<cfreturn variables.ForumService>
	</cffunction>

	<cffunction name="setThreadService" access="public" returntype="any" output="false">
		<cfargument name="ThreadService" type="any" required="true">
		<cfset variables.ThreadService = arguments.ThreadService>
	</cffunction>
	<cffunction name="getThreadService" access="public" returntype="any" output="false">
		<cfreturn variables.ThreadService>
	</cffunction>

	<cffunction name="setPostService" access="public" returntype="any" output="false">
		<cfargument name="PostService" type="any" required="true">
		<cfset variables.PostService = arguments.PostService>
	</cffunction>
	<cffunction name="getPostService" access="public" returntype="any" output="false">
		<cfreturn variables.PostService>
	</cffunction>
</cfcomponent>