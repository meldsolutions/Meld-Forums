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
	<cfparam name="rc.quote" default="" />
	<cfset rc.mode = "#request.item##request.section#" />
</cfsilent>

<cfoutput>
	<div id="editorblock">
		<div id="title">
			<h3>#rc.mmRBF.key('Editor')#</h3>
		</div>
		<cfswitch expression="#rc.mode#">
			<cfcase value="editthread">
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_editor_thread.cfm">
				<cfif len(local.eventContent['editor'])>
					#local.eventContent['editor']#
				<cfelse>
					<cfmodule template="module/md_editor_edit_thread.cfm" local="#local#" form="#form#">
				</cfif>
			</cfcase>
			<cfcase value="newpost,editpost">
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_editor_post.cfm">
				<cfif len(local.eventContent['editor'])>
					#local.eventContent['editor']#
				<cfelse>
					<cfmodule template="module/md_editor_post.cfm" local="#local#" form="#form#">
				</cfif>
			</cfcase>
			<cfcase value="newthread">
				<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_md_editor_thread.cfm">
				<cfif len(local.eventContent['editor'])>
					#local.eventContent['editor']#
				<cfelse>
					<cfmodule template="module/md_editor_thread.cfm" local="#local#" form="#form#">
				</cfif>
			</cfcase>
			<cfdefaultcase>
				???
			</cfdefaultcase>
		</cfswitch>
	</div>
	<script language="javascript">
	$(document).ready(function()	{
		mySettings.previewParserPath = "#rc.MFBean.getPluginWebRoot()#/?action=forum:preview";

	    $('##txtMessage').markItUp(mySettings);
	});
	</script>
</cfoutput>