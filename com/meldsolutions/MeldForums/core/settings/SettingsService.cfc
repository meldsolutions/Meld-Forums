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
<cfcomponent name="SettingsService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="SettingsService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createSettings" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SettingsID" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="PermissionGroups" type="string" required="false" />
		<cfargument name="ThemeID" type="string" required="false" />
		<cfargument name="ThreadsPerPage" type="numeric" required="false" />
		<cfargument name="PostsPerPage" type="numeric" required="false" />
		<cfargument name="SubscriptionLimit" type="numeric" required="false" />
		<cfargument name="AllowedExtensions" type="string" required="false" />
		<cfargument name="DeniedExtensions" type="string" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarResizeType" type="string" required="false" />
		<cfargument name="AvatarQualityType" type="string" required="false" />
		<cfargument name="AvatarAspectType" type="string" required="false" />
		<cfargument name="AvatarCropType" type="string" required="false" />
		<cfargument name="UserCacheSize" type="numeric" required="false" />
		<cfargument name="ResetAvatar" type="boolean" required="false" />
		<cfargument name="DoInit" type="boolean" required="false" />
		<cfargument name="ActiveWithinMinutes" type="numeric" required="false" />
		<cfargument name="SearchMode" type="string" required="false" />
		<cfargument name="TempDir" type="string" required="false" />
		<cfargument name="BaseTempDir" type="string" required="false" />
		<cfargument name="URLKey" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var tmpObj = createObject("component","SettingsBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setSettingsService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getSettings" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="SiteID" type="string" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var SettingsBean = createSettings(argumentCollection=arguments) />
		<cfset getSettingsDAO().read(SettingsBean) />
		<cfreturn SettingsBean />
	</cffunction>

	<cffunction name="getSettingss" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SettingsID" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="PermissionGroups" type="string" required="false" />
		<cfargument name="ThemeID" type="string" required="false" />
		<cfargument name="ThreadsPerPage" type="numeric" required="false" />
		<cfargument name="PostsPerPage" type="numeric" required="false" />
		<cfargument name="SubscriptionLimit" type="numeric" required="false" />
		<cfargument name="AllowedExtensions" type="string" required="false" />
		<cfargument name="DeniedExtensions" type="string" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarResizeType" type="string" required="false" />
		<cfargument name="AvatarQualityType" type="string" required="false" />
		<cfargument name="AvatarAspectType" type="string" required="false" />
		<cfargument name="AvatarCropType" type="string" required="false" />
		<cfargument name="UserCacheSize" type="numeric" required="false" />
		<cfargument name="ResetAvatar" type="boolean" required="false" />
		<cfargument name="DoInit" type="boolean" required="false" />
		<cfargument name="ActiveWithinMinutes" type="numeric" required="false" />
		<cfargument name="SearchMode" type="string" required="false" />
		<cfargument name="TempDir" type="string" required="false" />
		<cfargument name="BaseTempDir" type="string" required="false" />
		<cfargument name="URLKey" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn getSettingsGateway().getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SettingsID" type="string" required="false" />
		<cfargument name="SiteID" type="string" required="false" />
		<cfargument name="IsMaster" type="boolean" required="false" />
		<cfargument name="PermissionGroups" type="string" required="false" />
		<cfargument name="ThemeID" type="string" required="false" />
		<cfargument name="ThreadsPerPage" type="numeric" required="false" />
		<cfargument name="PostsPerPage" type="numeric" required="false" />
		<cfargument name="SubscriptionLimit" type="numeric" required="false" />
		<cfargument name="AllowedExtensions" type="string" required="false" />
		<cfargument name="DeniedExtensions" type="string" required="false" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" />
		<cfargument name="AvatarID" type="string" required="false" />
		<cfargument name="AvatarResizeType" type="string" required="false" />
		<cfargument name="AvatarQualityType" type="string" required="false" />
		<cfargument name="AvatarAspectType" type="string" required="false" />
		<cfargument name="AvatarCropType" type="string" required="false" />
		<cfargument name="UserCacheSize" type="numeric" required="false" />
		<cfargument name="ResetAvatar" type="boolean" required="false" />
		<cfargument name="DoInit" type="boolean" required="false" />
		<cfargument name="ActiveWithinMinutes" type="numeric" required="false" />
		<cfargument name="SearchMode" type="string" required="false" />
		<cfargument name="TempDir" type="string" required="false" />
		<cfargument name="BaseTempDir" type="string" required="false" />
		<cfargument name="URLKey" type="string" required="false" />
		<cfargument name="RemoteID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn getSettingsGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getSettingsGateway().getByArray(argumentCollection=arguments) />
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
			<cfset sReturn.count = getSettingsGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getSettingsGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveSettings" access="public" output="false" returntype="boolean">
		<cfargument name="SettingsBean" type="any" required="true" />

		<cfreturn getSettingsDAO().save(SettingsBean) />
	</cffunction>
	
	<cffunction name="updateSettings" access="public" output="false" returntype="boolean">
		<cfargument name="SettingsBean" type="any" required="true" />

		<cfreturn getSettingsDAO().update(SettingsBean) />
	</cffunction>

	<cffunction name="deleteSettings" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="SiteID" type="string" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var SettingsBean = createSettings(argumentCollection=arguments) />
		<cfreturn getSettingsDAO().delete(SettingsBean) />
	</cffunction>

	<cffunction name="setSettingsGateway" access="public" returntype="void" output="false">
		<cfargument name="SettingsGateway" type="any" required="true" />
		<cfset variables['settingsGateway'] = arguments.SettingsGateway />
	</cffunction>
	<cffunction name="getSettingsGateway" access="public" returntype="any" output="false">
		<cfreturn SettingsGateway />
	</cffunction>

	<cffunction name="setSettingsDAO" access="public" returntype="void" output="false">
		<cfargument name="SettingsDAO" type="any" required="true" />
		<cfset variables['settingsDAO'] = arguments.SettingsDAO />
	</cffunction>
	<cffunction name="getSettingsDAO" access="public" returntype="any" output="false">
		<cfreturn variables.SettingsDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="createSettingsForSite" access="public" output="false" returntype="boolean">
		<cfargument name="siteID" type="string" required="true" />
		
		<cfset var settingsBean		= getSettings( argumentCollection=arguments ) />
		<cfset var sArgs			= StructNew() />

		<cfif settingsBean.beanExists()>
			<cfreturn false>
		</cfif>

		<cfset sArgs.siteID		= "default" />
		<cfset settingsBean		= getBeanByAttributes( argumentCollection=sArgs ) />
		
		<!--- start restrictive --->
		<cfset settingsBean.setPermissionGroups( 'RestrictAll' )>
		<cfset settingsBean.setSettingsID( CreateUUID() )>
		<cfset settingsBean.setResetAvatar( 1 )>
		<cfset settingsBean.setSiteID( arguments.siteID )>
		<cfset settingsBean.setTempDir( CreateUUID() )>
		
		<cfset variables.SettingsDAO.save( settingsBean ) />
		<cfreturn true />
	</cffunction>

	<!--- formerly: getAllSettings --->
	<cffunction name="getInitSettings" access="public" output="false" returntype="array">
		<!---<cfset var themeBean	= "" />--->
		<cfset var userCache	= "" />
		<cfset var avatarID		= "" />
		<cfset var aSettings	= variables.SettingsGateway.getByAttributes() />
		<cfset var iiX			= 0 />
		<cfset var sArgs		= StructNew() />
		
		<cfloop from="1" to="#arrayLen(aSettings)#" index="iiX">
			<cfset themeBean = getThemeService().getTheme( aSettings[iiX].getThemeID() ) />
			<cfset aSettings[iiX].setThemeBean( themeBean ) />

			<cfset userCache = createObject("component","UserCache").init( 
				aSettings[iiX].getSiteID(),
				getUserService(),
				getMuraManager().getCacheFactory( aSettings[iiX].getSiteID() ),
				15,
				15,
				15,
				aSettings[iiX].getUserCacheSize() )>

			<cfset aSettings[iiX].setUserCache( userCache ) >
		</cfloop>
		
		<cfreturn aSettings />
	</cffunction>

<!---^^CUSTOMEND^^--->

	<cffunction name="getMuraManager" access="public" output="false" returntype="any">
		<cfreturn variables.MuraManager />
	</cffunction>
	<cffunction name="setMuraManager" access="public" output="false" returntype="void">
		<cfargument name="MuraManager" type="any" required="true" />
		<cfset variables.MuraManager = arguments.MuraManager />
	</cffunction>

	<cffunction name="setThemeService" access="public" returntype="any" output="false">
		<cfargument name="ThemeService" type="any" required="true">
		<cfset variables.ThemeService = arguments.ThemeService>
	</cffunction>
	<cffunction name="getThemeService" access="public" returntype="any" output="false">
		<cfreturn variables.ThemeService>
	</cffunction>

	<cffunction name="getUserService" access="public" output="false" returntype="any">
		<cfreturn variables.UserService />
	</cffunction>
	<cffunction name="setUserService" access="public" output="false" returntype="void">
		<cfargument name="UserService" type="any" required="true" />
		<cfset variables.UserService = arguments.UserService />
	</cffunction>
</cfcomponent>













