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
<cfcomponent displayname="MuraDisplayObjectManager" hint="Interfaces with PluginManager to add/remove/update Display Objects">

	<cffunction name="init" access="public" output="false" returntype="MuraDisplayObjectManager">
		<cfreturn this />
	</cffunction>

	<cffunction name="registerDisplayObject" output="false" returntype="any" access="public" description="Adds a new Mura Display Object (checks to see if the Object already exists)">
		<cfargument name="moduleID" type="string" required="true" />
		<cfargument name="name" type="string" required="true" />
		<cfargument name="objectID" type="string" required="false" default="#CreateUUID()#" />
		<cfargument name="location" type="string" required="false" />
		<cfargument name="displayObjectFile" type="string" required="false" />
		<cfargument name="component" type="string" required="false" />
		<cfargument name="displayMethod" type="string" required="false" />
		<cfargument name="docache" type="boolean" required="false" />
		<cfargument name="displayTypeBean" type="any" required="false" />
		
		<cfset var displayObjectExists	= checkIfDisplayObjectExists( argumentCollection=arguments ) />		
		<cfset var displayObjectBean	= getMuraScope().getPluginManager().getDisplayObjectBean()>
		
		<!--- return if already exists --->
		<cfif displayObjectExists>
			<cfreturn false>
		</cfif>

		<cfset session.MeldForumsAppreinit = true />

		<cfset displayObjectBean.setModuleID( arguments.moduleID ) />
		<cfset displayObjectBean.setName( arguments.name ) />
		<cfif isDefined("arguments.objectID")>
			<cfset displayObjectBean.setObjectID( arguments.objectID ) />
		</cfif>
		<cfif isDefined("arguments.location")>
			<cfset displayObjectBean.setLocation( arguments.location ) />
		</cfif>
		<cfif isDefined("arguments.displayObjectFile")>
			<cfset displayObjectBean.setDisplayObjectFile( arguments.displayObjectFile ) />
		<cfelseif isDefined("arguments.component")>
			<cfset displayObjectBean.setDisplayObjectFile( arguments.component ) />
		</cfif>
		<cfif isDefined("arguments.displayMethod")>
			<cfset displayObjectBean.setDisplayMethod( arguments.displayMethod ) />
		</cfif>
		<cfif isDefined("arguments.cache")>
			<cfset displayObjectBean.setDoCache( arguments.cache ) />
		<cfelse>
			<cfset displayObjectBean.setDoCache( false ) />
		</cfif>

		<cfset displayObjectBean.save() />

		<cfif isDefined("arguments.displayTypeBean") and not len( arguments.displayTypeBean.getObjectID() )>
			<cfset arguments.displayTypeBean.setObjectID( displayObjectBean.getObjectID() ) />
			<cfset getDisplayTypeService().updateDisplayType( arguments.displayTypeBean ) />
		</cfif>

		<cfreturn displayObjectBean>
	</cffunction>

	<cffunction name="deleteDisplayObjectByObjectID" output="false" returntype="void" access="public" description="deletes a Mura Display Object by objectID">
		<cfargument name="moduleID" type="string" required="true" />
		<cfargument name="objectID" type="string" required="true" />
		
		<cfset var qDo			= "" />		
		
		<cfquery name="qDo" datasource="#getMuraScope().globalConfig().getDatasource()#" username="#getMuraScope().globalConfig().getDBUserName()#" password="#getMuraScope().globalConfig().getDBPassword()#">
			DELETE FROM
				tplugindisplayobjects
			WHERE
				moduleID = <cfqueryparam value="#arguments.moduleID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				objectID = <cfqueryparam value="#arguments.objectID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
	</cffunction>

	<cffunction name="deleteDisplayObjectByName" output="false" returntype="void" access="public" description="deletes a Mura Display Object by name">
		<cfargument name="moduleID" type="string" required="true" />
		<cfargument name="name" type="string" required="true" />
		
		<cfset var qDo			= "" />		
		
		<cfquery name="qDo" datasource="#getMuraScope().globalConfig().getDatasource()#" username="#getMuraScope().globalConfig().getDBUserName()#" password="#getMuraScope().globalConfig().getDBPassword()#">
			DELETE FROM
				tplugindisplayobjects
			WHERE
				moduleID = <cfqueryparam value="#arguments.moduleID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				name = <cfqueryparam value="#arguments.name#" CFSQLType="cf_sql_varchar" maxlength="100" />
		</cfquery>
	</cffunction>

	<cffunction name="checkIfDisplayObjectExists" output="false" returntype="boolean" access="public" description="checks to see if a Mura Display Object exists">
		<cfargument name="moduleID" type="string" required="true" />
		<cfargument name="displayObjectFile" type="string" required="false" />
		<cfargument name="component" type="string" required="false" />
		<cfargument name="displayTypeBean" type="any" required="false" />
		
		<cfset var qCheck = "" />
		
		<cfquery name="qCheck" datasource="#getMuraScope().globalConfig().getDatasource()#" username="#getMuraScope().globalConfig().getDBUserName()#" password="#getMuraScope().globalConfig().getDBPassword()#">
			SELECT
			<cfif getMuraScope().globalConfig().getDBType() eq "MSSQL">
				TOP 1
			</cfif>
				objectID
			FROM
				tplugindisplayobjects
			WHERE
				moduleID = <cfqueryparam value="#arguments.moduleID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				<cfif structKeyExists(arguments,"displayObjectFile")>
					displayObjectFile = <cfqueryparam value="#arguments.displayObjectFile#" CFSQLType="cf_sql_varchar" maxlength="100" />
				<cfelse>
					displayObjectFile = <cfqueryparam value="#arguments.component#" CFSQLType="cf_sql_varchar" maxlength="100" />
				</cfif>
			<cfif getMuraScope().globalConfig().getDBType() eq "MYSQL">
				LIMIT 1
			</cfif>
		</cfquery>
		
		<cfif qCheck.recordcount>
			<cfif isDefined("arguments.displayTypeBean") and not len( arguments.displayTypeBean.getObjectID() )>
				<cfset arguments.displayTypeBean.setObjectID( qCheck.objectID ) />
				<cfset getDisplayTypeService().updateDisplayType( arguments.displayTypeBean ) />
			</cfif>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="setMuraScope" access="public" returntype="any" output="false">
		<cfargument name="MuraScope" type="any" required="true">
		<cfset variables.MuraScope = arguments.MuraScope>
	</cffunction>
	<cffunction name="getMuraScope" access="public" returntype="any" output="false">
		<cfreturn variables.MuraScope>
	</cffunction>

	<cffunction name="setDisplayTypeService" access="public" returntype="any" output="false">
		<cfargument name="DisplayTypeService" type="any" required="true">
		<cfset variables.DisplayTypeService = arguments.DisplayTypeService>
	</cffunction>
	<cffunction name="getDisplayTypeService" access="public" returntype="any" output="false">
		<cfreturn variables.DisplayTypeService>
	</cffunction>	
</cfcomponent>