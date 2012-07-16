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
<cfcomponent name="SearchableService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="SearchableService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createSearchable" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="Searchblock" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var tmpObj = createObject("component","SearchableBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setSearchableService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getSearchable" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="PostID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var SearchableBean = createSearchable(argumentCollection=arguments) />
		<cfset getSearchableDAO().read(SearchableBean) />
		<cfreturn SearchableBean />
	</cffunction>

	<cffunction name="getSearchables" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="Searchblock" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn getSearchableGateway().getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="string" required="false" />
		<cfargument name="PostID" type="uuid" required="false" />
		<cfargument name="Searchblock" type="string" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn getSearchableGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getSearchableGateway().getByArray(argumentCollection=arguments) />
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
			<cfset sReturn.count = getSearchableGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getSearchableGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveSearchable" access="public" output="false" returntype="boolean">
		<cfargument name="SearchableBean" type="any" required="true" />

		<cfreturn getSearchableDAO().save(SearchableBean) />
	</cffunction>
	
	<cffunction name="updateSearchable" access="public" output="false" returntype="boolean">
		<cfargument name="SearchableBean" type="any" required="true" />

		<cfreturn getSearchableDAO().update(SearchableBean) />
	</cffunction>

	<cffunction name="deleteSearchable" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="PostID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var SearchableBean = createSearchable(argumentCollection=arguments) />
		<cfreturn getSearchableDAO().delete(SearchableBean) />
	</cffunction>

	<cffunction name="setSearchableGateway" access="public" returntype="void" output="false">
		<cfargument name="SearchableGateway" type="any" required="true" />
		<cfset variables['searchableGateway'] = arguments.SearchableGateway />
	</cffunction>
	<cffunction name="getSearchableGateway" access="public" returntype="any" output="false">
		<cfreturn SearchableGateway />
	</cffunction>

	<cffunction name="setSearchableDAO" access="public" returntype="void" output="false">
		<cfargument name="SearchableDAO" type="any" required="true" />
		<cfset variables['searchableDAO'] = arguments.SearchableDAO />
	</cffunction>
	<cffunction name="getSearchableDAO" access="public" returntype="any" output="false">
		<cfreturn variables.SearchableDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>














