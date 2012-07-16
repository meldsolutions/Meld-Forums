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
<cfcomponent displayname="MeldForumsManager" output="false">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MeldForumsManager" access="public" output="false">
		<cfset variables.settings = StructNew() />
		
		<cfreturn this>
	</cffunction>

	<cffunction name="getMeldBean" returntype="any" access="public" output="false">
		<cfreturn createObject("component","MeldForums.com.meldsolutions.core.MeldBean")>
	</cffunction>

	<cffunction name="hasForums" returntype="boolean" access="public" output="false">
		<cfargument name="$" />
		<cfargument name="moduleID" />
		<cfargument name="contentHistID" />

		<cfset var qHasForums = "" />

		<cfset var pluginEvent 		= getMeldForumsEventManager().createEvent($) />
		<cfset var ident			= "" />
		<cfset var siteID			= $.event().getValue('siteID') />

		<cfset pluginEvent.setValue("siteID", siteID ) />
		<cfset pluginEvent.setValue("moduleID", arguments.moduleID ) />
		<cfset pluginEvent.setValue("contentHistID", arguments.contentHistID ) />
		<cfset pluginEvent.setValue("hasForums", "" ) />

		<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsGetHasForums",pluginEvent)>

		<cfif isBoolean( pluginEvent.getValue( "hasForums" ) )>
			<cfreturn pluginEvent.getValue( "hasForums" ) >
		</cfif>		

		<cfquery name="qHasForums" datasource="#$.globalConfig().getDatasource()#" username="#$.globalConfig().getDBUsername()#" password="#$.globalConfig().getDBPassword()#" cachedwithin="#createTimeSpan(0,0,0,1)#">
			SELECT
				tco.contentID
			FROM
				tcontentobjects tco
			JOIN
				tplugindisplayobjects tpdo
			ON
				(tco.objectID = tpdo.objectID)
			WHERE
				tpdo.moduleID = <cfqueryparam value="#arguments.moduleID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				tco.contentHistID = <cfqueryparam value="#arguments.contentHistID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
	
		<cfif qHasForums.recordCount>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="getForumRoot" returntype="string" access="public" output="false">
		<cfargument name="$" />
		<cfargument name="moduleID" />

		<cfset var qForums = "" />

		<cfset var pluginEvent 		= getMeldForumsEventManager().createEvent($) />
		<cfset var muraManager 		= getBeanFactory().getBean("MuraManager") />
		<cfset var contentRenderer	= muraManager.getBean("contentRenderer") />
		<cfset var ident			= "" />
		<cfset var siteID			= $.event().getValue('siteID') />

		<cfquery name="qForums" datasource="#$.globalConfig().getDatasource()#" username="#$.globalConfig().getDBUsername()#" password="#$.globalConfig().getDBPassword()#" maxrows="1">
			SELECT
				tc.fileName
			FROM
				tcontent tc
			JOIN
				tcontentobjects tco
			ON
				(tco.contentID = tc.contentID)
			JOIN
				tplugindisplayobjects tpdo
			ON
				(tco.objectID = tpdo.objectID)
			WHERE
				tpdo.moduleID = <cfqueryparam value="#arguments.moduleID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				tpdo.displayObjectFile = <cfqueryparam value="forum.display.displayManager" CFSQLType="cf_sql_varchar" maxlength="100" />
			AND
				tc.active=1
			AND
				tc.siteID = <cfqueryparam value="#siteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
		</cfquery>
	
		<cfif qForums.recordCount>
			<cfreturn contentRenderer.getUrlStem(siteID=siteID,fileName=qForums.fileName) />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

	<cffunction name="processIntercept" returntype="any" access="public" output="false">
		<cfargument name="$" />
		<cfargument name="aIntercept" type="array" required="true" />

		<cfset var pluginEvent 		= getMeldForumsEventManager().createEvent($) />
		<cfset var mmUtility 		= getBeanFactory().getBean('mmUtility') />
		<cfset var mmRBF	 		= getBeanFactory().getBean('mmResourceBundle') />
		<cfset var ident			= "" />
		<cfset var aCrumbData		= ArrayNew( 1 ) />
		<cfset var siteID			= $.event().getValue('siteID') />
		<cfset var userID			= "" />
		<cfset var panel			= "" />
		<cfset var panelContent		= "" />
		<cfset var profileUserBean	= "" />
		
		<cfif not ArrayLen( aIntercept )>
			<cfreturn />
		</cfif>

		<cfset MeldForumsBean = getMeldForumsRequestManager().getMeldForumsBean($) />
		<cfset MeldForumsBean.setIntercept( aIntercept ) />

		<cfset pluginEvent.setValue("siteID", siteID ) />

		<cfswitch expression="#aIntercept[1]#">
			<cfcase value="subscribe">
				<cfif ArrayLen(aIntercept) eq 4 and mmUtility.isUUID(aIntercept[4])>
					<cfset url.action = "subscribe" />
					<cfset MeldForumsBean.setAction( url.action ) />
					<cfset pluginEvent.setValue("intercept",aIntercept) />
					<cfset pluginEvent.setValue("type",aIntercept[2]) />
					<cfset pluginEvent.setValue("mode",aIntercept[3]) />
					<cfset pluginEvent.setValue("id",aIntercept[4]) />
					<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsSubscribe",pluginEvent)>
				</cfif>
			</cfcase>
			<cfcase value="thread">
				<cfset url.action = "thread" />
				<cfif not mmUtility.isUUID(aIntercept[2])>
					<cfset pluginEvent.setValue("action",url.action & "." & aIntercept[2]) />
					<cfif mmUtility.isUUID(aIntercept[3])>
						<cfswitch expression="#aIntercept[2]#">
							<cfcase value="new">
								<cfset $.event().setValue('forumID',aIntercept[3] ) />
							</cfcase>
							<cfdefaultcase>
								<cfset $.event().setValue('threadID',aIntercept[3] ) />
							</cfdefaultcase> 	
						</cfswitch>
					</cfif>
				<cfelse>
					<cfset pluginEvent.setValue("action",url.action) />
				</cfif>
				<cfset pluginEvent.setValue("intercept",aIntercept) />
				<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsThreadRequest",pluginEvent)>
				<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
				<cfif pluginEvent.valueExists('threadBean')>
					<cfset $.event().setValue('threadBean',pluginEvent.getValue('threadBean')) />
					<cfset $.event().setValue('threadID',pluginEvent.getValue('threadBean').getthreadID() ) />
				</cfif>
				<cfif $.event().valueExists('threadID')>
					<cfset aCrumbData = getBeanFactory().getBean('threadService').getCrumbData(siteID,$.event().getValue('threadID') ) >
				<cfelseif $.event().valueExists('forumID')>
					<cfset aCrumbData = getBeanFactory().getBean('forumService').getCrumbData(siteID,$.event().getValue('forumID') ) >
				</cfif>
			</cfcase>
			<cfcase value="post">
				<cfset url.action = "post" />
				<cfset pluginEvent.setValue("intercept",aIntercept) />
				<cfif not mmUtility.isUUID(aIntercept[2])>
					<cfset pluginEvent.setValue("action",url.action & "." & aIntercept[2]) />
					<cfif mmUtility.isUUID(aIntercept[3])>
						<cfswitch expression="#aIntercept[2]#">
							<cfcase value="new">
								<cfset $.event().setValue('threadID',aIntercept[3] ) />
							</cfcase>
							<cfdefaultcase>
								<cfset $.event().setValue('postID',aIntercept[3] ) />
							</cfdefaultcase> 	
						</cfswitch>
					</cfif>
				<cfelse>
					<cfset pluginEvent.setValue("action",url.action) />
				</cfif>
				<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsPostRequest",pluginEvent)>
				<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
				<cfif pluginEvent.valueExists('postBean')>
					<cfset $.event().setValue('postBean',pluginEvent.getValue('postBean')) />
					<cfset $.event().setValue('postID',pluginEvent.getValue('postBean').getpostID() ) />
				</cfif>
				<cfif $.event().valueExists('postID')>
					<cfset aCrumbData = getBeanFactory().getBean('postService').getCrumbData(siteID, $.event().getValue('postID') ) >
				</cfif>
			</cfcase>
			<cfcase value="forum">
				<cfset url.action = "forum" />

				<cfset pluginEvent.setValue("intercept",aIntercept) />
				<cfset pluginEvent.setValue("action",url.action) />
				<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsForumRequest",pluginEvent)>
				<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
				<cfif pluginEvent.valueExists('forumBean')>
					<cfset $.event().setValue('forumBean',pluginEvent.getValue('forumBean')) />
					<cfset $.event().setValue('forumID',pluginEvent.getValue('forumBean').getforumID() ) />
				</cfif>
				<cfif $.event().valueExists('forumID')>
					<cfset aCrumbData = getBeanFactory().getBean('forumService').getCrumbData(siteID, $.event().getValue('forumID') ) >
				</cfif>
			</cfcase>
			<cfcase value="conference">
				<cfset url.action = "conference" />
				<cfset pluginEvent.setValue("intercept",aIntercept) />
				<cfset pluginEvent.setValue("action",url.action) />
				<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsConferenceRequest",pluginEvent)>
				<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
				<cfif pluginEvent.valueExists('conferenceBean')>
					<cfset $.event().setValue('conferenceBean',pluginEvent.getValue('conferenceBean')) />
					<cfset $.event().setValue('conferenceID',pluginEvent.getValue('conferenceBean').getconferenceID() ) />
				</cfif>
				<cfif $.event().valueExists('conferenceID')>
					<cfset aCrumbData = getBeanFactory().getBean('conferenceService').getCrumbData(siteID, $.event().getValue('conferenceID') ) >
				</cfif>
			</cfcase>
			<cfcase value="profile">
				<cfif ArrayLen(aIntercept) gte 3 and mmUtility.isUUID( aIntercept[3] )>
					<cfset url.action	= "profile.#aIntercept[2]#" />
					<cfset userID		= aIntercept[3] />
					<cfset pluginEvent.setValue("userID",aIntercept[3]) />
				<cfelseif ArrayLen(aIntercept) gte 2 and $.currentUser().isLoggedIn()>
					<cfset url.action		= "profile.#aIntercept[2]#" />
					<cfset aIntercept[3]	= $.currentUser().getUserID() />
					<cfset userID			= $.currentUser().getUserID() />
					<cfset pluginEvent.setValue("userID",$.currentUser().getUserID()) />
				<cfelseif $.currentUser().isLoggedIn()>
					<cfset url.action = "profile.view" />
					<cfset aIntercept[2]	= "view" />
					<cfset aIntercept[3]	= $.currentUser().getUserID() />
					<cfset userID			= $.currentUser().getUserID() />
					<cfset pluginEvent.setValue("userID",$.currentUser().getUserID()) />
				<cfelse>
					<cfset url.action = "profile.login" />
				</cfif>

				<cfset pluginEvent.setValue("intercept",aIntercept) />
				<cfset pluginEvent.setValue("userID",userID) />

				<!--- panels --->
				<cfif url.action eq "profile.panel" and StructKeyExists(url,"panel")>
					<cfset panel = rereplace(url.panel,"[^[:ALPHA:]]","","all")>

					<cfif fileExists(expandPath('/MeldForums/') & "forum/views/profile/panels/#panel#.cfm" )>
						<cfset url.action = "profile.panel" />	
					<cfelse>
						<cfset url.action = "profile.custom" />
					</cfif>	
				</cfif> 

				<cfset pluginEvent.setValue("action",url.action) />

				<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsProfileRequest",pluginEvent)>
				<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
				<cfif len(userID)>
					<cfset profileUserBean = getSiteSettings(siteID).getUserCache().getUser( userID ) />
					<cfset aCrumbData = getBeanFactory().getBean('userService').getCrumbData( profileUserBean ) >
				</cfif>
			</cfcase>
			<cfcase value="do">
				<cfset url.action = "do" />
				<cfif ArrayLen(aIntercept) gt 1>
					<cfset pluginEvent.setValue("call",aIntercept[2]) />
				</cfif>
				<cfset pluginEvent.setValue("intercept",aIntercept) />
				<cfset pluginEvent.setValue("action",url.action) />
				<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsDoRequest",pluginEvent)>
				<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
			</cfcase>
			<cfcase value="search">
				<cfset url.action = "search" />
				<cfset pluginEvent.setValue("intercept",aIntercept) />
				<cfset pluginEvent.setValue("action",url.action) />
				<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsDoSearch",pluginEvent)>
				<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
				<!---<cfset aCrumbData = getBeanFactory().getBean('searchable').getCrumbData(siteID) >--->
			</cfcase>
			<cfdefaultcase>
				<cfset ident = rereplacenocase( aIntercept[1],"([c|f|t|p]\d{1,})\-.*","\1" ) />

				<cfif len( ident ) and find("-",aIntercept[1])>
					<cfset MeldForumsBean.setIdent( ident ) />

					<cfset pluginEvent.setValue("ident",ident) />
					<cfset pluginEvent.setValue("idx", rereplace(ident,"[^\d]","","all") ) />
					<cfset pluginEvent.setValue("intercept",aIntercept) />
					<cfif left(ident,1) eq "c">
						<cfset url.action = "conference" />
						<cfset MeldForumsBean.setAction( url.action ) />
						<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsConferenceRequest",pluginEvent)>
						<cfif pluginEvent.valueExists('conferenceBean')>
							<cfset $.event().setValue('conferenceBean',pluginEvent.getValue('conferenceBean')) />
							<cfset $.event().setValue('conferenceID',pluginEvent.getValue('conferenceBean').getConferenceID() ) />
						<cfelse>
							<cfset bean = getBeanFactory().getBean('conferenceService').getBeanByAttributes(idx=pluginEvent.getValue("idx") ) />
							<cfif bean.beanExists()>
								<cfset $.event().setValue('conferenceBean',bean ) />
								<cfset $.event().setValue('conferenceID',bean.getConferenceID() ) />
							</cfif>
						</cfif>
						<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
						<cfif $.event().valueExists('conferenceID')>
							<cfset aCrumbData = getBeanFactory().getBean('conferenceService').getCrumbData(siteID, $.event().getValue('conferenceID') ) >
						</cfif>
					<cfelseif left(ident,1) eq "f">
						<cfset url.action = "forum" />
						<cfset MeldForumsBean.setAction( url.action ) />
						<cfset pluginEvent.setValue("action",url.action) />
						<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsForumRequest",pluginEvent)>
						<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
						<cfif pluginEvent.valueExists('forumBean')>
							<cfset $.event().setValue('forumBean',pluginEvent.getValue('forumBean')) />
							<cfset $.event().setValue('forumID',pluginEvent.getValue('forumBean').getforumID() ) />
						<cfelse>
							<cfset bean = getBeanFactory().getBean('forumService').getBeanByAttributes(idx=pluginEvent.getValue("idx") ) />
							<cfif bean.beanExists()>
								<cfset $.event().setValue('forumBean',bean ) />
								<cfset $.event().setValue('forumID',bean.getforumID() ) />
							</cfif>
						</cfif>
						<cfif $.event().valueExists('forumID')>
							<cfset aCrumbData = getBeanFactory().getBean('forumService').getCrumbData(siteID, $.event().getValue('forumID') ) >
						</cfif>
					<cfelseif left(ident,1) eq "t">
						<cfset url.action = "thread" />
						<cfset MeldForumsBean.setAction( url.action ) />
						<cfset pluginEvent.setValue("action",url.action) />
						<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsThreadRequest",pluginEvent)>
						<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
						<cfif pluginEvent.valueExists('threadBean')>
							<cfset $.event().setValue('threadBean',pluginEvent.getValue('threadBean')) />
							<cfset $.event().setValue('threadID',pluginEvent.getValue('threadBean').getthreadID() ) />
						<cfelse>
							<cfset bean = getBeanFactory().getBean('threadService').getBeanByAttributes(idx=pluginEvent.getValue("idx") ) />
							<cfif bean.beanExists()>
								<cfset $.event().setValue('threadBean',bean ) />
								<cfset $.event().setValue('threadID',bean.getthreadID() ) />
							</cfif>
						</cfif>
						<cfif $.event().valueExists('threadID')>
							<cfset aCrumbData = getBeanFactory().getBean('threadService').getCrumbData(siteID, $.event().getValue('threadID') ) >
						</cfif>
					<cfelse>
						<cfset url.action = "post" />
						<cfset MeldForumsBean.setAction( url.action ) />
						<cfset pluginEvent.setValue("action",url.action) />
						<cfset getMeldForumsEventManager().announceEvent($,"onMeldForumsPostRequest",pluginEvent)>
						<cfset MeldForumsBean.setAction( pluginEvent.getValue('action') ) />
						<cfif pluginEvent.valueExists('postBean')>
							<cfset $.event().setValue('postBean',pluginEvent.getValue('postBean')) />
							<cfset $.event().setValue('postID',pluginEvent.getValue('postBean').getpostID() ) />
						<cfelse>
							<cfset bean = getBeanFactory().getBean('postService').getBeanByAttributes(idx=pluginEvent.getValue("idx") ) />
							<cfif bean.beanExists()>
								<cfset $.event().setValue('postBean',bean ) />
								<cfset $.event().setValue('postID',bean.getpostID() ) />
							</cfif>
						</cfif>
						<cfif $.event().valueExists('postID')>
							<cfset aCrumbData = getBeanFactory().getBean('postService').getCrumbData(siteID, $.event().getValue('postID') ) >
						</cfif>
					</cfif>
				</cfif>
			</cfdefaultcase>			
		</cfswitch>

		<cfif ArrayLen( aCrumbData )>
			<cfset $.getGlobalEvent().setValue( 'MeldForumsCrumbData',aCrumbData ) />
		</cfif>

		<cfset MeldForumsBean.getConfigurationBean() />
	</cffunction>

	<cffunction name="setCrumbData" returntype="void" access="public" output="false">
		<cfargument name="$" type="any" required="true">
		<cfargument name="aCrumbData" type="any" required="true">

		<cfset var MuraCrumbManager	= getBeanFactory().getBean("MuraCrumbManager") />
		<cfset var iiX				= "" />
		<cfset var strCrumb			= StructNew() />
		<cfset var aCrumb			= ArrayNew(1) />
		<cfset var aMuraCrumb		= duplicate($.event("crumbData")) />
		<cfset var filename			= $.event().getValue("currentFileName") & "/" />
		
		<cfloop from="1" to="#arraylen(aCrumbData)#" index="iiX">
			<cfset strCrumb = aCrumbData[iiX] />
			<cfset strCrumb.filename = filename />
			<cfset arrayPrepend( aMuraCrumb,  MuraCrumbManager.createCrumb( argumentCollection=strCrumb ))  />
		</cfloop>
		
		<cfset $.event("crumbData",aMuraCrumb)>
		<cfset $.getContentRenderer().crumbData=aMuraCrumb>
		<cfif isObject( $.getThemeRenderer() )>
			<cfset $.getThemeRenderer().crumbData=aMuraCrumb>
		</cfif>
	</cffunction>

	<cffunction name="getSiteSettings" returntype="any" access="public" output="false">
		<cfargument name="siteID" type="string" required="true">

		<cfreturn  getMeldForumsSettingsManager().getSiteSettings(arguments.siteID)>
	</cffunction>

	<cffunction name="clearSiteSettings" returntype="void" access="public" output="false">
		<cfset variables.settings = StructNew() />
	</cffunction>

	<cffunction name="setPluginConfig" access="public" returntype="any" output="false">
		<cfargument name="PluginConfig" type="any" required="true">
		<cfset variables.PluginConfig = arguments.PluginConfig>
	</cffunction>
	<cffunction name="getPluginConfig" access="public" returntype="any" output="false">
		<cfreturn variables.PluginConfig>
	</cffunction>

	<cffunction name="setBeanFactory" access="public" returntype="any" output="false">
		<cfargument name="BeanFactory" type="any" required="true">
		<cfset variables.BeanFactory = arguments.BeanFactory>
	</cffunction>
	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.BeanFactory>
	</cffunction>

	<cffunction name="setMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfargument name="MeldForumsSettingsManager" type="any" required="true">
		<cfset variables.MeldForumsSettingsManager = arguments.MeldForumsSettingsManager>
	</cffunction>
	<cffunction name="getMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldForumsSettingsManager>
	</cffunction>

	<cffunction name="setMeldForumsEventManager" access="public" returntype="any" output="false">
		<cfargument name="MeldForumsEventManager" type="any" required="true">
		<cfset variables.MeldForumsEventManager = arguments.MeldForumsEventManager>
	</cffunction>
	<cffunction name="getMeldForumsEventManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldForumsEventManager>
	</cffunction>

	<cffunction name="setMeldForumsRequestManager" access="public" returntype="any" output="false">
		<cfargument name="MeldForumsRequestManager" type="any" required="true">
		<cfset variables.MeldForumsRequestManager = arguments.MeldForumsRequestManager>
	</cffunction>
	<cffunction name="getMeldForumsRequestManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldForumsRequestManager>
	</cffunction>
</cfcomponent>