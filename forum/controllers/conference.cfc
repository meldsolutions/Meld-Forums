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

		<cfset doGetConferences( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="select" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset doGetConferences( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doGetConferences" returntype="void" access="private" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var forumService			= getBeanFactory().getBean("forumService") />
		<cfset var qConferenceTree		= "" />
		<cfset var aConferences			= ArrayNew(1) />
		<cfset var aForums				= ArrayNew(1) />
		<cfset var aForumSet			= ArrayNew(1) />
		<cfset var iiX					= "" />
		<cfset var sArgs				= StructNew() />
		<cfset var pluginEvent 			= createEvent(rc) />
		<cfset var idx					= 0 />
		<cfset var ConferenceBean		= "" />
	
		<cfif len( rc.meldForumsBean.getIdent() )>
			<cfset idx = rereplace( rc.meldForumsBean.getIdent(),"[^\d]","","all" ) />

		</cfif>


		<!--- friendlyname ident --->
		<cfif len( rc.meldForumsBean.getIdent() ) and isNumeric(idx) >
			<cfset pluginEvent.setValue("ident",rc.meldForumsBean.getIdent() ) />
			<cfset pluginEvent.setValue("idx",idx ) />
			<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>

			<cfif pluginEvent.valueExists('aConferences')>
				<cfset aConferences	= pluginEvent.getValue('aConferences') />
			<cfelse>
				<cfset sArgs.idx = idx />
				<cfset sArgs.isActive = 1 />
				<cfset sArgs.doForums = 1 />
				<cfset sArgs.siteID = rc.siteID />
				<cfif StructKeyExists(rc.params,"conferenceID") and len( rc.params.conferenceID )>
					<cfset sArgs.conferenceID = rc.params.conferenceID />
				</cfif>


				<cfset aConferences	= conferenceService.getConferences( argumentCollection=sArgs ) />
			</cfif>
		<cfelseif StructKeyExists(rc,"params")>
			<!--- id array --->
			<cfif StructKeyExists(rc.params,"conferenceIDList") and len( rc.params.conferenceIDList )>

				<cfset pluginEvent.setValue("conferenceIDList",rc.params.conferenceIDList) />
				<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>

				<cfif pluginEvent.valueExists('aConferences')>
					<cfset aConferences	= pluginEvent.getValue('aConferences') />
				<cfelse>
					<cfset sArgs.idList = rc.params.conferenceIDList />
					<cfset sArgs.isActive = 1 />
					<cfset sArgs.doForums = 1 />
					<cfset sArgs.siteID = rc.siteID />
					<cfset aConferences	= conferenceService.getConferences( argumentCollection=sArgs ) />
				</cfif>

			<!--- get conference --->
			<cfelseif StructKeyExists(rc.params,"conferenceID") and len( rc.params.conferenceID )>
				<cfset pluginEvent.setValue("conferenceID",rc.params.conferenceID) />
				<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>

				<cfif pluginEvent.valueExists('aConferences')>
					<cfset aConferences	= pluginEvent.getValue('aConferences') />
				<cfelse>
					<cfset ConferenceBean	= conferenceService.getConference( rc.params.conferenceID ) />
					<cfset ArrayAppend(aConferences,ConferenceBean) />
				</cfif>
			<!--- get all --->
			<cfelse>
				<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>
				<cfif pluginEvent.valueExists('aConferences')>
					<cfset aConferences	= pluginEvent.getValue('aConferences') />
				<cfelse>
					<cfset sArgs.doForums = 1 />
					<cfset sArgs.siteID = rc.siteID />
					<cfset aConferences	= conferenceService.getConferences(argumentCollection=sArgs) />
				</cfif>
			</cfif>
			<!--- get all --->
		<cfelse>
			<cfset announceEvent(rc,"onMeldForumsGetConferences",pluginEvent)>

			<cfif pluginEvent.valueExists('aConferences')>
				<cfset aConferences	= pluginEvent.getValue('aConferences') />
			<cfelse>
				<cfset aConferences	= conferenceService.getConferences() />
			</cfif>
		</cfif>

		<cfset rc.aConferences = aConferences />
	</cffunction>
</cfcomponent>