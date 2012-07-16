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
<cfcomponent displayname="ConfigurationGateway" output="false" extends="MeldForums.com.meldsolutions.core.MeldGateway">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ConfigurationGateway">
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
		<cfargument name="ConfigurationID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="RestrictReadGroups" type="string" required="false" />
		<cfargument name="RestrictContributeGroups" type="string" required="false" />
		<cfargument name="RestrictModerateGroups" type="string" required="false" />
		<cfargument name="DoRequireConfirmation" type="boolean" required="false" />
		<cfargument name="DoAvatars" type="boolean" required="false" />
		<cfargument name="DoClosed" type="boolean" required="false" />
		<cfargument name="AllowAttachmentExtensions" type="string" required="false" />
		<cfargument name="DoAttachments" type="boolean" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="CharacterLimit" type="numeric" required="false" />
		<cfargument name="DoInlineImageAttachments" type="boolean" required="false" />
		<cfargument name="ImageWidthLimit" type="numeric" required="false" />
		<cfargument name="ImageHeightLimit" type="numeric" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="orderby" type="string" required="false" />
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#" password="#variables.dsnpassword#">
			SELECT
				*,1 AS BeanExists
			FROM	#variables.dsnprefix#mf_configuration
			WHERE	0=0
		<!---^^VALUES-START^^--->
			<cfif structKeyExists(arguments,"ConfigurationID") and len(arguments.ConfigurationID)>
				AND ConfigurationID = <cfqueryparam value="#arguments.ConfigurationID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments,"SiteID") and len(arguments.SiteID)>
				AND SiteID = <cfqueryparam value="#arguments.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
				AND Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" maxlength="100" />
			</cfif>
			
			<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
				AND Description = <cfqueryparam value="#arguments.Description#" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsActive") and len(arguments.IsActive)>
				AND IsActive = <cfqueryparam value="#arguments.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RestrictReadGroups") and len(arguments.RestrictReadGroups)>
				AND RestrictReadGroups = <cfqueryparam value="#arguments.RestrictReadGroups#" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RestrictContributeGroups") and len(arguments.RestrictContributeGroups)>
				AND RestrictContributeGroups = <cfqueryparam value="#arguments.RestrictContributeGroups#" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments,"RestrictModerateGroups") and len(arguments.RestrictModerateGroups)>
				AND RestrictModerateGroups = <cfqueryparam value="#arguments.RestrictModerateGroups#" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoRequireConfirmation") and len(arguments.DoRequireConfirmation)>
				AND DoRequireConfirmation = <cfqueryparam value="#arguments.DoRequireConfirmation#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoAvatars") and len(arguments.DoAvatars)>
				AND DoAvatars = <cfqueryparam value="#arguments.DoAvatars#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoClosed") and len(arguments.DoClosed)>
				AND DoClosed = <cfqueryparam value="#arguments.DoClosed#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"AllowAttachmentExtensions") and len(arguments.AllowAttachmentExtensions)>
				AND AllowAttachmentExtensions = <cfqueryparam value="#arguments.AllowAttachmentExtensions#" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoAttachments") and len(arguments.DoAttachments)>
				AND DoAttachments = <cfqueryparam value="#arguments.DoAttachments#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"IsMaster") and len(arguments.IsMaster)>
				AND IsMaster = <cfqueryparam value="#arguments.IsMaster#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"FilesizeLimit") and len(arguments.FilesizeLimit)>
				AND FilesizeLimit = <cfqueryparam value="#arguments.FilesizeLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"CharacterLimit") and len(arguments.CharacterLimit)>
				AND CharacterLimit = <cfqueryparam value="#arguments.CharacterLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"DoInlineImageAttachments") and len(arguments.DoInlineImageAttachments)>
				AND DoInlineImageAttachments = <cfqueryparam value="#arguments.DoInlineImageAttachments#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ImageWidthLimit") and len(arguments.ImageWidthLimit)>
				AND ImageWidthLimit = <cfqueryparam value="#arguments.ImageWidthLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments,"ImageHeightLimit") and len(arguments.ImageHeightLimit)>
				AND ImageHeightLimit = <cfqueryparam value="#arguments.ImageHeightLimit#" CFSQLType="cf_sql_integer" />
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
		<cfargument name="ConfigurationID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="RestrictReadGroups" type="string" required="false" />
		<cfargument name="RestrictContributeGroups" type="string" required="false" />
		<cfargument name="RestrictModerateGroups" type="string" required="false" />
		<cfargument name="DoRequireConfirmation" type="boolean" required="false" />
		<cfargument name="DoAvatars" type="boolean" required="false" />
		<cfargument name="DoClosed" type="boolean" required="false" />
		<cfargument name="AllowAttachmentExtensions" type="string" required="false" />
		<cfargument name="DoAttachments" type="boolean" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="CharacterLimit" type="numeric" required="false" />
		<cfargument name="DoInlineImageAttachments" type="boolean" required="false" />
		<cfargument name="ImageWidthLimit" type="numeric" required="false" />
		<cfargument name="ImageHeightLimit" type="numeric" required="false" />
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
			<cfset tmpObj = createObject("component","ConfigurationBean").init(argumentCollection=queryRowToStruct(qList,iiX)) />
			<cfset tmpObj.setConfigurationService( getConfigurationService() ) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ConfigurationID" type="uuid" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="RestrictReadGroups" type="string" required="false" />
		<cfargument name="RestrictContributeGroups" type="string" required="false" />
		<cfargument name="RestrictModerateGroups" type="string" required="false" />
		<cfargument name="DoRequireConfirmation" type="boolean" required="false" />
		<cfargument name="DoAvatars" type="boolean" required="false" />
		<cfargument name="DoClosed" type="boolean" required="false" />
		<cfargument name="AllowAttachmentExtensions" type="string" required="false" />
		<cfargument name="DoAttachments" type="boolean" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="CharacterLimit" type="numeric" required="false" />
		<cfargument name="DoInlineImageAttachments" type="boolean" required="false" />
		<cfargument name="ImageWidthLimit" type="numeric" required="false" />
		<cfargument name="ImageHeightLimit" type="numeric" required="false" />
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
			<cfset tmpObj = createObject("component","ConfigurationBean").init(argumentCollection=queryRowToStruct(qList))>
			<cfset tmpObj.setConfigurationService( getConfigurationService() ) />
			<cfreturn tmpObj />
		<cfelseif qList.recordCount>
			<cfset tmpObj = createObject("component","ConfigurationBean").init(argumentCollection=queryRowToStruct(qList)) />
			<cfset tmpObj.setConfigurationService( getConfigurationService() ) />
			<cfreturn tmpObj />
		<cfelse>
			<cfset tmpObj = createObject("component","ConfigurationBean").init()>
			<cfset tmpObj.setConfigurationService( getConfigurationService() ) />
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
				#variables.dsnprefix#mf_configuration
			WHERE
				0=0
		
			AND
			ConfigurationID IN (<cfqueryparam value="#IDList#" CFSQLType="cf_sql_char" list="true" maxlength="35" />)
		
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
			FROM	#variables.dsnprefix#mf_configuration 
			WHERE
				0=0
			<cfif structKeyExists(arguments.criteria,"ConfigurationID") and len(arguments.criteria.ConfigurationID)>
			AND ConfigurationID = <cfqueryparam value="#arguments.criteria.ConfigurationID#" CFSQLType="cf_sql_char" maxlength="35" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"SiteID") and len(arguments.criteria.SiteID)>
			AND SiteID = <cfqueryparam value="#arguments.criteria.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Name") and len(arguments.criteria.Name)>
			AND Name LIKE <cfqueryparam value="%#arguments.criteria.Name#%" CFSQLType="cf_sql_varchar" maxlength="100" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"Description") and len(arguments.criteria.Description)>
			AND Description LIKE <cfqueryparam value="%#arguments.criteria.Description#%" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsActive") and len(arguments.criteria.IsActive)>
			AND IsActive = <cfqueryparam value="#arguments.criteria.IsActive#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RestrictReadGroups") and len(arguments.criteria.RestrictReadGroups)>
			AND RestrictReadGroups LIKE <cfqueryparam value="%#arguments.criteria.RestrictReadGroups#%" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RestrictContributeGroups") and len(arguments.criteria.RestrictContributeGroups)>
			AND RestrictContributeGroups LIKE <cfqueryparam value="%#arguments.criteria.RestrictContributeGroups#%" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"RestrictModerateGroups") and len(arguments.criteria.RestrictModerateGroups)>
			AND RestrictModerateGroups LIKE <cfqueryparam value="%#arguments.criteria.RestrictModerateGroups#%" CFSQLType="cf_sql_varchar" maxlength="255" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoRequireConfirmation") and len(arguments.criteria.DoRequireConfirmation)>
			AND DoRequireConfirmation = <cfqueryparam value="#arguments.criteria.DoRequireConfirmation#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoAvatars") and len(arguments.criteria.DoAvatars)>
			AND DoAvatars = <cfqueryparam value="#arguments.criteria.DoAvatars#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoClosed") and len(arguments.criteria.DoClosed)>
			AND DoClosed = <cfqueryparam value="#arguments.criteria.DoClosed#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"AllowAttachmentExtensions") and len(arguments.criteria.AllowAttachmentExtensions)>
			AND AllowAttachmentExtensions LIKE <cfqueryparam value="%#arguments.criteria.AllowAttachmentExtensions#%" CFSQLType="cf_sql_longvarchar" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoAttachments") and len(arguments.criteria.DoAttachments)>
			AND DoAttachments = <cfqueryparam value="#arguments.criteria.DoAttachments#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"IsMaster") and len(arguments.criteria.IsMaster)>
			AND IsMaster = <cfqueryparam value="#arguments.criteria.IsMaster#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"FilesizeLimit") and len(arguments.criteria.FilesizeLimit)>
			AND FilesizeLimit = <cfqueryparam value="#arguments.criteria.FilesizeLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"CharacterLimit") and len(arguments.criteria.CharacterLimit)>
			AND CharacterLimit = <cfqueryparam value="#arguments.criteria.CharacterLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"DoInlineImageAttachments") and len(arguments.criteria.DoInlineImageAttachments)>
			AND DoInlineImageAttachments = <cfqueryparam value="#arguments.criteria.DoInlineImageAttachments#" CFSQLType="cf_sql_tinyint" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ImageWidthLimit") and len(arguments.criteria.ImageWidthLimit)>
			AND ImageWidthLimit = <cfqueryparam value="#arguments.criteria.ImageWidthLimit#" CFSQLType="cf_sql_integer" />
			</cfif>
			
			<cfif structKeyExists(arguments.criteria,"ImageHeightLimit") and len(arguments.criteria.ImageHeightLimit)>
			AND ImageHeightLimit = <cfqueryparam value="#arguments.criteria.ImageHeightLimit#" CFSQLType="cf_sql_integer" />
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
			<cfif not arguments.isCount AND len( arguments.orderBy )and variables.dsntype neq "mssql"> 	
				ORDER BY isMaster DESC,#returnOrder#
			</cfif>
			<cfif not arguments.isCount and arguments.size gt 0 AND variables.dsntype eq "mysql">
				LIMIT <cfqueryparam value="#arguments.start#" CFSQLType="cf_sql_integer" />,<cfqueryparam value="#arguments.size#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>

		<cfif not arguments.isCount AND variables.dsntype eq "mssql" AND arguments.start gt 0>
			<cfquery name="qExclude" dbtype="query" maxrows="#arguments.start#" >  
	        	SELECT
				
					ConfigurationID
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
					ConfigurationID NOT IN (<cfqueryparam value="#valueList(qExclude.ConfigurationID)#" list="true" CFSQLType="cf_sql_char" maxlength="35" />)
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

	<cffunction name="setConfigurationService" access="public" returntype="void" output="false">
		<cfargument name="ConfigurationService" type="any" required="true" />
		<cfset variables['configurationService'] = arguments.ConfigurationService />
	</cffunction>
	<cffunction name="getConfigurationService" access="public" returntype="any" output="false">
		<cfreturn variables.ConfigurationService />
	</cffunction>


