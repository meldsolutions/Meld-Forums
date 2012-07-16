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

		<cfset var displayService			= getBeanFactory().getBean("displayService") />
		<cfset var displaytypeService		= getBeanFactory().getBean("DisplaytypeService") />
		<cfset var adisplayType			= ArrayNew(1) />
		<cfset var sArgs					= StructNew() />
		<cfset var mmBreadCrumbs			= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle			= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var displayTypeBean			= "" />
		
		<cfparam name="arguments.rc.displayTypeID" default="" />
		
		<cfset sArgs.siteID	= arguments.rc.siteID>

		<cfif not len(arguments.rc.displayTypeID)>
			<cfset adisplayType			= displaytypeService.getdisplayTypes(argumentCollection=sArgs) />
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('displays'),"?action=displays" )>
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('displays'),"?action=displays" )>
		<cfelse>
			<cfset sArgs.displayTypeID	= arguments.rc.displayTypeID>
			<cfset displayTypeBean		= displaytypeService.getdisplayType(argumentCollection=sArgs) />
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('displays'),"?action=displays" )>
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,displayTypeBean.getName(),"?action=displays&displayTypeid=" & displayTypeBean.getdisplayTypeID() )>
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('displays') )>
		</cfif>
		
		<cfset arguments.rc.adisplayType	= adisplayType />
		<cfset arguments.rc.displayTypeBean	= displayTypeBean />
	</cffunction>

	<cffunction name="new" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">

		<cfset var displaytypeService		= getBeanFactory().getBean("DisplaytypeService") />
		<cfset var aDisplayTypes			= ArrayNew(1) />
		<cfset var sArgs					= StructNew() />
		<cfset var mmBreadCrumbs			= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle			= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var displayTypeBean			= "" />
		
		<cfset sArgs.siteID	= arguments.rc.siteID>

		<cfset adisplayType			= displaytypeService.getdisplayTypes(argumentCollection=sArgs) />
		<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('displays'),"?action=displays" )>
		<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('newdisplay') )>
		
		<cfset arguments.rc.aDisplayTypes	= aDisplayTypes />
	</cffunction>

	<cffunction name="edit" access="public" returntype="void" output="false">
		<cfargument name="rc" type="struct" required="false" default="#StructNew()#">
	
		<cfset var displayTypeService	= getBeanFactory().getBean("displayTypeService") />
		<cfset var displayService			= getBeanFactory().getBean("displayService") />
		<cfset var configurationService	= getBeanFactory().getBean("configurationService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var mmBreadCrumbs		= getBeanFactory().getBean("mmBreadCrumbs") />
		<cfset var mmResourceBundle		= getBeanFactory().getBean("mmResourceBundle") />
		<cfset var displayBean			= "" />
		<cfset var newdisplayBean			= "" />
		<cfset var aConfiguration		= ArrayNew(1)>
		<cfset var displayTypeBean		= "" />

		<cfset var sPresets			= StructNew() />
		<cfset var sArgs			= StructNew() />

		<!--- check if a button was clicked --->
		<cfif isDefined("arguments.rc.btaction")>
			<!--- cancel? --->
			<cfif arguments.rc.btaction eq 'cancel'>
				<cflocation url="?action=displays&displayTypeID=#arguments.rc.displayTypeID#" addtoken="false">
			<!--- save? --->
			<cfelseif arguments.rc.btaction eq 'save'>
				<cfset success = actionSavedisplay( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=displays&displayTypeID=#arguments.rc.displayTypeID#" addtoken="false">
				</cfif> 
			<!--- update? --->
			<cfelseif arguments.rc.btaction eq 'update'>
				<cfset success = actionUpdatedisplay( arguments.rc )>
				<cfif success eq true>
					<cflocation url="?action=displays&displayTypeID=#arguments.rc.displayTypeID#" addtoken="false">
				</cfif>
			</cfif>
		<cfelseif isDefined("arguments.rc.btdeleteconfirm") and arguments.rc.btdeleteconfirm eq "delete">
			<cfset success = actionDeletedisplay( arguments.rc )>
			<cfif success eq true>
				<cflocation url="?action=displays&displayTypeID=#arguments.rc.displayTypeID#" addtoken="false">
			</cfif> 
		</cfif>

		<cfif isDefined( "arguments.rc.displayID" )>
			<cfset var displayBean = displayService.getdisplay( displayID = arguments.rc.displayID ) />
			<cfset arguments.rc.displayTypeID = displayBean.getConferenceID()>
		<cfelse>
			<cfset sPresets.isActive		= 1 />
			<cfset sPresets.displayTypeID	= arguments.rc.displayTypeID />
			<cfset displayBean 				= displayService.createdisplay() />
		</cfif>

		<cfif displayBean.beanExists()>
			<cfset sArgs = StructNew() />
			<cfset sArgs.displayTypeID = arguments.rc.displayTypeID>
			<cfset displayTypeBean		= displayTypeService.getConference(argumentCollection=sArgs) />
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('displayType'),"?action=displayType" )>
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,displayTypeBean.getName(),"?action=displays&displayTypeid=" & arguments.rc.displayTypeID )>
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,displayBean.getName() )>
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('edit') )>
		<cfelse>
			<cfset sArgs = StructNew() />
			<cfset sArgs.displayTypeID = arguments.rc.displayTypeID>
			<cfset displayTypeBean		= displayTypeService.getConference(argumentCollection=sArgs) />
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('displayType'),"?action=displayType" )>
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,displayTypeBean.getName(),"?action=displays&displayTypeid=" & arguments.rc.displayTypeID )>
			<cfset mmBreadCrumbs.addCrumb( arguments.rc.breadcrumbs,mmResourceBundle.key('adddisplay') )>
		</cfif>
		
		<!--- set up for form --->
		<cfset mmFormTools.paramaterizeBeanForm(displayBean,sPresets) />

		<cfset var aConfiguration		= configurationService.getConfigurations( siteID=arguments.rc.siteID )>
		
		<!--- return vars --->
		<cfset arguments.rc.displayBean		= displayBean />
		<cfset arguments.rc.aConfiguration		= aConfiguration />
	</cffunction>

	<cffunction name="actionUpdateDisplay" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var displayService		= getBeanFactory().getBean("DisplayService") />
		<cfset var mmFormTools		= getBeanFactory().getBean("mmFormTools") />
		<cfset var displayBean		= "" />
		<cfset var sArgs			= StructNew() />

		<!--- create a blank Display bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset var displayBean 		= displayService.createDisplay() />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(displayBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
	
		<!--- now get the existing bean --->
		<cfset displayBean = DisplayService.getDisplay( formData.displaybean.displayID ) />
		<!--- set the new values --->
		<cfset displayBean.updateMemento( formData.displayBean )>
		
		<!--- update the display --->
		<cfreturn DisplayService.updateDisplay( displayBean ) />		
	</cffunction>	

	<cffunction name="actionSaveDisplay" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">

		<cfset var displayService			= getBeanFactory().getBean("DisplayService") />
		<cfset var mmFormTools			= getBeanFactory().getBean("mmFormTools") />
		<cfset var displayBean			= "" />
		<cfset var sArgs				= StructNew() />

		<!--- create a blank Display bean for the form params (i.e. unchecked checkboxes ) --->
		<cfset var displayBean 		= displayService.createDisplay() />

		<cfset displayBean.setAdminID( $.currentUser('userID') ) />
		
		<!--- we do paramaterizeBeanBooleans to 'fill in' the form's unsubmitted checkboxes --->
		<cfset mmFormTools.paramaterizeBeanBooleans(displayBean) />
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />

		<!--- set the new values --->
		<cfset displayBean.updateMemento( formData.displayBean )>

		<!--- save the display --->
		<cfreturn DisplayService.saveDisplay( displayBean ) />		
	</cffunction>	

	<cffunction name="actionDeleteDisplay" access="private" returntype="boolean">
		<cfargument name="rc" type="struct" required="true">
		<cfset var displayService	= getBeanFactory().getBean("DisplayService") />
		<cfset var mmFormTools	= getBeanFactory().getBean("mmFormTools") />
		
		<cfset formData = mmFormTools.scopeFormSubmission(form,false,true) />
		
		<!--- save the display --->
		<cfreturn DisplayService.deleteDisplay( formData.displaybean.displayID ) />		
	</cffunction>	




</cfcomponent>