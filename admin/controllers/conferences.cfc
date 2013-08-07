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

		<cfset var configurationService	= getBeanFactory().getBean("configurationService") />
		<cfset configurationService.verifyBaseConfiguration( rc.siteID ) />

		<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('conferences'),"?action=conferences" )>


	</cffunction>

	<cffunction name="reorder" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('conferences'),"?action=conferences" )>
		<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('reorder') )>

		<!--- check if a button was clicked --->
		<cfif StructKeyExists(rc,"sortorder") and len(rc.sortOrder) gt 0>
			<cfset getBeanFactory().getBean("conferenceService").setSortOrder( rc.sortOrder ) />
			<cflocation url="?action=conferences" addtoken="false">
		</cfif>
		
		<cfset rc.aConferences = getBeanFactory().getBean("conferenceService").search( criteria=StructNew(),orderby="OrderNo ASC" ) /> 
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset var conferenceService	= getBeanFactory().getBean("conferenceService") />
		<cfset var configurationService	= getBeanFactory().getBean("configurationService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var conferenceBean		= "" />
		<cfset var newConferenceBean	= "" />
		<cfset var aConfiguration		= ArrayNew(1)>

		<cfset var sPresets			= StructNew() />
		<cfset var sArgs			= StructNew() />

		<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('conferences'),"?action=conferences" )>

		<!--- check if a button was clicked --->
		<cfif isDefined("rc.btaction")>
			<!--- cancel? --->
			<cfif arguments.rc.btaction eq 'cancel'>
				<cflocation url="?action=conferences" addtoken="false">
			<!--- save? --->
			<cfelseif rc.btaction eq 'save'>
				<cfset success = actionSaveConference( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=conferences" addtoken="false">
				</cfif> 
			<!--- update? --->
			<cfelseif rc.btaction eq 'update'>
				<cfset success = actionUpdateConference( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=conferences" addtoken="false">
				</cfif>
			</cfif>
		<cfelseif isDefined("rc.btdeleteconfirm") and rc.btdeleteconfirm eq "delete">
			<cfset success = actionDeleteConference( arguments.rc )>
			<cfif success eq true>
				<cflocation url="?action=conferences" addtoken="false">
			</cfif> 
		</cfif>

		<cfif isDefined( "rc.conferenceID" )>
			<cfset conferenceBean = conferenceService.getConference( conferenceID = rc.conferenceID ) />
			<cfif conferenceBean.beanExists()>
				<cfset rc.mmBC.addCrumb( rc,conferenceBean.getName() )>
			</cfif>
			<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('edit') )>
		<cfelse>
			<cfset sPresets.isActive		= 1 />
			<cfset conferenceBean = conferenceService.createConference() />
			<cfset rc.mmBC.addCrumb( rc,rc.mmRBF.key('addconference') )>
		</cfif>
		
		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(conferenceBean,sPresets) />

		<cfset aConfiguration		= configurationService.getConfigurations( siteID=rc.siteID )>
		
		<!--- return vars --->
		<cfset rc.conferenceBean		= conferenceBean />
		<cfset rc.aConfiguration		= aConfiguration />
	</cffunction>

	<cffunction name="actionUpdateConference" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var conferenceBean		= "" />
		<cfset var sArgs				= StructNew() />
		<cfset var pluginEvent 			= createEvent(rc) />
		<cfset var pluginManager		= rc.$.getBean('pluginManager') />
		<cfset var success				= false />

		<!--- create a blank Conference bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset conferenceBean	 		= conferenceService.createConference() />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(conferenceBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
	
		<!--- now get the existing bean --->
		<cfset conferenceBean = ConferenceService.getConference( formData.conferencebean.conferenceID ) />
		<cfset conferenceBean.updateMemento( formData.conferenceBean )>

		<cfset pluginEvent.setValue('data',formData ) />
		<cfset pluginEvent.setValue('siteID',rc.siteID ) />
		<cfset pluginEvent.setValue('complete',false ) />
		<cfset pluginEvent.setValue('conferenceBean',conferenceBean ) />
		<cfset pluginEvent.setValue('success',success ) />
		<cfset pluginEvent.setValue('conferenceID',formData.conferencebean.conferenceID ) />
		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsBeforeUpdateConference",pluginEvent ) />

		<cfif pluginEvent.getValue('complete') eq false>
			<!--- set the new values --->
			<cfset conferenceBean.updateMemento( formData.conferenceBean )>
			<!--- update the conference --->
			<cfset success = ConferenceService.updateConference( conferenceBean ) />		
		<cfelse>
			<cfset success = pluginEvent.getValue('success') />
		</cfif>

		<cfif success>
			<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsAfterUpdateConference",pluginEvent ) />
		</cfif>
		
		<cfreturn success />
	</cffunction>	

	<cffunction name="actionSaveConference" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var conferenceBean		= "" />
		<cfset var sArgs				= StructNew() />
		<cfset var formData				= StructNew() />
		<cfset var pluginEvent 			= createEvent(rc) />
		<cfset var pluginManager		= rc.$.getBean('pluginManager') />
		<cfset var success				= false />

		<!--- create a blank Conference bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset conferenceBean	 		= conferenceService.createConference() />

		<cfset conferenceBean.setSiteID( rc.siteID ) />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(conferenceBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset conferenceBean.updateMemento( formData.conferenceBean )>

		<cfset pluginEvent.setValue('data',formData ) />
		<cfset pluginEvent.setValue('siteID',rc.siteID ) />
		<cfset pluginEvent.setValue('complete',false ) />
		<cfset pluginEvent.setValue('conferenceBean',conferencebean ) />
		<cfset pluginEvent.setValue('success',success ) />
		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsBeforeSaveConference",pluginEvent ) />
		
		<!--- save the conference --->
		<cfif pluginEvent.getValue('complete') eq false>
			<!--- update the conference --->
			<cfset success = ConferenceService.saveConference( conferenceBean ) />		
		<cfelse>
			<cfset success = pluginEvent.getValue('success') />
		</cfif>

		<cfif success>
			<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsAfterSaveConference",pluginEvent ) />
		</cfif>
		
		<cfreturn success />

	</cffunction>	

	<cffunction name="actionDeleteConference" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">
		<cfset var conferenceService	= getBeanFactory().getBean("ConferenceService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var pluginEvent 			= createEvent(rc) />
		<cfset var pluginManager		= rc.$.getBean('pluginManager') />
		
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<cfset pluginEvent.setValue('data',formData ) />
		<cfset pluginEvent.setValue('conferenceID',formData.conferencebean.conferenceID ) />
		<cfset pluginEvent.setValue('siteID',rc.siteID ) />
		<cfset pluginEvent.setValue('complete',false ) />
		<cfset rc.mmEvents.announceEvent( rc.$,"onMeldForumsDeleteConference",pluginEvent ) />
		
		<!--- delete the conference --->
		<cfif pluginEvent.getValue('complete') eq false>
			<cfreturn ConferenceService.deleteConference( formData.conferencebean.conferenceID ) />
		</cfif>		
	</cffunction>	
</cfcomponent>