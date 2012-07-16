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
	<cfset local.aThread	= rc.forumBean.getThreads() />
	<cfset local.aAnnounce	= rc.forumBean.getAnnouncements()>
	<cfset local.forumBean	= rc.forumBean />
	<cfset local.context	= "forum" />
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_global.cfm">
</cfsilent>
<cfoutput>

<cfmodule template="module/md_page_header.cfm" local="#local#">
<cfif len(local.eventContent['searchform'])>
	#local.eventContent['searchform']#
<cfelse>
	<cfmodule template="module/md_searchform.cfm" local="#local#">
</cfif>

<cfif ArrayLen(local.aAnnounce)>
	<table class="mf-forum-block mf-forum-announce" id="mf-forum-announce-#lcase(rereplace(rc.forumBean.getTitle(),"[^[:alnum:]]","","all"))#_announcements">
		<!--- announcements --->
		<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_announcement.cfm">
		<cfif len(local.eventContent['announcementheader'])>
			#local.eventContent['announcementheader']#
		<cfelse>
			<cfmodule template="module/md_announcement.cfm" local="#local#">
		</cfif>
		<cfloop from="1" to="#ArrayLen(local.aAnnounce)#" index="local.iiY">
			<cfset local.threadBean = local.aAnnounce[local.iiY] />
			<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_forum_announcement.cfm">
			<cfif len(local.eventContent['forumannouncement'])>
				#local.eventContent['forumannouncement']#
			<cfelse>
				<cfmodule template="module/md_forum_announcement.cfm" local="#local#" showPostCounter="false" count="#ArrayLen(local.aAnnounce)#" row="#local.iiY#">
			</cfif>
		</cfloop>
	</table>
</cfif>

<!--- page navigation --->

<!---<cfmodule template="module/forum_buttonbar.cfm" local="#local#" class="first">--->
<cfmodule template="module/md_forum_pagenav.cfm" local="#local#" class="first">

<table class="mf-forum-block mf-forum-threads" id="mf-forum-threads-#lcase(rereplace(rc.forumBean.getTitle(),"[^[:alnum:]]","","all"))#">
<!--- page navigation --->
	<!--- forum header --->
		<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_forum.cfm">
		<cfif len(local.eventContent['forumheader'])>
			#local.eventContent['forumheader']#
		<cfelse>
			<cfmodule template="module/md_forum.cfm" local="#local#">
		</cfif>
	<!--- threads --->
	<cfloop from="1" to="#ArrayLen(local.aThread)#" index="local.iiY">
		<cfif not local.aThread[local.iiY].getIsDisabled() or rc.MeldForumsBean.userHasModeratePermissions()>
			<cfset local.threadBean = local.aThread[local.iiY] />
			<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_forum_thread.cfm">
			<cfmodule template="module/md_forum_thread.cfm" local="#local#" count="#ArrayLen(local.aThread)#" row="#local.iiY#">
		</cfif>
	</cfloop>
</table>
<!--- page navigation --->
<cfmodule template="module/md_forum_pagenav.cfm" local="#local#" class="first">

<cfmodule template="module/md_page_footer.cfm" local="#local#">
</cfoutput>