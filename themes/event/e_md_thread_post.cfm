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
<cfsilent>
<cfparam name="local.eventContent" default="#StructNew()#" > 
<cfset local.event = rc.mmEvents.createEvent( rc.$ ) />

<cfset local.event.setValue('postBean',local.postBean) />
<cfset local.event.setValue('userBean',local.PostUserBean ) />
<cfset local.event.setValue('avatarSize',"small" ) />
<cfset local.event.setValue('context',"post" ) />

<cfset local.eventContent['threadpost'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostRender",local.event ) />
<cfif not len(local.eventContent['threadpost'])>
	<cfset local.eventContent['avatar'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsAvatarRender",local.event ) />
	<cfset local.eventContent['postinfo'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostInformationRender",local.event ) />

	<cfset local.eventContent['postinfo'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostInformationRender",local.event ) />
	<cfset local.eventContent['postdisabled'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostDisabledRender",local.event ) />
	<cfset local.eventContent['postmessage'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostMessageRender",local.event ) />
	<cfset local.eventContent['postupdated'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostUpdatedRender",local.event ) />
	<cfset local.eventContent['postmoderated'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostModeratedRender",local.event ) />
	<cfset local.eventContent['postsignature'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostSignatureRender",local.event ) />
	<cfif len( local.postBean.getAttachmentID() )>
		<cfset local.eventContent['postattachment'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostAttachmentRender",local.event ) />
	</cfif>

	<cfset local.eventContent['postposition'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostPositionRender",local.event ) />
	<cfset local.eventContent['postbuttonbarupperleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostButtonBarULRender",local.event ) />
	<cfset local.eventContent['postbuttonbarupperright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostButtonBarURRender",local.event ) />
	<cfset local.eventContent['postbuttonbarlowerleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostButtonBarLLRender",local.event ) />
	<cfset local.eventContent['postbuttonbarlowerright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPostButtonBarLRRender",local.event ) />
</cfif>
</cfsilent>