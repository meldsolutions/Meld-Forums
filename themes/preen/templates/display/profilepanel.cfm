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
	<cfset local.userBean	= rc.userBean />
	<cfset local.context	= "profile" />
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_global.cfm">
	<cfinclude template="#rc.MFBean.getThemeRootDirectory()#event/e_profilepanel.cfm">
</cfsilent>
<cfoutput>
	<cfmodule template="module/md_page_header.cfm" local="#local#">

	<cfif rc.userBean.getUserID() neq $.currentUser().getUserID()>
		<div class="notice highlight"><strong>#rc.mmRBF.key('attention')#:</strong> #rc.mmRBF.key('moderatingprofile')#</div>
	</cfif>
	<cfif len( rc.userBean.getAdminMessage() )>
	<div class="notice highlight">
		<p>#rc.userBean.getAdminMessage()#</p>
	</div>
	</cfif>
	<table id="md-profile-panel" class="clearfix md-profile-panel-#rc.panel#">
		<tr>
		<td id="md-profile-panel-menu">
			<cfmodule template="module/md_profile_panel_menu.cfm" local="#local#">	
		</td>
		<td id="md-profile-panel-panel" class="clearfix">
		<cfif rc.panel eq "custom">
			<cfmodule template="module/md_profile_custom.cfm" local="#local#">
		<cfelseif len(local.eventContent['panelContent'])>
			#local.eventContent['panelContent']#
		<cfelse>
			<cfswitch expression="#rc.panel#">
				<cfcase value="overview">
					<cfmodule template="module/md_profile_panel.cfm" local="#local#">
				</cfcase>	
				<cfcase value="avatar">
					<cfmodule template="module/md_profile_panel_avatar.cfm" local="#local#">
				</cfcase>	
				<cfcase value="moderate">
					<cfif rc.MFBean.userHasModeratePermissions(rc.userID)>
						<cfmodule template="module/md_profile_panel_moderate.cfm" local="#local#">
					<cfelse>
						<cfthrow message="!" />
					</cfif>
				</cfcase>	
				<cfcase value="privacy">
					<cfmodule template="module/md_profile_panel_privacy.cfm" local="#local#">
				</cfcase>	
				<cfcase value="settings">
					<cfmodule template="module/md_profile_panel_settings.cfm" local="#local#">
				</cfcase>	
				<cfcase value="error">
					<cfmodule template="module/md_profile_panel_error.cfm" local="#local#">
				</cfcase>	
				<cfdefaultcase>
					<cfmodule template="module/md_profile_panel.cfm" local="#local#">
				</cfdefaultcase>
			</cfswitch>
		</cfif>
		<cfif len(local.eventContent['customPanelContent'])>
			#local.eventContent['customPanelContent']#
		</cfif>
		</td>
		</tr>
	</table>

	<cfmodule template="module/md_page_footer.cfm" local="#local#">
</cfoutput>