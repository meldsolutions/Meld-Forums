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
	<cfset local.aPost		= rc.threadBean.getPosts() />
	<cfset local.threadBean	= rc.threadBean />
	<cfset local.context	= "thread" />
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_global.cfm">
</cfsilent>
<cfoutput>

<cfmodule template="module/md_page_header.cfm" local="#local#">
<cfif len(local.eventContent['searchform'])>
	#local.eventContent['searchform']#
<cfelse>
	<cfmodule template="module/md_searchform.cfm" local="#local#">
</cfif>

<cfmodule template="module/md_thread_pagenav.cfm" local="#local#" subscribed="false">

<table class="mf-thread-block" id="thr#lcase(rereplace(rc.ThreadBean.getTitle(),"[^[:alnum:]]","","all"))#">
	<!--- thread header --->
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_thread.cfm">
	<cfif len(local.eventContent['threadheader'])>
		#local.eventContent['threadheader']#
	<cfelse>
		<cfmodule template="module/md_thread.cfm" local="#local#" threadbean="#rc.ThreadBean#">
	</cfif>
	
	<!--- administrator message --->
	<cfif len(local.eventContent['threadadminmessage'])>
		#local.eventContent['threadadminmessage']#
	<cfelseif len( rc.ThreadBean.getAdminMessage() )>
		<tr class="threadposts">
			<td colspan="2" class="adminmessage">
				<cfset local.UserBean = rc.MFBEan.getUser( rc.threadBean.getAdminID() )>
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_thread_adminmessage.cfm">
				<cfif len(local.eventContent['threadadminmessage'])>
					#local.eventContent['threadadminmessage']#
				<cfelse>
					<cfmodule template="module/md_thread_adminmessage.cfm" local="#local#" threadbean="#rc.ThreadBean#">
				</cfif>
			</td>
		</tr>
	</cfif>
	<!--- posts --->
	<cfif not rc.ThreadBean.getisDisabled()>
		<cfloop from="1" to="#ArrayLen(local.aPost)#" index="local.iiY">
			<tr class="threadposts<cfif local.iiY mod 2> even</cfif>">
				<td colspan="2" class="threadpost">
					<cfset local.postBean = local.aPost[local.iiY] />
					<cfset local.postUserBean = rc.MFBean.getUser( local.postBean.getUserID() )>
					<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_thread_post.cfm">
					<cfif len(local.eventContent['threadpost'])>
						#local.eventContent['threadpost']#
					<cfelse>
						<cfmodule template="module/md_thread_post.cfm" local="#local#" count="#ArrayLen(local.aPost)#" row="#local.iiY#" type="thread">
					</cfif>
				</td>
			</tr>
		</cfloop>
	</cfif>
	<!--- page navigation --->
</table>
<cfmodule template="module/md_thread_pagenav.cfm" local="#local#" subscribed="false">
<cfmodule template="module/md_page_footer.cfm" local="#local#">

</cfoutput>