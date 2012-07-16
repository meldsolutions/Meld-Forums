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
<cfcomponent displayname="ThemeGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ThemeGateway">
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
		<cfargument name="ThemeID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="PackageName" type="string" required="false" />
		<cfargument name="AvatarSmallWidth" type="numeric" required="false" />
		<cfargument name="AvatarSmallHeight" type="numeric" required="false" />
		<cfargument name="AvatarMediumWidth" type="numeric" required="false" />
		<cfargument name="AvatarMediumHeight" type="numeric" required="false" />
		<cfargument name="AvatarDimensionType" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="DefaultAvatar" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="Style" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mf_theme
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"ThemeID") and len(arguments.ThemeID)>
				AND ThemeID = <cfqueryparam value="#arguments.ThemeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
				AND Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"PackageName") and len(arguments.PackageName)>
				AND PackageName = <cfqueryparam value="#arguments.PackageName#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarSmallWidth") and len(arguments.AvatarSmallWidth)>
				AND AvatarSmallWidth = <cfqueryparam value="#arguments.AvatarSmallWidth#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarSmallHeight") and len(arguments.AvatarSmallHeight)>
				AND AvatarSmallHeight = <cfqueryparam value="#arguments.AvatarSmallHeight#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarMediumWidth") and len(arguments.AvatarMediumWidth)>
				AND AvatarMediumWidth = <cfqueryparam value="#arguments.AvatarMediumWidth#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarMediumHeight") and len(arguments.AvatarMediumHeight)>
				AND AvatarMediumHeight = <cfqueryparam value="#arguments.AvatarMediumHeight#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AvatarDimensionType") and len(arguments.AvatarDimensionType)>
				AND AvatarDimensionType = <cfqueryparam value="#arguments.AvatarDimensionType#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Settings") and len(arguments.Settings)>
				AND Settings = <cfqueryparam value="#arguments.Settings#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DefaultAvatar") and len(arguments.DefaultAvatar)>
				AND DefaultAvatar = <cfqueryparam value="#arguments.DefaultAvatar#" CFSQLType="cf_sql_varchar" maxlength="80" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsMaster") and len(arguments.IsMaster)>
				AND IsMaster = <cfqueryparam value="#arguments.IsMaster#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Style") and len(arguments.Style)>
				AND Style = <cfqueryparam value="#arguments.Style#" CFSQLType="cf_sql_varchar" maxlength="12" />
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
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThemeID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="PackageName" type="string" required="false" />
		<cfargument name="AvatarSmallWidth" type="numeric" required="false" />
		<cfargument name="AvatarSmallHeight" type="numeric" required="false" />
		<cfargument name="AvatarMediumWidth" type="numeric" required="false" />
		<cfargument name="AvatarMediumHeight" type="numeric" required="false" />
		<cfargument name="AvatarDimensionType" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="DefaultAvatar" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="Style" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		<cfloop from="1" to="#qList.recordCount#" index="iiX">
			<cfset tmpObj = createObject("component","ThemeBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setThemeService( getThemeService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThemeID" type="uuid" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="PackageName" type="string" required="false" />
		<cfargument name="AvatarSmallWidth" type="numeric" required="false" />
		<cfargument name="AvatarSmallHeight" type="numeric" required="false" />
		<cfargument name="AvatarMediumWidth" type="numeric" required="false" />
		<cfargument name="AvatarMediumHeight" type="numeric" required="false" />
		<cfargument name="AvatarDimensionType" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="DefaultAvatar" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="Style" type="string" required="false" />
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
			<cfset tmpObj = createObject("component","ThemeBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setThemeService( getThemeService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","ThemeBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setThemeService( getThemeService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","ThemeBean").init()>
			<cfset tmpObj.setThemeService( getThemeService() ) />
			<cfreturn tmpObj />
		</cfif>
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		
		<cfargument name="aThemeID" type="array" required="true" />
		
		
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
				#variables.dsnprefix#mf_theme
			WHERE
				0=0
		
			AND
			ThemeID IN (<cfqueryparam value="#aThemeID#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
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
			FROM	#variables.dsnprefix#mf_theme
			WHERE
				0=0
				<!---^^SEARCH-START^^--->
			<cfif structKeyExists(arguments.criteria,"ThemeID") and len(arguments.criteria.ThemeID)>
			AND ThemeID = <cfqueryparam value="#arguments.criteria.ThemeID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Name") and len(arguments.criteria.Name)>
			AND Name LIKE <cfqueryparam value="%#arguments.criteria.Name#%" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"PackageName") and len(arguments.criteria.PackageName)>
			AND PackageName LIKE <cfqueryparam value="%#arguments.criteria.PackageName#%" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarSmallWidth") and len(arguments.criteria.AvatarSmallWidth)>
			AND AvatarSmallWidth = <cfqueryparam value="#arguments.criteria.AvatarSmallWidth#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarSmallHeight") and len(arguments.criteria.AvatarSmallHeight)>
			AND AvatarSmallHeight = <cfqueryparam value="#arguments.criteria.AvatarSmallHeight#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarMediumWidth") and len(arguments.criteria.AvatarMediumWidth)>
			AND AvatarMediumWidth = <cfqueryparam value="#arguments.criteria.AvatarMediumWidth#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarMediumHeight") and len(arguments.criteria.AvatarMediumHeight)>
			AND AvatarMediumHeight = <cfqueryparam value="#arguments.criteria.AvatarMediumHeight#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AvatarDimensionType") and len(arguments.criteria.AvatarDimensionType)>
			AND AvatarDimensionType LIKE <cfqueryparam value="%#arguments.criteria.AvatarDimensionType#%" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Settings") and len(arguments.criteria.Settings)>
			AND Settings LIKE <cfqueryparam value="%#arguments.criteria.Settings#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DefaultAvatar") and len(arguments.criteria.DefaultAvatar)>
			AND DefaultAvatar LIKE <cfqueryparam value="%#arguments.criteria.DefaultAvatar#%" CFSQLType="cf_sql_varchar" maxlength="80" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsMaster") and len(arguments.criteria.IsMaster)>
			AND IsMaster = <cfqueryparam value="#arguments.criteria.IsMaster#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Style") and len(arguments.criteria.Style)>
			AND Style LIKE <cfqueryparam value="%#arguments.criteria.Style#%" CFSQLType="cf_sql_varchar" maxlength="12" />
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
				
					ThemeID
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
					ThemeID NOT IN (<cfqueryparam value="#valueList(qExclude.ThemeID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
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

	<cffunction name="setThemeService" access="public" returntype="void" output="false">
		<cfargument name="ThemeService" type="any" required="true" />
		<cfset variables['themeService'] = arguments.ThemeService />
	</cffunction>
	<cffunction name="getThemeService" access="public" returntype="any" output="false">
		<cfreturn variables.ThemeService />
	</cffunction>


<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	

