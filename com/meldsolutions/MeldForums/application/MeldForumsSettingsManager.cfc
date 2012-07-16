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
<cfcomponent displayname="MeldForumsSettingsManager" hint="General settings for MeldForums" output="false">

	<cfset variables.instance = StructNew()>

	<cffunction name="init" access="public" output="false" returntype="MeldForumsSettingsManager">
		<cfreturn this/>
	</cffunction>

	<cffunction name="getAllSettings" returntype="array" access="public" output="false">
		<cfargument name="siteID" type="string" required="false" />

		<cfif not StructKeyExists(variables.instance,"Settings")>
			<cfset setAllSettings()>
		</cfif>

		<cfif isDefined("arguments.siteID")>
			<cfreturn getSiteSettings(arguments.siteID)>
		<cfelse>
			<cfreturn variables.instance.Settings>
		</cfif>
	</cffunction>

	<cffunction name="setAllSettings" returntype="void" access="public" output="false">
		<cfset var iiX = "">
		
		<cfset variables.instance.Settings = getSettingsService().getInitSettings()>
		<cfset variables.instance.SettingsKey = StructNew()>

		<cflock type="exclusive" timeout="30">
			<cfloop from="1" to="#arrayLen(variables.instance.Settings)#" index="iiX">
				<cfset variables.instance.SettingsKey[variables.instance.Settings[iiX].getSiteID()] = iiX>
			</cfloop>
		</cflock>
	</cffunction>

	<cffunction name="getUserFromCache" returntype="any" access="public" output="false">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="siteID" type="string" required="false" />

		<cfset var settingsBean = getSiteSettings( arguments.siteID )>
		<cfset var userCache	= settingsBean.getUserCache() />
		
		<cfreturn userCache.getUser( arguments.userID ) />
	</cffunction>

	<cffunction name="getSiteSettings" returntype="any" access="public" output="false">
		<cfargument name="siteID" type="string" required="false" />

		<cfset settingsKey = "">

		<cfif not StructKeyExists(variables.instance,"Settings")>
			<cfset setAllSettings()>
		</cfif>

		<cfif StructKeyExists(variables.instance.SettingsKey,arguments.siteID)>
			<cfset settingsKey =  variables.instance.SettingsKey[arguments.siteID]>
			<cfreturn variables.instance.Settings[settingsKey]>
		<cfelse>
			<cfset settingsKey = variables.instance.SettingsKey["default"]>
			<cfreturn variables.instance.Settings[settingsKey]>
		</cfif>

		<cfreturn "">
	</cffunction>

	<cffunction name="setSettingsService" access="public" returntype="any" output="false">
		<cfargument name="SettingsService" type="any" required="true">
		<cfset variables.SettingsService = arguments.SettingsService>
	</cffunction>
	<cffunction name="getSettingsService" access="public" returntype="any" output="false">
		<cfreturn variables.SettingsService>
	</cffunction>
</cfcomponent>