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
<cfcomponent extends="mura.plugin.pluginGenericEventHandler">
	<cfset variables.framework=getFrameworkVariables()>

	<cffunction name="onApplicationLoad">
		<cfargument name="$">

		<cfset var appreloadKey = $.GlobalConfig().getValue('appreloadKey') />
		<cfset var qEventHandlers = "" />
		<cfset var customEventHandler = "" />

		<cfif len( appreloadKey ) and structKeyExists(url,appreloadKey)> 
			<cfset url[variables.framework.reload] = true />
		</cfif>

		<!--- invoke onApplicationStart in the application.cfc so the framework can do its thing --->
		<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onApplicationStart" />

		<cfset variables.pluginConfig.addEventHandler(this)>
		
		<cfset qEventHandlers = directoryList( expandPath("/#variables.pluginConfig.getDirectory()#/events/custom"),false,"query","*.cfc"  )>
		
		<cfif qEventHandlers.recordCount>
			<cfloop query="qEventHandlers">
				<cfset customEventHandler = createObject("component","#variables.pluginConfig.getDirectory()#.events.custom.#replaceNoCase(qEventHandlers.name,".cfc","")#") />	
				
				<cfset variables.pluginConfig.addEventHandler(customEventHandler)>
			</cfloop>			
		</cfif>			
	</cffunction>


	<cffunction name="onAdminModuleNav">
		<cfargument name="$">

		<cfif structKeyExists(session,"MeldForumsAppreinit")>
			<cfset structDelete(session,"MeldForumsAppreinit") />
			<cfif not StructKeyExists(url,"appreload")>
				<cflocation url="./?appreload&reload=appreload" addtoken="false">
			</cfif>
		</cfif>
	</cffunction>

	<cffunction name="onRenderStart">
		<cfargument name="$">

		<cfset var app 						= variables.pluginConfig.getApplication() />
		<cfset var beanFactory				= app.getValue('beanFactory') />
		<cfset var meldForumsEventManager	= beanFactory.getBean('MeldForumsEventManager') />
		<cfset var meldForumsManager		= beanFactory.getBean('MeldForumsManager') />
		<cfset var mmUtility 				= beanFactory.getBean('mmUtility') />
		<cfset var pluginEvent 				= meldForumsEventManager.createEvent($) />
		<cfset var aCrumbData				= ArrayNew( 1 ) />

		<cfif not $.getGlobalEvent().valueExists('MeldForumsCrumbData')>
			<cfreturn />
		</cfif>

		<cfset aCrumbData = $.getGlobalEvent().getValue('MeldForumsCrumbData')  />

		<cfif not arraylen(aCrumbData)>
			<cfreturn />
		</cfif>

		<cfset pluginEvent.setValue("aCrumbData",aCrumbData) />
		<cfset meldForumsEventManager.announceEvent($,"onMeldForumsAddBreadCrumbs",pluginEvent)>
		<cfset meldForumsManager.setCrumbData( $,aCrumbData ) />
	</cffunction>

	<cffunction name="onSiteRequestStart">
		<cfargument name="$">
	</cffunction>

	<cffunction name="onSiteLoginSuccess" output="false" returntype="any">
		<cfargument name="$">

		<cfset var app 						= variables.pluginConfig.getApplication() />
		<cfset var beanFactory				= app.getValue('beanFactory') />
		<cfset var userService				= beanFactory.getBean('userService')>	
		<cfset var userID 					= $.currentUser().getUserID()>

		<cfset userService.setLoggedIn( userID,$.event().getValue('siteID') )>
	</cffunction>

	<cffunction name="onGlobalLoginSuccess" output="false" returntype="any">
		<cfargument name="$">

		<cfset var app 						= variables.pluginConfig.getApplication() />
		<cfset var beanFactory				= app.getValue('beanFactory') />
		<cfset var userService				= beanFactory.getBean('userService')>	
		<cfset var userID 					= $.currentUser().getUserID()>

		<cfset userService.setLoggedIn( userID,$.event().getValue('siteID') )>
	</cffunction>

	<cffunction name="onSiteRequestInit">
		<cfargument name="$">
		
		<cfset var app 					= "" />
		<cfset var beanFactory			= "" />
		<cfset var cFileName			= $.event().getValue('currentfilename') />
		<cfset var filenameMarker		= "" />
		<cfset var pathMarker			= "" />

		<cfset var meldForumsManager	= "" />

		<cfset var aIntercept			= ArrayNew(1) />
		<cfset var sIntercept			= "" />

		<cfset filenameMarker		= refindNoCase("mf[$|/]",$.event().getValue('currentfilename')) />
		<cfset pathMarker			= refindNoCase("mf[$|/]",$.event().getValue('path')) />

		<!--- deal with vanishing application scope --->
		<cfif not variables.pluginConfig.getApplication().valueExists("beanFactory")
			or isSimpleValue( variables.pluginConfig.getApplication().getValue("beanFactory") )>
			<cfinvoke component="#pluginConfig.getPackage()#.Application" method="onApplicationStart" />
		</cfif>

		<cfset app 			= variables.pluginConfig.getApplication() />
		<cfset beanFactory	= app.getValue('beanFactory') />

		<!---<cfoutput>#filenameMarker# #$.event().getValue('currentfilename')# HERE!</cfoutput><cfabort>--->

		<cfif not filenameMarker or isSimpleValue(beanFactory)>
			<cfreturn />
		</cfif>
		
		<cfset meldForumsManager		= beanFactory.getBean('MeldForumsManager') />
		
		<cfif filenameMarker gt 1>
			<cfset $.event().setValue('currentfilename',left( cFileName,filenameMarker-2 )) />
			<cfset $.event().setValue('path', left( $.event().getValue('path'),pathMarker-2 ) & "/" ) />
		<cfelse>
			<cfset $.event().setValue('currentfilename',"" ) />
			<cfset $.event().setValue('path', left( $.event().getValue('path'),pathMarker-2 ) & "/" ) />
		</cfif>

		<cfif len( $.event().getValue('currentfilenameadjusted') )>
			<cfset $.event().setValue('currentfilenameadjusted',left( cFileName,filenameMarker-2 )) />
		</cfif>

		<cfset sIntercept = mid( cFileName,filenameMarker+3,len(cFileName) ) />
	
		<cfif len( sIntercept )>
			<cfset aIntercept = ListToArray( sIntercept,"/" ) />
		</cfif>

		<cfif ArrayLen( aIntercept )>
			<cfset meldForumsManager.processIntercept( $,aIntercept ) />
		</cfif>
	</cffunction>

	<cffunction name="getFrameworkVariables" output="false" access="private">
		<cfset var framework = StructNew() />

		<cfinclude template="../frameworkConfig.cfm" />

		<cfreturn framework />		
	</cffunction>
</cfcomponent>