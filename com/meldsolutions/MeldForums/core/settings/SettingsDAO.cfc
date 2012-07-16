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
<cfcomponent displayname="SettingsDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="SettingsDAO">
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
	
	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="SettingsBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_settings
				(
				<!---^^SAVECOLUMNS-START^^--->
				SettingsID,
				SiteID,
				IsMaster,
				PermissionGroups,
				ThemeID,
				ThreadsPerPage,
				PostsPerPage,
				SubscriptionLimit,
				AllowedExtensions,
				DeniedExtensions,
				FilesizeLimit,
				AvatarID,
				AvatarResizeType,
				AvatarQualityType,
				AvatarAspectType,
				AvatarCropType,
				UserCacheSize,
				ResetAvatar,
				DoInit,
				ActiveWithinMinutes,
				SearchMode,
				TempDir,
				BaseTempDir,
				URLKey,
				RemoteID,
				DateCreate,
				DateLastUpdate
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.SettingsBean.getSettingsID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.SettingsBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				<cfqueryparam value="#arguments.SettingsBean.getIsMaster()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.SettingsBean.getPermissionGroups()#" CFSQLType="cf_sql_varchar" maxlength="255" />,
				<cfqueryparam value="#arguments.SettingsBean.getThemeID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SettingsBean.getThemeID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.SettingsBean.getThreadsPerPage()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.SettingsBean.getPostsPerPage()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.SettingsBean.getSubscriptionLimit()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.SettingsBean.getAllowedExtensions()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.SettingsBean.getAllowedExtensions()))#" maxlength="255" />,
				<cfqueryparam value="#arguments.SettingsBean.getDeniedExtensions()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.SettingsBean.getDeniedExtensions()))#" maxlength="255" />,
				<cfqueryparam value="#arguments.SettingsBean.getFilesizeLimit()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.SettingsBean.getAvatarID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SettingsBean.getAvatarID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.SettingsBean.getAvatarResizeType()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				<cfqueryparam value="#arguments.SettingsBean.getAvatarQualityType()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				<cfqueryparam value="#arguments.SettingsBean.getAvatarAspectType()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				<cfqueryparam value="#arguments.SettingsBean.getAvatarCropType()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				<cfqueryparam value="#arguments.SettingsBean.getUserCacheSize()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.SettingsBean.getResetAvatar()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.SettingsBean.getDoInit()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.SettingsBean.getActiveWithinMinutes()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.SettingsBean.getSearchMode()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				<cfqueryparam value="#arguments.SettingsBean.getTempDir()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.SettingsBean.getBaseTempDir()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.SettingsBean.getBaseTempDir()))#" maxlength="150" />,
				<cfqueryparam value="#arguments.SettingsBean.getURLKey()#" CFSQLType="cf_sql_varchar" maxlength="10" />,
				<cfqueryparam value="#arguments.SettingsBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.SettingsBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		
		<cfset arguments.SettingsBean.setBeanExists( 1 ) />
		<cfset arguments.SettingsBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.SettingsBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="SettingsBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mf_settings
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND SiteID = <cfqueryparam value="#arguments.SettingsBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.SettingsBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="SettingsBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_settings
			SET
				<!---^^UPDATEVALUES-START^^--->
				SettingsID = <cfqueryparam value="#arguments.SettingsBean.getSettingsID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				SiteID = <cfqueryparam value="#arguments.SettingsBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				IsMaster = <cfqueryparam value="#arguments.SettingsBean.getIsMaster()#" CFSQLType="cf_sql_tinyint" />,
				PermissionGroups = <cfqueryparam value="#arguments.SettingsBean.getPermissionGroups()#" CFSQLType="cf_sql_varchar" maxlength="255" />,
				ThemeID = <cfqueryparam value="#arguments.SettingsBean.getThemeID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SettingsBean.getThemeID()))#" maxlength="35" />,
				ThreadsPerPage = <cfqueryparam value="#arguments.SettingsBean.getThreadsPerPage()#" CFSQLType="cf_sql_integer" />,
				PostsPerPage = <cfqueryparam value="#arguments.SettingsBean.getPostsPerPage()#" CFSQLType="cf_sql_integer" />,
				SubscriptionLimit = <cfqueryparam value="#arguments.SettingsBean.getSubscriptionLimit()#" CFSQLType="cf_sql_integer" />,
				AllowedExtensions = <cfqueryparam value="#arguments.SettingsBean.getAllowedExtensions()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.SettingsBean.getAllowedExtensions()))#" maxlength="255" />,
				DeniedExtensions = <cfqueryparam value="#arguments.SettingsBean.getDeniedExtensions()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.SettingsBean.getDeniedExtensions()))#" maxlength="255" />,
				FilesizeLimit = <cfqueryparam value="#arguments.SettingsBean.getFilesizeLimit()#" CFSQLType="cf_sql_integer" />,
				AvatarID = <cfqueryparam value="#arguments.SettingsBean.getAvatarID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SettingsBean.getAvatarID()))#" maxlength="35" />,
				AvatarResizeType = <cfqueryparam value="#arguments.SettingsBean.getAvatarResizeType()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				AvatarQualityType = <cfqueryparam value="#arguments.SettingsBean.getAvatarQualityType()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				AvatarAspectType = <cfqueryparam value="#arguments.SettingsBean.getAvatarAspectType()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				AvatarCropType = <cfqueryparam value="#arguments.SettingsBean.getAvatarCropType()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				UserCacheSize = <cfqueryparam value="#arguments.SettingsBean.getUserCacheSize()#" CFSQLType="cf_sql_integer" />,
				ResetAvatar = <cfqueryparam value="#arguments.SettingsBean.getResetAvatar()#" CFSQLType="cf_sql_tinyint" />,
				DoInit = <cfqueryparam value="#arguments.SettingsBean.getDoInit()#" CFSQLType="cf_sql_tinyint" />,
				ActiveWithinMinutes = <cfqueryparam value="#arguments.SettingsBean.getActiveWithinMinutes()#" CFSQLType="cf_sql_integer" />,
				SearchMode = <cfqueryparam value="#arguments.SettingsBean.getSearchMode()#" CFSQLType="cf_sql_varchar" maxlength="45" />,
				TempDir = <cfqueryparam value="#arguments.SettingsBean.getTempDir()#" CFSQLType="cf_sql_char" maxlength="35" />,
				BaseTempDir = <cfqueryparam value="#arguments.SettingsBean.getBaseTempDir()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.SettingsBean.getBaseTempDir()))#" maxlength="150" />,
				URLKey = <cfqueryparam value="#arguments.SettingsBean.getURLKey()#" CFSQLType="cf_sql_varchar" maxlength="10" />,
				RemoteID = <cfqueryparam value="#arguments.SettingsBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.SettingsBean.getRemoteID()))#" maxlength="35" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND SiteID = <cfqueryparam value="#arguments.SettingsBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.SettingsBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="SettingsBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_settings
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND SiteID = <cfqueryparam value="#arguments.SettingsBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.SettingsBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="SettingsBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_settings
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND SiteID = <cfqueryparam value="#arguments.SettingsBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.SettingsBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.SettingsBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	









