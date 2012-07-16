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
<cfcomponent displayname="UserGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="UserGateway">
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
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="UserID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Screenname" type="string" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarFileType" type="string" required="false" />
		<cfargument name="RedoAvatar" type="boolean" required="false" />
		<cfargument name="ThreadCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="LastThreadID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="IsConfirmed" type="boolean" required="false" />
		<cfargument name="IsPrivate" type="boolean" required="false" />
		<cfargument name="IsPostBlocked" type="boolean" required="false" />
		<cfargument name="IsBlocked" type="boolean" required="false" />
		<cfargument name="DoShowOnline" type="boolean" required="false" />
		<cfargument name="DoReplyNotifications" type="boolean" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="CustomValues" type="string" required="false" />
		<cfargument name="DateLastAction" type="string" required="false" />
		<cfargument name="DateLastLogin" type="string" required="false" />
		<cfargument name="DateIsNewFrom" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="idList" type="string" required="false" />
		<cfargument name="pageBean" type="any" required="false" />
		<cfargument name="isCount" type="any" required="false" default="false" />

		<cfset var qList	= "" />		
		<cfset var qExclude	= "" />		
		<cfset var qKeep	= "" />		
		<cfset var count	= 0 />		
		<cfset var sArgs	= StructNew() />		

		<cfif not arguments.isCount AND structKeyExists(arguments,"pageBean") and not pageBean.getCount()>
			<cfset sArgs = structCopy(arguments) />
			<cfset sArgs.isCount = 1 />
			<cfset count = getByAttributesQuery( argumentCollection=sArgs ) />
			<cfset pageBean.setCount( count ) />
			<cfset sArgs.isCount = 0 />
		</cfif>

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
			<cfif not arguments.isCount and variables.dsntype eq "mssql" AND structKeyExists(arguments,"pageBean")> 	
				TOP  #( Ceiling(Val(arguments.pageBean.getPos())) + Ceiling(Val(arguments.pageBean.getSize())) )#
			</cfif>
			<cfif arguments.isCount>
				COUNT(userID) AS total
			<cfelse>
				*,1 AS BeanExists
			</cfif>
			FROM	#variables.dsnprefix#mf_user
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"UserID") and len(arguments.UserID)>
				AND UserID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"SiteID") and len(arguments.SiteID)>
				AND SiteID = <cfqueryparam value="#arguments.SiteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Screenname") and len(arguments.Screenname)>
				AND Screenname = <cfqueryparam value="#arguments.Screenname#" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarID") and len(arguments.AvatarID)>
				AND AvatarID = <cfqueryparam value="#arguments.AvatarID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarFileType") and len(arguments.AvatarFileType)>
				AND AvatarFileType = <cfqueryparam value="#arguments.AvatarFileType#" CFSQLType="cf_sql_varchar" maxlength="5" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RedoAvatar") and len(arguments.RedoAvatar)>
				AND RedoAvatar = <cfqueryparam value="#arguments.RedoAvatar#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ThreadCounter") and len(arguments.ThreadCounter)>
				AND ThreadCounter = <cfqueryparam value="#arguments.ThreadCounter#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"LastPostID") and len(arguments.LastPostID)>
				AND LastPostID = <cfqueryparam value="#arguments.LastPostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"LastThreadID") and len(arguments.LastThreadID)>
				AND LastThreadID = <cfqueryparam value="#arguments.LastThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AdminMessage") and len(arguments.AdminMessage)>
				AND AdminMessage = <cfqueryparam value="#arguments.AdminMessage#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsConfirmed") and len(arguments.IsConfirmed)>
				AND IsConfirmed = <cfqueryparam value="#arguments.IsConfirmed#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsPrivate") and len(arguments.IsPrivate)>
				AND IsPrivate = <cfqueryparam value="#arguments.IsPrivate#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsPostBlocked") and len(arguments.IsPostBlocked)>
				AND IsPostBlocked = <cfqueryparam value="#arguments.IsPostBlocked#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsBlocked") and len(arguments.IsBlocked)>
				AND IsBlocked = <cfqueryparam value="#arguments.IsBlocked#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoShowOnline") and len(arguments.DoShowOnline)>
				AND DoShowOnline = <cfqueryparam value="#arguments.DoShowOnline#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoReplyNotifications") and len(arguments.DoReplyNotifications)>
				AND DoReplyNotifications = <cfqueryparam value="#arguments.DoReplyNotifications#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"PostCounter") and len(arguments.PostCounter)>
				AND PostCounter = <cfqueryparam value="#arguments.PostCounter#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"CustomValues") and len(arguments.CustomValues)>
				AND CustomValues = <cfqueryparam value="#arguments.CustomValues#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastAction") and len(arguments.DateLastAction)>
				AND DateLastAction = <cfqueryparam value="#arguments.DateLastAction#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastLogin") and len(arguments.DateLastLogin)>
				AND DateLastLogin = <cfqueryparam value="#arguments.DateLastLogin#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateIsNewFrom") and len(arguments.DateIsNewFrom)>
				AND DateIsNewFrom = <cfqueryparam value="#arguments.DateIsNewFrom#" CFSQLType="cf_sql_timestamp" />
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
		<cfif not arguments.isCount and structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		<cfif not arguments.isCount and variables.dsntype eq "mysql" and structKeyExists(arguments,"pageBean")>
			LIMIT <cfif len(arguments.pageBean.getPos())><cfqueryparam value="#arguments.pageBean.getPos()#" CFSQLType="cf_sql_integer"  />,</cfif> <cfqueryparam value="#arguments.pageBean.getSize()#" CFSQLType="cf_sql_integer"  />
		</cfif>
		</cfquery>

		<cfif arguments.isCount>
			<cfreturn qList.total >
		</cfif>
		
		<!--- if this is a MS SQL db, we have more work to do --->
		<cfif variables.dsntype eq "mssql" AND structKeyExists(arguments,"pageBean") AND arguments.pageBean.getPos() gt 0>
			<cfquery name="qExclude" dbtype="query" maxrows="#Ceiling(Val(arguments.pageBean.getPos()))#" >  
	        	SELECT
					userID  
				FROM
					qList    
			</cfquery>
			
			<cfquery name="qKeep" dbtype="query" maxrows="#Ceiling(Val(arguments.pageBean.getCount()))#">  
				SELECT
					*  
				FROM  
					qList  
				WHERE  
					userID NOT IN (<cfqueryparam value="#valueList(qExclude.postID)#" list="true" />)  
			</cfquery> 

			<cfset qList = qKeep> 
		</cfif>
	
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="UserID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Screenname" type="string" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarFileType" type="string" required="false" />
		<cfargument name="RedoAvatar" type="boolean" required="false" />
		<cfargument name="ThreadCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="LastThreadID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="IsConfirmed" type="boolean" required="false" />
		<cfargument name="IsPrivate" type="boolean" required="false" />
		<cfargument name="IsPostBlocked" type="boolean" required="false" />
		<cfargument name="IsBlocked" type="boolean" required="false" />
		<cfargument name="DoShowOnline" type="boolean" required="false" />
		<cfargument name="DoReplyNotifications" type="boolean" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="CustomValues" type="string" required="false" />
		<cfargument name="DateLastAction" type="string" required="false" />
		<cfargument name="DateLastLogin" type="string" required="false" />
		<cfargument name="DateIsNewFrom" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="pageBean" type="any" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		<cfloop from="1" to="#qList.recordCount#" index="iiX">
			<cfset tmpObj = createObject("component","UserBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setUserService( getUserService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="UserID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Screenname" type="string" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarFileType" type="string" required="false" />
		<cfargument name="RedoAvatar" type="boolean" required="false" />
		<cfargument name="ThreadCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="LastThreadID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="IsConfirmed" type="boolean" required="false" />
		<cfargument name="IsPrivate" type="boolean" required="false" />
		<cfargument name="IsPostBlocked" type="boolean" required="false" />
		<cfargument name="IsBlocked" type="boolean" required="false" />
		<cfargument name="DoShowOnline" type="boolean" required="false" />
		<cfargument name="DoReplyNotifications" type="boolean" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="CustomValues" type="string" required="false" />
		<cfargument name="DateLastAction" type="string" required="false" />
		<cfargument name="DateLastLogin" type="string" required="false" />
		<cfargument name="DateIsNewFrom" type="string" required="false" />
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
			<cfset tmpObj = createObject("component","UserBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setUserService( getUserService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","UserBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setUserService( getUserService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","UserBean").init()>
			<cfset tmpObj.setUserService( getUserService() ) />
			<cfreturn tmpObj />
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		
		<cfargument name="aUserID" type="array" required="true" />
		
		
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
				#variables.dsnprefix#mf_user
			WHERE
				0=0
		
			AND
			UserID IN (<cfqueryparam value="#aUserID#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
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
			FROM	#variables.dsnprefix#mf_user
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"UserID") and len(arguments.criteria.UserID)>
			AND UserID = <cfqueryparam value="#arguments.criteria.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SiteID") and len(arguments.criteria.SiteID)>
			AND SiteID = <cfqueryparam value="#arguments.criteria.SiteID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Screenname") and len(arguments.criteria.Screenname)>
			AND Screenname LIKE <cfqueryparam value="%#arguments.criteria.Screenname#%" CFSQLType="cf_sql_varchar" maxlength="50" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarID") and len(arguments.criteria.AvatarID)>
			AND AvatarID = <cfqueryparam value="#arguments.criteria.AvatarID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarFileType") and len(arguments.criteria.AvatarFileType)>
			AND AvatarFileType LIKE <cfqueryparam value="%#arguments.criteria.AvatarFileType#%" CFSQLType="cf_sql_varchar" maxlength="5" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RedoAvatar") and len(arguments.criteria.RedoAvatar)>
			AND RedoAvatar = <cfqueryparam value="#arguments.criteria.RedoAvatar#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ThreadCounter") and len(arguments.criteria.ThreadCounter)>
			AND ThreadCounter = <cfqueryparam value="#arguments.criteria.ThreadCounter#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"LastPostID") and len(arguments.criteria.LastPostID)>
			AND LastPostID = <cfqueryparam value="#arguments.criteria.LastPostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"LastThreadID") and len(arguments.criteria.LastThreadID)>
			AND LastThreadID = <cfqueryparam value="#arguments.criteria.LastThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AdminMessage") and len(arguments.criteria.AdminMessage)>
			AND AdminMessage LIKE <cfqueryparam value="%#arguments.criteria.AdminMessage#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsConfirmed") and len(arguments.criteria.IsConfirmed)>
			AND IsConfirmed = <cfqueryparam value="#arguments.criteria.IsConfirmed#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsPrivate") and len(arguments.criteria.IsPrivate)>
			AND IsPrivate = <cfqueryparam value="#arguments.criteria.IsPrivate#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsPostBlocked") and len(arguments.criteria.IsPostBlocked)>
			AND IsPostBlocked = <cfqueryparam value="#arguments.criteria.IsPostBlocked#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsBlocked") and len(arguments.criteria.IsBlocked)>
			AND IsBlocked = <cfqueryparam value="#arguments.criteria.IsBlocked#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoShowOnline") and len(arguments.criteria.DoShowOnline)>
			AND DoShowOnline = <cfqueryparam value="#arguments.criteria.DoShowOnline#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoReplyNotifications") and len(arguments.criteria.DoReplyNotifications)>
			AND DoReplyNotifications = <cfqueryparam value="#arguments.criteria.DoReplyNotifications#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PostCounter") and len(arguments.criteria.PostCounter)>
			AND PostCounter = <cfqueryparam value="#arguments.criteria.PostCounter#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"CustomValues") and len(arguments.criteria.CustomValues)>
			AND CustomValues LIKE <cfqueryparam value="%#arguments.criteria.CustomValues#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastAction") and len(arguments.criteria.DateLastAction)>
			AND DateLastAction LIKE <cfqueryparam value="%#arguments.criteria.DateLastAction#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastLogin") and len(arguments.criteria.DateLastLogin)>
			AND DateLastLogin LIKE <cfqueryparam value="%#arguments.criteria.DateLastLogin#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateIsNewFrom") and len(arguments.criteria.DateIsNewFrom)>
			AND DateIsNewFrom LIKE <cfqueryparam value="%#arguments.criteria.DateIsNewFrom#%" CFSQLType="cf_sql_timestamp" />
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
				
					UserID
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
					UserID NOT IN (<cfqueryparam value="#valueList(qExclude.UserID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
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

	<cffunction name="setUserService" access="public" returntype="void" output="false">
		<cfargument name="UserService" type="any" required="true" />
		<cfset variables['userService'] = arguments.UserService />
	</cffunction>
	<cffunction name="getUserService" access="public" returntype="any" output="false">
		<cfreturn variables.UserService />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="userAddedPost" access="public" output="false" returntype="void">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="postID" type="string" required="true" />

		<cfset var qCreate = "">

		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_user
			SET
				postCounter=postCounter+1,
				lastPostID= <cfqueryparam value="#arguments.postID	#" CFSQLType="cf_sql_char" />,
				dateLastAction = <cfqueryparam value="#createODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
			WHERE
				userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />
		</cfquery>
	</cffunction>

	<cffunction name="userAddedThread" access="public" output="false" returntype="void">
		<cfargument name="userID" type="string" required="true" />
		<cfargument name="threadID" type="string" required="true" />

		<cfset var qCreate = "">

		<cfquery name="qCreate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			UPDATE
				#variables.dsnprefix#mf_user
			SET
				threadCounter=threadCounter+1,
				lastThreadID= <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />,
				dateLastAction = <cfqueryparam value="#createODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
			WHERE
				userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" />
		</cfquery>
	</cffunction>


<!---^^CUSTOMEND^^--->
</cfcomponent>	





