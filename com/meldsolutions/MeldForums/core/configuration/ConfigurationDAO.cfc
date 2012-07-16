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
<cfcomponent displayname="ConfigurationDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ConfigurationDAO">
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
		<cfargument name="ConfigurationBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_configuration
				(
				<!---^^SAVECOLUMNS-START^^--->
				ConfigurationID,
				SiteID,
				Name,
				Description,
				IsActive,
				RestrictReadGroups,
				RestrictContributeGroups,
				RestrictModerateGroups,
				DoRequireConfirmation,
				DoAvatars,
				DoClosed,
				AllowAttachmentExtensions,
				DoAttachments,
				IsMaster,
				FilesizeLimit,
				CharacterLimit,
				DoInlineImageAttachments,
				ImageWidthLimit,
				ImageHeightLimit,
				RemoteID,
				DateCreate,
				DateLastUpdate
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.ConfigurationBean.getConfigurationID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="100" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getDescription()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ConfigurationBean.getDescription()))#" maxlength="255" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getRestrictReadGroups()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ConfigurationBean.getRestrictReadGroups()))#" maxlength="255" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getRestrictContributeGroups()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ConfigurationBean.getRestrictContributeGroups()))#" maxlength="255" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getRestrictModerateGroups()#" CFSQLType="cf_sql_varchar" maxlength="255" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getDoRequireConfirmation()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getDoAvatars()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getDoClosed()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getAllowAttachmentExtensions()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.ConfigurationBean.getAllowAttachmentExtensions()))#" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getDoAttachments()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getIsMaster()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getFilesizeLimit()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getCharacterLimit()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getDoInlineImageAttachments()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getImageWidthLimit()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getImageHeightLimit()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ConfigurationBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ConfigurationBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		
		<cfset arguments.ConfigurationBean.setBeanExists( 1 ) />
		<cfset arguments.ConfigurationBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.ConfigurationBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ConfigurationBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mf_configuration
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ConfigurationID = <cfqueryparam value="#arguments.ConfigurationBean.getConfigurationID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ConfigurationBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ConfigurationBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_configuration
			SET
				<!---^^UPDATEVALUES-START^^--->
				SiteID = <cfqueryparam value="#arguments.ConfigurationBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				Name = <cfqueryparam value="#arguments.ConfigurationBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="100" />,
				Description = <cfqueryparam value="#arguments.ConfigurationBean.getDescription()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ConfigurationBean.getDescription()))#" maxlength="255" />,
				IsActive = <cfqueryparam value="#arguments.ConfigurationBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				RestrictReadGroups = <cfqueryparam value="#arguments.ConfigurationBean.getRestrictReadGroups()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ConfigurationBean.getRestrictReadGroups()))#" maxlength="255" />,
				RestrictContributeGroups = <cfqueryparam value="#arguments.ConfigurationBean.getRestrictContributeGroups()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ConfigurationBean.getRestrictContributeGroups()))#" maxlength="255" />,
				RestrictModerateGroups = <cfqueryparam value="#arguments.ConfigurationBean.getRestrictModerateGroups()#" CFSQLType="cf_sql_varchar" maxlength="255" />,
				DoRequireConfirmation = <cfqueryparam value="#arguments.ConfigurationBean.getDoRequireConfirmation()#" CFSQLType="cf_sql_tinyint" />,
				DoAvatars = <cfqueryparam value="#arguments.ConfigurationBean.getDoAvatars()#" CFSQLType="cf_sql_tinyint" />,
				DoClosed = <cfqueryparam value="#arguments.ConfigurationBean.getDoClosed()#" CFSQLType="cf_sql_tinyint" />,
				AllowAttachmentExtensions = <cfqueryparam value="#arguments.ConfigurationBean.getAllowAttachmentExtensions()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.ConfigurationBean.getAllowAttachmentExtensions()))#" />,
				DoAttachments = <cfqueryparam value="#arguments.ConfigurationBean.getDoAttachments()#" CFSQLType="cf_sql_tinyint" />,
				IsMaster = <cfqueryparam value="#arguments.ConfigurationBean.getIsMaster()#" CFSQLType="cf_sql_tinyint" />,
				FilesizeLimit = <cfqueryparam value="#arguments.ConfigurationBean.getFilesizeLimit()#" CFSQLType="cf_sql_integer" />,
				CharacterLimit = <cfqueryparam value="#arguments.ConfigurationBean.getCharacterLimit()#" CFSQLType="cf_sql_integer" />,
				DoInlineImageAttachments = <cfqueryparam value="#arguments.ConfigurationBean.getDoInlineImageAttachments()#" CFSQLType="cf_sql_tinyint" />,
				ImageWidthLimit = <cfqueryparam value="#arguments.ConfigurationBean.getImageWidthLimit()#" CFSQLType="cf_sql_integer" />,
				ImageHeightLimit = <cfqueryparam value="#arguments.ConfigurationBean.getImageHeightLimit()#" CFSQLType="cf_sql_integer" />,
				RemoteID = <cfqueryparam value="#arguments.ConfigurationBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ConfigurationBean.getRemoteID()))#" maxlength="35" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ConfigurationID = <cfqueryparam value="#arguments.ConfigurationBean.getConfigurationID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.ConfigurationBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ConfigurationBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_configuration
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ConfigurationID = <cfqueryparam value="#arguments.ConfigurationBean.getConfigurationID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.ConfigurationBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ConfigurationBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_configuration
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ConfigurationID = <cfqueryparam value="#arguments.ConfigurationBean.getConfigurationID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.ConfigurationBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.ConfigurationBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	






