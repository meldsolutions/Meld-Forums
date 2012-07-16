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
<cfcomponent displayname="MeldForumsEventManager" hint="Meld Event" output="false">
	<cfset variables.values		= StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldForumsEventManager">
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="createEvent" access="public" returntype="any" output="false">
		<cfargument name="$" type="struct" required="false" default="#StructNew()#">

		<cfset var pluginEvent 		= createObject("component","mura.MuraScope") />
		<cfset var ident			= "" />

		<cfset pluginEvent= pluginEvent.init( StructNew() ).getEvent() />
		<cfset pluginEvent.setValue("siteID", $.event().getValue('siteID') ) />

		<cfreturn pluginEvent />
	</cffunction>	
	
	<cffunction name="announceEvent" access="public" returntype="void" output="false">
		<cfargument name="$" type="struct" required="false" default="#StructNew()#">
		<cfargument name="name" type="string" required="true">
		<cfargument name="event" type="any" required="true">

		<cfset $.getBean('pluginManager').announceEvent(arguments.name,arguments.event) />
	</cffunction>	
	
	<cffunction name="renderEvent" access="public" returntype="any" output="false">
		<cfargument name="$" type="struct" required="false" default="#StructNew()#">
		<cfargument name="name" type="string" required="true">
		<cfargument name="event" type="any" required="true">

		<cfreturn $.getBean('pluginManager').renderEvent(arguments.name,arguments.event) />
	</cffunction>	
</cfcomponent>