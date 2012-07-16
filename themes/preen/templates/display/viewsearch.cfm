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
<cfsilent>
	<cfset local.rc = rc />
	<cfset local.aThread	= rc.aThread />
	<cfset local.context	= "search" />
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_global.cfm">
</cfsilent>
<cfoutput>

<cfmodule template="module/md_page_header.cfm" local="#local#">
<cfif len(local.eventContent['searchform'])>
	#local.eventContent['searchform']#
<cfelse>
	<cfmodule template="module/md_searchform.cfm" local="#local#">
</cfif>
<!--- page navigation --->
<cfmodule template="module/md_search_pagenav.cfm" local="#local#" class="first">
<table class="mf-search-block mf-search-threads mf-search-search">
<!--- page navigation --->
	<!--- search header --->

	<cfif ArrayLen(local.aThread)>
		<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_search.cfm">
		<cfif len(local.eventContent['searchheader'])>
			#local.eventContent['searchheader']#
		<cfelse>
			<cfmodule template="module/md_search.cfm" local="#local#">
		</cfif>
			
		<!--- threads --->
		
		<cfloop from="1" to="#ArrayLen(local.aThread)#" index="local.iiY">
			<cfif not local.aThread[local.iiY].getIsDisabled()>
				<cfset local.threadBean = local.aThread[local.iiY] />
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_search_thread.cfm">
				<cfmodule template="module/md_search_thread.cfm" local="#local#" count="#ArrayLen(local.aThread)#" row="#local.iiY#">
			</cfif>
		</cfloop>
	<cfelse>
		<div class="notice">
			#rc.mmRBF.key('nomatches')#
		</div>
	</cfif>
</table>
<cfmodule template="module/md_search_pagenav.cfm" local="#local#" class="first">

<cfmodule template="module/md_page_header.cfm" local="#local#">

</cfoutput>