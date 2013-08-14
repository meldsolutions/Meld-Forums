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
<cfcomponent displayname="mmBreadCrumbs" hint="Manage admin breadcrumbs" output="false">
	<cfset variables.instance = StructNew()>

	<!---  --->

	<cffunction name="init" access="public" output="false" returntype="mmBreadCrumbs">
		<cfreturn this/>
	</cffunction>

	<cffunction name="addCrumb" access="public" output="false" returntype="void">
		<cfargument name="rc" type="struct" required="true" />
		<cfargument name="label" type="string" required="true" />
		<cfargument name="url" type="string" required="false" default="" />

		<cfset ArrayAppend( rc.breadcrumbs,createCrumb( arguments.label,arguments.url ) )/>
	</cffunction>
	
	<cffunction name="createCrumb" access="public" output="false" returntype="any">
		<cfargument name="label" type="string" required="true" />
		<cfargument name="url" type="string" required="false" default="" />
				
		<cfset var bcBean = createObject("component","bcBean").init( argumentCollection=arguments )/>
		
		<cfreturn bcBean>
	</cffunction>

	<cffunction name="printCrumb" access="public" output="false" returntype="any">
		<cfargument name="crumbArray" type="Array" required="true" />
		<cfset var str = "" />
		<cfset var iiX = "" />
        <cfsavecontent variable="str"><cfoutput>
			<ul class="navZoom alt">
			<cfloop from="1" to="#ArrayLen(crumbArray)#" index="iiX">
			<cfif len( crumbArray[iiX].getURL() )>
				<li class="page">
				<a href="#crumbArray[iiX].getURL()#">#crumbArray[iiX].getLabel()#</a> <cfif iiX neq ArrayLen(crumbArray)><span class="delim">&raquo;</span></cfif>
				</li>
			<cfelseif iiX neq ArrayLen(crumbArray)>
				#crumbArray[iiX].getLabel()# <span class="delim">&raquo;</span>
			<cfelse>
				<li class="page">
				<span class="current">#crumbArray[iiX].getLabel()#</span>
				</li>
			</cfif>
			</cfloop></ul></cfoutput>
		</cfsavecontent>

		<cfreturn str>
	</cffunction>

</cfcomponent>