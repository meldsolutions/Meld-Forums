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
<cfcomponent displayname="SettingsBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="SettingsID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="IsMaster" type="boolean" default="0" required="true" />
	<cfproperty name="PermissionGroups" type="string" default="RestrictAll" required="true" maxlength="255" />
	<cfproperty name="ThemeID" type="uuid" default="" maxlength="35" />
	<cfproperty name="ThreadsPerPage" type="numeric" default="20" required="true" />
	<cfproperty name="PostsPerPage" type="numeric" default="20" required="true" />
	<cfproperty name="SubscriptionLimit" type="numeric" default="100" required="true" />
	<cfproperty name="AllowedExtensions" type="string" default="" maxlength="255" />
	<cfproperty name="DeniedExtensions" type="string" default="" maxlength="255" />
	<cfproperty name="FilesizeLimit" type="numeric" default="100" required="true" />
	<cfproperty name="AvatarID" type="uuid" default="" maxlength="35" />
	<cfproperty name="AvatarResizeType" type="string" default="CropResize" required="true" maxlength="45" />
	<cfproperty name="AvatarQualityType" type="string" default="highQuality" required="true" maxlength="45" />
	<cfproperty name="AvatarAspectType" type="string" default="MaxAspectXY" required="true" maxlength="45" />
	<cfproperty name="AvatarCropType" type="string" default="BestXY" required="true" maxlength="45" />
	<cfproperty name="UserCacheSize" type="numeric" default="250" required="true" />
	<cfproperty name="ResetAvatar" type="boolean" default="0" required="true" />
	<cfproperty name="DoInit" type="boolean" default="0" required="true" />
	<cfproperty name="ActiveWithinMinutes" type="numeric" default="15" required="true" />
	<cfproperty name="SearchMode" type="string" default="SIMPLE" required="true" maxlength="45" />
	<cfproperty name="TempDir" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="BaseTempDir" type="string" default="" maxlength="150" />
	<cfproperty name="URLKey" type="string" default="" required="true" maxlength="10" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="ThemeBean" type="any" default="" maxlength="35" />
	<cfproperty name="UserCache" type="any" default="" maxlength="35" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="SettingsBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SettingsID" type="string" required="false" default="" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="IsMaster" type="boolean" required="false" default="0" />
		<cfargument name="PermissionGroups" type="string" required="false" default="RestrictAll" />
		<cfargument name="ThemeID" type="string" required="false" default="" />
		<cfargument name="ThreadsPerPage" type="numeric" required="false" default="20" />
		<cfargument name="PostsPerPage" type="numeric" required="false" default="20" />
		<cfargument name="SubscriptionLimit" type="numeric" required="false" default="100" />
		<cfargument name="AllowedExtensions" type="string" required="false" default="" />
		<cfargument name="DeniedExtensions" type="string" required="false" default="" />
		<cfargument name="FilesizeLimit" type="numeric" required="false" default="100" />
		<cfargument name="AvatarID" type="string" required="false" default="" />
		<cfargument name="AvatarResizeType" type="string" required="false" default="CropResize" />
		<cfargument name="AvatarQualityType" type="string" required="false" default="highQuality" />
		<cfargument name="AvatarAspectType" type="string" required="false" default="MaxAspectXY" />
		<cfargument name="AvatarCropType" type="string" required="false" default="BestXY" />
		<cfargument name="UserCacheSize" type="numeric" required="false" default="250" />
		<cfargument name="ResetAvatar" type="boolean" required="false" default="0" />
		<cfargument name="DoInit" type="boolean" required="false" default="0" />
		<cfargument name="ActiveWithinMinutes" type="numeric" required="false" default="15" />
		<cfargument name="SearchMode" type="string" required="false" default="SIMPLE" />
		<cfargument name="TempDir" type="string" required="false" default="" />
		<cfargument name="BaseTempDir" type="string" required="false" default="" />
		<cfargument name="URLKey" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="ThemeBean" type="any" required="false" default="" />
		<cfargument name="UserCache" type="any" required="false" default="" />

		<!---^^SETTERS-START^^--->
		<cfset setSettingsID( arguments.SettingsID ) />
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setIsMaster( arguments.IsMaster ) />
		<cfset setPermissionGroups( arguments.PermissionGroups ) />
		<cfset setThemeID( arguments.ThemeID ) />
		<cfset setThreadsPerPage( arguments.ThreadsPerPage ) />
		<cfset setPostsPerPage( arguments.PostsPerPage ) />
		<cfset setSubscriptionLimit( arguments.SubscriptionLimit ) />
		<cfset setAllowedExtensions( arguments.AllowedExtensions ) />
		<cfset setDeniedExtensions( arguments.DeniedExtensions ) />
		<cfset setFilesizeLimit( arguments.FilesizeLimit ) />
		<cfset setAvatarID( arguments.AvatarID ) />
		<cfset setAvatarResizeType( arguments.AvatarResizeType ) />
		<cfset setAvatarQualityType( arguments.AvatarQualityType ) />
		<cfset setAvatarAspectType( arguments.AvatarAspectType ) />
		<cfset setAvatarCropType( arguments.AvatarCropType ) />
		<cfset setUserCacheSize( arguments.UserCacheSize ) />
		<cfset setResetAvatar( arguments.ResetAvatar ) />
		<cfset setDoInit( arguments.DoInit ) />
		<cfset setActiveWithinMinutes( arguments.ActiveWithinMinutes ) />
		<cfset setSearchMode( arguments.SearchMode ) />
		<cfset setTempDir( arguments.TempDir ) />
		<cfset setBaseTempDir( arguments.BaseTempDir ) />
		<cfset setURLKey( arguments.URLKey ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setThemeBean( arguments.ThemeBean ) />
		<cfset setUserCache( arguments.UserCache ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="SettingsBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setSettingsID" access="public" returntype="void" output="false">
		<cfargument name="SettingsID" type="string" required="true" />
		<cfset variables.instance['settingsid'] = arguments.SettingsID />
	</cffunction>
	<cffunction name="getSettingsID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SettingsID />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	
	<cffunction name="setIsMaster" access="public" returntype="void" output="false">
		<cfargument name="IsMaster" type="boolean" required="true" />
		<cfset variables.instance['ismaster'] = arguments.IsMaster />
	</cffunction>
	<cffunction name="getIsMaster" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsMaster />
	</cffunction>
	
	<cffunction name="setPermissionGroups" access="public" returntype="void" output="false">
		<cfargument name="PermissionGroups" type="string" required="true" />
		<cfset variables.instance['permissiongroups'] = arguments.PermissionGroups />
	</cffunction>
	<cffunction name="getPermissionGroups" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PermissionGroups />
	</cffunction>
	
	<cffunction name="setThemeID" access="public" returntype="void" output="false">
		<cfargument name="ThemeID" type="string" required="true" />
		<cfset variables.instance['themeid'] = arguments.ThemeID />
	</cffunction>
	<cffunction name="getThemeID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ThemeID />
	</cffunction>
	
	<cffunction name="setThreadsPerPage" access="public" returntype="void" output="false">
		<cfargument name="ThreadsPerPage" type="numeric" required="true" />
		<cfset variables.instance['threadsperpage'] = arguments.ThreadsPerPage />
	</cffunction>
	<cffunction name="getThreadsPerPage" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ThreadsPerPage />
	</cffunction>
	
	<cffunction name="setPostsPerPage" access="public" returntype="void" output="false">
		<cfargument name="PostsPerPage" type="numeric" required="true" />
		<cfset variables.instance['postsperpage'] = arguments.PostsPerPage />
	</cffunction>
	<cffunction name="getPostsPerPage" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PostsPerPage />
	</cffunction>
	
	<cffunction name="setSubscriptionLimit" access="public" returntype="void" output="false">
		<cfargument name="SubscriptionLimit" type="numeric" required="true" />
		<cfset variables.instance['subscriptionlimit'] = arguments.SubscriptionLimit />
	</cffunction>
	<cffunction name="getSubscriptionLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.SubscriptionLimit />
	</cffunction>
	
	<cffunction name="setAllowedExtensions" access="public" returntype="void" output="false">
		<cfargument name="AllowedExtensions" type="string" required="true" />
		<cfset variables.instance['allowedextensions'] = arguments.AllowedExtensions />
	</cffunction>
	<cffunction name="getAllowedExtensions" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AllowedExtensions />
	</cffunction>
	
	<cffunction name="setDeniedExtensions" access="public" returntype="void" output="false">
		<cfargument name="DeniedExtensions" type="string" required="true" />
		<cfset variables.instance['deniedextensions'] = arguments.DeniedExtensions />
	</cffunction>
	<cffunction name="getDeniedExtensions" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DeniedExtensions />
	</cffunction>
	
	<cffunction name="setFilesizeLimit" access="public" returntype="void" output="false">
		<cfargument name="FilesizeLimit" type="numeric" required="true" />
		<cfset variables.instance['filesizelimit'] = arguments.FilesizeLimit />
	</cffunction>
	<cffunction name="getFilesizeLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.FilesizeLimit />
	</cffunction>
	
	<cffunction name="setAvatarID" access="public" returntype="void" output="false">
		<cfargument name="AvatarID" type="string" required="true" />
		<cfset variables.instance['avatarid'] = arguments.AvatarID />
	</cffunction>
	<cffunction name="getAvatarID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AvatarID />
	</cffunction>
	
	<cffunction name="setAvatarResizeType" access="public" returntype="void" output="false">
		<cfargument name="AvatarResizeType" type="string" required="true" />
		<cfset variables.instance['avatarresizetype'] = arguments.AvatarResizeType />
	</cffunction>
	<cffunction name="getAvatarResizeType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AvatarResizeType />
	</cffunction>
	
	<cffunction name="setAvatarQualityType" access="public" returntype="void" output="false">
		<cfargument name="AvatarQualityType" type="string" required="true" />
		<cfset variables.instance['avatarqualitytype'] = arguments.AvatarQualityType />
	</cffunction>
	<cffunction name="getAvatarQualityType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AvatarQualityType />
	</cffunction>
	
	<cffunction name="setAvatarAspectType" access="public" returntype="void" output="false">
		<cfargument name="AvatarAspectType" type="string" required="true" />
		<cfset variables.instance['avataraspecttype'] = arguments.AvatarAspectType />
	</cffunction>
	<cffunction name="getAvatarAspectType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AvatarAspectType />
	</cffunction>
	
	<cffunction name="setAvatarCropType" access="public" returntype="void" output="false">
		<cfargument name="AvatarCropType" type="string" required="true" />
		<cfset variables.instance['avatarcroptype'] = arguments.AvatarCropType />
	</cffunction>
	<cffunction name="getAvatarCropType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AvatarCropType />
	</cffunction>
	
	<cffunction name="setUserCacheSize" access="public" returntype="void" output="false">
		<cfargument name="UserCacheSize" type="numeric" required="true" />
		<cfset variables.instance['usercachesize'] = arguments.UserCacheSize />
	</cffunction>
	<cffunction name="getUserCacheSize" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.UserCacheSize />
	</cffunction>
	
	<cffunction name="setResetAvatar" access="public" returntype="void" output="false">
		<cfargument name="ResetAvatar" type="boolean" required="true" />
		<cfset variables.instance['resetavatar'] = arguments.ResetAvatar />
	</cffunction>
	<cffunction name="getResetAvatar" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.ResetAvatar />
	</cffunction>
	
	<cffunction name="setDoInit" access="public" returntype="void" output="false">
		<cfargument name="DoInit" type="boolean" required="true" />
		<cfset variables.instance['doinit'] = arguments.DoInit />
	</cffunction>
	<cffunction name="getDoInit" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoInit />
	</cffunction>
	
	<cffunction name="setActiveWithinMinutes" access="public" returntype="void" output="false">
		<cfargument name="ActiveWithinMinutes" type="numeric" required="true" />
		<cfset variables.instance['activewithinminutes'] = arguments.ActiveWithinMinutes />
	</cffunction>
	<cffunction name="getActiveWithinMinutes" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ActiveWithinMinutes />
	</cffunction>
	
	<cffunction name="setSearchMode" access="public" returntype="void" output="false">
		<cfargument name="SearchMode" type="string" required="true" />
		<cfset variables.instance['searchmode'] = arguments.SearchMode />
	</cffunction>
	<cffunction name="getSearchMode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SearchMode />
	</cffunction>
	
	<cffunction name="setTempDir" access="public" returntype="void" output="false">
		<cfargument name="TempDir" type="string" required="true" />
		<cfset variables.instance['tempdir'] = arguments.TempDir />
	</cffunction>
	<cffunction name="getTempDir" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TempDir />
	</cffunction>
	
	<cffunction name="setBaseTempDir" access="public" returntype="void" output="false">
		<cfargument name="BaseTempDir" type="string" required="true" />
		<cfset variables.instance['basetempdir'] = arguments.BaseTempDir />
	</cffunction>
	<cffunction name="getBaseTempDir" access="public" returntype="string" output="false">
		<cfreturn variables.instance.BaseTempDir />
	</cffunction>
	
	<cffunction name="setURLKey" access="public" returntype="void" output="false">
		<cfargument name="URLKey" type="string" required="true" />
		<cfset variables.instance['urlkey'] = arguments.URLKey />
	</cffunction>
	<cffunction name="getURLKey" access="public" returntype="string" output="false">
		<cfreturn variables.instance.URLKey />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setDateCreate" access="public" returntype="void" output="false">
		<cfargument name="DateCreate" type="string" required="true" />
		<cfset variables.instance['datecreate'] = arguments.DateCreate />
	</cffunction>
	<cffunction name="getDateCreate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateCreate />
	</cffunction>
	
	<cffunction name="setDateLastUpdate" access="public" returntype="void" output="false">
		<cfargument name="DateLastUpdate" type="string" required="true" />
		<cfset variables.instance['datelastupdate'] = arguments.DateLastUpdate />
	</cffunction>
	<cffunction name="getDateLastUpdate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastUpdate />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- Services --->
	<cffunction name="save" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		
		<cfif getBeanExists()>
			<cfset getSettingsService().updateSettings( this ) />
		<cfelse>
			<cfset getSettingsService().saveSettings( this ) />
		</cfif>

		<cfreturn true>
	</cffunction>

	<cffunction name="update" access="public" output="true" return="boolean">
		<cfreturn save()>
	</cffunction>

	<cffunction name="delete" access="public" output="true" return="boolean">

		<cfset var sArgs = StructNew() />

		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		<cfset sArgs['SiteID'] = getSiteID() /> 
		

		<cfset getSettingsService().deleteSettings( argumentCollection=sArgs  ) />
		<cfreturn true>
	</cffunction>

	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#getMemento()#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

	<cffunction name="setBeanExists" access="public" output="false" returntype="void">
		<cfargument name="BeanExists" type="boolean" required="true" />
		<cfset variables.BeanExists = arguments.BeanExists >
	</cffunction>
	<cffunction name="BeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>
	<cffunction name="getBeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>

	<cffunction name="setSettingsService" access="public" returntype="void" output="false">
		<cfargument name="SettingsService" type="any" required="yes"/>
		<cfset variables.SettingsService = arguments.SettingsService />
	</cffunction>
	<cffunction name="getSettingsService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.SettingsService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"SettingsService")>
	</cffunction>
	
	<cffunction name="setThemeBean" access="public" returntype="void" output="false">
		<cfargument name="ThemeBean" type="any" required="true" />
		<cfset variables.instance['themebean'] = arguments.ThemeBean />
	</cffunction>
	<cffunction name="getThemeBean" access="public" returntype="any" output="false">
		<cfreturn variables.instance.ThemeBean />
	</cffunction>
	
	<cffunction name="setUserCache" access="public" returntype="void" output="false">
		<cfargument name="UserCache" type="any" required="true" />
		<cfset variables.instance['UserCache'] = arguments.UserCache />
	</cffunction>
	<cffunction name="getUserCache" access="public" returntype="any" output="false">
		<cfreturn variables.instance.UserCache />
	</cffunction>

	<cffunction name="getKey" access="public" returntype="string" output="false" >
		<cfreturn "MeldForumsSettings">
	</cffunction>

	<cffunction name="getID" access="public" returntype="uuid" output="false" >
		<cfreturn getSettingsID()>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	







