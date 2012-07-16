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
<cfcomponent displayname="DisplayBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="DisplayID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="DisplayTypeID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ObjectID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Name" type="string" default="" required="true" maxlength="150" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="Params" type="string" default="" />
	<cfproperty name="Notes" type="string" default="" />
	<cfproperty name="IsActive" type="boolean" default="0" required="true" />
	<cfproperty name="AdminID" type="uuid" default="" maxlength="35" />
	<cfproperty name="ModuleID" type="uuid" default="" maxlength="35" />
	<cfproperty name="ContentID" type="uuid" default="" maxlength="35" />
	<cfproperty name="IsValid" type="boolean" default="0" required="true" />
	<cfproperty name="Settings" type="string" default="" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="DisplayBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="DisplayID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="DisplayTypeID" type="string" required="false" default="" />
		<cfargument name="ObjectID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="Params" type="string" required="false" default="" />
		<cfargument name="Notes" type="string" required="false" default="" />
		<cfargument name="IsActive" type="boolean" required="false" default="0" />
		<cfargument name="AdminID" type="string" required="false" default="" />
		<cfargument name="ModuleID" type="string" required="false" default="" />
		<cfargument name="ContentID" type="string" required="false" default="" />
		<cfargument name="IsValid" type="boolean" required="false" default="0" />
		<cfargument name="Settings" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />

		<!---^^SETTERS-START^^--->
		<cfset setDisplayID( arguments.DisplayID ) />
		<cfset setDisplayTypeID( arguments.DisplayTypeID ) />
		<cfset setObjectID( arguments.ObjectID ) />
		<cfset setName( arguments.Name ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setParams( arguments.Params ) />
		<cfset setNotes( arguments.Notes ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setAdminID( arguments.AdminID ) />
		<cfset setModuleID( arguments.ModuleID ) />
		<cfset setContentID( arguments.ContentID ) />
		<cfset setIsValid( arguments.IsValid ) />
		<cfset setSettings( arguments.Settings ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="DisplayBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setDisplayID" access="public" returntype="void" output="false">
		<cfargument name="DisplayID" type="uuid" required="true" />
		<cfset variables.instance['displayid'] = arguments.DisplayID />
	</cffunction>
	<cffunction name="getDisplayID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.DisplayID />
	</cffunction>
	
	<cffunction name="setDisplayTypeID" access="public" returntype="void" output="false">
		<cfargument name="DisplayTypeID" type="string" required="true" />
		<cfset variables.instance['displaytypeid'] = arguments.DisplayTypeID />
	</cffunction>
	<cffunction name="getDisplayTypeID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DisplayTypeID />
	</cffunction>
	
	<cffunction name="setObjectID" access="public" returntype="void" output="false">
		<cfargument name="ObjectID" type="string" required="true" />
		<cfset variables.instance['objectid'] = arguments.ObjectID />
	</cffunction>
	<cffunction name="getObjectID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ObjectID />
	</cffunction>
	
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
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
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	
	<cffunction name="setParams" access="public" returntype="void" output="false">
		<cfargument name="Params" type="string" required="true" />
		<cfset variables.instance['params'] = arguments.Params />
	</cffunction>
	<cffunction name="getParams" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Params />
	</cffunction>
	
	<cffunction name="setNotes" access="public" returntype="void" output="false">
		<cfargument name="Notes" type="string" required="true" />
		<cfset variables.instance['notes'] = arguments.Notes />
	</cffunction>
	<cffunction name="getNotes" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Notes />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setAdminID" access="public" returntype="void" output="false">
		<cfargument name="AdminID" type="string" required="true" />
		<cfset variables.instance['adminid'] = arguments.AdminID />
	</cffunction>
	<cffunction name="getAdminID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AdminID />
	</cffunction>
	
	<cffunction name="setModuleID" access="public" returntype="void" output="false">
		<cfargument name="ModuleID" type="string" required="true" />
		<cfset variables.instance['moduleid'] = arguments.ModuleID />
	</cffunction>
	<cffunction name="getModuleID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ModuleID />
	</cffunction>
	
	<cffunction name="setContentID" access="public" returntype="void" output="false">
		<cfargument name="ContentID" type="string" required="true" />
		<cfset variables.instance['contentid'] = arguments.ContentID />
	</cffunction>
	<cffunction name="getContentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ContentID />
	</cffunction>
	
	<cffunction name="setIsValid" access="public" returntype="void" output="false">
		<cfargument name="IsValid" type="boolean" required="true" />
		<cfset variables.instance['isvalid'] = arguments.IsValid />
	</cffunction>
	<cffunction name="getIsValid" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsValid />
	</cffunction>
	
	<cffunction name="setSettings" access="public" returntype="void" output="false">
		<cfargument name="Settings" type="string" required="true" />
		<cfset variables.instance['settings'] = arguments.Settings />
	</cffunction>
	<cffunction name="getSettings" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Settings />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- Services --->
	<cffunction name="save" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		
		<cfif getBeanExists()>
			<cfset getDisplayService().updateDisplay( this ) />
		<cfelse>
			<cfset getDisplayService().saveDisplay( this ) />
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
		<cfset sArgs['DisplayID'] = getDisplayID() /> 
		

		<cfset getDisplayService().deleteDisplay( argumentCollection=sArgs  ) />
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

	<cffunction name="setDisplayService" access="public" returntype="void" output="false">
		<cfargument name="DisplayService" type="any" required="yes"/>
		<cfset variables.DisplayService = arguments.DisplayService />
	</cffunction>
	<cffunction name="getDisplayService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.DisplayService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"DisplayService")>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	




