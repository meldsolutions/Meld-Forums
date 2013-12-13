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
<cfcomponent displayname="ThreadGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cfset variables.instance = StructNew() />
	<cffunction name="init" access="public" output="false" returntype="ThreadGateway">
		<cfargument name="MeldConfig" type="any" required="true">

		<cfset variables.MeldConfig = arguments.MeldConfig />
		
		<cfset structAppend(variables.instance,structCopy(variables.MeldConfig.getAllValues()),true) />
		<cfset structAppend(variables,structCopy(variables.MeldConfig.getAllValues()),true) />

		<cfreturn this>
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="TypeID" type="numeric" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsClosed" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsDraft" type="boolean" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="DateLastPost" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="IsAnnouncement" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="idList" type="string" required="false" />
		<cfargument name="pageBean" type="any" required="false" />
		<cfargument name="isCount" type="any" required="false" default="false" />

		<cfset var qList	= "" />		
		<cfset var qExclude	= "" />		
		<cfset var qKeep	= "" />		

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
			<cfif variables.dsntype eq "mssql" AND structKeyExists(arguments,"pageBean")> 	
				TOP  #( Ceiling(Val(arguments.pageBean.getPos())) + Ceiling(Val(arguments.pageBean.getSize())) )#
			</cfif>
			<cfif arguments.isCount>
				COUNT(thr.threadID) AS total
			<cfelse>
				thr.*,1 AS BeanExists,vws.views AS viewCounter,
				<cfif variables.dsntype eq "mssql">
				thr.typeID as issticky
				<cfelse>
				thr.typeID = 1 as issticky
				</cfif>
			</cfif>
			FROM	#variables.dsnprefix#mf_thread thr
			<cfif not arguments.isCount>
			LEFT JOIN
				#variables.dsnprefix#mf_viewcounter vws
			ON
				(thr.threadID = vws.threadID)
			</cfif>
			LEFT JOIN
				#variables.dsnprefix#mf_post pst
			ON
				(
					thr.threadID = pst.threadID
					AND
					pst.postPosition = 0
					AND
					pst.isActive = 1
					AND
					pst.isDisabled = 0
					AND
					pst.isApproved = 1
				)
			WHERE	0=0

			<cfif structKeyExists(arguments,"idList") and len(arguments.idList)>
				AND thr.ThreadID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
			</cfif>

			<cfif structKeyExists(arguments,"IsActive") and len(arguments.IsActive)>
				AND thr.IsActive = <cfqueryparam value="#arguments.IsActive#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND thr.IsActive = <cfqueryparam value="1" CFSQLType="cf_sql_tinyint" />
			</cfif>

			<cfif structKeyExists(arguments,"IsDisabled") and len(arguments.IsDisabled)>
				AND thr.IsDisabled = <cfqueryparam value="#arguments.IsDisabled#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND thr.IsDisabled = <cfqueryparam value="0" CFSQLType="cf_sql_tinyint" />
			</cfif>

			<!---  --->
			<cfif structKeyExists(arguments,"ThreadID") and len(arguments.ThreadID)>
				AND thr.ThreadID = <cfqueryparam value="#arguments.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ForumID") and len(arguments.ForumID)>
				AND thr.ForumID = <cfqueryparam value="#arguments.ForumID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"TypeID") and len(arguments.TypeID)>
				AND thr.TypeID = <cfqueryparam value="#arguments.TypeID#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"SiteID") and len(arguments.SiteID)>
				AND thr.SiteID = <cfqueryparam value="#arguments.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
						
			<cfif structKeyExists(arguments,"IsClosed") and len(arguments.IsClosed)>
				AND thr.IsClosed = <cfqueryparam value="#arguments.IsClosed#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsUserDisabled") and len(arguments.IsUserDisabled)>
				AND thr.IsUserDisabled = <cfqueryparam value="#arguments.IsUserDisabled#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsDraft") and len(arguments.IsDraft)>
				AND thr.IsDraft = <cfqueryparam value="#arguments.IsDraft#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"UserID") and len(arguments.UserID)>
				AND thr.UserID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AdminID") and len(arguments.AdminID)>
				AND thr.AdminID = <cfqueryparam value="#arguments.AdminID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AdminMessage") and len(arguments.AdminMessage)>
				AND thr.AdminMessage = <cfqueryparam value="#arguments.AdminMessage#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Title") and len(arguments.Title)>
				AND thr.Title = <cfqueryparam value="#arguments.Title#" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments,"FriendlyName") and len(arguments.FriendlyName)>
				AND thr.FriendlyName = <cfqueryparam value="#arguments.FriendlyName#" CFSQLType="cf_sql_varchar" maxlength="200" />
			</cfif>
			
			<cfif structKeyExists(arguments,"OrderNo") and len(arguments.OrderNo)>
				AND thr.OrderNo = <cfqueryparam value="#arguments.OrderNo#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"PostCounter") and len(arguments.PostCounter)>
				AND thr.PostCounter = <cfqueryparam value="#arguments.PostCounter#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"LastPostID") and len(arguments.LastPostID)>
				AND thr.LastPostID = <cfqueryparam value="#arguments.LastPostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastPost") and len(arguments.DateLastPost)>
				AND thr.DateLastPost = <cfqueryparam value="#arguments.DateLastPost#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
				AND thr.RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND thr.DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND thr.DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Idx") and len(arguments.Idx)>
				AND thr.Idx = <cfqueryparam value="#arguments.Idx#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsAnnouncement") and len(arguments.IsAnnouncement)>
				AND thr.IsAnnouncement = <cfqueryparam value="#arguments.IsAnnouncement#" CFSQLType="cf_sql_tinyint" />
			</cfif>

			<cfif not arguments.isCount>
				<cfif structKeyExists(arguments,"orderby") and len(arguments.orderby)>
					ORDER BY #arguments.orderby#
				<cfelse>
					ORDER BY thr.typeID DESC,thr.dateLastPost DESC
				</cfif>
			</cfif>			
			<!--- if this is a MYSQL db, we can use LIMIT to get our start + count total and we are finished  --->
			<cfif variables.dsntype eq "mysql" and structKeyExists(arguments,"pageBean")>
				LIMIT <cfif len(arguments.pageBean.getPos())><cfqueryparam value="#arguments.pageBean.getPos()#" CFSQLType="cf_sql_integer"  />,</cfif> <cfqueryparam value="#arguments.pageBean.getSize()#" CFSQLType="cf_sql_integer"  />
			</cfif>
		</cfquery>
		
		<!--- if this is a MS SQL db, we have more work to do --->
		<cfif variables.dsntype eq "mssql" AND structKeyExists(arguments,"pageBean") AND arguments.pageBean.getPos() gt 0>
			<!--- first, get the first record set (start) we are excluding.  We only need the primary key.  --->
			<cfquery name="qExclude" dbtype="query" maxrows="#Ceiling(Val(arguments.pageBean.getPos()))#" >  
		       	SELECT
					threadID  
				FROM
					qList    
			</cfquery>
				
			<!--- next, we get the (count) records we actually want returned  --->
			<cfquery name="qKeep" dbtype="query" maxrows="#Ceiling(Val(arguments.pageBean.getCount()))#">  
				SELECT
					*  
				FROM  
					qList  
				WHERE  
			<!--- now we use the primary key to exclude the 'start' records we retrieved above --->  
				threadID NOT IN (<cfqueryparam value="#valueList(qExclude.threadID)#" list="true" />)  
			</cfquery> 
				
			<!--- to finish, we re-assign the QoQ to the initial query variable --->  
			<cfset qList = qKeep> 
		</cfif>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="TypeID" type="numeric" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsClosed" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsDraft" type="boolean" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="DateLastPost" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="IsAnnouncement" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="pageBean" type="any" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		
		<cfloop from="1" to="#qList.recordCount#" index="iiX">
			<cfset tmpObj = createObject("component","ThreadBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setThreadService( getThreadService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="ForumID" type="string" required="false" />
		<cfargument name="TypeID" type="numeric" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsClosed" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsDraft" type="boolean" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="AdminMessage" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="PostCounter" type="numeric" required="false" />
		<cfargument name="LastPostID" type="string" required="false" />
		<cfargument name="DateLastPost" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="IsAnnouncement" type="boolean" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfif qList.recordCount gt 1>
			<cfset tmpObj = createObject("component","ThreadBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setThreadService( getThreadService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","ThreadBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setThreadService( getThreadService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","ThreadBean").init()>
			<cfset tmpObj.setThreadService( getThreadService() ) />
			<cfreturn tmpObj />
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Any" >
		<cfargument name="idArray" type="array" required="true" />
		<cfargument name="format" type="string" required="false" default="query" />
		
		<cfset var qList			= "" />		
		<cfset var strObjects		= StructNew() />
		<cfset var tmpObj			= "" />
		<cfset var IDList			= "" />
		<cfset var iiX 				= "" />
		<cfset var sResults			= StructNew() />
		<cfset var aResults			= ArrayNew(1) />

		<cfif not arrayLen(arguments.idArray)>
			<cfreturn QueryNew('null') />
		</cfif>

		<cfset IDList = ArrayToList(arguments.idArray) />
		<cfset qList = getByAttributesQuery( idList=IDList,orderby="" ) />
		
		<cfswitch expression="#arguments.format#">
			<cfcase value="struct">
				<cfloop from="1" to="#qList.recordCount#" index="iiX">
					<cfset tmpObj = createObject("component","threadBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
					<cfset sResults[qList.threadID[iiX]] = tmpObj />
				</cfloop>
				<cfreturn sResults />
			</cfcase> 	
			<cfcase value="array">
				<cfloop from="1" to="#qList.recordCount#" index="iiX">
					<cfset tmpObj = createObject("component","threadBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
					<cfset ArrayAppend(aResults,tmpObj) />
				</cfloop>
				<cfreturn aResults />
			</cfcase> 	
			<cfdefaultcase>
				<cfreturn qList />
			</cfdefaultcase> 	
		</cfswitch> 
				
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
			FROM	#variables.dsnprefix#mf_thread thr
			LEFT JOIN
				#variables.dsnprefix#mf_post pst
			ON
				(
					thr.threadID = post.threadID
					AND
					post.postPosition = 0
					AND
					post.isActive = 1
					AND
					post.isDisabled = 0
					AND
					post.isApproved = 1
				)
			WHERE
				0=0

			<cfif structKeyExists(arguments.criteria,"IsActive") and len(arguments.criteria.IsActive)>
				AND thr.IsActive = <cfqueryparam value="#arguments.criteria.IsActive#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND thr.IsActive = <cfqueryparam value="1" CFSQLType="cf_sql_tinyint" />
			</cfif>

			<cfif structKeyExists(arguments.criteria,"IsDisabled") and len(arguments.criteria.IsDisabled)>
				AND thr.IsDisabled = <cfqueryparam value="#arguments.criteria.IsDisabled#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND thr.IsDisabled = <cfqueryparam value="0" CFSQLType="cf_sql_tinyint" />
			</cfif>

			<!---  --->

			<cfif structKeyExists(arguments.criteria,"ThreadID") and len(arguments.criteria.ThreadID)>
			AND thr.ThreadID = <cfqueryparam value="#arguments.criteria.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ForumID") and len(arguments.criteria.ForumID)>
			AND thr.ForumID = <cfqueryparam value="#arguments.criteria.ForumID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"TypeID") and len(arguments.criteria.TypeID)>
			AND thr.TypeID = <cfqueryparam value="#arguments.criteria.TypeID#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SiteID") and len(arguments.criteria.SiteID)>
			AND thr.SiteID LIKE <cfqueryparam value="%#arguments.criteria.SiteID#%" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsClosed") and len(arguments.criteria.IsClosed)>
			AND thr.IsClosed = <cfqueryparam value="#arguments.criteria.IsClosed#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsUserDisabled") and len(arguments.criteria.IsUserDisabled)>
			AND thr.IsUserDisabled = <cfqueryparam value="#arguments.criteria.IsUserDisabled#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsDraft") and len(arguments.criteria.IsDraft)>
			AND thr.IsDraft = <cfqueryparam value="#arguments.criteria.IsDraft#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"UserID") and len(arguments.criteria.UserID)>
			AND thr.UserID = <cfqueryparam value="#arguments.criteria.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AdminID") and len(arguments.criteria.AdminID)>
			AND thr.AdminID = <cfqueryparam value="#arguments.criteria.AdminID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AdminMessage") and len(arguments.criteria.AdminMessage)>
			AND thr.AdminMessage LIKE <cfqueryparam value="%#arguments.criteria.AdminMessage#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Title") and len(arguments.criteria.Title)>
			AND thr.Title LIKE <cfqueryparam value="%#arguments.criteria.Title#%" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"FriendlyName") and len(arguments.criteria.FriendlyName)>
			AND thr.FriendlyName LIKE <cfqueryparam value="%#arguments.criteria.FriendlyName#%" CFSQLType="cf_sql_varchar" maxlength="200" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"OrderNo") and len(arguments.criteria.OrderNo)>
			AND thr.OrderNo = <cfqueryparam value="#arguments.criteria.OrderNo#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PostCounter") and len(arguments.criteria.PostCounter)>
			AND thr.PostCounter = <cfqueryparam value="#arguments.criteria.PostCounter#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"LastPostID") and len(arguments.criteria.LastPostID)>
			AND thr.LastPostID = <cfqueryparam value="#arguments.criteria.LastPostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastPost") and len(arguments.criteria.DateLastPost)>
			AND thr.DateLastPost LIKE <cfqueryparam value="%#arguments.criteria.DateLastPost#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RemoteID") and len(arguments.criteria.RemoteID)>
			AND thr.RemoteID LIKE <cfqueryparam value="%#arguments.criteria.RemoteID#%" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateCreate") and len(arguments.criteria.DateCreate)>
			AND thr.DateCreate LIKE <cfqueryparam value="%#arguments.criteria.DateCreate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND thr.DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Idx") and len(arguments.criteria.Idx)>
			AND thr.Idx = <cfqueryparam value="#arguments.criteria.Idx#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsAnnouncement") and len(arguments.criteria.IsAnnouncement)>
			AND thr.IsAnnouncement = <cfqueryparam value="#arguments.criteria.IsAnnouncement#" CFSQLType="cf_sql_tinyint" />
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
				
					ThreadID
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
					ThreadID NOT IN (<cfqueryparam value="#valueList(qExclude.ThreadID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
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

	<cffunction name="setThreadService" access="public" returntype="void" output="false">
		<cfargument name="ThreadService" type="any" required="true" />
		<cfset variables['threadService'] = arguments.ThreadService />
	</cffunction>
	<cffunction name="getThreadService" access="public" returntype="any" output="false">
		<cfreturn variables.ThreadService />
	</cffunction>


<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="updateThreadCounter" access="public" output="false" returntype="void">
		<cfargument name="threadID" type="uuid" required="true" />
		<cfargument name="forumID" type="uuid" required="true"/>
		<cfargument name="currentCount" type="string" required="false" default="" />
		
		<cfset var qUpdate = "">

		<cfif isNumeric(arguments.currentCount)>
			<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
				UPDATE
					#variables.dsnprefix#mf_viewcounter
				SET
					views = <cfqueryparam value="#int(currentCount)#" CFSQLType="cf_sql_int" />
				WHERE
					threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
			</cfquery>
		<cfelse>
			<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
				UPDATE
					#variables.dsnprefix#mf_viewcounter
				SET
					views = views+1
				WHERE
					threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
			</cfquery>
		</cfif>
	</cffunction>

	<cffunction name="getForumIDByThreadID" access="public" output="false" returntype="string" description="retrieves the forum id for a particular thread">
		<cfargument name="threadID" type="uuid" required="true" />

		<cfset var qList			= "" />		

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				forumID
			FROM
				#variables.dsnprefix#mf_thread
			WHERE
				threadID = <cfqueryparam value="#arguments.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>

		<cfif qList.RecordCount>
			<cfreturn qList.forumID />
		</cfif>

		<cfreturn ""/>
	</cffunction>

	<cffunction name="getSearchedThreads" access="public" output="false" returntype="array">
		<cfargument name="qSearch" type="query" required="true" />

		<cfset var qList			= "" />		
		<cfset var qPost			= "" />		
		<cfset var sPosts			= StructNew() />		
		<cfset var tmpObj			= "" />
		<cfset var iiX 				= "" />
		<cfset var arrObjects		= ArrayNew(1) />

		<cfif not qSearch.recordCount>
			<cfreturn aResults />
		</cfif>

		<cfset qList = getByAttributesQuery( idList=valueList( qSearch.threadID ),orderby="" ) />
		<cfset sPosts = getPostGateway().getByArray( listToArray( valueList( qSearch.postID ) ),"struct" )>

		<cfloop from="1" to="#qList.recordCount#" index="iiX">
			<cfset tmpObj = createObject("component","threadBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfquery name="qPost" dbtype="query">
				SELECT
					postID
				FROM
					qSearch
				WHERE
					threadID = '#qList.threadID[iiX]#'
			</cfquery>
			
			<cfif qPost.RecordCount and StructKeyExists(sPosts,qPost.postID)>
				<cfset tmpObj.setLastPost( sPosts[qPost.postID] ) />				
			</cfif>

			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
		<cfreturn arrObjects />
	</cffunction>


	<cffunction name="getPostCount" access="public" output="false" returntype="numeric">
		<cfargument name="ThreadID" type="uuid" required="true" />
		<cfargument name="PostID" type="uuid" required="false" default=""/>
		<cfargument name="doIncrement" type="boolean" required="false" default="false" />
		<cfargument name="PostDate" type="date" required="false" default=""/>
		
		<cfset var qCount = "">
		<cfset var qList = "">

		<cfif arguments.doIncrement>
			<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
				UPDATE
					#variables.dsnprefix#mf_thread
				SET
					postCounter = 
					(
						SELECT COUNT(postID)
						FROM
						#variables.dsnprefix#mf_post
						WHERE
						threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
					)+1,
					dateLastPost = <cfqueryparam value="#createODBCDateTime( now() )#" CFSQLType="cf_sql_timestamp" />,
					lastPostID = <cfqueryparam value="#arguments.PostID#" CFSQLType="cf_sql_char" />
				WHERE
					threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
			</cfquery>
		</cfif>
			
		<cfquery name="qCount" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			SELECT
				postCounter
			FROM
				#variables.dsnprefix#mf_thread
			WHERE
				threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
		</cfquery>

		<cfreturn qCount.postCounter>
	</cffunction>

	<cffunction name="getCrumbData" access="public" output="false" returntype="array">
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="ThreadID" type="uuid" required="true" />
			
		<cfset var qList		= "" />
		<cfset var sObject		= StructNew() />
		<cfset var aCrumb		= ArrayNew(1) />
		<cfset var settingsBean	= getMeldForumsSettingsManager().getSiteSettings( siteID=arguments.siteID ) />
		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				thread.idx as thread_idx,thread.title as thread_title,thread.friendlyName as thread_friendlyName,
				forum.idx as forum_idx,forum.title as forum_title,forum.friendlyName as forum_friendlyName,
				conf.idx as conf_idx,conf.title as conf_title,conf.friendlyName as conf_friendlyName,conf.siteID
			FROM	#variables.dsnprefix#mf_thread thread
			JOIN	#variables.dsnprefix#mf_forum forum
			ON
				(forum.forumID = thread.forumID)
			JOIN	#variables.dsnprefix#mf_conference conf
			ON
				(forum.conferenceID = conf.conferenceID)
			WHERE	
				threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
			
		<cfif not qList.recordCount>
			<cfreturn aCrumb />
		</cfif>
			
		<cfset sObject.siteID			= qList.siteID />
		<cfset sObject.menutitle		= qList.conf_title />
		<cfset sObject.fileNameSuffix	= settingsBean.getURLKey() & "c" & qList.conf_idx & "-" & qList.conf_friendlyName />
		<cfset arrayAppend( aCrumb,sObject ) />
				
		<cfset sObject = StructNew() />
		<cfset sObject.siteID			= qList.siteID />
		<cfset sObject.menutitle		= qList.forum_title />
		<cfset sObject.fileNameSuffix	= settingsBean.getURLKey() & "f" & qList.forum_idx & "-" & qList.forum_friendlyName />
		<cfset arrayAppend( aCrumb,sObject ) />
		<cfset sObject = StructNew() />
		
		<cfset sObject.siteID			= qList.siteID />
		<cfset sObject.menutitle		= qList.thread_title />
		<cfset sObject.fileNameSuffix	= settingsBean.getURLKey() & "t" & qList.thread_idx & "-" & qList.thread_friendlyName />

		<cfset arrayAppend( aCrumb,sObject ) />

		<cfreturn aCrumb />
	</cffunction>

	<cffunction name="blockByUserID" access="public" output="false" returntype="void">
		<cfargument name="userID" type="uuid" required="true" />
		<cfargument name="type" type="numeric" required="false" default="2" />

		<cfset var qList		= "" />
		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
			#variables.dsnprefix#mf_thread
			SET
				isDisabled = <cfqueryparam value="#arguments.type#" CFSQLType="cf_sql_integer" />
			WHERE	
				userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
	</cffunction>

	<cffunction name="unblockByUserID" access="public" output="false" returntype="void">
		<cfargument name="userID" type="uuid" required="true" />
		<cfargument name="type" type="numeric" required="false" default="2" />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
			#variables.dsnprefix#mf_thread
			SET
				isDisabled = <cfqueryparam value="0" CFSQLType="cf_sql_integer" />
			WHERE	
				userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				isDisabled = <cfqueryparam value="#arguments.type#" CFSQLType="cf_sql_integer" />			
		</cfquery>
	</cffunction>

	<cffunction name="deleteThreads" access="public" output="false" returntype="boolean">
		<cfargument name="ForumID" type="uuid" required="true" />
	
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
			#variables.dsnprefix#mf_post
			WHERE	
				threadID IN
				(
					SELECT
						threadID
					FROM
						#variables.dsnprefix#mf_thread
					WHERE
						forumID = <cfqueryparam value="#arguments.ForumID#" CFSQLType="cf_sql_char" maxlength="35" />
				)
		</cfquery>
			
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE FROM
			#variables.dsnprefix#mf_thread
			WHERE	
				forumID = <cfqueryparam value="#arguments.ForumID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
			
		<cfreturn true />
	</cffunction>
	
<!---^^CUSTOMEND^^--->

	<cffunction name="setPostGateway" access="public" returntype="any" output="false">
		<cfargument name="PostGateway" type="any" required="true">
		<cfset variables.PostGateway = arguments.PostGateway>
	</cffunction>
	<cffunction name="getPostGateway" access="public" returntype="any" output="false">
		<cfreturn variables.PostGateway>
	</cffunction>

	<cffunction name="setMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfargument name="MeldForumsSettingsManager" type="any" required="true">
		<cfset variables.MeldForumsSettingsManager = arguments.MeldForumsSettingsManager>
	</cffunction>
	<cffunction name="getMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldForumsSettingsManager>
	</cffunction>
</cfcomponent>	






