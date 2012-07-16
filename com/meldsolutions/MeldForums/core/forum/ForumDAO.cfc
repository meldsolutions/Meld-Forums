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
<cfcomponent displayname="ForumDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ForumDAO">
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
		<cfargument name="ForumBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_forum
				(
				<!---^^SAVECOLUMNS-START^^--->
				ForumID,
				ConferenceID,
				ConfigurationID,
				SiteID,
				Name,
				Title,
				Description,
				FriendlyName,
				IsActive,
				AdminID,
				OrderNo,
				ThreadCounter,
				LastPostID,
				RemoteID,
				DateCreate,
				DateLastUpdate
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.ForumBean.getForumID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.ForumBean.getConferenceID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.ForumBean.getConfigurationID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ForumBean.getConfigurationID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.ForumBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				<cfqueryparam value="#arguments.ForumBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="150" />,
				<cfqueryparam value="#arguments.ForumBean.getTitle()#" CFSQLType="cf_sql_varchar" maxlength="150" />,
				<cfqueryparam value="#arguments.ForumBean.getDescription()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.ForumBean.getDescription()))#" />,
				<cfqueryparam value="#arguments.ForumBean.getFriendlyName()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ForumBean.getFriendlyName()))#" maxlength="200" />,
				<cfqueryparam value="#arguments.ForumBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ForumBean.getAdminID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ForumBean.getAdminID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.ForumBean.getOrderNo()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ForumBean.getThreadCounter()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ForumBean.getLastPostID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ForumBean.getLastPostID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.ForumBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ForumBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		
		<cfset arguments.ForumBean.setBeanExists( 1 ) />
		<cfset arguments.ForumBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.ForumBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ForumBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mf_forum
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ForumID = <cfqueryparam value="#arguments.ForumBean.getForumID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ForumBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ForumBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_forum
			SET
				<!---^^UPDATEVALUES-START^^--->
				ConferenceID = <cfqueryparam value="#arguments.ForumBean.getConferenceID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				ConfigurationID = <cfqueryparam value="#arguments.ForumBean.getConfigurationID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ForumBean.getConfigurationID()))#" maxlength="35" />,
				SiteID = <cfqueryparam value="#arguments.ForumBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				Name = <cfqueryparam value="#arguments.ForumBean.getName()#" CFSQLType="cf_sql_varchar" maxlength="150" />,
				Title = <cfqueryparam value="#arguments.ForumBean.getTitle()#" CFSQLType="cf_sql_varchar" maxlength="150" />,
				Description = <cfqueryparam value="#arguments.ForumBean.getDescription()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.ForumBean.getDescription()))#" />,
				FriendlyName = <cfqueryparam value="#arguments.ForumBean.getFriendlyName()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ForumBean.getFriendlyName()))#" maxlength="200" />,
				IsActive = <cfqueryparam value="#arguments.ForumBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				AdminID = <cfqueryparam value="#arguments.ForumBean.getAdminID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ForumBean.getAdminID()))#" maxlength="35" />,
				OrderNo = <cfqueryparam value="#arguments.ForumBean.getOrderNo()#" CFSQLType="cf_sql_integer" />,
				ThreadCounter = <cfqueryparam value="#arguments.ForumBean.getThreadCounter()#" CFSQLType="cf_sql_integer" />,
				LastPostID = <cfqueryparam value="#arguments.ForumBean.getLastPostID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ForumBean.getLastPostID()))#" maxlength="35" />,
				RemoteID = <cfqueryparam value="#arguments.ForumBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ForumBean.getRemoteID()))#" maxlength="35" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ForumID = <cfqueryparam value="#arguments.ForumBean.getForumID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.ForumBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ForumBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_forum
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ForumID = <cfqueryparam value="#arguments.ForumBean.getForumID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.ForumBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="deleteForums" access="public" output="false" returntype="boolean">
		<cfargument name="ConferenceID" type="uuid" required="true" />

		<cfset var qDelete = "">

		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_forum
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ForumID = <cfqueryparam value="#arguments.ForumBean.getForumID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ForumBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_forum
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ForumID = <cfqueryparam value="#arguments.ForumBean.getForumID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.ForumBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.ForumBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	






