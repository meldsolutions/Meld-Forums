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

<cfset local.event.setValue('threadBean',local.threadBean) />
<cfset local.event.setValue('context',"thread" ) />

<cfset local.eventContent['threadheader'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadHeaderRender",local.event ) />
<cfif not len(local.eventContent['threadheader'])>
	<cfset local.eventContent['threaddescription'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadDescriptionRender",local.event ) />
	<cfset local.eventContent['threadadminmessage'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadAdministratorMessageRender",local.event ) />
	<cfset local.eventContent['threadclosed'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsThreadClosedRender",local.event ) />
</cfif>
</cfsilent>