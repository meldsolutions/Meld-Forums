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
<cfcomponent name="DisplaytypeService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="DisplaytypeService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createDisplaytype" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="IsConfigurable" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Version" type="string" required="false" />
		<cfargument name="Defaults" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var tmpObj = createObject("component","DisplaytypeBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setDisplaytypeService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getDisplaytype" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var DisplaytypeBean = createDisplaytype(argumentCollection=arguments) />
		<cfset getDisplaytypeDAO().read(DisplaytypeBean) />
		<cfreturn DisplaytypeBean />
	</cffunction>

	<cffunction name="getDisplaytypes" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="IsConfigurable" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Version" type="string" required="false" />
		<cfargument name="Defaults" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn getDisplaytypeGateway().getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="false" />
		<cfargument name="ObjectID" type="string" required="false" />
		<cfargument name="Package" type="string" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Settings" type="string" required="false" />
		<cfargument name="IsConfigurable" type="boolean" required="false" />
		<cfargument name="IsActive" type="boolean" required="false" />
		<cfargument name="Version" type="string" required="false" />
		<cfargument name="Defaults" type="string" required="false" />
		<cfargument name="ModuleID" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn getDisplaytypeGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getDisplaytypeGateway().getByArray(argumentCollection=arguments) />
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
			<cfset sReturn.count = getDisplaytypeGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getDisplaytypeGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveDisplaytype" access="public" output="false" returntype="boolean">
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfreturn getDisplaytypeDAO().save(DisplaytypeBean) />
	</cffunction>
	
	<cffunction name="updateDisplaytype" access="public" output="false" returntype="boolean">
		<cfargument name="DisplaytypeBean" type="any" required="true" />

		<cfreturn getDisplaytypeDAO().update(DisplaytypeBean) />
	</cffunction>

	<cffunction name="deleteDisplaytype" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var DisplaytypeBean = createDisplaytype(argumentCollection=arguments) />
		<cfreturn getDisplaytypeDAO().delete(DisplaytypeBean) />
	</cffunction>

	<cffunction name="setDisplaytypeGateway" access="public" returntype="void" output="false">
		<cfargument name="DisplaytypeGateway" type="any" required="true" />
		<cfset variables['displaytypeGateway'] = arguments.DisplaytypeGateway />
	</cffunction>
	<cffunction name="getDisplaytypeGateway" access="public" returntype="any" output="false">
		<cfreturn DisplaytypeGateway />
	</cffunction>

	<cffunction name="setDisplaytypeDAO" access="public" returntype="void" output="false">
		<cfargument name="DisplaytypeDAO" type="any" required="true" />
		<cfset variables['displaytypeDAO'] = arguments.DisplaytypeDAO />
	</cffunction>
	<cffunction name="getDisplaytypeDAO" access="public" returntype="any" output="false">
		<cfreturn variables.DisplaytypeDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>










