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
<cfcomponent displayname="ViewcounterGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ViewcounterGateway">
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
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ForumID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="Views" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mf_viewcounter
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"ForumID") and len(arguments.ForumID)>
				AND ForumID = <cfqueryparam value="#arguments.ForumID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ThreadID") and len(arguments.ThreadID)>
				AND ThreadID = <cfqueryparam value="#arguments.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Views") and len(arguments.Views)>
				AND Views = <cfqueryparam value="#arguments.Views#" CFSQLType="cf_sql_integer" />
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
		<cfargument name="ForumID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="Views" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ViewcounterBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setViewcounterService( getViewcounterService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ForumID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="Views" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfif qList.recordCount gt 1>
			<cfset tmpObj = createObject("component","ViewcounterBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setViewcounterService( getViewcounterService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","ViewcounterBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setViewcounterService( getViewcounterService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","ViewcounterBean").init()>
			<cfset tmpObj.setViewcounterService( getViewcounterService() ) />
			<cfreturn tmpObj />
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		
		<cfargument name="aForumID" type="array" required="true" />
		
		<cfargument name="aThreadID" type="array" required="true" />
		
		
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
				#variables.dsnprefix#mf_viewcounter
			WHERE
				0=0
		
			AND
			ForumID IN (<cfqueryparam value="#aForumID#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
			AND
			ThreadID IN (<cfqueryparam value="#aThreadID#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
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
			FROM	#variables.dsnprefix#mf_viewcounter
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"ForumID") and len(arguments.criteria.ForumID)>
			AND ForumID = <cfqueryparam value="#arguments.criteria.ForumID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ThreadID") and len(arguments.criteria.ThreadID)>
			AND ThreadID = <cfqueryparam value="#arguments.criteria.ThreadID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Views") and len(arguments.criteria.Views)>
			AND Views = <cfqueryparam value="#arguments.criteria.Views#" CFSQLType="cf_sql_integer" />
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
				
					ForumID,
				
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
					ForumID NOT IN (<cfqueryparam value="#valueList(qExclude.ForumID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
					)  
				
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

	<cffunction name="setViewcounterService" access="public" returntype="void" output="false">
		<cfargument name="ViewcounterService" type="any" required="true" />
		<cfset variables['viewcounterService'] = arguments.ViewcounterService />
	</cffunction>
	<cffunction name="getViewcounterService" access="public" returntype="any" output="false">
		<cfreturn variables.ViewcounterService />
	</cffunction>


<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	


