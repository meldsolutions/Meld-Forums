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
	<cfset local.aConferences		= rc.aConferences />
	<cfset local.conferenceBean		= "" />
	<cfset local.aForums			= "" />
	<cfset local.forumBean			= "" />
	<cfset local.context			= "conference" />
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_global.cfm">
</cfsilent>
<cfoutput>
<div class="span12">
	<cfif len(local.eventContent['searchform'])>
		#local.eventContent['searchform']#
	<cfelse>
		<cfmodule template="module/md_searchform.cfm" local="#local#">
	</cfif>
</div>
<div class="col-lg-12" style="border: 1px solid green">
<cfmodule template="module/md_page_header.cfm" local="#local#">

<cfloop from="1" to="#ArrayLen(local.aConferences)#" index="local.iiX">
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_conference.cfm">
	<!--- current conference & forums to local --->
	<cfset local.conferenceBean	= local.aConferences[local.iiX] />
	<cfset local.aForums	= local.conferenceBean.getForums() />
	<cfif ArrayLen( local.aForums ) and rc.MeldForumsBean.getHasPermissions( local.conferenceBean.getActiveConfigurationID() )>
	<table class="mf-conference-block" id="mf-conference-#lcase(rereplace(local.conferenceBean.getTitle(),"[^[:alnum:]]","","all"))#">
		<cfif len(local.eventContent['conference'])>
			#local.eventContent['conference']#
		<cfelse>
			<cfmodule template="module/md_conference.cfm" local="#local#" count="#ArrayLen(local.aConferences)#" row="#local.iiX#">
		</cfif>
		<cfloop from="1" to="#ArrayLen(local.aForums)#" index="local.iiY">
			<!--- current forum to local --->
			<cfset local.forumBean	= local.aForums[local.iiY] />

			<cfif rc.MeldForumsBean.getHasPermissions( local.forumBean.getActiveConfigurationID() )>
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_conference_forum.cfm">
				<cfif len(local.eventContent['conferenceforum'])>
					#local.eventContent['conferenceforum']#
				<cfelse>
					<cfmodule template="module/md_conference_forum.cfm" local="#local#" count="#ArrayLen(local.aForums)#" row="#local.iiY#">
				</cfif>
			</cfif>
		</cfloop>
	</table>
	</cfif>
</cfloop>
</div>

<cfmodule template="module/md_page_footer.cfm" local="#local#">

</cfoutput>