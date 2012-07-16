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
<cfcomponent displayname="ThreadDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ThreadDAO">
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
		<cfargument name="ThreadBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfset var qUpdate = "" />
		<cfset var qIDX = "" />

		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_thread
				(
				<!---^^SAVECOLUMNS-START^^--->
				ThreadID,
				ForumID,
				TypeID,
				SiteID,
				IsActive,
				IsClosed,
				IsDisabled,
				IsUserDisabled,
				IsDraft,
				UserID,
				AdminID,
				AdminMessage,
				Title,
				FriendlyName,
				OrderNo,
				PostCounter,
				LastPostID,
				DateLastPost,
				RemoteID,
				DateCreate,
				DateLastUpdate,
				IsAnnouncement
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.ThreadBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.ThreadBean.getForumID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.ThreadBean.getTypeID()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ThreadBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				<cfqueryparam value="#arguments.ThreadBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ThreadBean.getIsClosed()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ThreadBean.getIsDisabled()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ThreadBean.getIsUserDisabled()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ThreadBean.getIsDraft()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.ThreadBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.ThreadBean.getAdminID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ThreadBean.getAdminID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.ThreadBean.getAdminMessage()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.ThreadBean.getAdminMessage()))#" />,
				<cfqueryparam value="#arguments.ThreadBean.getTitle()#" CFSQLType="cf_sql_varchar" maxlength="150" />,
				<cfqueryparam value="#arguments.ThreadBean.getFriendlyName()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThreadBean.getFriendlyName()))#" maxlength="200" />,
				<cfqueryparam value="#arguments.ThreadBean.getOrderNo()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ThreadBean.getPostCounter()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.ThreadBean.getLastPostID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ThreadBean.getLastPostID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.ThreadBean.getDateLastPost()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.ThreadBean.getDateLastPost()))#" />,
				<cfqueryparam value="#arguments.ThreadBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThreadBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#arguments.ThreadBean.getIsAnnouncement()#" CFSQLType="cf_sql_tinyint" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>

		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_viewcounter
				(
				threadID,
				forumID,
				views,
				dateCreate,
				dateLastUpdate
				)
			VALUES
				(
				<cfqueryparam value="#arguments.ThreadBean.getThreadID()#" CFSQLType="cf_sql_char" />,
				<cfqueryparam value="#arguments.ThreadBean.getForumID()#" CFSQLType="cf_sql_char" />,
				0,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
				)
		</cfquery>
		
		<cfquery name="qIDX" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			SELECT
				idx
			FROM
				#variables.dsnprefix#mf_thread
			WHERE
				ThreadID = <cfqueryparam value="#arguments.ThreadBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
		
		<cfset arguments.ThreadBean.setIDX( qIDX.idx ) />
		<cfset arguments.ThreadBean.setBeanExists( 1 ) />
		<cfset arguments.ThreadBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.ThreadBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ThreadBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM
				#variables.dsnprefix#mf_thread
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ThreadID = <cfqueryparam value="#arguments.ThreadBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ThreadBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ThreadBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_thread
			SET
				<!---^^UPDATEVALUES-START^^--->
				ForumID = <cfqueryparam value="#arguments.ThreadBean.getForumID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				TypeID = <cfqueryparam value="#arguments.ThreadBean.getTypeID()#" CFSQLType="cf_sql_integer" />,
				SiteID = <cfqueryparam value="#arguments.ThreadBean.getSiteID()#" CFSQLType="cf_sql_varchar" maxlength="25" />,
				IsActive = <cfqueryparam value="#arguments.ThreadBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				IsClosed = <cfqueryparam value="#arguments.ThreadBean.getIsClosed()#" CFSQLType="cf_sql_tinyint" />,
				IsDisabled = <cfqueryparam value="#arguments.ThreadBean.getIsDisabled()#" CFSQLType="cf_sql_tinyint" />,
				IsUserDisabled = <cfqueryparam value="#arguments.ThreadBean.getIsUserDisabled()#" CFSQLType="cf_sql_tinyint" />,
				IsDraft = <cfqueryparam value="#arguments.ThreadBean.getIsDraft()#" CFSQLType="cf_sql_tinyint" />,
				UserID = <cfqueryparam value="#arguments.ThreadBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				AdminID = <cfqueryparam value="#arguments.ThreadBean.getAdminID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ThreadBean.getAdminID()))#" maxlength="35" />,
				AdminMessage = <cfqueryparam value="#arguments.ThreadBean.getAdminMessage()#" CFSQLType="cf_sql_longvarchar" null="#(not len(arguments.ThreadBean.getAdminMessage()))#" />,
				Title = <cfqueryparam value="#arguments.ThreadBean.getTitle()#" CFSQLType="cf_sql_varchar" maxlength="150" />,
				FriendlyName = <cfqueryparam value="#arguments.ThreadBean.getFriendlyName()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThreadBean.getFriendlyName()))#" maxlength="200" />,
				OrderNo = <cfqueryparam value="#arguments.ThreadBean.getOrderNo()#" CFSQLType="cf_sql_integer" />,
				PostCounter = <cfqueryparam value="#arguments.ThreadBean.getPostCounter()#" CFSQLType="cf_sql_integer" />,
				LastPostID = <cfqueryparam value="#arguments.ThreadBean.getLastPostID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.ThreadBean.getLastPostID()))#" maxlength="35" />,
				DateLastPost = <cfqueryparam value="#arguments.ThreadBean.getDateLastPost()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.ThreadBean.getDateLastPost()))#" />,
				RemoteID = <cfqueryparam value="#arguments.ThreadBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.ThreadBean.getRemoteID()))#" maxlength="35" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				IsAnnouncement = <cfqueryparam value="#arguments.ThreadBean.getIsAnnouncement()#" CFSQLType="cf_sql_tinyint" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ThreadID = <cfqueryparam value="#arguments.ThreadBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.ThreadBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ThreadBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cftransaction>

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
			#variables.dsnprefix#mf_post
			WHERE	
				threadID  = <cfqueryparam value="#arguments.ThreadBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
			
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_thread
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ThreadID = <cfqueryparam value="#arguments.ThreadBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>
		</cftransaction>
		<cfset arguments.ThreadBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ThreadBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_thread
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND ThreadID = <cfqueryparam value="#arguments.ThreadBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.ThreadBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.ThreadBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	














