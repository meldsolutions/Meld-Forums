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
<cfcomponent displayname="MuraManager" output="false" hint="interfaces with Mura Service Factory">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" returntype="MuraManager" access="public">
		<cfreturn this>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getServiceFactory" returntype="any" access="public">
		<cfreturn variables.instance.ServiceFactory>
	</cffunction>
	<cffunction name="setServiceFactory" returntype="void" access="public">
		<cfargument name="ServiceFactory" type="any" required="true">
		<cfset variables.instance.ServiceFactory = arguments.ServiceFactory>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getRBFactory" access="public" returntype="any" output="false">
		<cfreturn getServiceFactory().getBean("resourceBundleFactory")>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getBean" returntype="any" access="public">
		<cfargument name="beanID" type="string" required="true">
		<cfreturn getServiceFactory().getBean(arguments.beanID)>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getCacheFactory" access="public" returntype="any" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfreturn getSettingsManager(arguments.siteID).getCacheFactory()>
	</cffunction>
	<!--- --------------------------------------------------------------------------- --->
	<cffunction name="getSettingsManager" access="public" returntype="any" output="false">
		<cfargument name="siteID" type="string" required="true">
		<cfreturn getBean("settingsManager").getSite(arguments.siteID)>
	</cffunction>
</cfcomponent>