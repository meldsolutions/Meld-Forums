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

		<cfset var forumService		= getBeanFactory().getBean('forumService') />
		<cfset var subscribeService	= getBeanFactory().getBean('subscribeService') />
		<cfset var mmUtility		= getBeanFactory().getBean("mmUtility") />
		<cfset var aIntercept		= rc.MFBean.getIntercept() />
		<cfset var subType			= aIntercept[2] />
		<cfset var subMode			= aIntercept[3] />
		<cfset var beanID			= aIntercept[4] />
		<cfset var success			= true />

		<cfif not mmUtility.isUUID(beanID)>
			<cflocation url="#rc.MFBean.getForumWebRoot()#?ecode=2501" addtoken="false" />
		<cfelseif not $.currentUser().isLoggedIn()>
			<cflocation url="#rc.MFBean.getForumWebRoot()##$.siteConfig('loginURL')#&returnUrl=#cgi.http_referer#" addtoken="false" />
		</cfif>
	
		<cfswitch expression="#subType#">
			<cfcase value="forum">
				<cfif subMode eq "remove">
					<cfset subscribeService.doUnSubscribeToForum( $.currentUser().getUserID(),beanID ) />
				<cfelse>
					<cfset subscribeService.doSubscribeToForum( $.currentUser().getUserID(),beanID ) />
				</cfif>
			</cfcase>
			<cfcase value="thread">
				<cfif subMode eq "remove">
					<cfset success = subscribeService.doUnSubscribeToThread( $.currentUser().getUserID(),beanID ) />
					<cfif not success>
						<cfset rc.forumBean = forumService.getForumByThreadID( beanID ) />
					</cfif>						
				<cfelse>
					<cfset subscribeService.doSubscribeToThread( $.currentUser().getUserID(),beanID ) />
				</cfif>
			</cfcase>
			<cfcase value="post">
				<cfif subMode eq "remove">
					<cfset success = subscribeService.doUnSubscribeToThread( $.currentUser().getUserID(),beanID ) />
				<cfelse>
					<cfset subscribeService.doSubscribeToThread( $.currentUser().getUserID(),beanID ) />
				</cfif>
			</cfcase>
		</cfswitch>

		<cfset rc.success = success />

		<cfif len(cgi.http_referer) and not findnocase("/subscribe/",cgi.http_referer)>
			<cflocation url="#cgi.http_referer#" addtoken="false" />
		</cfif>
		
		<cfset rc.mode = subMode />
	</cffunction>
</cfcomponent>