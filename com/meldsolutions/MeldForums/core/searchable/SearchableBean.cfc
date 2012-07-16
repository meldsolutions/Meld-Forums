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
<cfcomponent displayname="SearchableBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="ThreadID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="PostID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="Searchblock" type="string" default="" required="true" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="SearchableBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="string" required="false" default="" />
		<cfargument name="PostID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="Searchblock" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />

		<!---^^SETTERS-START^^--->
		<cfset setThreadID( arguments.ThreadID ) />
		<cfset setPostID( arguments.PostID ) />
		<cfset setSearchblock( arguments.Searchblock ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="SearchableBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setThreadID" access="public" returntype="void" output="false">
		<cfargument name="ThreadID" type="string" required="true" />
		<cfset variables.instance['threadid'] = arguments.ThreadID />
	</cffunction>
	<cffunction name="getThreadID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ThreadID />
	</cffunction>
	
	<cffunction name="setPostID" access="public" returntype="void" output="false">
		<cfargument name="PostID" type="uuid" required="true" />
		<cfset variables.instance['postid'] = arguments.PostID />
	</cffunction>
	<cffunction name="getPostID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.PostID />
	</cffunction>
	
	<cffunction name="setSearchblock" access="public" returntype="void" output="false">
		<cfargument name="Searchblock" type="string" required="true" />
		<cfset variables.instance['searchblock'] = arguments.Searchblock />
	</cffunction>
	<cffunction name="getSearchblock" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Searchblock />
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
			<cfset getSearchableService().updateSearchable( this ) />
		<cfelse>
			<cfset getSearchableService().saveSearchable( this ) />
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
		<cfset sArgs['ThreadID'] = getThreadID() /> 
		<cfset sArgs['PostID'] = getPostID() /> 
		

		<cfset getSearchableService().deleteSearchable( argumentCollection=sArgs  ) />
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

	<cffunction name="setSearchableService" access="public" returntype="void" output="false">
		<cfargument name="SearchableService" type="any" required="yes"/>
		<cfset variables.SearchableService = arguments.SearchableService />
	</cffunction>
	<cffunction name="getSearchableService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.SearchableService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"SearchableService")>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	








