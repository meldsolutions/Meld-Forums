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
<cfcomponent displayname="SubscribeDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="SubscribeDAO">
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
		<cfargument name="SubscribeBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_subscribe
				(
				<!---^^SAVECOLUMNS-START^^--->
				SubscribeID,
				ConferenceID,
				ForumID,
				ThreadID,
				UserID,
				DateCreate,
				DateLastUpdate,
				IsEmail
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.SubscribeBean.getSubscribeID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.SubscribeBean.getConferenceID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SubscribeBean.getConferenceID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.SubscribeBean.getForumID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SubscribeBean.getForumID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.SubscribeBean.getThreadID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SubscribeBean.getThreadID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.SubscribeBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#arguments.SubscribeBean.getIsEmail()#" CFSQLType="cf_sql_tinyint" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		
		<cfset arguments.SubscribeBean.setBeanExists( 1 ) />
		<cfset arguments.SubscribeBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.SubscribeBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="SubscribeBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mf_subscribe
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND SubscribeID = <cfqueryparam value="#arguments.SubscribeBean.getSubscribeID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.SubscribeBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="SubscribeBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_subscribe
			SET
				<!---^^UPDATEVALUES-START^^--->
				ConferenceID = <cfqueryparam value="#arguments.SubscribeBean.getConferenceID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SubscribeBean.getConferenceID()))#" maxlength="35" />,
				ForumID = <cfqueryparam value="#arguments.SubscribeBean.getForumID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SubscribeBean.getForumID()))#" maxlength="35" />,
				ThreadID = <cfqueryparam value="#arguments.SubscribeBean.getThreadID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.SubscribeBean.getThreadID()))#" maxlength="35" />,
				UserID = <cfqueryparam value="#arguments.SubscribeBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				IsEmail = <cfqueryparam value="#arguments.SubscribeBean.getIsEmail()#" CFSQLType="cf_sql_tinyint" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND SubscribeID = <cfqueryparam value="#arguments.SubscribeBean.getSubscribeID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.SubscribeBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="SubscribeBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_subscribe
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND SubscribeID = <cfqueryparam value="#arguments.SubscribeBean.getSubscribeID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.SubscribeBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="SubscribeBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_subscribe
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND SubscribeID = <cfqueryparam value="#arguments.SubscribeBean.getSubscribeID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.SubscribeBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.SubscribeBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	





