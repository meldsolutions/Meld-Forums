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
<cfcomponent displayname="MeldForumsRequestManager" hint="Meld Event" output="false">
	<cfset variables.values		= StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldForumsRequestManager">
		<cfreturn this/>
	</cffunction>

	<cffunction name="getMeldForumsBean" access="public" output="false" returntype="any" description="retrieves the ordered tree of conferences and/or forums">
		<cfargument name="$">
		<cfargument name="initConfig" required="false" default="#StructNew()#">

		<cfset var MeldForumsBean		= "" />
		<cfset var sArgs		 		= initConfig />

		<!--- legacy support --->
		<cfif not isStruct(arguments.initConfig)>
			<cfset arguments.initConfig = StructNew() />
			<cfset sArgs = StructNew() />
		</cfif>
		
		<cfif not $.getGlobalEvent().valueExists("MeldForumsBean")
			OR (structKeyExists(sArgs,"reinit") AND sArgs.reinit eq true)>
			<cfset sArgs.beanFactory = getBeanFactory() />
			<cfset sArgs.$ = $ />
			<cfif $.getGlobalEvent().valueExists('MeldForumsIntercept')>
				<cfset sArgs.Intercept = $.getGlobalEvent().getValue('MeldForumsIntercept') />
			</cfif>
			<cfset MeldForumsBean = createObject("component","#getPluginConfig().getPackage()#.com.meldsolutions.meldforums.application.MeldForumsBean").init( argumentCollection=sArgs ) />
			<cfset $.getGlobalEvent().setValue("MeldForumsBean",MeldForumsBean) />
		<cfelse>
			<cfset MeldForumsBean = $.getGlobalEvent().getValue("MeldForumsBean") />
		</cfif>

		<cfreturn MeldForumsBean />
	</cffunction>

	<cffunction name="getConferenceTree" access="public" output="false" returntype="query" description="retrieves the ordered tree of conferences and/or forums">
		<cfargument name="value" type="any" required="false" />

		<cfset var conferenceService	= getBeanFactory().getBean("conferenceService") />
		
		<cfreturn conferenceService.getTree( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="getForumIDsByConferenceID" access="public" output="false" returntype="array" description="retrieves the forum ids for a particular conference">
		<cfargument name="conferenceID" type="uuid" required="false" />

		<cfset var forumService		= getBeanFactory().getBean("forumService") />
		<cfreturn forumService.getForumIDsByConferenceID( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="getHasPermissions" returntype="boolean" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="configurationID" type="uuid" required="true" />
		<cfargument name="permType" type="string" required="true" default="read" />

		<cfset var settingsManager		= getMuraManager().getBean("settingsManager")>
		<cfset var configurationManager	= getBeanFactory().getBean("meldForumsConfigurationManager")>
		<cfset var configurationBean	= configurationManager.getConfigurationByID( arguments.configurationID )>
		<cfset var siteID				= "">
		<cfset var groupName			= "">
		
		<cfset siteID = configurationBean.getSiteID()>

		<cfswitch expression="#arguments.permType#">
			<cfcase value="read">
				<cfif not configurationManager.getConfigurationByID( arguments.configurationID ).getdoRestrictRead()>
					<cfreturn true>
				<cfelseif $.currentUser().isSuperUser()>
					<cfreturn true>
				<cfelse>
					<cfloop list="#configurationManager.getConfigurationByID( arguments.configurationID ).getRestrictReadGroups()#" index="groupName">
						<cfif $.currentUser().isInGroup(groupName) eq true>
							<cfreturn true>
							<cfbreak>
						</cfif>
					</cfloop>
				</cfif>
			</cfcase>
			<cfcase value="post">
				<!--- create session if one doesn't exist --->
				<cfif $.currentUser().isLoggedIn() and not isDefined("session.meldForumsUser")>
					<cfset setForumSession( $.currentUser().getUserID() )>
				</cfif>
				<cfif $.currentUser().isLoggedIn() and session.MeldForumsUser.isBlocked>
					<cfreturn false>
				<cfelseif $.currentUser().isLoggedIn() and not configurationManager.getConfigurationByID( arguments.configurationID ).getdoRestrictContribute()>
					<cfreturn true>
				<cfelseif $.currentUser().isSuperUser()>
					<cfreturn true>
				<cfelseif $.currentUser().isLoggedIn()>
					<cfloop list="#configurationManager.getConfigurationByID( arguments.configurationID ).getRestrictContributeGroups()#" index="groupName">
						<cfif $.currentUser().isInGroup(groupName)>
							<cfreturn true>
							<cfbreak>
						</cfif>
					</cfloop>
				</cfif>
			</cfcase>
			<cfcase value="edit">
				<!--- create session if one doesn't exist --->
				<cfif $.currentUser().isLoggedIn() and not isDefined("session.meldForumsUser")>
					<cfset setForumSession( $.currentUser().getUserID() )>
				</cfif>
				<cfif $.currentUser().isLoggedIn() and session.MeldForumsUser.isBlocked>
					<cfreturn false>
				<cfelseif $.currentUser().isLoggedIn() and not configurationManager.getConfigurationByID( arguments.configurationID ).getdoRestrictModerate()>
					<cfreturn true>
				<cfelseif $.currentUser().isSuperUser()>
					<cfreturn true>
				<cfelseif $.currentUser().isLoggedIn()>
					<cfloop list="#configurationManager.getConfigurationByID( arguments.configurationID ).getRestrictModerateGroups()#" index="groupName">
						<cfif $.currentUser().isInGroup(groupName)>
							<cfreturn true>
							<cfbreak>
						</cfif>
					</cfloop>
				</cfif>
			</cfcase>
		</cfswitch>

		<cfreturn false>
	</cffunction>

	<cffunction name="getHasFullPermissions" returntype="boolean" access="public" output="false">
		<cfargument name="$" type="any" required="true" />
		<cfargument name="siteID" type="string" required="true" />

		<cfset var settingsManager	= getMuraManager().getBean("settingsManager")>
		<cfset var groupName		= "">
		
		<cfif $.currentUser().isSuperUser()>
			<cfreturn true>
		<cfelseif $.currentUser().isLoggedIn()>
			<cfloop list="#getMeldForumsSettingsManager().getSiteSettings( arguments.siteID ).getPermissionGroups()#" index="groupName">
				<cfif $.currentUser().isInGroup(groupName)>
					<cfreturn true>
					<cfbreak>
				</cfif>
			</cfloop>
		</cfif>

		<cfreturn false>
	</cffunction>

	<cffunction name="validateIntercept" returntype="boolean" access="public" output="false">
		<cfargument name="$" type="any" required="true">
		<cfargument name="isPassiveCheck" type="boolean" required="false" default="false"/>

		<cfset var iResponse			= $.event().getValue("MeldInterceptResponse")>
		<cfset var meldForumsBean		= $.event().getValue("MeldForumsBean") />

		<cfset var sResponseData	= iResponse.getData()>
		<cfset var isValidIntercept	= false>

		<cfset var currentFileName			= $.event().getValue("currentFileName") />
		<cfset var siteID					= $.event().getValue("siteID") />


		<cfif not iResponse.getIsValid()>
			<cfif arguments.isPassiveCheck>
				<cfreturn false>
			<cfelse>
				<cflocation url="#meldForumsBean.getForumWebRoot()#?ecode=3000&vf=true" addtoken="false">
			</cfif>
		<cfelseif not len( iResponse.getKeysetID() )>
			<cfreturn true>
		</cfif>

		<cfswitch expression="#iResponse.getKeysetID()#">
			<cfcase value="viewconference">
				<cfif StructKeyExists(sResponseData,"ident")>
					<cfset $.event().setValue("conferenceID",sResponseData["ident"])>
					<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="subscribe">
				<cfif StructKeyExists(sResponseData,"ident") and StructKeyExists(sResponseData,"mode")>
					<cfif sResponseData["type"] eq "thread">
						<cfset $.event().setValue("threadID",sResponseData["ident"])>
					<cfelseif sResponseData["type"] eq "forum">
						<cfset $.event().setValue("forumID",sResponseData["ident"])>
					</cfif>
					<cfset isValidIntercept	= true>
				</cfif>
				<cfset $.event().setValue("mode",sResponseData["mode"])>
				<cfset $.event().setValue("type",sResponseData["type"])>
				<cfreturn isValidIntercept>
			</cfcase>
			<cfcase value="viewforum,newthread">
				<cfif StructKeyExists(sResponseData,"ident")>
					<cfset $.event().setValue("forumID",sResponseData["ident"])>
					<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="newpost">
				<cfif StructKeyExists(sResponseData,"ident")>
					<cfset $.event().setValue("threadID",sResponseData["ident"])>
					<cfset isValidIntercept	= true>
				</cfif>
				<!--- post id, for quotes --->
				<cfif isValidIntercept and StructKeyExists(sResponseData,"quote")>
					<cfset $.event().setValue("quoteID",sResponseData["quote"])>
					<cfreturn true>
				</cfif>
				<cfreturn isValidIntercept>
			</cfcase>
			<cfcase value="viewthread,editthread">
				<cfif StructKeyExists(sResponseData,"ident")>
					<cfset $.event().setValue("threadID",sResponseData["ident"])>
					<cfset isValidIntercept	= true>
				</cfif>
				<!--- post id --->
				<cfif isValidIntercept and StructKeyExists(sResponseData,"postposition") and isNumeric(sResponseData["postposition"])>
					<cfset $.event().setValue("postposition",sResponseData["postposition"])>
					<cfreturn true>
				</cfif>
				<cfreturn isValidIntercept>
			</cfcase>
			<cfcase value="editpost">
				<cfif StructKeyExists(sResponseData,"ident")>
					<cfset $.event().setValue("postID",sResponseData["ident"])>
					<cfreturn true>
				</cfif>
				<!--- post id, for quotes --->
				<cfif isValidIntercept and StructKeyExists(sResponseData,"quote")>
					<cfset $.event().setValue("quoteID",sResponseData["quote"])>
					<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="viewprofile">
				<cfif StructKeyExists(sResponseData,"ident")>
					<cfset $.event().setValue("profileUserID",sResponseData["ident"])>
					<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="panel">
				<cfif StructKeyExists(sResponseData,"item")>
					<cfset $.event().setValue("item",sResponseData["item"])>
					<cfset $.event().setValue("action","panel.view")>
				<cfreturn true>
				</cfif>
			</cfcase>
			<cfcase value="searchresults">
				<cfreturn true>
			</cfcase>
		</cfswitch>

		<cfif arguments.isPassiveCheck>
			<cfreturn false>
		</cfif>

		<cflocation url="#$.getURLStem(siteID,currentFileName)#?ecode=3000&vf=true" addtoken="false">
		<cfreturn false>
	</cffunction>

	<cffunction name="setForumSession" access="public" output="false" returntype="void">
		<cfargument name="userID" type="string" required="true" />

		<cfset var forumUser	= getUserService().getUser( arguments.userID )>
		<cfset var sForumUser	= structNew()>

		<cfset sForumUser.isBlocked		= forumUser.getIsBlocked()>
		<cfset sForumUser.dateIsNewFrom = forumUser.getDateIsNewFrom()>
		<cfset sForumUser.threadsViewed = StructNew()>

		<cflock type="exclusive" scope="Session" timeout="10">
			<cfset session.MeldForumsUser = sForumUser>
		</cflock>
	</cffunction>

	<cffunction name="getBeanFactory" access="public" output="false" returntype="any">
		<cfreturn getMeldForumsManager().getBeanFactory() />
	</cffunction>
	<cffunction name="setBeanFactory" access="public" output="false" returntype="void">
		<cfargument name="BeanFactory" type="any" required="true" />
		<cfset variables.BeanFactory = arguments.BeanFactory />
	</cffunction>

	<cffunction name="getPluginConfig" access="public" output="false" returntype="any">
		<cfreturn getMeldForumsManager().getPluginConfig() />
	</cffunction>

	<cffunction name="getMuraManager" access="public" output="false" returntype="any">
		<cfreturn variables.MuraManager />
	</cffunction>
	<cffunction name="setMuraManager" access="public" output="false" returntype="void">
		<cfargument name="MuraManager" type="any" required="true" />
		<cfset variables.MuraManager = arguments.MuraManager />
	</cffunction>

	<cffunction name="getUserService" access="public" output="false" returntype="any">
		<cfreturn variables.UserService />
	</cffunction>
	<cffunction name="setUserService" access="public" output="false" returntype="void">
		<cfargument name="UserService" type="any" required="true" />
		<cfset variables.UserService = arguments.UserService />
	</cffunction>

	<cffunction name="getMeldForumsManager" access="public" output="false" returntype="any">
		<cfreturn variables.MeldForumsManager />
	</cffunction>
	<cffunction name="setMeldForumsManager" access="public" output="false" returntype="void">
		<cfargument name="MeldForumsManager" type="any" required="true" />
		<cfset variables.MeldForumsManager = arguments.MeldForumsManager />
	</cffunction>

	<cffunction name="getMeldForumsConfigurationManager" access="public" output="false" returntype="any">
		<cfreturn variables.MeldForumsConfigurationManager />
	</cffunction>
	<cffunction name="setMeldForumsConfigurationManager" access="public" output="false" returntype="void">
		<cfargument name="MeldForumsConfigurationManager" type="any" required="true" />
		<cfset variables.MeldForumsConfigurationManager = arguments.MeldForumsConfigurationManager />
	</cffunction>

	<cffunction name="getMeldForumsSettingsManager" access="public" output="false" returntype="any">
		<cfreturn variables.MeldForumsSettingsManager />
	</cffunction>
	<cffunction name="setMeldForumsSettingsManager" access="public" output="false" returntype="void">
		<cfargument name="MeldForumsSettingsManager" type="any" required="true" />
		<cfset variables.MeldForumsSettingsManager = arguments.MeldForumsSettingsManager />
	</cffunction>
</cfcomponent>