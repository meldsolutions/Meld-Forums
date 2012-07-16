<!---
This file is part of the Meld Forums application.

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
<cfcomponent displayname="MeldBean" hint="Root for all mm-based beans" output="false">
	<cfset variables.values			= StructNew()>
	<cfset variables.customvalues	= StructNew()>
	<cfset variables.customset		= false>

	<cffunction name="init" access="public" output="false" returntype="MeldBean">
		<cfargument name="isDirty" type="boolean" required="false" default="0" /> 
		
		<cfset setIsDirty( isDirty ) />
		
		<cfreturn this/>
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="PostBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<!--- will update an existing bean's memento with data values --->
	<cffunction name="updateMemento" access="public" output="false" returntype="void">
		<cfargument name="data" type="struct" required="true">

		<cfset var iiX = "">
		<cfloop collection="#arguments.data#" item="iiX">
			<cfif structKeyExists( variables.instance,iiX )>
				<cfset variables.instance[lcase(iiX)] = arguments.data[iiX]>
			</cfif>
		</cfloop>

		<cfif isDefined("arguments.data.values") and isStruct( arguments.data.values )>
			<cfloop collection="#arguments.data.values#" item="iiX">
				<cfset variables.values[lcase(iiX)] = arguments.data.values[iiX]>
			</cfloop>
		</cfif>
	</cffunction>

	<cffunction name="getAsJSON" access="public" output="false" returntype="String" >
		<cfset var data = getAsStruct() />
		
		<cfreturn serializeJSON( data ) />
	</cffunction>

	<cffunction name="getAsStruct" access="public" output="false" returntype="struct">
		<cfset var data			= getMemento()>
		<cfset var iiX			= "">
		<cfset var subBeans		= StructNew()>
		<cfset var subData		= StructNew()>
		<cfset var subItem		= "">
		<cfset var iiY			= "">

		<cfloop collection="#data#" item="iiX">
			<cfif isInstanceOf(data[iiX],"MeldBean")>
				<cfset data[iiX] = data[iiX].getAsStruct() />
			<cfelseif isStruct( data[iiX] ) and StructCount( data[iiX] )>
				<cfset subBeans = data[iiX] />
				<cfset subData	= StructNew()>

				<cfloop collection="#subBeans#" item="iiY">
					<cfset subItem = subBeans[iiY] />
					<cfif isInstanceOf(subItem,"MeldBean")>
						<cfset subData[iiY] = subItem.getAsStruct() />
					<cfelseif isStruct(subItem)>
						<cfset subData[iiY] = subItem />
					</cfif>
				</cfloop>
				<cfif structCount( subData )>
					<cfset data[iiX] = subData />
				</cfif>
			<cfelseif isJSON(data[iiX])>
				<cfset data[iiX] = deserializeJSON( data[iiX] ) />
			</cfif> 
		</cfloop>
		
		<cfreturn data />
	</cffunction>

	<!--- VALUES --->
	<cffunction name="getCustomValues" access="public" output="false" returntype="any">
		<cfset var custObj		= "" />
		<cfset var qData		= "" />
		
		<cfif variables.customset>
			<cfreturn variables.customvalues />
		</cfif>
	
		<cfset custObj	= getClassExtension()>
		<cfset qData = custObj.getExtendedData().getAllValues().data />

		<cfloop query="qData">
			<cfset variables.customvalues[name] = attributevalue /> 
		</cfloop>
		<cfset variables.customset = true />
		
		<cfreturn variables.customvalues />
	</cffunction>

	<cffunction name="getCustomValuesQuery" access="public" output="false" returntype="query">

		<cfreturn getClassExtension().GETEXTENDEDDATA().GETALLVALUES().data />
	</cffunction>

	<cffunction name="getClassExtension" access="public" output="false" returntype="any">
		<cfset var classExt		= "" />
		<cfset var siteID		= "" />
		
		<cfif StructKeyExists(variables,"classextension")>
			<cfreturn variables.classExtension />
		</cfif>
		
		<!--- bean not configured --->
		<cfif not structKeyExists(this,"getKey") or not structKeyExists(this,"getID")>
			<cfset classExt	= createObject("component","mura.extend.extendObject").init(Type="Custom",SubType="Null",SiteID="default" ) />
			<cfset classExt.setID( '00000000-0000-0000-0000000000000001' ) />
			<cfset classExt.setSiteID( 'default' ) />
			<cfset variables.classExtension = classExt />
			<cfreturn variables.classExtension />
		<cfelseif not structKeyExists(this,"getSiteID") or not len( getSiteID() )>
			<cfset siteID = 'default' />
		<cfelse>
			<cfset siteID = getSiteID() />
		</cfif>
		
		<cfset classExt	= createObject("component","mura.extend.extendObject").init(Type="Custom",SubType="#getKey()#",SiteID="#siteID#" )>
		<cfset classExt.setID( getID() ) />
		<cfset classExt.setSiteID( siteID ) />
		
		<cfset variables.classExtension = classExt />
		<cfreturn variables.classExtension />
	</cffunction>

	<cffunction name="valueExists" access="public" output="false" returntype="boolean">
		<cfargument name="key" type="string" required="true">
		
		<cfreturn structkeyexists( variables.values,arguments.key) or structkeyexists( variables.customvalues,arguments.key) />
	</cffunction>
	<cffunction name="getAllValues" access="public" output="false" returntype="struct">
		<cfreturn variables.values />
	</cffunction>
	<cffunction name="getAllCustomValues" access="public" output="false" returntype="struct">
		<cfreturn variables.customvalues />
	</cffunction>
	<cffunction name="setAllValues" access="public" output="false" returntype="void">
		<cfargument name="value" type="struct" required="true">
		
		<cfset variables.values = structCopy( arguments.value ) />
	</cffunction>

	<cffunction name="clearAllValues" access="public" output="false" returntype="struct">
		<cfreturn structclear(variables.values) />
	</cffunction>

	<cffunction name="setValue" access="public" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		
		<cfset variables.values[arguments.key] = arguments.value />
	</cffunction>

	<cffunction name="getValue" access="public" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		
		<cfif structkeyexists( variables.values,arguments.key)>
			<cfreturn variables.values[arguments.key] />
		<cfelseif structkeyexists( variables.customvalues,arguments.key)>
			<cfreturn variables.customvalues[arguments.key] />
		</cfif>
		<cfreturn "" />
	</cffunction>

	<cffunction name="getCustomValue" access="public" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		
		<cfif structkeyexists( variables.customvalues,arguments.key)>
			<cfreturn variables.customvalues[arguments.key] />
		</cfif>
		<cfreturn "" />
	</cffunction>


	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfif isDate( getDateCreate() )>
			<cfreturn true />
		</cfif>
		<cfreturn false />
	</cffunction>
	
	<cffunction name="setIsDirty" access="public" returntype="void" output="false">
		<cfargument name="IsDirty" type="boolean" required="true" />
		<cfset variables.instance['isdirty'] = arguments.IsDirty />
	</cffunction>
	<cffunction name="getIsDirty" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsDirty />
	</cffunction>
</cfcomponent>