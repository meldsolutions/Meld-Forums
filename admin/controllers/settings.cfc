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

		<cfset var settingsManager		= getBeanFactory().getBean("MeldForumsSettingsManager") />
		<cfset var settingsService		= getBeanFactory().getBean("settingsService") />
		<cfset var mmBreadCrumbs		= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle		= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var settingsBean			= "" />
		<cfset var sArgs				= StructNew() />

		<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('settings'),"" )>

		<!--- Settings are by siteID --->
		<cfset sArgs = StructNew() />
		<cfset sArgs.siteID = rc.siteID>
		<cfset settingsBean		= settingsService.getSettings( argumentCollection=sArgs ) />

		<!--- Settings are by siteID; if settingsBean does not exist, call the function to create the site settingsBean --->
		<cfif not settingsBean.beanExists()>
			<cfset settingsService.createSettingsForSite( argumentCollection=sArgs )>
			<cfset settingsBean	= settingsService.getSettings( argumentCollection=sArgs ) />
		</cfif>

		<cfset rc.settingsBean	= settingsBean />
		<cfset rc.themename			= settingsManager.getSiteSettings( rc.siteID ).getThemeBean().getName() />
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset var settingsService		= getBeanFactory().getBean("settingsService") />
		<cfset var themeService			= getBeanFactory().getBean("themeService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var mmBreadCrumbs		= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle		= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var settingsBean			= "" />
		<cfset var newSettingsBean		= "" />
		
		<cfset var qGroupsPublic		= rc.$.getBean("userManager").getPublicGroups( session.siteID ) />
		<cfset var qGroupsPrivate		= rc.$.getBean("userManager").getPrivateGroups( session.siteID ) />

		<cfset var sPresets			= StructNew() />
		<cfset var sArgs			= StructNew() />

		<cfset mmBreadCrumbs.addCrumb( rc,mmResourceBundle.key('settings'),"?action=settings" )>

		<!--- check if a button was clicked --->
		<cfif isDefined("rc.btaction")>
			<!--- cancel? --->
			<cfif rc.btaction eq 'cancel'>
				<cflocation url="?action=settings" addtoken="false">
			<!--- update? --->
			<cfelseif rc.btaction eq 'update'>
				<cfset success = actionUpdateSettings( rc )>
				<cfif success eq true>
					<cflocation url="?action=settings" addtoken="false">
				</cfif>
			</cfif>
		</cfif>

		<!--- Settings are by siteID --->
		<cfset sArgs = StructNew() />
		<cfset sArgs.siteID = rc.siteID>
		<cfset settingsBean		= settingsService.getSettings( argumentCollection=sArgs ) />

		<!--- Settings are by siteID; if settingsBean does not exist, call the function to create the site settingsBean --->
		<cfif not settingsBean.beanExists()>
			<cfset settingsService.createSettingsForSite( argumentCollection=sArgs )>
			<cfset settingsBean	= settingsService.getSettings( argumentCollection=sArgs ) />
		</cfif>

		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(settingsBean,sPresets) />
		
		<!--- return vars --->
		<cfset rc.settingsBean	= settingsBean />
		<cfset rc.aThemes		= themeService.getThemes( isActive=1 ) />

		<cfset rc.qGroupsPublic		= qGroupsPublic />
		<cfset rc.qGroupsPrivate	= qGroupsPrivate />
	</cffunction>

	<cffunction name="actionUpdateSettings" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var settingsService	= getBeanFactory().getBean("SettingsService") />
		<cfset var mmFormTools		= getBeanFactory().getBean("mmFormTools") />
		<cfset var settingsBean		= "" />
		<cfset var sArgs			= StructNew() />


		<!--- create a blank Settings bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset settingsBean 		= settingsService.createSettings() />

		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(settingsBean) />

		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
						
		<!--- now get the existing bean --->
		<cfset settingsBean = SettingsService.getBeanByAttributes( formData.settingsbean.settingsID ) />

		<!--- set the new values --->
		<cfset settingsBean.updateMemento( formData.settingsBean )>

		<cfif structKeyExists(formData.SETTINGSBEAN,"RESETTEMPDIRECTORY") and formData.SETTINGSBEAN['RESETTEMPDIRECTORY'] eq 1>
			<cfset settingsBean.setTempDir( createUUID() ) />
		</cfif>

		<cfif structKeyExists(formData.SETTINGSBEAN,"resetavatar") and formData.SETTINGSBEAN['resetavatar'] eq 1>
			<cfset settingsBean.setResetAvatar( 1 )>
		</cfif>
		
		<!--- update the settings --->
		<cfreturn SettingsService.updateSettings( settingsBean ) />		
	</cffunction>	
</cfcomponent>