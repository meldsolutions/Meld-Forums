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

<cfset local.event.setValue('conferenceBean',local.conferenceBean) />
<cfset local.event.setValue('columnsNew',0) />
<cfset local.event.setValue('context',"conference" ) />

<cfset local.eventContent['conference'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceRender",local.event ) />
<cfif not len(local.eventContent['conference'])>
	<cfset local.eventContent['description'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceDescriptionRender",local.event ) />
	<cfset local.eventContent['columns'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsConferenceColumnsRender",local.event ) />
</cfif>

<cfset local.columns = iif( local.event.getValue('columnsNew') gt 0,de(local.event.getValue('columnsNew')),de(6) ) />
</cfsilent>