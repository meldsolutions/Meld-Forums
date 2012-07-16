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
<cfcomponent displayname="PostDAO" output="false" extends="MeldForums.com.meldsolutions.core.MeldDAO">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="PostDAO">
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
		<cfargument name="PostBean" type="any" required="true" />

		<cfset var qCreate = "" />
		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			INSERT INTO
				#variables.dsnprefix#mf_post
				(
				<!---^^SAVECOLUMNS-START^^--->
				PostID,
				ThreadID,
				UserID,
				AdminID,
				Message,
				IsActive,
				IsDisabled,
				IsApproved,
				IsUserDisabled,
				IsModerated,
				DateModerated,
				DoBlockAttachment,
				AttachmentID,
				PostPosition,
				RemoteID,
				DateCreate,
				DateLastUpdate,
				ParentID
				<!---^^SAVECOLUMNS-END^^--->
				)
			VALUES
				(
				<!---^^SAVEVALUES-START^^--->
				<cfqueryparam value="#arguments.PostBean.getPostID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.PostBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.PostBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				<cfqueryparam value="#arguments.PostBean.getAdminID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.PostBean.getAdminID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.PostBean.getMessage()#" CFSQLType="cf_sql_longvarchar" />,
				<cfqueryparam value="#arguments.PostBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.PostBean.getIsDisabled()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.PostBean.getIsApproved()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.PostBean.getIsUserDisabled()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.PostBean.getIsModerated()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.PostBean.getDateModerated()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.PostBean.getDateModerated()))#" />,
				<cfqueryparam value="#arguments.PostBean.getDoBlockAttachment()#" CFSQLType="cf_sql_tinyint" />,
				<cfqueryparam value="#arguments.PostBean.getAttachmentID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.PostBean.getAttachmentID()))#" maxlength="35" />,
				<cfqueryparam value="#arguments.PostBean.getPostPosition()#" CFSQLType="cf_sql_integer" />,
				<cfqueryparam value="#arguments.PostBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.PostBean.getRemoteID()))#" maxlength="35" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				<cfqueryparam value="#arguments.PostBean.getParentID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.PostBean.getParentID()))#" maxlength="35" />
				<!---^^SAVEVALUES-END^^--->
				)
		</cfquery>
		
		<cfset arguments.PostBean.setBeanExists( 1 ) />
		<cfset arguments.PostBean.setDateCreate( CreateODBCDateTime(now()) ) />
		<cfset arguments.PostBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="PostBean" type="any" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				pst.*,
				thr.title AS Title,thr.idx AS threadIDX,thr.friendlyName as threadFriendlyName,thr.siteID as siteID,
				1 AS BeanExists
			FROM
				#variables.dsnprefix#mf_post pst
			LEFT JOIN
				#variables.dsnprefix#mf_thread thr
				ON
				(pst.threadID = thr.threadID)
			WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND PostID = <cfqueryparam value="#arguments.PostBean.getPostID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.PostBean.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="PostBean" type="any" required="true" />

		<cfset var qUpdate = "" />
		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_post
			SET
				<!---^^UPDATEVALUES-START^^--->
				ThreadID = <cfqueryparam value="#arguments.PostBean.getThreadID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				UserID = <cfqueryparam value="#arguments.PostBean.getUserID()#" CFSQLType="cf_sql_char" maxlength="35" />,
				AdminID = <cfqueryparam value="#arguments.PostBean.getAdminID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.PostBean.getAdminID()))#" maxlength="35" />,
				Message = <cfqueryparam value="#arguments.PostBean.getMessage()#" CFSQLType="cf_sql_longvarchar" />,
				IsActive = <cfqueryparam value="#arguments.PostBean.getIsActive()#" CFSQLType="cf_sql_tinyint" />,
				IsDisabled = <cfqueryparam value="#arguments.PostBean.getIsDisabled()#" CFSQLType="cf_sql_tinyint" />,
				IsApproved = <cfqueryparam value="#arguments.PostBean.getIsApproved()#" CFSQLType="cf_sql_tinyint" />,
				IsUserDisabled = <cfqueryparam value="#arguments.PostBean.getIsUserDisabled()#" CFSQLType="cf_sql_tinyint" />,
				IsModerated = <cfqueryparam value="#arguments.PostBean.getIsModerated()#" CFSQLType="cf_sql_tinyint" />,
				DateModerated = <cfqueryparam value="#arguments.PostBean.getDateModerated()#" CFSQLType="cf_sql_timestamp" null="#(not isDate(arguments.PostBean.getDateModerated()))#" />,
				DoBlockAttachment = <cfqueryparam value="#arguments.PostBean.getDoBlockAttachment()#" CFSQLType="cf_sql_tinyint" />,
				AttachmentID = <cfqueryparam value="#arguments.PostBean.getAttachmentID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.PostBean.getAttachmentID()))#" maxlength="35" />,
				PostPosition = <cfqueryparam value="#arguments.PostBean.getPostPosition()#" CFSQLType="cf_sql_integer" />,
				RemoteID = <cfqueryparam value="#arguments.PostBean.getRemoteID()#" CFSQLType="cf_sql_varchar" null="#(not len(arguments.PostBean.getRemoteID()))#" maxlength="35" />,
				DateLastUpdate = <cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
				ParentID = <cfqueryparam value="#arguments.PostBean.getParentID()#" CFSQLType="cf_sql_char" null="#(not len(arguments.PostBean.getParentID()))#" maxlength="35" />
				<!---^^UPDATEVALUES-END^^--->
		WHERE
			0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND PostID = <cfqueryparam value="#arguments.PostBean.getPostID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.PostBean.setDateLastUpdate( CreateODBCDateTime(now()) ) />

		<cfreturn true />
	</cffunction>
	
	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="PostBean" type="any" required="true" />

		<cfset var qDelete = "">
		<cfquery name="qDelete" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
					#variables.dsnprefix#mf_post
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND PostID = <cfqueryparam value="#arguments.PostBean.getPostID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfset arguments.PostBean.setBeanExists( 0 ) />

		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="PostBean" type="any" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				count(1) as idexists
			FROM
				#variables.dsnprefix#mf_post
			WHERE
				0=0
			<!---^^PRIMARYKEYS-START^^--->
				AND PostID = <cfqueryparam value="#arguments.PostBean.getPostID()#" CFSQLType="cf_sql_char" maxlength="35" />
			<!---^^PRIMARYKEYS-END^^--->
		</cfquery>

		<cfif qExists.idexists>
			<cfset arguments.PostBean.setBeanExists( 1 ) />
			<cfreturn true />
		<cfelse>
			<cfset arguments.PostBean.setBeanExists( 0 ) />
			<cfreturn false />
		</cfif>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	







