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
<cfcomponent name="DisplayService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="DisplayService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createDisplay" access="public" output="false" returntype="any">
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
				
		<cfset var tmpObj = createObject("component","DisplayBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setDisplayService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getDisplay" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="DisplayID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var DisplayBean = createDisplay(argumentCollection=arguments) />
		<cfset getDisplayDAO().read(DisplayBean) />
		<cfreturn DisplayBean />
	</cffunction>

	<cffunction name="getDisplays" access="public" output="false" returntype="array">
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
		
		<cfreturn getDisplayGateway().getByAttributes(argumentCollection=arguments) />
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

		<cfreturn getDisplayGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getDisplayGateway().getByArray(argumentCollection=arguments) />
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
			<cfset sReturn.count = getDisplayGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getDisplayGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveDisplay" access="public" output="false" returntype="boolean">
		<cfargument name="DisplayBean" type="any" required="true" />

		<cfreturn getDisplayDAO().save(DisplayBean) />
	</cffunction>
	
	<cffunction name="updateDisplay" access="public" output="false" returntype="boolean">
		<cfargument name="DisplayBean" type="any" required="true" />

		<cfreturn getDisplayDAO().update(DisplayBean) />
	</cffunction>

	<cffunction name="deleteDisplay" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="DisplayID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var DisplayBean = createDisplay(argumentCollection=arguments) />
		<cfreturn getDisplayDAO().delete(DisplayBean) />
	</cffunction>

	<cffunction name="setDisplayGateway" access="public" returntype="void" output="false">
		<cfargument name="DisplayGateway" type="any" required="true" />
		<cfset variables['displayGateway'] = arguments.DisplayGateway />
	</cffunction>
	<cffunction name="getDisplayGateway" access="public" returntype="any" output="false">
		<cfreturn DisplayGateway />
	</cffunction>

	<cffunction name="setDisplayDAO" access="public" returntype="void" output="false">
		<cfargument name="DisplayDAO" type="any" required="true" />
		<cfset variables['displayDAO'] = arguments.DisplayDAO />
	</cffunction>
	<cffunction name="getDisplayDAO" access="public" returntype="any" output="false">
		<cfreturn variables.DisplayDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>










