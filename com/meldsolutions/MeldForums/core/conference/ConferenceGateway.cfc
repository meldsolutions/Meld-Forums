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
<cfcomponent displayname="ConferenceGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ConferenceGateway">
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
		<cfargument name="ConferenceID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="ConfigurationID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="IDList" type="string" required="false" />

		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mf_conference cnf
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"ConferenceID") and len(arguments.ConferenceID)>
				AND cnf.ConferenceID = <cfqueryparam value="#arguments.ConferenceID#" CFSQLType="cf_sql_char" maxlength="35" />
			<cfelseif structKeyExists(arguments,"IDList") and len(arguments.IDList)>
				AND cnf.ConferenceID IN (<cfqueryparam value="#arguments.IDList#" CFSQLType="cf_sql_char" maxlength="35" list="true" />)
			</cfif>
			
			<cfif structKeyExists(arguments,"SiteID") and len(arguments.SiteID)>
				AND cnf.SiteID = <cfqueryparam value="#arguments.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ConfigurationID") and len(arguments.ConfigurationID)>
				AND cnf.ConfigurationID = <cfqueryparam value="#arguments.ConfigurationID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
				AND cnf.Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Title") and len(arguments.Title)>
				AND cnf.Title = <cfqueryparam value="#arguments.Title#" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
				AND cnf.Description = <cfqueryparam value="#arguments.Description#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsActive") and len(arguments.IsActive)>
				AND cnf.IsActive = <cfqueryparam value="#arguments.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"FriendlyName") and len(arguments.FriendlyName)>
				AND cnf.FriendlyName = <cfqueryparam value="#arguments.FriendlyName#" CFSQLType="cf_sql_varchar" maxlength="200" />
			</cfif>
			
			<cfif structKeyExists(arguments,"OrderNo") and len(arguments.OrderNo)>
				AND cnf.OrderNo = <cfqueryparam value="#arguments.OrderNo#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RemoteID") and len(arguments.RemoteID)>
				AND cnf.RemoteID = <cfqueryparam value="#arguments.RemoteID#" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateCreate") and len(arguments.DateCreate)>
				AND cnf.DateCreate = <cfqueryparam value="#arguments.DateCreate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DateLastUpdate") and len(arguments.DateLastUpdate)>
				AND cnf.DateLastUpdate = <cfqueryparam value="#arguments.DateLastUpdate#" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Idx") and len(arguments.Idx)>
				AND cnf.Idx = <cfqueryparam value="#arguments.Idx#" CFSQLType="cf_sql_integer" />
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
		<cfargument name="ConferenceID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="ConfigurationID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="IDList" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />
		<cfloop from="1" to="#qList.recordCount#" index="iiX">
			<cfset tmpObj = createObject("component","ConferenceBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setConferenceService( getConferenceService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ConferenceID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="ConfigurationID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Title" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="FriendlyName" type="string" required="false" />
		<cfargument name="OrderNo" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<cfargument name="Idx" type="numeric" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var iiX = "" />

		<cfif qList.recordCount gt 1>
			<cfset tmpObj = createObject("component","ConferenceBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setConferenceService( getConferenceService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","ConferenceBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setConferenceService( getConferenceService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","ConferenceBean").init()>
			<cfset tmpObj.setConferenceService( getConferenceService() ) />
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
				#variables.dsnprefix#mf_conference
			WHERE
				0=0
			AND
			ConferenceID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
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
		<cfset var qList			= QueryNew('null') />
		<cfset var qExclude			= "" />
		<cfset var qKeep			= "" />
		<cfset var iiX				= "" />
		<cfset var returnFields		= rereplace(arguments.fieldList,";.*","") />
		<cfset var returnOrder		= rereplace(arguments.orderby,";.*","") />

		<cfcontent type="text/html">

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mssql"> 	
					TOP #Ceiling(Val(arguments.start+arguments.size))#
				</cfif>
				<cfif arguments.isCount>
					COUNT(cnf.ConferenceID) AS total
				<cfelse>
					#returnFields#,
					0 AS threadCount,
					0 AS forumCount
				</cfif>
			FROM	#variables.dsnprefix#mf_conference cnf
			WHERE
				0=0

			<cfif structKeyExists(arguments.criteria,"ConferenceID") and len(arguments.criteria.ConferenceID)>
			AND cnf.ConferenceID = <cfqueryparam value="#arguments.criteria.ConferenceID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SiteID") and len(arguments.criteria.SiteID)>
			AND cnf.SiteID = <cfqueryparam value="#arguments.criteria.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ConfigurationID") and len(arguments.criteria.ConfigurationID)>
			AND cnf.ConfigurationID = <cfqueryparam value="#arguments.criteria.ConfigurationID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Name") and len(arguments.criteria.Name)>
			AND cnf.Name LIKE <cfqueryparam value="%#arguments.criteria.Name#%" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Title") and len(arguments.criteria.Title)>
			AND cnf.Title LIKE <cfqueryparam value="%#arguments.criteria.Title#%" CFSQLType="cf_sql_varchar" maxlength="150" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Description") and len(arguments.criteria.Description)>
			AND cnf.Description LIKE <cfqueryparam value="%#arguments.criteria.Description#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsActive") and len(arguments.criteria.IsActive)>
				AND cnf.IsActive = <cfqueryparam value="#arguments.criteria.IsActive#" CFSQLType="cf_sql_tinyint" />
			<cfelse>
				AND cnf.IsActive = <cfqueryparam value="1" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"FriendlyName") and len(arguments.criteria.FriendlyName)>
			AND cnf.FriendlyName LIKE <cfqueryparam value="%#arguments.criteria.FriendlyName#%" CFSQLType="cf_sql_varchar" maxlength="200" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"OrderNo") and len(arguments.criteria.OrderNo)>
			AND cnf.OrderNo = <cfqueryparam value="#arguments.criteria.OrderNo#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RemoteID") and len(arguments.criteria.RemoteID)>
			AND cnf.RemoteID LIKE <cfqueryparam value="%#arguments.criteria.RemoteID#%" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateCreate") and len(arguments.criteria.DateCreate)>
			AND cnf.DateCreate LIKE <cfqueryparam value="%#arguments.criteria.DateCreate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DateLastUpdate") and len(arguments.criteria.DateLastUpdate)>
			AND cnf.DateLastUpdate LIKE <cfqueryparam value="%#arguments.criteria.DateLastUpdate#%" CFSQLType="cf_sql_timestamp" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Idx") and len(arguments.criteria.Idx)>
			AND cnf.Idx = <cfqueryparam value="#arguments.criteria.Idx#" CFSQLType="cf_sql_integer" />
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
				
					ConferenceID
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
					ConferenceID NOT IN (<cfqueryparam value="#valueList(qExclude.ConferenceID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
					)  
				
			</cfquery> 

			<cfset qList = qKeep> 
		</cfif>

		<cfif arguments.isCount>
			<cfreturn qList.total >
		<cfelse>
		<cfcontent type="text/html">

		<cfset qList = getForumGateway().getForumCountsForConference( qList ) />
			<cfloop from="1" to="#qList.recordCount#" index="iiX">
				<cfif len(qList.conferenceID[iiX])>
					<cfset tmpObj = queryRowToStruct(qList,iiX) />
					<cfset arrayAppend(arrObjects,tmpObj) />
				</cfif>
			</cfloop>
		</cfif>
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="setConferenceService" access="public" returntype="void" output="false">
		<cfargument name="ConferenceService" type="any" required="true" />
		<cfset variables['conferenceservice'] = arguments.ConferenceService />
	</cffunction>
	<cffunction name="getConferenceService" access="public" returntype="any" output="false">
		<cfreturn variables.ConferenceService />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->

	<cffunction name="getCrumbData" access="public" output="false" returntype="array">
		<cfargument name="siteID" type="string" required="false" />
		<cfargument name="ConferenceID" type="uuid" required="false" />
		
		<cfset var qList		= "" />
		<cfset var sObject		= StructNew() />
		<cfset var aCrumb		= ArrayNew(1) />
		<cfset var settingsBean	= getMeldForumsSettingsManager().getSiteSettings( siteID=arguments.siteID ) />
		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				idx,title,friendlyName,conferenceID,siteID
			FROM	#variables.dsnprefix#mf_conference
			WHERE	
				ConferenceID = <cfqueryparam value="#arguments.ConferenceID#" CFSQLType="cf_sql_char" maxlength="35" />
		</cfquery>
				
		<cfif not qList.recordCount>
			<cfreturn aCrumb />
		</cfif>
		
		<cfset sObject.siteID			= qList.siteID />
		<cfset sObject.menutitle		= qList.title />
		<cfset sObject.fileNameSuffix	= settingsBean.getURLKey() & "c" & qList.idx & "-" & qList.friendlyName />
		
		<cfset arrayAppend( aCrumb,sObject ) />
		
		<cfreturn aCrumb />
	</cffunction>

	<cffunction name="getCount" access="public" output="false" returntype="Numeric" >
		<cfargument name="siteID" type="string" required="false" default="" />

		<cfset var qList		= "" />
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				COUNT(conferenceID) as total
			FROM	#variables.dsnprefix#mf_conference
			<cfif len(arguments.siteID)>
			WHERE	
				siteID = <cfqueryparam value="#arguments.siteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
		</cfquery>
		
		<cfreturn qList.total />
	</cffunction>

	<cffunction name="setSortOrder" access="public" output="false" returntype="void">
		<cfargument name="sortIDs" type="string" required="false" default="" />

		<cfset var qList		= "" />
		<cfset var iiX = 0 />
		<cfset var aOrder = ListToArray( arguments.sortIDs ) />
		
		<cfloop from="1" to="#ArrayLen( aOrder )#" index="iiX">
			<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
				UPDATE	#variables.dsnprefix#mf_conference
				SET
					orderNo = #iiX#
				WHERE	
					conferenceID = <cfqueryparam value="#aOrder[iiX]#" CFSQLType="cf_sql_varchar" maxlength="35" />
			</cfquery>
		</cfloop>
	</cffunction>

<!---^^CUSTOMEND^^--->

	<cffunction name="setForumGateway" access="public" returntype="any" output="false">
		<cfargument name="ForumGateway" type="any" required="true">
		<cfset variables.ForumGateway = arguments.ForumGateway>
	</cffunction>
	<cffunction name="getForumGateway" access="public" returntype="any" output="false">
		<cfreturn variables.ForumGateway>
	</cffunction>

	<cffunction name="setMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfargument name="MeldForumsSettingsManager" type="any" required="true">
		<cfset variables.MeldForumsSettingsManager = arguments.MeldForumsSettingsManager>
	</cffunction>
	<cffunction name="getMeldForumsSettingsManager" access="public" returntype="any" output="false">
		<cfreturn variables.MeldForumsSettingsManager>
	</cffunction>
</cfcomponent>	




