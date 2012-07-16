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
<cfcomponent displayname="MeldForumsRemote" output="false" hint="Provides remote core functionality calls.">
	<cfset variables.instance = StructNew() />
	
	<cffunction name="init" returntype="MeldForumsRemote" output="false">
		<cfreturn this>
	</cffunction>
	<cffunction name="getConfigurationList" access="remote" returntype="any" returnformat="json" output="false" hint="Retrieves products.">
		<cfset var mmFormTools			= getMeldForumsManager().getBeanFactory().getBean("mmFormTools") />
		<cfset var mmResourceBundle		= getMeldForumsManager().getBeanFactory().getBean("mmResourceBundle") />
		<cfset var configurationService	= getMeldForumsManager().getBeanFactory().getBean("ConfigurationService") />
		
		<cfset var returnStruct			= StructNew() />
		<cfset var sConfiguration		= StructNew() />
		<cfset var aConfigurationData	= ArrayNew(1) />
		<cfset var sCols				= StructNew() />

		<cfset var iiX					= "" />
		<cfset var cConfiguration		= "" />
		<cfset var aConfiguration		= ArrayNew(1) />
		<cfset var sData				= mmFormTools.scopeFormSubmission( arguments,true,false )> <!--- data,skip empty,append global --->
		<cfset var sCriteria			= StructNew() />

		<cfset sData['criteria']['siteid'] = session.siteID>

		<!--- sortable columns, as per database query --->
		<cfset sCols['0'] = "">
		<cfset sCols['1'] = "name">
		<cfset sCols['2'] = "isMaster">
		<cfset sCols['3'] = "restrictreadgroups">
		<cfset sCols['4'] = "restrictcontributegroups">
		<cfset sCols['5'] = "restrictmoderategroups">
		<cfset sCols['6'] = "doAttachments">
		<cfset sCols['7'] = "isActive">

		<cfset sCriteria = setCriteria( sData,sCols,1 ) />
		<cfset sConfiguration = configurationService.search( argumentCollection=sCriteria )>

		<cfloop from="1" to="#ArrayLen(sConfiguration.itemarray)#" index="iiX">
			<cfset cConfiguration = sConfiguration.itemarray[iiX] />
			<cfset aConfiguration	= ArrayNew(1) />
			
			<cfset ArrayAppend(aConfiguration,"
			<ul class='table-buttons two'>
			<li><span title='#mmResourceBundle.key('configurationcopy')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-copy' href='?action=configurations.edit&amp;copy=true&ConfigurationID=#cConfiguration.ConfigurationID#'></a></span></li>
			<li><span title='#mmResourceBundle.key('configurationedit')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-pencil' href='?action=configurations.edit&amp;ConfigurationID=#cConfiguration.ConfigurationID#'></a></span></li>
			</ul>
			" ) />
			<cfset ArrayAppend(aConfiguration,"<a title='#mmResourceBundle.key('configurationview')#' href='?action=configurations.edit&amp;ConfigurationID=#cConfiguration.ConfigurationID#'>#cConfiguration.name#</a>" ) />
			<cfset ArrayAppend(aConfiguration, iif(cConfiguration.isMaster,de("*"),de("")) ) />
			<cfset ArrayAppend(aConfiguration, iif(len(trim(cConfiguration.restrictreadgroups)),de("*"),de("")) ) />
			<cfset ArrayAppend(aConfiguration, iif(len(trim(cConfiguration.restrictcontributegroups)),de("*"),de("")) ) />
			<cfset ArrayAppend(aConfiguration, iif(len(trim(cConfiguration.restrictmoderategroups)),de("*"),de("")) ) />
			<cfset ArrayAppend(aConfiguration, iif(cConfiguration.doAttachments,de("*"),de("")) ) />
			<cfset ArrayAppend(aConfiguration,mmResourceBundle.key("active"& cConfiguration.isActive )) />
			<cfset ArrayAppend(aConfigurationData,aConfiguration) />
		</cfloop>

		<cfset returnStruct['sEcho']					= getTickCount()>
		<cfset returnStruct['iTotalDisplayRecords']		= sConfiguration.count>
		<cfset returnStruct['iTotalRecords']			= sConfiguration.count>
		<cfset returnStruct['aaData']					= aConfigurationData>
		<cfset returnStruct['success']					= true>

		<cfcontent type="application/json">
		<cfreturn returnStruct />
	</cffunction>


	<cffunction name="getConferenceList" access="remote" returntype="any" returnformat="json" output="false" hint="Retrieves products.">
		<cfset var mmFormTools			= getMeldForumsManager().getBeanFactory().getBean("mmFormTools") />
		<cfset var mmResourceBundle		= getMeldForumsManager().getBeanFactory().getBean("mmResourceBundle") />
		<cfset var conferenceService	= getMeldForumsManager().getBeanFactory().getBean("ConferenceService") />
		
		<cfset var returnStruct		= StructNew() />
		<cfset var sConference		= StructNew() />
		<cfset var aConferenceData	= ArrayNew(1) />
		<cfset var sCols			= StructNew() />

		<cfset var iiX				= "" />
		<cfset var cConference		= "" />
		<cfset var aConference		= ArrayNew(1) />
		<cfset var sData			= mmFormTools.scopeFormSubmission( arguments,true,false )> <!--- data,skip empty,append global --->
		<cfset var sCriteria		= StructNew() />

		<!--- sortable columns, as per database query --->
		<cfset sCols['0'] = "">
		<cfset sCols['1'] = "name">
		<cfset sCols['2'] = "forumcount">
		<cfset sCols['3'] = "threadcount">
		<cfset sCols['4'] = "isActive">

		<cfset sData['criteria']['siteid'] = session.siteID>

		<cfset sCriteria = setCriteria( sData,sCols,1 ) />
		<cfset sConference = conferenceService.search( argumentCollection=sCriteria )>

		<cfloop from="1" to="#ArrayLen(sConference.itemarray)#" index="iiX">
			<cfset cConference = sConference.itemarray[iiX] />
			<cfset aConference	= ArrayNew(1) />
			<cfset ArrayAppend(aConference,"
			<ul class='table-buttons three'>
			<li><span title='#mmResourceBundle.key('conferenceedit')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-pencil' href='?action=conferences.edit&amp;ConferenceID=#cConference.ConferenceID#'></a></span></li>
			<li><span title='#mmResourceBundle.key('forumadd')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-plusthick' href='?action=forums.edit&amp;ConferenceID=#cConference.ConferenceID#'></a></span></li>
			<li><span title='#mmResourceBundle.key('forumslist')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-folder-open' href='?action=forums&amp;ConferenceID=#cConference.ConferenceID#'></a></span></li>
			</ul>
			" ) />
			<cfset ArrayAppend(aConference,"<a title='#mmResourceBundle.key('conferenceview')#' href='?action=forums&amp;ConferenceID=#cConference.ConferenceID#'>#cConference.name#</a>" ) />
			<cfset ArrayAppend(aConference,cConference.forumcount) />
			<cfset ArrayAppend(aConference,cConference.threadcount) />
			<cfset ArrayAppend(aConference,mmResourceBundle.key("active"&cConference.isActive )) />
			<cfset ArrayAppend(aConferenceData,aConference) />
		</cfloop>

		<cfset returnStruct['sEcho']					= getTickCount()>
		<cfset returnStruct['iTotalDisplayRecords']		= sConference.count>
		<cfset returnStruct['iTotalRecords']			= sConference.count>
		<cfset returnStruct['aaData']					= aConferenceData>
		<cfset returnStruct['success']					= true>

		<cfcontent type="application/json">
		<cfreturn returnStruct />
	</cffunction>

	<cffunction name="getForumList" access="remote" returntype="any" returnformat="json" output="false" hint="Retrieves products.">
		<cfset var mmFormTools			= getMeldForumsManager().getBeanFactory().getBean("mmFormTools") />
		<cfset var mmResourceBundle		= getMeldForumsManager().getBeanFactory().getBean("mmResourceBundle") />
		<cfset var forumService			= getMeldForumsManager().getBeanFactory().getBean("ForumService") />
		
		<cfset var returnStruct		= StructNew() />
		<cfset var sForum			= StructNew() />
		<cfset var aForumData		= ArrayNew(1) />
		<cfset var sCols			= StructNew() />

		<cfset var iiX				= "" />
		<cfset var cForum			= "" />
		<cfset var aForum			= ArrayNew(1) />
		<cfset var sData			= mmFormTools.scopeFormSubmission( arguments,true,false )> <!--- data,skip empty,append global --->
		<cfset var sCriteria		= StructNew() />

		<!--- sortable columns, as per database query --->
		<cfset sCols['0'] = "">
		<cfset sCols['1'] = "name">
		<cfset sCols['2'] = "conferencename">
		<cfset sCols['3'] = "threadcounter">
		<cfset sCols['4'] = "postcount">
		<cfset sCols['5'] = "viewcount">
		<cfset sCols['6'] = "isActive">

		<cfset sData['criteria']['siteid'] = session.siteID>

		<cfset sCriteria = setCriteria( sData,sCols,1 ) />
		<cfset sForum = forumService.search( argumentCollection=sCriteria )>

		<cfloop from="1" to="#ArrayLen(sForum.itemarray)#" index="iiX">
			<cfset cForum = sForum.itemarray[iiX] />
			<cfset aForum	= ArrayNew(1) />
			<cfset ArrayAppend(aForum,"
			<ul class='table-buttons two'>
			<li class='blank'></li>
			<li><span title='#mmResourceBundle.key('forumedit')#' class='sb-button ui-state-default'><a class='ui-icon ui-icon-pencil' href='?action=forums.edit&amp;ForumID=#cForum.ForumID#'></a></span></li>
			</ul>
			" ) />
			<cfset ArrayAppend(aForum,"<a title='#mmResourceBundle.key('forumview')#' href='?action=forums.edit&amp;ForumID=#cForum.ForumID#'>#cForum.name#</a>" ) />
			<!---<cfif not len(arguments.conferenceID)>--->
				<cfset ArrayAppend(aForum,"<a title='#mmResourceBundle.key('forumview')#' href='?action=forums&amp;conferenceID=#cForum.conferenceID#'>#cForum.conferencename#</a>") />
			<!---</cfif>--->
			<cfset ArrayAppend(aForum,cForum.threadcounter) />
			<cfset ArrayAppend(aForum,cForum.postcount) />
			<cfset ArrayAppend(aForum,cForum.viewcount) />
			<cfset ArrayAppend(aForum,mmResourceBundle.key("active"&cForum.isActive )) />
			<cfset ArrayAppend(aForumData,aForum) />
		</cfloop>

		<cfset returnStruct['sEcho']					= getTickCount()>
		<cfset returnStruct['iTotalDisplayRecords']		= sForum.count>
		<cfset returnStruct['iTotalRecords']			= sForum.count>
		<cfset returnStruct['aaData']					= aForumData>
		<cfset returnStruct['success']					= true>

		<cfcontent type="application/json">
		<cfreturn returnStruct />
	</cffunction>

	<cffunction name="setCriteria" access="private" returntype="struct" output="false" hint="Creates the search critera structure">
		<cfargument name="sData" required="true" type="struct">
		<cfargument name="cols" required="true" type="struct">
		<cfargument name="defaultSortCol" required="false" type="string" default="1">

		<cfset var sCriteria		= StructNew() />
		<cfset var sortDir			= "" />

		<cfset sCriteria.criteria	= StructNew()>
		<cfset sCriteria.orderBy	= "">

		<cfif structkeyexists(sData,"criteria")>
			<cfset sCriteria.criteria = sData.criteria>
		</cfif>

		<cfif structkeyexists(sData,"mm_global") and structkeyexists(sData.mm_global,"iDisplayStart")>
			<cfset sCriteria.start	= sData['mm_global'].iDisplayStart>
			<cfset sCriteria.size	= sData['mm_global'].iDisplayLength>
			<cfset sCriteria.count	= 0>
		</cfif>

		<cfif structkeyexists(sData,"iSortCol") and structKeyExists( arguments.cols,sData.iSortCol['0'] )>
			<cfif sData.sSortDir['0'] eq "asc">
				<cfset sortDir = "ASC">
			<cfelse>
				<cfset sortDir = "DESC">
			</cfif>
			<cfset sCriteria.orderBy = "#arguments.cols[ sData.iSortCol['0'] ]# #sortDir#">
		<cfelse>
			<cfset sCriteria.orderBy = "#arguments.cols[ arguments.defaultSortCol ]# ASC">
		</cfif>

		<cfreturn sCriteria>	
	</cffunction>

	<cffunction name="setMeldForumsManager" access="public" returntype="void" output="false">
		<cfargument name="MeldForumsManager" type="any" required="true" />
		<cfset variables.instance.MeldForumsManager = arguments.MeldForumsManager />
	</cffunction>
	<cffunction name="getMeldForumsManager" access="public" returntype="any" output="false">
		<cfreturn variables.instance.MeldForumsManager />
	</cffunction>

	<cffunction name="setMuraManager" access="public" returntype="void" output="false">
		<cfargument name="MuraManager" type="any" required="true" />
		<cfset variables.instance.MuraManager = arguments.MuraManager />
	</cffunction>
	<cffunction name="getMuraManager" access="public" returntype="any" output="false">
		<cfreturn variables.instance.MuraManager />
	</cffunction>

</cfcomponent>