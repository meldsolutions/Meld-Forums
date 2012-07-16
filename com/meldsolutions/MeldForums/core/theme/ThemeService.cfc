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
<cfcomponent name="ThemeService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ThemeService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createTheme" access="public" output="false" returntype="any">
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
				
		<cfset var tmpObj = createObject("component","ThemeBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setThemeService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getTheme" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ThemeID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var ThemeBean = createTheme(argumentCollection=arguments) />
		<cfset getThemeDAO().read(ThemeBean) />
		<cfreturn ThemeBean />
	</cffunction>

	<cffunction name="getThemes" access="public" output="false" returntype="array">
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
		
		<cfreturn getThemeGateway().getByAttributes(argumentCollection=arguments) />
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

		<cfreturn getThemeGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getThemeGateway().getByArray(argumentCollection=arguments) />
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
			<cfset sReturn.count = getThemeGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getThemeGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveTheme" access="public" output="false" returntype="boolean">
		<cfargument name="ThemeBean" type="any" required="true" />

		<cfreturn getThemeDAO().save(ThemeBean) />
	</cffunction>
	
	<cffunction name="updateTheme" access="public" output="false" returntype="boolean">
		<cfargument name="ThemeBean" type="any" required="true" />

		<cfreturn getThemeDAO().update(ThemeBean) />
	</cffunction>

	<cffunction name="deleteTheme" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ThemeID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var ThemeBean = createTheme(argumentCollection=arguments) />
		<cfreturn getThemeDAO().delete(ThemeBean) />
	</cffunction>

	<cffunction name="setThemeGateway" access="public" returntype="void" output="false">
		<cfargument name="ThemeGateway" type="any" required="true" />
		<cfset variables['themeGateway'] = arguments.ThemeGateway />
	</cffunction>
	<cffunction name="getThemeGateway" access="public" returntype="any" output="false">
		<cfreturn ThemeGateway />
	</cffunction>

	<cffunction name="setThemeDAO" access="public" returntype="void" output="false">
		<cfargument name="ThemeDAO" type="any" required="true" />
		<cfset variables['themeDAO'] = arguments.ThemeDAO />
	</cffunction>
	<cffunction name="getThemeDAO" access="public" returntype="any" output="false">
		<cfreturn variables.ThemeDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>

