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
<cfcomponent extends="mura.plugin.pluginGenericEventHandler">

	<cffunction name="renderPluginDisplayObject" access="private" returntype="any" output="false">
		<cfargument name="object" type="string" required="true" />
		<cfargument name="event" type="component" required="true" />
		
		<cfset var rValue = super(argumentCollection=arguments) />
		<cfreturn rValue /> 
	</cffunction>

	<cffunction name="onApplicationLoad">
		<cfargument name="$">
		<cfset variables.pluginConfig.addEventHandler(this)>
	</cffunction>

	<cffunction name="onSiteLoginSuccess">
		<cfargument name="$">

		<cfset var app 							= variables.pluginConfig.getApplication() />
		<cfset var beanFactory					= app.getValue('beanFactory') />
		<cfset var meldForumsSettingsManager	= "" />
		<cfset var settingsBean					= "" />

		<cfif isSimpleValue(beanFactory)>
			<cfreturn />
		</cfif>

		<cfset meldForumsSettingsManager		= beanFactory.getBean('MeldForumsSettingsManager') />
		
		<cfset settingsBean = meldForumsSettingsManager.getSiteSettings( $.event('siteID') ) />

		<cfif isSimpleValue(settingsBean)>
			<cfreturn />
		</cfif>
		<cfif structKeyExists(session,"MeldForumsUser")>
			<cfset structDelete(session,"MeldForumsUser") />
		</cfif>		
		<cfset settingsBean.getUserCache().purgeUser( $.currentUser().getUserID() ) />
	</cffunction>

	<cffunction name="onRenderStart">
		<cfargument name="$">

		<cfset var app 					= variables.pluginConfig.getApplication() />
		<cfset var beanFactory			= app.getValue('beanFactory') />
		<cfset var meldForumsManager	= "" />
		<cfset var isForums				= false />

		<cfif isSimpleValue(beanFactory)>
			<cfreturn />
		</cfif>

		<cfset meldForumsManager		= beanFactory.getBean('MeldForumsManager') />
		<cfset isForums					= meldForumsManager.hasForums( $,variables.pluginConfig.getModuleID(),$.content().getContentHistID() ) />

		<cfif not isForums>
			<cfreturn>
		</cfif>
	</cffunction>

	<!--- SETS "MeldForumsForumObjectID" into the event scope; useful for $.dspObject('plugin','...') --->
	<cffunction name="onMeldForumsGetForumObjectID">
		<cfargument name="$">

		<cfset getObjectID($) />
	</cffunction>

	<cffunction name="getObjectID" returntype="string" access="private">
		<cfargument name="$">
		<cfset var qCheck = "" />		
		
		<cfquery name="qCheck" datasource="#$.globalConfig().getDatasource()#" username="#$.globalConfig().getDBUserName()#" password="#$.globalConfig().getDBPassword()#">
			SELECT
				objectID
			FROM
				tplugindisplayobjects
			WHERE
				moduleID = <cfqueryparam value="#variables.pluginConfig.getModuleID()#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				displayObjectFile = <cfqueryparam value="forum.display.displayManager" CFSQLType="cf_sql_varchar" maxlength="100" />
		</cfquery>

		<cfif qCheck.RecordCount>
			<cfset $.event('MeldForumsForumObjectID',qCheck.objectID) />
		</cfif>
	</cffunction>

	<cffunction name="getFrameworkConfig" output="false">
		<cfset var framework = StructNew() />

		<cfinclude template="../../frameworkConfig.cfm" />
		<cfreturn framework />		
	</cffunction>

</cfcomponent>