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
<cfcomponent displayname="ThemeBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="ThemeID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="Name" type="string" default="" required="true" maxlength="35" />
	<cfproperty name="PackageName" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="AvatarSmallWidth" type="numeric" default="125" required="true" />
	<cfproperty name="AvatarSmallHeight" type="numeric" default="125" required="true" />
	<cfproperty name="AvatarMediumWidth" type="numeric" default="250" required="true" />
	<cfproperty name="AvatarMediumHeight" type="numeric" default="250" required="true" />
	<cfproperty name="AvatarDimensionType" type="string" default="square" required="true" maxlength="25" />
	<cfproperty name="Settings" type="string" default="" />
	<cfproperty name="DefaultAvatar" type="string" default="" maxlength="80" />
	<cfproperty name="IsMaster" type="boolean" default="0" required="true" />
	<cfproperty name="Style" type="string" default="" maxlength="12" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="ThemeBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThemeID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="PackageName" type="string" required="false" default="" />
		<cfargument name="AvatarSmallWidth" type="numeric" required="false" default="125" />
		<cfargument name="AvatarSmallHeight" type="numeric" required="false" default="125" />
		<cfargument name="AvatarMediumWidth" type="numeric" required="false" default="250" />
		<cfargument name="AvatarMediumHeight" type="numeric" required="false" default="250" />
		<cfargument name="AvatarDimensionType" type="string" required="false" default="square" />
		<cfargument name="Settings" type="string" required="false" default="" />
		<cfargument name="DefaultAvatar" type="string" required="false" default="" />
		<cfargument name="IsMaster" type="boolean" required="false" default="0" />
		<cfargument name="Style" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />

		<!---^^SETTERS-START^^--->
		<cfset setThemeID( arguments.ThemeID ) />
		<cfset setName( arguments.Name ) />
		<cfset setPackageName( arguments.PackageName ) />
		<cfset setAvatarSmallWidth( arguments.AvatarSmallWidth ) />
		<cfset setAvatarSmallHeight( arguments.AvatarSmallHeight ) />
		<cfset setAvatarMediumWidth( arguments.AvatarMediumWidth ) />
		<cfset setAvatarMediumHeight( arguments.AvatarMediumHeight ) />
		<cfset setAvatarDimensionType( arguments.AvatarDimensionType ) />
		<cfset setSettings( arguments.Settings ) />
		<cfset setDefaultAvatar( arguments.DefaultAvatar ) />
		<cfset setIsMaster( arguments.IsMaster ) />
		<cfset setStyle( arguments.Style ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="ThemeBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setThemeID" access="public" returntype="void" output="false">
		<cfargument name="ThemeID" type="uuid" required="true" />
		<cfset variables.instance['themeid'] = arguments.ThemeID />
	</cffunction>
	<cffunction name="getThemeID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.ThemeID />
	</cffunction>
	
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>
	
	<cffunction name="setPackageName" access="public" returntype="void" output="false">
		<cfargument name="PackageName" type="string" required="true" />
		<cfset variables.instance['packagename'] = arguments.PackageName />
	</cffunction>
	<cffunction name="getPackageName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PackageName />
	</cffunction>
	
	<cffunction name="setAvatarSmallWidth" access="public" returntype="void" output="false">
		<cfargument name="AvatarSmallWidth" type="numeric" required="true" />
		<cfset variables.instance['avatarsmallwidth'] = arguments.AvatarSmallWidth />
	</cffunction>
	<cffunction name="getAvatarSmallWidth" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.AvatarSmallWidth />
	</cffunction>
	
	<cffunction name="setAvatarSmallHeight" access="public" returntype="void" output="false">
		<cfargument name="AvatarSmallHeight" type="numeric" required="true" />
		<cfset variables.instance['avatarsmallheight'] = arguments.AvatarSmallHeight />
	</cffunction>
	<cffunction name="getAvatarSmallHeight" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.AvatarSmallHeight />
	</cffunction>
	
	<cffunction name="setAvatarMediumWidth" access="public" returntype="void" output="false">
		<cfargument name="AvatarMediumWidth" type="numeric" required="true" />
		<cfset variables.instance['avatarmediumwidth'] = arguments.AvatarMediumWidth />
	</cffunction>
	<cffunction name="getAvatarMediumWidth" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.AvatarMediumWidth />
	</cffunction>
	
	<cffunction name="setAvatarMediumHeight" access="public" returntype="void" output="false">
		<cfargument name="AvatarMediumHeight" type="numeric" required="true" />
		<cfset variables.instance['avatarmediumheight'] = arguments.AvatarMediumHeight />
	</cffunction>
	<cffunction name="getAvatarMediumHeight" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.AvatarMediumHeight />
	</cffunction>
	
	<cffunction name="setAvatarDimensionType" access="public" returntype="void" output="false">
		<cfargument name="AvatarDimensionType" type="string" required="true" />
		<cfset variables.instance['avatardimensiontype'] = arguments.AvatarDimensionType />
	</cffunction>
	<cffunction name="getAvatarDimensionType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AvatarDimensionType />
	</cffunction>
	
	<cffunction name="setSettings" access="public" returntype="void" output="false">
		<cfargument name="Settings" type="string" required="true" />
		<cfset variables.instance['settings'] = arguments.Settings />
	</cffunction>
	<cffunction name="getSettings" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Settings />
	</cffunction>
	
	<cffunction name="setDefaultAvatar" access="public" returntype="void" output="false">
		<cfargument name="DefaultAvatar" type="string" required="true" />
		<cfset variables.instance['defaultavatar'] = arguments.DefaultAvatar />
	</cffunction>
	<cffunction name="getDefaultAvatar" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DefaultAvatar />
	</cffunction>
	
	<cffunction name="setIsMaster" access="public" returntype="void" output="false">
		<cfargument name="IsMaster" type="boolean" required="true" />
		<cfset variables.instance['ismaster'] = arguments.IsMaster />
	</cffunction>
	<cffunction name="getIsMaster" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsMaster />
	</cffunction>
	
	<cffunction name="setStyle" access="public" returntype="void" output="false">
		<cfargument name="Style" type="string" required="true" />
		<cfset variables.instance['style'] = arguments.Style />
	</cffunction>
	<cffunction name="getStyle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Style />
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
			<cfset getThemeService().updateTheme( this ) />
		<cfelse>
			<cfset getThemeService().saveTheme( this ) />
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
		<cfset sArgs['ThemeID'] = getThemeID() /> 
		
		<cfset getThemeService().deleteTheme( argumentCollection=sArgs  ) />
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

	<cffunction name="setThemeService" access="public" returntype="void" output="false">
		<cfargument name="ThemeService" type="any" required="yes"/>
		<cfset variables.ThemeService = arguments.ThemeService />
	</cffunction>
	<cffunction name="getThemeService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.ThemeService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"ThemeService")>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	

