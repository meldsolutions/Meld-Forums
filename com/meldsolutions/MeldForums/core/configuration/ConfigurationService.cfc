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
<cfcomponent name="ConfigurationService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ConfigurationService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createConfiguration" access="public" output="false" returntype="any">
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
				
		<cfset var tmpObj = createObject("component","ConfigurationBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setConfigurationService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getConfiguration" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ConfigurationID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var ConfigurationBean = createConfiguration(argumentCollection=arguments) />
		<cfset getConfigurationDAO().read(ConfigurationBean) />
		<cfreturn ConfigurationBean />
	</cffunction>

	<cffunction name="getConfigurations" access="public" output="false" returntype="array">
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
		
		<cfreturn getConfigurationGateway().getByAttributes(argumentCollection=arguments) />
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

		<cfreturn getConfigurationGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getConfigurationGateway().getByArray(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="search" access="public" output="false" returntype="struct">
		<cfargument name="criteria" type="struct" required="true" />
		<cfargument name="fieldList" type="string" required="false" default="*" />
		<cfargument name="start" type="numeric" required="false" default="0"/>
		<cfargument name="size" type="numeric" required="false" default="10"/>
		<cfargument name="count" type="numeric" required="false" default="0"/>
		<cfargument name="isPaged" type="numeric" required="false" default="true" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var arrObjects		= ArrayNew(1)>
		<cfset var iiX				= "" >
		<cfset var isValid			= false >
		<cfset var sReturn			= StructNew()>
		
		<cfif arguments.isPaged and not arguments.count>
			<cfset arguments.isCount = true>
			<cfset sReturn.count = getConfigurationGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getConfigurationGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveConfiguration" access="public" output="false" returntype="boolean">
		<cfargument name="ConfigurationBean" type="any" required="true" />

		<cfreturn getConfigurationDAO().save(ConfigurationBean) />
	</cffunction>
	
	<cffunction name="updateConfiguration" access="public" output="false" returntype="boolean">
		<cfargument name="ConfigurationBean" type="any" required="true" />

		<cfset var settingsBean			= getSettingsService().getBeanByAttributes( siteID=configurationBean.getSiteID() ) />
		<cfset var currentExtList		= configurationBean.getAllowAttachmentExtensions() />
		<cfset var allowedExtList		= settingsBean.getAllowedExtensions() />
		<cfset var deniedExtList		= "">
		<cfset var vetAllowedExt		= "">
		
		<!--- we will only allow extensions in the 'allowed' list for this site --->
		<cfloop list="#currentExtList#" index="iiX">
			<cfif listfindnocase(allowedExtList,iiX)>
				<cfset vetAllowedExt = listappend(vetAllowedExt,iiX)>
			<cfelse>
				<cfset deniedExtList = listappend(deniedExtList,iiX)>
			</cfif>
		</cfloop>

		<cfset configurationBean.setAllowAttachmentExtensions( vetAllowedExt )>

		<cfreturn variables.ConfigurationDAO.update( configurationBean ) />
	</cffunction>

	<cffunction name="deleteConfiguration" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ConfigurationID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var ConfigurationBean	= createConfiguration(argumentCollection=arguments) />
		<cfset var success				= false />

		<cftransaction>
			<!--- remove from forums & conferences --->
			<cfset cleanConferenceID( argumentCollection=arguments )>
			<cfset success = variables.ConfigurationDAO.delete(ConfigurationBean) />
		</cftransaction>

		<cfreturn success />
	</cffunction>

	<cffunction name="setConfigurationGateway" access="public" returntype="void" output="false">
		<cfargument name="ConfigurationGateway" type="any" required="true" />
		<cfset variables['configurationGateway'] = arguments.ConfigurationGateway />
	</cffunction>
	<cffunction name="getConfigurationGateway" access="public" returntype="any" output="false">
		<cfreturn ConfigurationGateway />
	</cffunction>

	<cffunction name="setConfigurationDAO" access="public" returntype="void" output="false">
		<cfargument name="ConfigurationDAO" type="any" required="true" />
		<cfset variables['configurationDAO'] = arguments.ConfigurationDAO />
	</cffunction>
	<cffunction name="getConfigurationDAO" access="public" returntype="any" output="false">
		<cfreturn variables.ConfigurationDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="verifyBaseConfiguration" access="public" output="false" returntype="boolean">
		<cfargument name="siteID" type="string" required="true" />

		<cfset var found = getConfigurationGateway().verifyBaseConfiguration( argumentCollection=arguments ) />

		<cfif not found>
			<cfset createBaseConfiguration( "",arguments.siteID ) />
		</cfif>
		
		<cfreturn found />
	</cffunction>
	
	<cffunction name="createBaseConfiguration" access="public" output="false" returntype="any">
		<cfargument name="prepend" type="string" required="true" />
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="configurationID" type="uuid" required="false" />

		<cfset var configurationBean = duplicateConfiguration( argumentCollection=arguments ) />
		
		<cfset configurationBean.setSiteID( arguments.siteID )>
		<cfset configurationBean.setRestrictModerateGroups( 'RestrictAll' )>
		
		<cfset saveConfiguration( configurationBean )>
	</cffunction>

	<cffunction name="cleanConferenceID" access="public" output="false" returntype="any">
		<cfargument name="configurationID" type="uuid" required="false" />
		
		<cfreturn getConfigurationGateway().cleanConferenceID( arguments.configurationID ) />
	</cffunction>

	<cffunction name="duplicateConfiguration" access="public" output="false" returntype="any">
		<cfargument name="prepend" type="string" required="true" />
		<cfargument name="siteID" type="string" required="true" />
		<cfargument name="configurationID" type="uuid" required="false" />

		<cfset var configurationBean	= "" />
		<cfset var sArgs				= StructNew() />

		<cfif not isDefined("arguments.configurationID")>
			<cfset sARgs.isMaster			= 1 />
			<cfset configurationBean		= getConfigurationGateway().getBeanByAttributes( argumentCollection=sArgs ) />
		<cfelse>
			<cfset sArgs.siteID				= arguments.siteID />
			<cfset sARgs.configurationID	= arguments.configurationID />
			<cfset configurationBean		= getConfigurationGateway().getBeanByAttributes( argumentCollection=sArgs ) />
		</cfif>
				
		<!--- new id for the new config --->
		<cfset configurationBean.setConfigurationID( createUUID() )>
		<!--- reset base values --->
		<cfset configurationBean.setDescription( "" )>
		<cfset configurationBean.setName( configurationBean.getName() & arguments.prepend )>

		<cfset configurationBean.setBeanExists( false )>

		<cfreturn configurationBean />
	</cffunction>

	<cffunction name="removeNonexistantID" access="public" output="false" returntype="void">
		<cfargument name="configurationID" type="uuid" required="false" />
		
		<cfset getConfigurationGateway().removeNonexistantID(arguments.configurationID) />
	</cffunction>
<!---^^CUSTOMEND^^--->

	<cffunction name="setSettingsService" access="public" returntype="any" output="false">
		<cfargument name="SettingsService" type="any" required="true">
		<cfset variables.SettingsService = arguments.SettingsService>
	</cffunction>
	<cffunction name="getSettingsService" access="public" returntype="any" output="false">
		<cfreturn variables.SettingsService>
	</cffunction>

</cfcomponent>










