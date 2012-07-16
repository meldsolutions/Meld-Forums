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

<cfset local.event.setValue('context',local.context ) />
<cfset local.event.setValue('data',local ) />

<cfset local.eventContent['profilebuttonbarupperleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsProfileButtonbarULRender",local.event ) />
<cfset local.eventContent['profilebuttonbarupperright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsProfileButtonbarURRender",local.event ) />
<cfset local.eventContent['profilefooter'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsPageFooterRender",local.event ) />
<cfset local.eventContent['profilebuttonbarlowerleft'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsProfileButtonbarLLRender",local.event ) />
<cfset local.eventContent['profilebuttonbarlowerright'] = rc.mmEvents.renderEvent( rc.$,"onMeldForumsProfileButtonbarLRRender",local.event ) />
</cfsilent>
