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
<cfcomponent displayname="DisplayDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="DisplayDAO">
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
		<cfargument name="DisplayBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_display
				(
				<!---^^SAVECOLUMNS-START^^--->
				DisplayID,
				DisplayTypeID,
				ObjectID,
				Name,
				DateCreate,
				DateLastUpdate,
				SiteID,
				Params,
				Notes,
				IsActive,
				AdminID,
				ModuleID,
				ContentID,
				IsValid,
				Settings
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.DisplayBean.getDisplayID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.DisplayBean.getDisplayTypeID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.DisplayBean.getObjectID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplayBean.getObjectID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.DisplayBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="150" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#arguments.DisplayBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				<cfqueryparam value="#arguments.DisplayBean.getParams()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplayBean.getParams()))#" />,
				<cfqueryparam value="#arguments.DisplayBean.getNotes()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplayBean.getNotes()))#" />,
				<cfqueryparam value="#arguments.DisplayBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.DisplayBean.getAdminID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplayBean.getAdminID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.DisplayBean.getModuleID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplayBean.getModuleID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.DisplayBean.getContentID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplayBean.getContentID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.DisplayBean.getIsValid()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.DisplayBean.getSettings()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplayBean.getSettings()))#" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		
		<cfset arguments.DisplayBean.setBeanExists( 1 ) />
		<cfset arguments.DisplayBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.DisplayBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="DisplayBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mf_display
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND DisplayID = <cfqueryparam value="#arguments.DisplayBean.getDisplayID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.DisplayBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="DisplayBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_display
			SET
				<!---^^UPDATEVALUES-START^^--->
				DisplayTypeID = <cfqueryparam value="#arguments.DisplayBean.getDisplayTypeID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				ObjectID = <cfqueryparam value="#arguments.DisplayBean.getObjectID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplayBean.getObjectID()))#" maxlength="35" />,
				Name = <cfqueryparam value="#arguments.DisplayBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="150" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				SiteID = <cfqueryparam value="#arguments.DisplayBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				Params = <cfqueryparam value="#arguments.DisplayBean.getParams()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplayBean.getParams()))#" />,
				Notes = <cfqueryparam value="#arguments.DisplayBean.getNotes()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplayBean.getNotes()))#" />,
				IsActive = <cfqueryparam value="#arguments.DisplayBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				AdminID = <cfqueryparam value="#arguments.DisplayBean.getAdminID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplayBean.getAdminID()))#" maxlength="35" />,
				ModuleID = <cfqueryparam value="#arguments.DisplayBean.getModuleID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplayBean.getModuleID()))#" maxlength="35" />,
				ContentID = <cfqueryparam value="#arguments.DisplayBean.getContentID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.DisplayBean.getContentID()))#" maxlength="35" />,
				IsValid = <cfqueryparam value="#arguments.DisplayBean.getIsValid()#" CFSQLType="cf_sql_tinyint" />,
				Settings = <cfqueryparam value="#arguments.DisplayBean.getSettings()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.DisplayBean.getSettings()))#" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND DisplayID = <cfqueryparam value="#arguments.DisplayBean.getDisplayID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.DisplayBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="DisplayBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_display
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND DisplayID = <cfqueryparam value="#arguments.DisplayBean.getDisplayID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.DisplayBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="DisplayBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_display
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND DisplayID = <cfqueryparam value="#arguments.DisplayBean.getDisplayID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.DisplayBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.DisplayBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	






