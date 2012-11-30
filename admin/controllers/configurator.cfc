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
<cfcomponent extends="controller">

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var params= rc.$.event("params") />
		<cfset var conferenceService	= getBeanFactory().getBean("conferenceService") />
		<cfset var aConferences			= conferenceService.getConferences( isActive=1,siteID=rc.siteID ) />
		
		<cfset rc.idlist = "" />

		<cfif structKeyExists(rc,"params") and isJSON(rc.params)>
			<cfset rc.objparams = deserializeJSON(rc.params) />
		</cfif> 
		
		<cfif structKeyExists(rc,"objparams") and isStruct(rc.objparams)and structKeyExists(rc.objparams,"conferenceIDList")>
			<cfif isArray(rc.objparams.conferenceIDList)>
				<cfset rc.idlist = arrayToList(rc.objparams.conferenceIDList) />
			<cfelseif isSimpleValue(rc.objparams.conferenceIDList) and len(rc.objparams.conferenceIDList) eq 35>
				<cfset rc.idlist = rc.objparams.conferenceIDList />
			</cfif>
		</cfif>

		<cfset rc.aConferences = aConferences />
	</cffunction>	
</cfcomponent>