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
<cfcomponent displayname="DisplaytypeBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="Displaytypeid" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ObjectID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Package" type="string" default="" required="true" maxlength="45" />
	<cfproperty name="Name" type="string" default="" required="true" maxlength="45" />
	<cfproperty name="Description" type="string" default="" />
	<cfproperty name="Settings" type="string" default="" />
	<cfproperty name="IsConfigurable" type="boolean" default="0" required="true" />
	<cfproperty name="IsActive" type="boolean" default="1" required="true" />
	<cfproperty name="Version" type="string" default="" required="true" maxlength="12" />
	<cfproperty name="Defaults" type="string" default="" />
	<cfproperty name="ModuleID" type="uuid" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="DisplaytypeBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="Displaytypeid" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="ObjectID" type="string" required="false" default="" />
		<cfargument name="Package" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="Settings" type="string" required="false" default="" />
		<cfargument name="IsConfigurable" type="boolean" required="false" default="0" />
		<cfargument name="IsActive" type="boolean" required="false" default="1" />
		<cfargument name="Version" type="string" required="false" default="" />
		<cfargument name="Defaults" type="string" required="false" default="" />
		<cfargument name="ModuleID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />

		<!---^^SETTERS-START^^--->
		<cfset setDisplaytypeid( arguments.Displaytypeid ) />
		<cfset setObjectID( arguments.ObjectID ) />
		<cfset setPackage( arguments.Package ) />
		<cfset setName( arguments.Name ) />
		<cfset setDescription( arguments.Description ) />
		<cfset setSettings( arguments.Settings ) />
		<cfset setIsConfigurable( arguments.IsConfigurable ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setVersion( arguments.Version ) />
		<cfset setDefaults( arguments.Defaults ) />
		<cfset setModuleID( arguments.ModuleID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="DisplaytypeBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setDisplaytypeid" access="public" returntype="void" output="false">
		<cfargument name="Displaytypeid" type="uuid" required="true" />
		<cfset variables.instance['displaytypeid'] = arguments.Displaytypeid />
	</cffunction>
	<cffunction name="getDisplaytypeid" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.Displaytypeid />
	</cffunction>
	
	<cffunction name="setObjectID" access="public" returntype="void" output="false">
		<cfargument name="ObjectID" type="string" required="true" />
		<cfset variables.instance['objectid'] = arguments.ObjectID />
	</cffunction>
	<cffunction name="getObjectID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ObjectID />
	</cffunction>
	
	<cffunction name="setPackage" access="public" returntype="void" output="false">
		<cfargument name="Package" type="string" required="true" />
		<cfset variables.instance['package'] = arguments.Package />
	</cffunction>
	<cffunction name="getPackage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Package />
	</cffunction>
	
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>
	
	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance['description'] = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>
	
	<cffunction name="setSettings" access="public" returntype="void" output="false">
		<cfargument name="Settings" type="string" required="true" />
		<cfset variables.instance['settings'] = arguments.Settings />
	</cffunction>
	<cffunction name="getSettings" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Settings />
	</cffunction>
	
	<cffunction name="setIsConfigurable" access="public" returntype="void" output="false">
		<cfargument name="IsConfigurable" type="boolean" required="true" />
		<cfset variables.instance['isconfigurable'] = arguments.IsConfigurable />
	</cffunction>
	<cffunction name="getIsConfigurable" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsConfigurable />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setVersion" access="public" returntype="void" output="false">
		<cfargument name="Version" type="string" required="true" />
		<cfset variables.instance['version'] = arguments.Version />
	</cffunction>
	<cffunction name="getVersion" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Version />
	</cffunction>
	
	<cffunction name="setDefaults" access="public" returntype="void" output="false">
		<cfargument name="Defaults" type="string" required="true" />
		<cfset variables.instance['defaults'] = arguments.Defaults />
	</cffunction>
	<cffunction name="getDefaults" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Defaults />
	</cffunction>
	
	<cffunction name="setModuleID" access="public" returntype="void" output="false">
		<cfargument name="ModuleID" type="string" required="true" />
		<cfset variables.instance['moduleid'] = arguments.ModuleID />
	</cffunction>
	<cffunction name="getModuleID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ModuleID />
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
			<cfset getDisplaytypeService().updateDisplaytype( this ) />
		<cfelse>
			<cfset getDisplaytypeService().saveDisplaytype( this ) />
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
		<cfset sArgs['Displaytypeid'] = getDisplaytypeid() /> 
		

		<cfset getDisplaytypeService().deleteDisplaytype( argumentCollection=sArgs  ) />
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

	<cffunction name="setDisplaytypeService" access="public" returntype="void" output="false">
		<cfargument name="DisplaytypeService" type="any" required="yes"/>
		<cfset variables.DisplaytypeService = arguments.DisplaytypeService />
	</cffunction>
	<cffunction name="getDisplaytypeService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.DisplaytypeService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"DisplaytypeService")>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	




