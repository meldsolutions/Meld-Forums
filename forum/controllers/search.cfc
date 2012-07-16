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

	<cffunction name="before" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
		<cfset super.before( argumentCollection=arguments ) />

	</cffunction>

	<cffunction name="default" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfif not structKeyExists(rc,"k") or not len(rc.k)>
			<cflocation url="#rc.MFBean.getForumWebRoot()#" addtoken="false" />
		</cfif>

		<cfset doSearch( argumentCollection=arguments ) />
	</cffunction>

	<cffunction name="doSearch" access="private" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="true">

		<cfset var searchManager		= getBeanFactory().getBean("MeldForumsSearchManager") />
		<cfset var pageManager			= getBeanFactory().getBean("PageManager")>
		<cfset var pageBean				= pageManager.getPageBean( $,rc.MFBean.getValue("settingsBean").getThreadsPerPage() )>

		<cfset var criteria				= StructNew() />
		<cfset var sArgs				= StructNew() />
		<cfset var aThread				= ArrayNew(1) />

		<cfset criteria.searchText		= pageBean.getSearch() />
		<cfset criteria.searchType		= pageBean.getSearchType() />
		<cfset criteria.siteID			= rc.$.event('siteID') />

		<cfset sArgs.criteria			= criteria />
		<cfset sArgs.pageBean			= pageBean />
		<cfset sArgs.MFBean				= rc.MFBean />

		<cfset aThread = searchManager.doSearch( argumentCollection=sArgs ) />
		<cfset rc.pageBean = pageBean />
		<cfset rc.aThread = aThread />
	</cffunction>


</cfcomponent>