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
<cfcomponent displayname="SearchableGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cfset variables.instance = StructNew() />
	<cffunction name="init" access="public" output="false" returntype="SearchableGateway">
		<cfargument name="MeldConfig" type="any" required="true">

		<cfset variables.MeldConfig = arguments.MeldConfig />
		
		<cfset structAppend(variables.instance,structCopy(variables.MeldConfig.getAllValues()),true) />
		<cfset structAppend(variables,structCopy(variables.MeldConfig.getAllValues()),true) />

		<cfreturn this>
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="Searchblock" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mf_searchable
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"ThreadID") and len(arguments.ThreadID)>
				AND ThreadID = <cfqueryparam value="#arguments.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"PostID") and len(arguments.PostID)>
				AND PostID = <cfqueryparam value="#arguments.PostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Searchblock") and len(arguments.Searchblock)>
				AND Searchblock = <cfqueryparam value="#arguments.Searchblock#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			<!---^^VALUES-END^^--->
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="Searchblock" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","SearchableBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setSearchableService( getSearchableService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="Searchblock" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfif qList.recordCount gt 1>
			<cfset tmpObj = createObject("component","SearchableBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setSearchableService( getSearchableService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","SearchableBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setSearchableService( getSearchableService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","SearchableBean").init()>
			<cfset tmpObj.setSearchableService( getSearchableService() ) />
			<cfreturn tmpObj />
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />
		
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
				#variables.dsnprefix#mf_searchable
			WHERE
				0=0
		
			AND
			ThreadID IN (<cfqueryparam value="#aThreadID#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
			AND
			PostID IN (<cfqueryparam value="#idArray#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
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
					COUNT(mf_searchable.postID) AS total
				<cfelse>
					#returnFields#
				</cfif>
			FROM	#variables.dsnprefix#mf_searchable
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"ThreadID") and len(arguments.criteria.ThreadID)>
			AND ThreadID = <cfqueryparam value="#arguments.criteria.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PostID") and len(arguments.criteria.PostID)>
			AND PostID = <cfqueryparam value="#arguments.criteria.PostID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Searchblock") and len(arguments.criteria.Searchblock)>
			AND Searchblock LIKE <cfqueryparam value="%#arguments.criteria.Searchblock#%" CFSQLType="cf_sql_longvarchar" />
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
				
					ThreadID,
				
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
					ThreadID NOT IN (<cfqueryparam value="#valueList(qExclude.ThreadID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
					)  
				
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

	<cffunction name="setSearchableService" access="public" returntype="void" output="false">
		<cfargument name="SearchableService" type="any" required="true" />
		<cfset variables['searchableService'] = arguments.SearchableService />
	</cffunction>
	<cffunction name="getSearchableService" access="public" returntype="any" output="false">
		<cfreturn variables.SearchableService />
	</cffunction>


<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->

	<cffunction name="rebuildSearch" access="public" output="false" returntype="void">

		<cfset var qList	= "" />		
		<cfset var qClear	= "" />		
		<cfset var qUp	= "" />		
		<cfset var count	= 0 />		
		<cfset var searchContent	= "" /> <!---  /> --->

		<cfquery name="qClear" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			DELETE
			FROM	#variables.dsnprefix#mf_searchable
		</cfquery>

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				mfp.threadID,mfp.postID,mfp.message,mft.title
			FROM
				#variables.dsnprefix#mf_post mfp
			JOIN
				#variables.dsnprefix#mf_thread mft
				ON
				(mfp.threadID = mft.threadID)
			WHERE
				mfp.isDisabled = 0
				AND
				mfp.isActive = 1
				AND
				mfp.isApproved = 1
		</cfquery>

		<cfloop query="qList">
			<cfquery name="qUp" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
				INSERT INTO
					#variables.dsnprefix#mf_searchable
					(
					ThreadID,
					PostID,
					Searchblock,
					DateCreate,
					DateLastUpdate
						)
					VALUES
					(
					<cfqueryparam value="#qList.threadID#" CFSQLType="cf_sql_char" maxlength="35" />,
					<cfqueryparam value="#qList.postID#" CFSQLType="cf_sql_char" maxlength="35" />,
					<cfqueryparam value="#getmmUtility().stripAll( qList.title & " ~ " & qList.message )#" CFSQLType="cf_sql_longvarchar" />,
					<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />,
					<cfqueryparam value="#CreateODBCDateTime(now())#" CFSQLType="cf_sql_timestamp" />
					)
			</cfquery>
		</cfloop>

	</cffunction>


<!---^^CUSTOMEND^^--->
</cfcomponent>	