<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="removeNonexistantID" access="public" output="false" returntype="void">
		<cfargument name="configurationID" type="uuid" required="false" />

		<cfset var qUpdate = "" />		

		<cfif arguments.configurationID eq "00000000-0000-0000-0000000000000001">
			<cfreturn>
		</cfif>

		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			UPDATE	#variables.dsnprefix#mf_forum
			SET
				configurationID = <cfqueryparam value="" CFSQLType="cf_sql_varchar" null="true" /> 
			WHERE
				configurationID = <cfqueryparam value="#arguments.configurationID#" CFSQLType="cf_sql_char" />
		</cfquery>

		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			UPDATE	#variables.dsnprefix#mf_conference
			SET
				configurationID = <cfqueryparam value="" CFSQLType="cf_sql_varchar" null="true" /> 
			WHERE
				configurationID = <cfqueryparam value="#arguments.configurationID#" CFSQLType="cf_sql_char" />
		</cfquery>
	</cffunction>

	<cffunction name="verifyBaseConfiguration" access="public" output="false" returntype="boolean">
		<cfargument name="siteID" type="string" required="true" />

		<cfset var qList = "" />		

		<cfquery name="qList" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#" maxrows="1">
			SELECT
				configurationID 
			FROM
				#variables.dsnprefix#mf_configuration	
			WHERE
				SiteID = <cfqueryparam value="#arguments.SiteID#" CFSQLType="cf_sql_varchar" maxlength="25" />
		</cfquery>

		<cfreturn qList.recordCount gt 0 />
	</cffunction>

	<cffunction name="cleanConferenceID" access="public" output="false" returntype="any">
		<cfargument name="configurationID" type="uuid" required="false" />

		<cfset var qUpdate = "" />		

		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			UPDATE	#variables.dsnprefix#mf_forum
			SET
				configurationID = <cfqueryparam value="" CFSQLType="cf_sql_varchar" null="true" /> 
			WHERE
				configurationID = <cfqueryparam value="#arguments.configurationID#" CFSQLType="cf_sql_char" />
		</cfquery>

		<cfquery name="qUpdate" datasource="#variables.dsn#" username="#variables.dsnusername#"  password="#variables.dsnpassword#">
			UPDATE	#variables.dsnprefix#mf_conference
			SET
				configurationID = <cfqueryparam value="" CFSQLType="cf_sql_varchar" null="true" /> 
			WHERE
				configurationID = <cfqueryparam value="#arguments.configurationID#" CFSQLType="cf_sql_char" />
		</cfquery>
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>	



