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
<cfcomponent displayname="PostGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="PostGateway">
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
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="Message" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsModerated" type="boolean" required="false" />
		<cfargument name="DateModerated" type="string" required="false" />
		<cfargument name="DoBlockAttachment" type="boolean" required="false" />
		<cfargument name="AttachmentID" type="string" required="false" />
		<cfargument name="PostPosition" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="ParentID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="idList" type="string" required="false" />
		<cfargument name="pageBean" type="any" required="false" />
		<cfargument name="isCount" type="any" required="false" default="false" />
		<cfargument name="siteID" type="string" required="false" default="" />

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
				COUNT(pst.postID) AS total
			<cfelse>
				*,1 AS BeanExists,
				thr.title AS Title,thr.idx AS threadIDX,thr.friendlyName as threadFriendlyName,thr.siteID as siteID
			</cfif>
			FROM	#variables.dsnprefix#mf_post pst
			<cfif not arguments.isCount or len(arguments.siteID)>
			JOIN
				#variables.dsnprefix#mf_thread thr
				ON
				(
				pst.threadID = thr.threadID
				<cfif len(arguments.siteID)>
					AND
					thr.siteID = <cfqueryparam value="#arguments.siteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
				</cfif>
				)
			</cfif>
			WHERE	0=0

			<cfif structKeyExists(arguments,"idList") and len(arguments.idList)>
				AND pst.postID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
			</cfif>

			<cfif structKeyExists(arguments,"IsActive") and len(arguments.IsActive)>
				AND pst.IsActive = <cfqueryparam value="#arguments.IsActive#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND pst.IsActive = <cfqueryparam value="1" CFSQLType="cf_sql_tinyint" />
			</cfif>

			<cfif structKeyExists(arguments,"IsDisabled") and len(arguments.IsDisabled)>
				AND pst.IsDisabled = <cfqueryparam value="#arguments.IsDisabled#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND pst.IsDisabled = <cfqueryparam value="0" CFSQLType="cf_sql_tinyint" />
			</cfif>

			<!---  --->
							
			<cfif structKeyExists(arguments,"PostID") AND len(arguments.PostID)>
				AND pst.PostID = <cfqueryparam value="#arguments.PostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
				
			<cfif structKeyExists(arguments,"ThreadID") AND len(arguments.ThreadID)>
				AND pst.ThreadID = <cfqueryparam value="#arguments.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"UserID") AND len(arguments.UserID)>
				AND pst.UserID = <cfqueryparam value="#arguments.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AdminID") AND len(arguments.AdminID)>
				AND pst.AdminID = <cfqueryparam value="#arguments.AdminID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Message") AND len(arguments.Message)>
				AND pst.Message = <cfqueryparam value="#arguments.Message#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsApproved") AND len(arguments.IsApproved)>
				AND pst.IsApproved = <cfqueryparam value="#arguments.IsApproved#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsUserDisabled") AND len(arguments.IsUserDisabled)>
				AND pst.IsUserDisabled = <cfqueryparam value="#arguments.IsUserDisabled#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsModerated") AND len(arguments.IsModerated)>
				AND pst.IsModerated = <cfqueryparam value="#arguments.IsModerated#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateModerated") AND len(arguments.DateModerated)>
				AND pst.DateModerated = <cfqueryparam value="#arguments.DateModerated#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoBlockAttachment") AND len(arguments.DoBlockAttachment)>
				AND pst.DoBlockAttachment = <cfqueryparam value="#arguments.DoBlockAttachment#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AttachmentID") AND len(arguments.AttachmentID)>
				AND pst.AttachmentID = <cfqueryparam value="#arguments.AttachmentID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"PostPosition") AND len(arguments.PostPosition)>
				AND pst.PostPosition = <cfqueryparam value="#arguments.PostPosition#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RemoteID") AND len(arguments.RemoteID)>
				AND pst.RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") AND len(arguments.DateCreate)>
				AND pst.DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") AND len(arguments.DateLastUpdate)>
				AND pst.DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Idx") AND len(arguments.Idx)>
				AND pst.Idx = <cfqueryparam value="#arguments.Idx#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ParentID") AND len(arguments.ParentID)>
				AND pst.ParentID = <cfqueryparam value="#arguments.ParentID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
		<cfif not arguments.isCount and structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		<!--- if this is a MYSQL db, we can use LIMIT to get our start + count total and we are finished  --->
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
					postID  
				FROM
					qList    
			</cfquery>
			
			<cfquery name="qKeep" dbtype="query" maxrows="#Ceiling(Val(arguments.pageBean.getCount()))#">  
				SELECT
					*  
				FROM  
					qList  
				WHERE  
					postID NOT IN (<cfqueryparam value="#valueList(qExclude.postID)#" list="true" />)  
			</cfquery> 

			<cfset qList = qKeep> 
		</cfif>
	
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="Message" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsModerated" type="boolean" required="false" />
		<cfargument name="DateModerated" type="string" required="false" />
		<cfargument name="DoBlockAttachment" type="boolean" required="false" />
		<cfargument name="AttachmentID" type="string" required="false" />
		<cfargument name="PostPosition" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="ParentID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="pageBean" type="any" required="false" />
		<cfargument name="siteID" type="string" required="false" default="" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfloop from="1" to="#qList.recordCount#" index="iiX">
			<cfset tmpObj = createObject("component","PostBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setPostService( getPostService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="UserID" type="string" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="Message" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="IsDisabled" type="boolean" required="false" />
		<cfargument name="IsApproved" type="boolean" required="false" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" />
		<cfargument name="IsModerated" type="boolean" required="false" />
		<cfargument name="DateModerated" type="string" required="false" />
		<cfargument name="DoBlockAttachment" type="boolean" required="false" />
		<cfargument name="AttachmentID" type="string" required="false" />
		<cfargument name="PostPosition" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<cfargument name="ParentID" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfif qList.recordCount gt 1>
			<cfset tmpObj = createObject("component","PostBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setPostService( getPostService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","PostBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setPostService( getPostService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","PostBean").init()>
			<cfset tmpObj.setPostService( getPostService() ) />
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
					<cfset tmpObj = createObject("component","PostBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
					<cfset sResults[qList.postID[iiX]] = tmpObj />
				</cfloop>
				<cfreturn sResults />
			</cfcase> 	
			<cfcase value="array">
				<cfloop from="1" to="#qList.recordCount#" index="iiX">
					<cfset tmpObj = createObject("component","PostBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
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
			FROM	#variables.dsnprefix#mf_post
			WHERE
				0=0

			<cfif structKeyExists(arguments.criteria,"IsActive") and len(arguments.criteria.IsActive)>
				AND pst.IsActive = <cfqueryparam value="#arguments.criteria.IsActive#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND pst.IsActive = <cfqueryparam value="1" CFSQLType="cf_sql_tinyint" />
			</cfif>

			<cfif structKeyExists(arguments.criteria,"IsDisabled") and len(arguments.criteria.IsDisabled)>
				AND pst.IsDisabled = <cfqueryparam value="#arguments.criteria.IsDisabled#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND pst.IsDisabled = <cfqueryparam value="0" CFSQLType="cf_sql_tinyint" />
			</cfif>
<!---  --->
			<cfif structKeyExists(arguments.criteria,"PostID") and len(arguments.criteria.PostID)>
			AND PostID = <cfqueryparam value="#arguments.criteria.PostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ThreadID") and len(arguments.criteria.ThreadID)>
			AND ThreadID = <cfqueryparam value="#arguments.criteria.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"UserID") and len(arguments.criteria.UserID)>
			AND UserID = <cfqueryparam value="#arguments.criteria.UserID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AdminID") and len(arguments.criteria.AdminID)>
			AND AdminID = <cfqueryparam value="#arguments.criteria.AdminID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Message") and len(arguments.criteria.Message)>
			AND Message LIKE <cfqueryparam value="%#arguments.criteria.Message#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsApproved") and len(arguments.criteria.IsApproved)>
			AND IsApproved = <cfqueryparam value="#arguments.criteria.IsApproved#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsUserDisabled") and len(arguments.criteria.IsUserDisabled)>
			AND IsUserDisabled = <cfqueryparam value="#arguments.criteria.IsUserDisabled#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsModerated") and len(arguments.criteria.IsModerated)>
			AND IsModerated = <cfqueryparam value="#arguments.criteria.IsModerated#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateModerated") and len(arguments.criteria.DateModerated)>
			AND DateModerated LIKE <cfqueryparam value="%#arguments.criteria.DateModerated#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoBlockAttachment") and len(arguments.criteria.DoBlockAttachment)>
			AND DoBlockAttachment = <cfqueryparam value="#arguments.criteria.DoBlockAttachment#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AttachmentID") and len(arguments.criteria.AttachmentID)>
			AND AttachmentID = <cfqueryparam value="#arguments.criteria.AttachmentID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PostPosition") and len(arguments.criteria.PostPosition)>
			AND PostPosition = <cfqueryparam value="#arguments.criteria.PostPosition#" CFSQLType="cf_sql_integer" />
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
			
			<cfif structKeyExists(arguments.criteria,"Idx") and len(arguments.criteria.Idx)>
			AND Idx = <cfqueryparam value="#arguments.criteria.Idx#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ParentID") and len(arguments.criteria.ParentID)>
			AND ParentID = <cfqueryparam value="#arguments.criteria.ParentID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>

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
				
					PostID
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
					PostID NOT IN (<cfqueryparam value="#valueList(qExclude.PostID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
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

	<cffunction name="setPostService" access="public" returntype="void" output="false">
		<cfargument name="PostService" type="any" required="true" />
		<cfset variables['postService'] = arguments.PostService />
	</cffunction>
	<cffunction name="getPostService" access="public" returntype="any" output="false">
		<cfreturn variables.PostService />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="getForumIDByPostID" access="public" output="false" returntype="string" description="retrieves the forum id for a particular thread">
		<cfargument name="postID" type="uuid" required="true" />

		<cfset var qList			= "" />		

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				thr.forumID
			FROM
				#variables.dsnprefix#mf_post pst
			JOIN
				#variables.dsnprefix#mf_thread thr
			ON
				pst.threadID = thr.threadID
			WHERE
				postID = <cfqueryparam value="#arguments.postID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>

		<cfif qList.RecordCount>
			<cfreturn qList.forumID />
		</cfif>

		<cfreturn ""/>
	</cffunction>

	<cffunction name="getCrumbData" access="public" output="false" returntype="array">
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="postID" type="uuid" required="true" />
		
		<cfset var qList		= "" />
		<cfset var sObject		= StructNew() />
		<cfset var aCrumb		= ArrayNew(1) />
		<cfset var settingsBean	= getMeldForumsSettingsManager().getSiteSettings( siteID=arguments.siteID ) />
		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				thread.idx as thread_idx,thread.title as thread_title,thread.friendlyName as thread_friendlyName,
				forum.idx as forum_idx,forum.title as forum_title,forum.friendlyName as forum_friendlyName,
				conf.idx as conf_idx,conf.title as conf_title,conf.friendlyName as conf_friendlyName,conf.siteID
			FROM	#variables.dsnprefix#mf_post post
			JOIN	#variables.dsnprefix#mf_thread thread
			ON
				(post.threadID = thread.threadID)
			JOIN	#variables.dsnprefix#mf_forum forum
			ON
				(thread.forumID = forum.forumID)
			JOIN	#variables.dsnprefix#mf_conference conf
			ON
				(forum.conferenceID = conf.conferenceID)
			WHERE	
				postID = <cfqueryparam value="#arguments.postID#" CFSQLType="cf_sql_char" maxlength="35" />
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

	<cffunction name="getPostPosition" access="public" output="false" returntype="numeric">
		<cfargument name="ThreadID" type="uuid" required="true" />
		
		<cfset var qList = "">

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			SELECT
				MAX(postPosition) as postPosition
			FROM
				#variables.dsnprefix#mf_post
			WHERE
				threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
		</cfquery>

		<cfreturn qList.postPosition>
	</cffunction>

	<cffunction name="setPageByPosition" access="public" output="false" returntype="Numeric">
		<cfargument name="threadID" type="uuid" required="true" />
		<cfargument name="pageBean" type="any" required="true" />

		<cfset var qList = "">

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			SELECT
				COUNT(postID) as pageCount
			FROM
				#variables.dsnprefix#mf_post
			WHERE
				threadID = <cfqueryparam value="#arguments.threadID#" CFSQLType="cf_sql_char" />
			AND
				postPosition <= <cfqueryparam value="#pageBean.getPagePosition()#" CFSQLType="cf_sql_integer" />
		</cfquery>
		
		<cfset pageBean.setPage( ceiling(qList.pageCount / pageBean.getSize()) ) />

		<cfreturn pageBean.getPage() />
	</cffunction>

	<cffunction name="blockByUserID" access="public" output="false" returntype="void">
		<cfargument name="userID" type="uuid" required="true" />
		<cfargument name="type" type="numeric" required="false" default="2" />

		<cfset var qList		= "" />
		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
			#variables.dsnprefix#mf_post
			SET
				isDisabled = <cfqueryparam value="#arguments.type#" CFSQLType="cf_sql_integer" />
			WHERE	
				userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
	</cffunction>

	<cffunction name="unblockByUserID" access="public" output="false" returntype="void">
		<cfargument name="userID" type="uuid" required="true" />
		<cfargument name="type" type="numeric" required="false" default="2" />

		<cfset var qList = "" />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			UPDATE
			#variables.dsnprefix#mf_post
			SET
				isDisabled = <cfqueryparam value="0" CFSQLType="cf_sql_integer" />
			WHERE	
				userID = <cfqueryparam value="#arguments.userID#" CFSQLType="cf_sql_char" maxlength="35" />
			AND
				isDisabled = <cfqueryparam value="#arguments.type#" CFSQLType="cf_sql_integer" />			
		</cfquery>
	</cffunction>

	<cffunction name="getRecentActivity" access="public" output="false" returntype="array">
		<cfargument name="pageBean" type="any" required="true" />
	
		<cfset var qList = "" />
		<cfset var aList = ArrayNew(1) />

		<cfset var sArgs = StructNew() />

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
			<cfif variables.dsntype eq "mssql"> 	
				TOP  #( Ceiling(Val(arguments.pageBean.getPos())) + Ceiling(Val(arguments.pageBean.getSize())) )#
			</cfif>
				mfpost.threadID,mfpost.postID
			FROM
				#variables.dsnprefix#mf_post mfpost
			JOIN
				#variables.dsnprefix#mf_thread mfthread
			ON
				(mfpost.threadID = mfthread.threadID)
			JOIN
				#variables.dsnprefix#mf_forum mfforum
			ON
				(mfthread.forumID = mfforum.forumID)
			GROUP BY
				mfpost.threadID
				<cfif variables.dsntype eq "mssql">
				,mfpost.postID,mfpost.datelastupdate
				</cfif>
			ORDER BY
				mfpost.dateLastUpdate DESC			
			<cfif variables.dsntype eq "mysql">
				LIMIT <cfif len(arguments.pageBean.getPos())><cfqueryparam value="#arguments.pageBean.getPos()#" CFSQLType="cf_sql_integer"  />,</cfif> <cfqueryparam value="#arguments.pageBean.getSize()#" CFSQLType="cf_sql_integer"  />
			</cfif>
		</cfquery>

		<cfset sArgs.idList		= valueList( qList.postID ) /> 
		<cfset sArgs.orderBy	= "pst.dateLastUpdate DESC" /> 
		<cfset sArgs.pageBean	= arguments.pageBean /> 

		<cfreturn getByAttributes( argumentCollection=sArgs ) />
	</cffunction>

<!---^^CUSTOMEND^^--->
	
	<cffunction name="setMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfargument name="MeldForumsSettingsManager" type="any" required="true">
		<cfset variables.MeldForumsSettingsManager = arguments.MeldForumsSettingsManager>
	</cffunction>
	<cffunction name="getMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldForumsSettingsManager>
	</cffunction>

</cfcomponent>	











