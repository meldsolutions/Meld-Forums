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
<cfcomponent displayname="ImageRenderBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean" >
	<cfproperty name="Width" type="numeric" default="800" required="true" />
	<cfproperty name="Height" type="numeric" default="600" required="true" />
	<cfproperty name="ResizeType" type="string" default="Resize" required="true" maxlength="45" hint="Crop,Resize,CropResize" />
	<cfproperty name="QualityType" type="string" default="highestQuality" required="true" maxlength="45" />
	<cfproperty name="AspectType" type="string" default="AspectXY" required="true" maxlength="45" hint="AspectXY,AspectX,AspectY,MaxAspectXY,Resize" />
	<cfproperty name="CropType" type="string" default="BestXY" required="true" maxlength="45" hint="CenterXY,CenterX,CenteryY,BestXY,Crop" />
	<cfproperty name="Binary" type="any" default="" />

	<cfset variables.instance = StructNew() />

	<cffunction name="init" access="public" returntype="ImageRenderBean" output="false">
		<cfargument name="Width" type="numeric" required="false" default="800" />
		<cfargument name="Height" type="numeric" required="false" default="600" />
		<cfargument name="ResizeType" type="string" required="false" default="Resize" />
		<cfargument name="QualityType" type="string" required="false" default="highestQuality" />
		<cfargument name="AspectType" type="string" required="false" default="AspectXY" />
		<cfargument name="CropType" type="string" required="false" default="BestXY" />
		<cfargument name="Binary" type="any" required="false" default="" />

		<cfset setWidth( arguments.Width ) />
		<cfset setHeight( arguments.Height ) />
		<cfset setResizeType( arguments.ResizeType ) />
		<cfset setQualityType( arguments.QualityType ) />
		<cfset setAspectType( arguments.AspectType ) />
		<cfset setCropType( arguments.CropType ) />
		<cfset setBinary( arguments.Binary ) />

		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="ImageUploadBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="setWidth" access="public" returntype="void" output="false">
		<cfargument name="Width" type="numeric" required="true" />
		<cfset variables.instance['width'] = arguments.Width />
	</cffunction>
	<cffunction name="getWidth" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Width />
	</cffunction>
	
	<cffunction name="setHeight" access="public" returntype="void" output="false">
		<cfargument name="Height" type="numeric" required="true" />
		<cfset variables.instance['height'] = arguments.Height />
	</cffunction>
	<cffunction name="getHeight" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Height />
	</cffunction>
	
	<cffunction name="setResizeType" access="public" returntype="void" output="false">
		<cfargument name="ResizeType" type="string" required="true" />
		<cfset variables.instance['resizetype'] = arguments.ResizeType />
	</cffunction>
	<cffunction name="getResizeType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ResizeType />
	</cffunction>
	
	<cffunction name="setQualityType" access="public" returntype="void" output="false">
		<cfargument name="QualityType" type="string" required="true" />
		<cfset variables.instance['qualitytype'] = arguments.QualityType />
	</cffunction>
	<cffunction name="getQualityType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.QualityType />
	</cffunction>
	
	<cffunction name="setAspectType" access="public" returntype="void" output="false">
		<cfargument name="AspectType" type="string" required="true" />
		<cfset variables.instance['aspecttype'] = arguments.AspectType />
	</cffunction>
	<cffunction name="getAspectType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AspectType />
	</cffunction>
	
	<cffunction name="setCropType" access="public" returntype="void" output="false">
		<cfargument name="CropType" type="string" required="true" />
		<cfset variables.instance['croptype'] = arguments.CropType />
	</cffunction>
	<cffunction name="getCropType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CropType />
	</cffunction>
	
	<cffunction name="setBinary" access="public" returntype="void" output="false">
		<cfargument name="Binary" type="any" required="true" />
		<cfset variables.instance['Binary'] = arguments.Binary />
	</cffunction>
	<cffunction name="getBinary" access="public" returntype="any" output="false">
		<cfreturn variables.instance.Binary />
	</cffunction>

	<!--- DUMP --->
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>
</cfcomponent>