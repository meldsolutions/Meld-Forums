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
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="fw" type="struct" required="false" default="#StructNew()#">
		<cfset variables.fw = fw />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var mmUtility	= getBeanFactory().getBean('mmUtility') />
		<cfset var bean			= "" />
		<cfset var MFEvent		= rc.mmEvents.createEvent( rc.$ ) />
		<cfset var cleanEvent	= "" />

		<cfif not StructKeyExists(url,"event")>
			<cfif len(cgi.http_referer)>	
				<cflocation url="#cgi.http_referer#?ecode=2500" addtoken="false" />
			<cfelse>
				<cflocation url="#rc.MFBean.getForumWebRoot()#" addtoken="false" />
			</cfif>
			<cfreturn />
		</cfif>
		
		<cfset cleanEvent	= rereplace(url.event,"[^[:alnum:]]","","all") />
		<cfset MFEvent.setValue('event',cleanEvent) />
		<cfset MFEvent.setValue('MFBean',rc.MFBean) />
		<cfset MFEvent.setValue('relocate',true) />
		<cfset MFEvent.setValue('relocateURL',"") />
		
		<cfloop collection="#url#" item="iiX">
			<cfif isSimpleValue(url[iiX]) and left(url[iiX],1) eq "_">
				<cfset MFEvent.setValue(iiX,url[iiX]) />
			</cfif>
		</cfloop>
		
		<cfif StructKeyExists(url,"type") and  StructKeyExists(url,"id") and mmUtility.isUUID(url.id)>
			<cfset MFEvent.setValue('type',url.type) />
			<cfset MFEvent.setValue('id',url.id) />

			<cfswitch expression="#url.type#">
				<cfcase value="conference">
					<cfif rc.$.event().valueExists('conferenceBean')>
						<cfset MFEvent.setValue('conferenceBean',rc.$.event().getValue('conferenceBean')  ) />
					<cfelse>
						<cfset bean = getBeanFactory().getBean('conferenceService').getBeanByAttributes(conferenceID=url.id) />
						<cfif bean.beanExists()>
							<cfset MFEvent.setValue('conferenceBean',bean) />
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="forum">
					<cfif rc.$.event().valueExists('forumBean')>
						<cfset MFEvent.setValue('forumBean',rc.$.event().getValue('forumBean')  ) />
					<cfelse>
						<cfset bean = getBeanFactory().getBean('forumService').getBeanByAttributes(forumID=url.id) />
						<cfif bean.beanExists()>
							<cfset MFEvent.setValue('forumBean',bean) />
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="thread">
					<cfif rc.$.event().valueExists('threadBean')>
						<cfset MFEvent.setValue('threadBean',rc.$.event().getValue('threadBean') ) />
					<cfelse>
						<cfset bean = getBeanFactory().getBean('threadService').getBeanByAttributes(threadID=url.id) />
						<cfif bean.beanExists()>
							<cfset MFEvent.setValue('threadBean',bean) />
						</cfif>
					</cfif>
				</cfcase>
				<cfcase value="post">
					<cfif rc.$.event().valueExists('postBean')>
						<cfoutput>YES!</cfoutput><cfabort>
						<cfset MFEvent.setValue('postBean',rc.$.event().getValue('postBean') ) />
					<cfelse>
						<cfset bean = getBeanFactory().getBean('postService').getBeanByAttributes(postID=url.id) />
						<cfif bean.beanExists()>
							<cfset MFEvent.setValue('postBean',bean) />
						</cfif>
					</cfif>
				</cfcase>
			</cfswitch>
		</cfif>

		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsDo#cleanEvent#",MFEvent ) />

		<cfif MFEvent.getValue('relocate')>
			<cfif len(MFEvent.getValue('relocateURL'))>	
				<cflocation url="#MFEvent.getValue('relocateURL')#" addtoken="false" />
			<cfelseif len(cgi.http_referer)>	
				<cflocation url="#cgi.http_referer#" addtoken="false" />
			<cfelse>
				<cflocation url="#rc.MFBean.getForumWebRoot()#" addtoken="false" />
			</cfif>
		</cfif>
		
		<cfset rc.MFEvent = MFEvent />
	</cffunction>

</cfcomponent>