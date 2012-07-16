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
<cfcomponent name="ViewcounterService" output="false" extends="MeldForums.com.meldsolutions.core.MeldService">
<!---^^GENERATEDSTART^^--->
	<cffunction name="init" access="public" output="false" returntype="ViewcounterService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createViewcounter" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ForumID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="Views" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
				
		<cfset var tmpObj = createObject("component","ViewcounterBean").init(argumentCollection=arguments) />
		<cfset tmpObj.setViewcounterService( this ) />
		<cfreturn tmpObj />
	</cffunction>

	<cffunction name="getViewcounter" access="public" output="false" returntype="any">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ForumID" type="uuid" required="true" />
		<cfargument name="ThreadID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var ViewcounterBean = createViewcounter(argumentCollection=arguments) />
		<cfset getViewcounterDAO().read(ViewcounterBean) />
		<cfreturn ViewcounterBean />
	</cffunction>

	<cffunction name="getViewcounters" access="public" output="false" returntype="array">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ForumID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="Views" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->
		
		<cfreturn getViewcounterGateway().getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getBeanByAttributes" access="public" output="false" returntype="any">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ForumID" type="uuid" required="false" />
		<cfargument name="ThreadID" type="uuid" required="false" />
		<cfargument name="Views" type="numeric" required="false" />
		<cfargument name="DateCreate" type="string" required="false" />
		<cfargument name="DateLastUpdate" type="string" required="false" />
		<!---^^ATTRIBUTES-END^^--->

		<cfreturn getViewcounterGateway().getBeanByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getByArray" access="public" output="false" returntype="Query" >
		<cfargument name="idArray" type="array" required="true" />

		<cfreturn getViewcounterGateway().getByArray(argumentCollection=arguments) />
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
			<cfset sReturn.count = getViewcounterGateway().search(argumentCollection=arguments) />
			<cfset arguments.isCount = false>
		<cfelse>
			<cfset sReturn.count = arguments.count />
		</cfif>
		
		<cfset arrObjects = getViewcounterGateway().search(argumentCollection=arguments) />

		<cfset sReturn.start		= arguments.start />
		<cfset sReturn.size			= arguments.size />
		<cfset sReturn.itemarray	= arrObjects />

		<cfreturn sReturn />
	</cffunction>

	<cffunction name="saveViewcounter" access="public" output="false" returntype="boolean">
		<cfargument name="ViewcounterBean" type="any" required="true" />

		<cfreturn getViewcounterDAO().save(ViewcounterBean) />
	</cffunction>
	
	<cffunction name="updateViewcounter" access="public" output="false" returntype="boolean">
		<cfargument name="ViewcounterBean" type="any" required="true" />

		<cfreturn getViewcounterDAO().update(ViewcounterBean) />
	</cffunction>

	<cffunction name="deleteViewcounter" access="public" output="false" returntype="boolean">
		<!---^^PRIMARY-START^^--->
		<cfargument name="ForumID" type="uuid" required="true" />
		<cfargument name="ThreadID" type="uuid" required="true" />
		<!---^^PRIMARY-END^^--->
		
		<cfset var ViewcounterBean = createViewcounter(argumentCollection=arguments) />
		<cfreturn getViewcounterDAO().delete(ViewcounterBean) />
	</cffunction>

	<cffunction name="setViewcounterGateway" access="public" returntype="void" output="false">
		<cfargument name="ViewcounterGateway" type="any" required="true" />
		<cfset variables['viewcounterGateway'] = arguments.ViewcounterGateway />
	</cffunction>
	<cffunction name="getViewcounterGateway" access="public" returntype="any" output="false">
		<cfreturn ViewcounterGateway />
	</cffunction>

	<cffunction name="setViewcounterDAO" access="public" returntype="void" output="false">
		<cfargument name="ViewcounterDAO" type="any" required="true" />
		<cfset variables['viewcounterDAO'] = arguments.ViewcounterDAO />
	</cffunction>
	<cffunction name="getViewcounterDAO" access="public" returntype="any" output="false">
		<cfreturn variables.ViewcounterDAO />
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>









