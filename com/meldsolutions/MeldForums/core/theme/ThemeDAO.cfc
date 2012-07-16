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
<cfcomponent displayname="ThemeDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ThemeDAO">
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
		<cfargument name="ThemeBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_theme
				(
				<!---^^SAVECOLUMNS-START^^--->
				ThemeID,
				Name,
				PackageName,
				AvatarSmallWidth,
				AvatarSmallHeight,
				AvatarMediumWidth,
				AvatarMediumHeight,
				AvatarDimensionType,
				Settings,
				DefaultAvatar,
				IsMaster,
				Style,
				RemoteID,
				DateCreate,
				DateLastUpdate
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.ThemeBean.getThemeID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.ThemeBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="35" />,
				<cfqueryparam value="#arguments.ThemeBean.getPackageName()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				<cfqueryparam value="#arguments.ThemeBean.getAvatarSmallWidth()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ThemeBean.getAvatarSmallHeight()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ThemeBean.getAvatarMediumWidth()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ThemeBean.getAvatarMediumHeight()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ThemeBean.getAvatarDimensionType()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				<cfqueryparam value="#arguments.ThemeBean.getSettings()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.ThemeBean.getSettings()))#" />,
				<cfqueryparam value="#arguments.ThemeBean.getDefaultAvatar()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThemeBean.getDefaultAvatar()))#" maxlength="80" />,
				<cfqueryparam value="#arguments.ThemeBean.getIsMaster()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ThemeBean.getStyle()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThemeBean.getStyle()))#" maxlength="12" />,
				<cfqueryparam value="#arguments.ThemeBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThemeBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		
		<cfset arguments.ThemeBean.setBeanExists( 1 ) />
		<cfset arguments.ThemeBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.ThemeBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ThemeBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mf_theme
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ThemeID = <cfqueryparam value="#arguments.ThemeBean.getThemeID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ThemeBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ThemeBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_theme
			SET
				<!---^^UPDATEVALUES-START^^--->
				Name = <cfqueryparam value="#arguments.ThemeBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="35" />,
				PackageName = <cfqueryparam value="#arguments.ThemeBean.getPackageName()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				AvatarSmallWidth = <cfqueryparam value="#arguments.ThemeBean.getAvatarSmallWidth()#" CFSQLType="cf_sql_integer" />,
				AvatarSmallHeight = <cfqueryparam value="#arguments.ThemeBean.getAvatarSmallHeight()#" CFSQLType="cf_sql_integer" />,
				AvatarMediumWidth = <cfqueryparam value="#arguments.ThemeBean.getAvatarMediumWidth()#" CFSQLType="cf_sql_integer" />,
				AvatarMediumHeight = <cfqueryparam value="#arguments.ThemeBean.getAvatarMediumHeight()#" CFSQLType="cf_sql_integer" />,
				AvatarDimensionType = <cfqueryparam value="#arguments.ThemeBean.getAvatarDimensionType()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				Settings = <cfqueryparam value="#arguments.ThemeBean.getSettings()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.ThemeBean.getSettings()))#" />,
				DefaultAvatar = <cfqueryparam value="#arguments.ThemeBean.getDefaultAvatar()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThemeBean.getDefaultAvatar()))#" maxlength="80" />,
				IsMaster = <cfqueryparam value="#arguments.ThemeBean.getIsMaster()#" CFSQLType="cf_sql_tinyint" />,
				Style = <cfqueryparam value="#arguments.ThemeBean.getStyle()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThemeBean.getStyle()))#" maxlength="12" />,
				RemoteID = <cfqueryparam value="#arguments.ThemeBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThemeBean.getRemoteID()))#" maxlength="35" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ThemeID = <cfqueryparam value="#arguments.ThemeBean.getThemeID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.ThemeBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ThemeBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_theme
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ThemeID = <cfqueryparam value="#arguments.ThemeBean.getThemeID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.ThemeBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ThemeBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_theme
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ThemeID = <cfqueryparam value="#arguments.ThemeBean.getThemeID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.ThemeBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.ThemeBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	


