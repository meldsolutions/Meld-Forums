<!---
This file is part of the Meld Manager application.

Meld Manager is licensed under the GPL 2.0 license
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
<cfcomponent displayname="FileUploadBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="ModuleID" type="uuid" default="" maxlength="35" />
	<cfproperty name="ContentID" type="uuid" default="" maxlength="35" />
	<cfproperty name="FileSizeLimit" type="numeric" default="1000" required="true" />
	<cfproperty name="AllowedExtensions" type="string" default="png,gif,jpg,jpeg" required="true" maxlength="255" />
	<cfproperty name="DoClearPrevious" type="boolean" default="0" />
	<cfproperty name="LargeFile" type="any" default="" />
	<cfproperty name="MediumFile" type="any" default="" />
	<cfproperty name="SmallFile" type="any" default="" />
	<cfproperty name="FileData" type="struct" default="" />
	<cfproperty name="FilePath" type="string" default="" />
	<cfproperty name="MuraFileID" type="string" default="" />

	<cfset variables.instance = StructNew() />

	<cffunction name="init" access="public" returntype="FileUploadBean" output="false">
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="ModuleID" type="string" required="false" default="" />
		<cfargument name="ContentID" type="string" required="false" default="" />
		<cfargument name="FileSizeLimit" type="numeric" required="false" default="1000" />
		<cfargument name="AllowedExtensions" type="string" required="false" default="png,gif,jpg,jpeg" />
		<cfargument name="DoClearPrevious" type="boolean" required="false" default="0" />
		<cfargument name="LargeFile" type="any" required="false" default="" />
		<cfargument name="MediumFile" type="any" required="false" default="" />
		<cfargument name="SmallFile" type="any" required="false" default="" />
		<cfargument name="FileData" type="struct" required="false" default="#StructNew()#" />
		<cfargument name="FilePath" type="string" required="false" default="" />
		<cfargument name="MuraFileID" type="string" required="false" default="" />

		<cfset setSiteID( arguments.SiteID ) />
		<cfset setModuleID( arguments.ModuleID ) />
		<cfset setContentID( arguments.ContentID ) />
		<cfset setFileSizeLimit( arguments.FileSizeLimit ) />
		<cfset setAllowedExtensions( arguments.AllowedExtensions ) />
		<cfset setDoClearPrevious( arguments.DoClearPrevious ) />
		<cfset setLargeFile( arguments.LargeFile ) />
		<cfset setMediumFile( arguments.MediumFile ) />
		<cfset setSmallFile( arguments.SmallFile ) />
		<cfset setFileData( arguments.FileData ) />
		<cfset setFilePath( arguments.FilePath ) />
		<cfset setMuraFileID( arguments.MuraFileID ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="FileUploadBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
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
	
	<cffunction name="setFileSizeLimit" access="public" returntype="void" output="false">
		<cfargument name="FileSizeLimit" type="numeric" required="true" />
		<cfset variables.instance['filesizelimit'] = arguments.FileSizeLimit />
	</cffunction>
	<cffunction name="getFileSizeLimit" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.FileSizeLimit />
	</cffunction>
	
	<cffunction name="setAllowedExtensions" access="public" returntype="void" output="false">
		<cfargument name="AllowedExtensions" type="string" required="true" />
		<cfset variables.instance['allowedextensions'] = arguments.AllowedExtensions />
	</cffunction>
	<cffunction name="getAllowedExtensions" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AllowedExtensions />
	</cffunction>
	
	<cffunction name="setDoClearPrevious" access="public" returntype="void" output="false">
		<cfargument name="DoClearPrevious" type="boolean" required="true" />
		<cfset variables.instance['doclearprevious'] = arguments.DoClearPrevious />
	</cffunction>
	<cffunction name="getDoClearPrevious" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoClearPrevious />
	</cffunction>
	
	<cffunction name="setLargeFile" access="public" returntype="void" output="false">
		<cfargument name="LargeFile" type="any" required="true" />
		<cfset variables.instance['largefile'] = arguments.LargeFile />
	</cffunction>
	<cffunction name="getLargeFile" access="public" returntype="any" output="false">
		<cfreturn variables.instance.LargeFile />
	</cffunction>
	
	<cffunction name="setMediumFile" access="public" returntype="void" output="false">
		<cfargument name="MediumFile" type="any" required="true" />
		<cfset variables.instance['mediumfile'] = arguments.MediumFile />
	</cffunction>
	<cffunction name="getMediumFile" access="public" returntype="any" output="false">
		<cfreturn variables.instance.MediumFile />
	</cffunction>
	
	<cffunction name="setSmallFile" access="public" returntype="void" output="false">
		<cfargument name="SmallFile" type="any" required="true" />
		<cfset variables.instance['smallfile'] = arguments.SmallFile />
	</cffunction>
	<cffunction name="getSmallFile" access="public" returntype="any" output="false">
		<cfreturn variables.instance.SmallFile />
	</cffunction>
	
	<cffunction name="setFileData" access="public" returntype="void" output="false">
		<cfargument name="FileData" type="struct" required="true" />
		<cfset variables.instance['filedata'] = arguments.FileData />
	</cffunction>
	<cffunction name="getFileData" access="public" returntype="struct" output="false">
		<cfreturn variables.instance.FileData />
	</cffunction>
	
	<cffunction name="setFilePath" access="public" returntype="void" output="false">
		<cfargument name="FilePath" type="string" required="true" />
		<cfset variables.instance['filepath'] = arguments.FilePath />
	</cffunction>
	<cffunction name="getFilePath" access="public" returntype="string" output="false">
		<cfreturn variables.instance.FilePath />
	</cffunction>
	
	<cffunction name="setMuraFileID" access="public" returntype="void" output="false">
		<cfargument name="MuraFileID" type="string" required="true" />
		<cfset variables.instance['MuraFileID'] = arguments.MuraFileID />
	</cffunction>
	<cffunction name="getMuraFileID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.MuraFileID />
	</cffunction>

	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>
</cfcomponent>