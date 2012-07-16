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
<cfcomponent>
	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="fw" type="struct" required="false" default="#StructNew()#">
		<cfset variables.fw = fw />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset rc.settingsBean		= getBeanFactory().getBean("MeldForumsSettingsManager").getSiteSettings( rc.$.event().getValue("siteID") ) />
		<cfset rc.themeBean			= rc.settingsBean.getThemeBean() />
		<cfset rc.pluginConfig 		= fw.getPluginConfig() />
		<cfset rc.mmEvents			= fw.getBeanFactory().getBean("MeldForumsEventManager")>
		<cfset rc.mmRBF				= fw.getBeanFactory().getBean("mmResourceBundle")>

		<cfset rc.themeDirectory	= getThemeWebRoot(rc)>

	</cffunction>

	<cffunction name="getThemeWebRoot" access="public" returntype="string" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfreturn getPluginWebRoot(rc) & "/themes/" & rc.themeBean.getPackageName() & "/">
	</cffunction>

	<cffunction name="getPluginWebRoot" access="public" returntype="string" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfreturn "#rc.$.globalConfig().getContext()#/plugins/#rc.pluginConfig.getDirectory()#">
	</cffunction>

	<cffunction name="getBeanFactory" access="public" returntype="any" output="false">
		<cfreturn variables.fw.getBeanFactory()>
	</cffunction>
</cfcomponent>