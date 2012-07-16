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
<cfcomponent displayname="DisplayGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="DisplayGateway">
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
		<cfargument name="DisplayID" type="uuid" required="false" />
		<cfargument name="DisplayTypeID" type="string" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="Notes" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="ContentID" type="string" required="false" />
		<cfargument name="IsValid" type="boolean" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mf_display
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"DisplayID") and len(arguments.DisplayID)>
				AND DisplayID = <cfqueryparam value="#arguments.DisplayID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DisplayTypeID") and len(arguments.DisplayTypeID)>
				AND DisplayTypeID = <cfqueryparam value="#arguments.DisplayTypeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ObjectID") and len(arguments.ObjectID)>
				AND ObjectID = <cfqueryparam value="#arguments.ObjectID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
				AND Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"SiteID") and len(arguments.SiteID)>
				AND SiteID = <cfqueryparam value="#arguments.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Params") and len(arguments.Params)>
				AND Params = <cfqueryparam value="#arguments.Params#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Notes") and len(arguments.Notes)>
				AND Notes = <cfqueryparam value="#arguments.Notes#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsActive") and len(arguments.IsActive)>
				AND IsActive = <cfqueryparam value="#arguments.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AdminID") and len(arguments.AdminID)>
				AND AdminID = <cfqueryparam value="#arguments.AdminID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ModuleID") and len(arguments.ModuleID)>
				AND ModuleID = <cfqueryparam value="#arguments.ModuleID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ContentID") and len(arguments.ContentID)>
				AND ContentID = <cfqueryparam value="#arguments.ContentID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsValid") and len(arguments.IsValid)>
				AND IsValid = <cfqueryparam value="#arguments.IsValid#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Settings") and len(arguments.Settings)>
				AND Settings = <cfqueryparam value="#arguments.Settings#" CFSQLType="cf_sql_longvarchar" />
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
		<cfargument name="DisplayID" type="uuid" required="false" />
		<cfargument name="DisplayTypeID" type="string" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="Notes" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="ContentID" type="string" required="false" />
		<cfargument name="IsValid" type="boolean" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","DisplayBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setDisplayService( getDisplayService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="DisplayID" type="uuid" required="false" />
		<cfargument name="DisplayTypeID" type="string" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Params" type="string" required="false" />
		<cfargument name="Notes" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="AdminID" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="ContentID" type="string" required="false" />
		<cfargument name="IsValid" type="boolean" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfif qList.recordCount gt 1>
			<cfset tmpObj = createObject("component","DisplayBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setDisplayService( getDisplayService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","DisplayBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setDisplayService( getDisplayService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","DisplayBean").init()>
			<cfset tmpObj.setDisplayService( getDisplayService() ) />
			<cfreturn tmpObj />
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		
		<cfargument name="aDisplayID" type="array" required="true" />
		
		
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
				#variables.dsnprefix#mf_display
			WHERE
				0=0
		
			AND
			DisplayID IN (<cfqueryparam value="#aDisplayID#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
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
			FROM	#variables.dsnprefix#mf_display
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"DisplayID") and len(arguments.criteria.DisplayID)>
			AND DisplayID = <cfqueryparam value="#arguments.criteria.DisplayID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DisplayTypeID") and len(arguments.criteria.DisplayTypeID)>
			AND DisplayTypeID = <cfqueryparam value="#arguments.criteria.DisplayTypeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ObjectID") and len(arguments.criteria.ObjectID)>
			AND ObjectID = <cfqueryparam value="#arguments.criteria.ObjectID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Name") and len(arguments.criteria.Name)>
			AND Name LIKE <cfqueryparam value="%#arguments.criteria.Name#%" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateCreate") and len(arguments.criteria.DateCreate)>
			AND DateCreate LIKE <cfqueryparam value="%#arguments.criteria.DateCreate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SiteID") and len(arguments.criteria.SiteID)>
			AND SiteID LIKE <cfqueryparam value="%#arguments.criteria.SiteID#%" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Params") and len(arguments.criteria.Params)>
			AND Params LIKE <cfqueryparam value="%#arguments.criteria.Params#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Notes") and len(arguments.criteria.Notes)>
			AND Notes LIKE <cfqueryparam value="%#arguments.criteria.Notes#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsActive") and len(arguments.criteria.IsActive)>
			AND IsActive = <cfqueryparam value="#arguments.criteria.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AdminID") and len(arguments.criteria.AdminID)>
			AND AdminID = <cfqueryparam value="#arguments.criteria.AdminID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ModuleID") and len(arguments.criteria.ModuleID)>
			AND ModuleID = <cfqueryparam value="#arguments.criteria.ModuleID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ContentID") and len(arguments.criteria.ContentID)>
			AND ContentID = <cfqueryparam value="#arguments.criteria.ContentID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsValid") and len(arguments.criteria.IsValid)>
			AND IsValid = <cfqueryparam value="#arguments.criteria.IsValid#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Settings") and len(arguments.criteria.Settings)>
			AND Settings LIKE <cfqueryparam value="%#arguments.criteria.Settings#%" CFSQLType="cf_sql_longvarchar" />
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
				
					DisplayID
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
					DisplayID NOT IN (<cfqueryparam value="#valueList(qExclude.DisplayID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
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

	<cffunction name="setDisplayService" access="public" returntype="void" output="false">
		<cfargument name="DisplayService" type="any" required="true" />
		<cfset variables['displayService'] = arguments.DisplayService />
	</cffunction>
	<cffunction name="getDisplayService" access="public" returntype="any" output="false">
		<cfreturn variables.DisplayService />
	</cffunction>


<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	



