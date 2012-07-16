<!---This file is part of the Meld Forums application.

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
<cfcomponent displayname="SettingsGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="SettingsGateway">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="dsnusername" type="string" required="true">
		<cfargument name="dsnpassword" type="string" required="true">
		<cfargument name="dsnprefix" type="string" required="true">
		<cfargument name="dsntype" type="string" required="true">

		<cfset variables.dsn = arguments.dsn>
		<cfset variables.dsnusername = arguments.dsnusername>
		<cfset variables.dsnpassword = arguments.dsnpassword>
		<cfset variables.dsnprefix = arguments.dsnprefix>
		<cfset variables.dsntype = arguments.dsntype>

		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SettingsID" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="PermissionGroups" type="string" required="false" />
		<cfargument name="ThemeID" type="string" required="false" />
		<cfargument name="ThreadsPerPage" type="numeric" required="false" />
		<cfargument name="PostsPerPage" type="numeric" required="false" />
		<cfargument name="SubscriptionLimit" type="numeric" required="false" />
		<cfargument name="AllowedExtensions" type="string" required="false" />
		<cfargument name="DeniedExtensions" type="string" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarResizeType" type="string" required="false" />
		<cfargument name="AvatarQualityType" type="string" required="false" />
		<cfargument name="AvatarAspectType" type="string" required="false" />
		<cfargument name="AvatarCropType" type="string" required="false" />
		<cfargument name="UserCacheSize" type="numeric" required="false" />
		<cfargument name="ResetAvatar" type="boolean" required="false" />
		<cfargument name="DoInit" type="boolean" required="false" />
		<cfargument name="ActiveWithinMinutes" type="numeric" required="false" />
		<cfargument name="SearchMode" type="string" required="false" />
		<cfargument name="TempDir" type="string" required="false" />
		<cfargument name="BaseTempDir" type="string" required="false" />
		<cfargument name="URLKey" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mf_settings
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"SettingsID") and len(arguments.SettingsID)>
				AND SettingsID = <cfqueryparam value="#arguments.SettingsID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"SiteID") and len(arguments.SiteID)>
				AND SiteID = <cfqueryparam value="#arguments.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsMaster") and len(arguments.IsMaster)>
				AND IsMaster = <cfqueryparam value="#arguments.IsMaster#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"PermissionGroups") and len(arguments.PermissionGroups)>
				AND PermissionGroups = <cfqueryparam value="#arguments.PermissionGroups#" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ThemeID") and len(arguments.ThemeID)>
				AND ThemeID = <cfqueryparam value="#arguments.ThemeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ThreadsPerPage") and len(arguments.ThreadsPerPage)>
				AND ThreadsPerPage = <cfqueryparam value="#arguments.ThreadsPerPage#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"PostsPerPage") and len(arguments.PostsPerPage)>
				AND PostsPerPage = <cfqueryparam value="#arguments.PostsPerPage#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"SubscriptionLimit") and len(arguments.SubscriptionLimit)>
				AND SubscriptionLimit = <cfqueryparam value="#arguments.SubscriptionLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AllowedExtensions") and len(arguments.AllowedExtensions)>
				AND AllowedExtensions = <cfqueryparam value="#arguments.AllowedExtensions#" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DeniedExtensions") and len(arguments.DeniedExtensions)>
				AND DeniedExtensions = <cfqueryparam value="#arguments.DeniedExtensions#" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments,"FilesizeLimit") and len(arguments.FilesizeLimit)>
				AND FilesizeLimit = <cfqueryparam value="#arguments.FilesizeLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarID") and len(arguments.AvatarID)>
				AND AvatarID = <cfqueryparam value="#arguments.AvatarID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarResizeType") and len(arguments.AvatarResizeType)>
				AND AvatarResizeType = <cfqueryparam value="#arguments.AvatarResizeType#" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarQualityType") and len(arguments.AvatarQualityType)>
				AND AvatarQualityType = <cfqueryparam value="#arguments.AvatarQualityType#" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarAspectType") and len(arguments.AvatarAspectType)>
				AND AvatarAspectType = <cfqueryparam value="#arguments.AvatarAspectType#" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarCropType") and len(arguments.AvatarCropType)>
				AND AvatarCropType = <cfqueryparam value="#arguments.AvatarCropType#" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments,"UserCacheSize") and len(arguments.UserCacheSize)>
				AND UserCacheSize = <cfqueryparam value="#arguments.UserCacheSize#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ResetAvatar") and len(arguments.ResetAvatar)>
				AND ResetAvatar = <cfqueryparam value="#arguments.ResetAvatar#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoInit") and len(arguments.DoInit)>
				AND DoInit = <cfqueryparam value="#arguments.DoInit#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ActiveWithinMinutes") and len(arguments.ActiveWithinMinutes)>
				AND ActiveWithinMinutes = <cfqueryparam value="#arguments.ActiveWithinMinutes#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"SearchMode") and len(arguments.SearchMode)>
				AND SearchMode = <cfqueryparam value="#arguments.SearchMode#" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments,"TempDir") and len(arguments.TempDir)>
				AND TempDir = <cfqueryparam value="#arguments.TempDir#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"BaseTempDir") and len(arguments.BaseTempDir)>
				AND BaseTempDir = <cfqueryparam value="#arguments.BaseTempDir#" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments,"URLKey") and len(arguments.URLKey)>
				AND URLKey = <cfqueryparam value="#arguments.URLKey#" CFSQLType="cf_sql_varchar" maxlength="10" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
				AND RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			<!---^^VALUES-END^^--->
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SettingsID" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="PermissionGroups" type="string" required="false" />
		<cfargument name="ThemeID" type="string" required="false" />
		<cfargument name="ThreadsPerPage" type="numeric" required="false" />
		<cfargument name="PostsPerPage" type="numeric" required="false" />
		<cfargument name="SubscriptionLimit" type="numeric" required="false" />
		<cfargument name="AllowedExtensions" type="string" required="false" />
		<cfargument name="DeniedExtensions" type="string" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarResizeType" type="string" required="false" />
		<cfargument name="AvatarQualityType" type="string" required="false" />
		<cfargument name="AvatarAspectType" type="string" required="false" />
		<cfargument name="AvatarCropType" type="string" required="false" />
		<cfargument name="UserCacheSize" type="numeric" required="false" />
		<cfargument name="ResetAvatar" type="boolean" required="false" />
		<cfargument name="DoInit" type="boolean" required="false" />
		<cfargument name="ActiveWithinMinutes" type="numeric" required="false" />
		<cfargument name="SearchMode" type="string" required="false" />
		<cfargument name="TempDir" type="string" required="false" />
		<cfargument name="BaseTempDir" type="string" required="false" />
		<cfargument name="URLKey" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		<cfset var themeBean = "" />
		
		<cfloop from="1" to="#qList.recordCount#" index="iiX">
			<cfset tmpObj = createObject("component","SettingsBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfif len( tmpObj.getThemeID() )>
				<cfset themeBean = getThemeService().getTheme( tmpObj.getThemeID() ) />
			<cfelse>
				<cfset themeBean = getThemeService().getTheme( '00000000-0000-0000-0000000000000001' ) />
			</cfif>
			<cfset tmpObj.setSettingsService( getSettingsService() ) />
			<cfset tmpObj.setThemeBean( themeBean ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SettingsID" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="PermissionGroups" type="string" required="false" />
		<cfargument name="ThemeID" type="string" required="false" />
		<cfargument name="ThreadsPerPage" type="numeric" required="false" />
		<cfargument name="PostsPerPage" type="numeric" required="false" />
		<cfargument name="SubscriptionLimit" type="numeric" required="false" />
		<cfargument name="AllowedExtensions" type="string" required="false" />
		<cfargument name="DeniedExtensions" type="string" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarResizeType" type="string" required="false" />
		<cfargument name="AvatarQualityType" type="string" required="false" />
		<cfargument name="AvatarAspectType" type="string" required="false" />
		<cfargument name="AvatarCropType" type="string" required="false" />
		<cfargument name="UserCacheSize" type="numeric" required="false" />
		<cfargument name="ResetAvatar" type="boolean" required="false" />
		<cfargument name="DoInit" type="boolean" required="false" />
		<cfargument name="ActiveWithinMinutes" type="numeric" required="false" />
		<cfargument name="SearchMode" type="string" required="false" />
		<cfargument name="TempDir" type="string" required="false" />
		<cfargument name="BaseTempDir" type="string" required="false" />
		<cfargument name="URLKey" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfif qList.recordCount gt 1>
			<cfset tmpObj = createObject("component","SettingsBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setSettingsService( getSettingsService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","SettingsBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setSettingsService( getSettingsService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","SettingsBean").init()>
			<cfset tmpObj.setSettingsService( getSettingsService() ) />
			<cfreturn tmpObj />
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />
		
		
		<cfset var qList			= "" />		
		<cfset var strObjects		= StructNew() />
		<cfset var tmpObj			= "" />
		<cfset var IDList			= "" />
		<cfset var iiX 				= "" />

		<cfif not arrayLen(arguments.idArray)>
			<cfreturn QueryNew('null') />
		</cfif>

		<cfset IDList = ArrayToList(arguments.idArray) />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*
			FROM
				#variables.dsnprefix#mf_settings
			WHERE
				0=0
		
			AND
			SiteID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="search" access="public" output="false" returntype="any">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="true" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="30"/>
		<cfargument name="orderby" type="string" required="false" default=""/>
		<cfargument name="isCount" type="boolean" required="false" default="false"/>
		
		<cfset var arrObjects		= ArrayNew(1)>
		<cfset var qList			= "" />
		<cfset var qExclude			= "" />
		<cfset var qKeep			= "" />
		<cfset var iiX				= "" />
		<cfset var returnFields		= rereplace(arguments.fieldList,";.*","") />
		<cfset var returnOrder		= rereplace(arguments.orderby,";.*","") />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mssql"> 	
					TOP #Ceiling(Val(arguments.start+arguments.size))#
				</cfif>
				<cfif arguments.isCount>
					COUNT(*) AS total
				<cfelse>
					#returnFields#
				</cfif>
			FROM	#variables.dsnprefix#mf_settings
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"SettingsID") and len(arguments.criteria.SettingsID)>
			AND SettingsID = <cfqueryparam value="#arguments.criteria.SettingsID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SiteID") and len(arguments.criteria.SiteID)>
			AND SiteID LIKE <cfqueryparam value="%#arguments.criteria.SiteID#%" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsMaster") and len(arguments.criteria.IsMaster)>
			AND IsMaster = <cfqueryparam value="#arguments.criteria.IsMaster#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PermissionGroups") and len(arguments.criteria.PermissionGroups)>
			AND PermissionGroups LIKE <cfqueryparam value="%#arguments.criteria.PermissionGroups#%" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ThemeID") and len(arguments.criteria.ThemeID)>
			AND ThemeID = <cfqueryparam value="#arguments.criteria.ThemeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ThreadsPerPage") and len(arguments.criteria.ThreadsPerPage)>
			AND ThreadsPerPage = <cfqueryparam value="#arguments.criteria.ThreadsPerPage#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PostsPerPage") and len(arguments.criteria.PostsPerPage)>
			AND PostsPerPage = <cfqueryparam value="#arguments.criteria.PostsPerPage#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SubscriptionLimit") and len(arguments.criteria.SubscriptionLimit)>
			AND SubscriptionLimit = <cfqueryparam value="#arguments.criteria.SubscriptionLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AllowedExtensions") and len(arguments.criteria.AllowedExtensions)>
			AND AllowedExtensions LIKE <cfqueryparam value="%#arguments.criteria.AllowedExtensions#%" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DeniedExtensions") and len(arguments.criteria.DeniedExtensions)>
			AND DeniedExtensions LIKE <cfqueryparam value="%#arguments.criteria.DeniedExtensions#%" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"FilesizeLimit") and len(arguments.criteria.FilesizeLimit)>
			AND FilesizeLimit = <cfqueryparam value="#arguments.criteria.FilesizeLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarID") and len(arguments.criteria.AvatarID)>
			AND AvatarID = <cfqueryparam value="#arguments.criteria.AvatarID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarResizeType") and len(arguments.criteria.AvatarResizeType)>
			AND AvatarResizeType LIKE <cfqueryparam value="%#arguments.criteria.AvatarResizeType#%" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarQualityType") and len(arguments.criteria.AvatarQualityType)>
			AND AvatarQualityType LIKE <cfqueryparam value="%#arguments.criteria.AvatarQualityType#%" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarAspectType") and len(arguments.criteria.AvatarAspectType)>
			AND AvatarAspectType LIKE <cfqueryparam value="%#arguments.criteria.AvatarAspectType#%" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarCropType") and len(arguments.criteria.AvatarCropType)>
			AND AvatarCropType LIKE <cfqueryparam value="%#arguments.criteria.AvatarCropType#%" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"UserCacheSize") and len(arguments.criteria.UserCacheSize)>
			AND UserCacheSize = <cfqueryparam value="#arguments.criteria.UserCacheSize#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ResetAvatar") and len(arguments.criteria.ResetAvatar)>
			AND ResetAvatar = <cfqueryparam value="#arguments.criteria.ResetAvatar#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoInit") and len(arguments.criteria.DoInit)>
			AND DoInit = <cfqueryparam value="#arguments.criteria.DoInit#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ActiveWithinMinutes") and len(arguments.criteria.ActiveWithinMinutes)>
			AND ActiveWithinMinutes = <cfqueryparam value="#arguments.criteria.ActiveWithinMinutes#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SearchMode") and len(arguments.criteria.SearchMode)>
			AND SearchMode LIKE <cfqueryparam value="%#arguments.criteria.SearchMode#%" CFSQLType="cf_sql_varchar" maxlength="45" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"TempDir") and len(arguments.criteria.TempDir)>
			AND TempDir = <cfqueryparam value="#arguments.criteria.TempDir#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"BaseTempDir") and len(arguments.criteria.BaseTempDir)>
			AND BaseTempDir LIKE <cfqueryparam value="%#arguments.criteria.BaseTempDir#%" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"URLKey") and len(arguments.criteria.URLKey)>
			AND URLKey LIKE <cfqueryparam value="%#arguments.criteria.URLKey#%" CFSQLType="cf_sql_varchar" maxlength="10" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RemoteID") and len(arguments.criteria.RemoteID)>
			AND RemoteID LIKE <cfqueryparam value="%#arguments.criteria.RemoteID#%" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateCreate") and len(arguments.criteria.DateCreate)>
			AND DateCreate LIKE <cfqueryparam value="%#arguments.criteria.DateCreate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			<!---^^SEARCH-END^^--->																		
			<cfif not arguments.isCount AND len( arguments.orderBy )>
				ORDER BY #returnOrder#
			</cfif>
			<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mysql">
				LIMIT <cfqueryparam value="#arguments.start#" CFSQLType="cf_sql_integer" />,<cfqueryparam value="#arguments.size#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>

		<cfif not arguments.isCount AND variables.dsntype eq "mssql" AND arguments.start gt 0>
			<cfquery name="qExclude" dbtype="query" maxrows="#arguments.start#" >  
	        	SELECT
				
					SiteID
				FROM
					qList    
			</cfquery>
			
			<cfquery name="qKeep" dbtype="query" maxrows="#arguments.count#">  
				SELECT
					*  
				FROM  
					qList  
				WHERE  
					0=0
					(
					AND
					SiteID NOT IN (<cfqueryparam value="#valueList(qExclude.SiteID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
					)  
				
			</cfquery> 

			<cfset qList = qKeep> 
		</cfif>

		<cfif arguments.isCount>
			<cfreturn qList.total >
		<cfelse>
			<cfloop from="1" to="#qList.recordCount#" index="iiX">
				<cfset tmpObj = queryRowToStruct(qList,iiX) />
				<cfset arrayAppend(arrObjects,tmpObj) />
			</cfloop>
		</cfif>
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="setSettingsService" access="public" returntype="void" output="false">
		<cfargument name="SettingsService" type="any" required="true" />
		<cfset variables['settingsService'] = arguments.SettingsService />
	</cffunction>
	<cffunction name="getSettingsService" access="public" returntype="any" output="false">
		<cfreturn variables.SettingsService />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->


	<cffunction name="setThemeService" access="public" returntype="void" output="false">
		<cfargument name="ThemeService" type="any" required="true" />
		<cfset variables['ThemeService'] = arguments.ThemeService />
	</cffunction>
	<cffunction name="getThemeService" access="public" returntype="any" output="false">
		<cfreturn variables.ThemeService />
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>	






