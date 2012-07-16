<!---
This file is part of the Meld Manager application.

Meld Manager is licensed under the GPL 2.0 license
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
<cfcomponent displayname="bcBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean" hint="BreadCrumb Bean">
	<cfproperty name="ConferenceID" type="uuid" default="" required="true" maxlength="35" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="bcBean" output="false">
		<cfargument name="label" type="string" required="true" />
		<cfargument name="url" type="string" required="false" default="" />

		<cfset setLabel( arguments.label ) />
		<cfset setURL( arguments.url ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="void" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="setLabel" access="public" returntype="void" output="false">
		<cfargument name="Label" type="string" required="yes"/>
		<cfset variables.instance.label = arguments.Label />
	</cffunction>
	<cffunction name="getLabel" access="public" returntype="string" output="false" >
		<cfreturn variables.instance.label />
	</cffunction>

	<cffunction name="setURL" access="public" returntype="void" output="false">
		<cfargument name="URL" type="string" required="yes"/>
		<cfset variables.instance.URL = arguments.URL />
	</cffunction>
	<cffunction name="getURL" access="public" returntype="string" output="false" >
		<cfreturn variables.instance.URL />
	</cffunction>
</cfcomponent>