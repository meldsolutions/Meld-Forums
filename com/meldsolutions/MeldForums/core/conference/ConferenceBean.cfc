<!---This file is part of the Meld Forums application.

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
<cfcomponent displayname="ConferenceBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="ConferenceID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="ConfigurationID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Name" type="string" default="" required="true" maxlength="150" />
	<cfproperty name="Title" type="string" default="" required="true" maxlength="150" />
	<cfproperty name="Description" type="string" default="" />
	<cfproperty name="IsActive" type="boolean" default="0" required="true" />
	<cfproperty name="FriendlyName" type="string" default="" required="true" maxlength="200" />
	<cfproperty name="OrderNo" type="numeric" default="0" required="true" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="Idx" type="numeric" default="0" required="true" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="parentConfigurationID" type="string" default="" />
	<cfproperty name="threadCount" type="numeric" default="0" />
	<cfproperty name="forumCount" type="numeric" default="0" />
	<cfproperty name="forums" type="array" default="" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="ConferenceBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ConferenceID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="ConfigurationID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Title" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="IsActive" type="boolean" required="false" default="0" />
		<cfargument name="FriendlyName" type="string" required="false" default="" />
		<cfargument name="OrderNo" type="numeric" required="false" default="0" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="Idx" type="numeric" required="false" default="0" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="parentConfigurationID" type="string" required="false" default="" />
		<cfargument name="threadCount" type="string" required="false" default="0" />
		<cfargument name="forumCount" type="string" required="false" default="0" />
		<cfargument name="forums" type="array" required="false" default="#arrayNew(1)#" />

		<!---^^SETTERS-START^^--->
		<cfset setConferenceID( arguments.ConferenceID ) />
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setConfigurationID( arguments.ConfigurationID ) />
		<cfset setName( arguments.Name ) />
		<cfset setTitle( arguments.Title ) />
		<cfset setDescription( arguments.Description ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setFriendlyName( arguments.FriendlyName ) />
		<cfset setOrderNo( arguments.OrderNo ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setIdx( arguments.Idx ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setParentConfigurationID(arguments.parentconfigurationID) />
		<cfset setThreadCount(arguments.threadCount) />
		<cfset setForumCount(arguments.forumCount) />
		<cfset setForums(arguments.forums) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="ConferenceBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setConferenceID" access="public" returntype="void" output="false">
		<cfargument name="ConferenceID" type="uuid" required="true" />
		<cfset variables.instance['conferenceid'] = arguments.ConferenceID />
	</cffunction>
	<cffunction name="getConferenceID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.ConferenceID />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	
	<cffunction name="setConfigurationID" access="public" returntype="void" output="false">
		<cfargument name="ConfigurationID" type="string" required="true" />
		<cfset variables.instance['configurationid'] = arguments.ConfigurationID />
	</cffunction>
	<cffunction name="getConfigurationID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ConfigurationID />
	</cffunction>
	
	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance['name'] = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="Title" type="string" required="true" />
		<cfset variables.instance['title'] = arguments.Title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Title />
	</cffunction>
	
	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance['description'] = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setFriendlyName" access="public" returntype="void" output="false">
		<cfargument name="FriendlyName" type="string" required="true" />
		<cfset variables.instance['friendlyname'] = arguments.FriendlyName />
	</cffunction>
	<cffunction name="getFriendlyName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.FriendlyName />
	</cffunction>
	
	<cffunction name="setOrderNo" access="public" returntype="void" output="false">
		<cfargument name="OrderNo" type="numeric" required="true" />
		<cfset variables.instance['orderno'] = arguments.OrderNo />
	</cffunction>
	<cffunction name="getOrderNo" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.OrderNo />
	</cffunction>
	
	<cffunction name="setRemoteID" access="public" returntype="void" output="false">
		<cfargument name="RemoteID" type="string" required="true" />
		<cfset variables.instance['remoteid'] = arguments.RemoteID />
	</cffunction>
	<cffunction name="getRemoteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.RemoteID />
	</cffunction>
	
	<cffunction name="setDateCreate" access="public" returntype="void" output="false">
		<cfargument name="DateCreate" type="string" required="true" />
		<cfset variables.instance['datecreate'] = arguments.DateCreate />
	</cffunction>
	<cffunction name="getDateCreate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateCreate />
	</cffunction>
	
	<cffunction name="setDateLastUpdate" access="public" returntype="void" output="false">
		<cfargument name="DateLastUpdate" type="string" required="true" />
		<cfset variables.instance['datelastupdate'] = arguments.DateLastUpdate />
	</cffunction>
	<cffunction name="getDateLastUpdate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastUpdate />
	</cffunction>
	
	<cffunction name="setIdx" access="public" returntype="void" output="false">
		<cfargument name="Idx" type="numeric" required="true" />
		<cfset variables.instance['idx'] = arguments.Idx />
	</cffunction>
	<cffunction name="getIdx" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.Idx />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- Services --->
	<cffunction name="save" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		
		<cfif getBeanExists()>
			<cfset getConferenceService().updateConference( this ) />
		<cfelse>
			<cfset getConferenceService().saveConference( this ) />
		</cfif>

		<cfreturn true>
	</cffunction>

	<cffunction name="update" access="public" output="true" return="boolean">
		<cfreturn save()>
	</cffunction>

	<cffunction name="delete" access="public" output="true" return="boolean">

		<cfset var sArgs = StructNew() />

		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		<cfset sArgs['ConferenceID'] = getConferenceID() /> 
		
		<cfset getConferenceService().deleteConference( argumentCollection=sArgs  ) />
		<cfreturn true>
	</cffunction>

	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#getMemento()#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

	<cffunction name="setBeanExists" access="public" output="false" returntype="void">
		<cfargument name="BeanExists" type="boolean" required="true" />
		<cfset variables.BeanExists = arguments.BeanExists >
	</cffunction>
	<cffunction name="BeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>
	<cffunction name="getBeanExists" access="public" output="false" returntype="boolean">
		<cfreturn variables.BeanExists>
	</cffunction>

	<cffunction name="setConferenceService" access="public" returntype="void" output="false">
		<cfargument name="ConferenceService" type="any" required="yes"/>
		<cfset variables.ConferenceService = arguments.ConferenceService />
	</cffunction>
	<cffunction name="getConferenceService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.ConferenceService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"ConferenceService")>
	</cffunction>
		
	<cffunction name="getKey" access="public" returntype="string" output="false" >
		<cfreturn "MeldForumsConference">
	</cffunction>

	<cffunction name="getID" access="public" returntype="uuid" output="false" >
		<cfreturn getConferenceID()>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="setParentConfigurationID" access="public" returntype="void" output="false">
		<cfargument name="ParentConfigurationID" type="string" required="true" />
		<cfset variables.instance['parentconfigurationid'] = arguments.ParentConfigurationID />
	</cffunction>
	<cffunction name="getParentConfigurationID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ParentConfigurationID />
	</cffunction>

	<cffunction name="getActiveConfigurationID" access="public" returntype="string" output="false">
		<cfif len( getconfigurationID() )>
			<cfreturn getconfigurationID()>
		<cfelse>
			<cfreturn "00000000-0000-0000-0000000000000001">
		</cfif>
	</cffunction>

	<cffunction name="setForums" access="public" returntype="void" output="false">
		<cfargument name="Forums" type="array" required="true" />
		<cfset variables.instance['forums'] = arguments.Forums />
	</cffunction>
	<cffunction name="getForums" access="public" returntype="array" output="false">
		<cfreturn variables.instance.Forums />
	</cffunction>

	<cffunction name="setThreadCount" access="public" returntype="void" output="false">
		<cfargument name="ThreadCount" type="string" required="true" />
		<cfset variables.instance['threadcount'] = arguments.ThreadCount />
	</cffunction>
	<cffunction name="getThreadCount" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ThreadCount />
	</cffunction>

	<cffunction name="setForumCount" access="public" returntype="void" output="false">
		<cfargument name="ForumCount" type="string" required="true" />
		<cfset variables.instance['forumcount'] = arguments.ForumCount />
	</cffunction>
	<cffunction name="getForumCount" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ForumCount />
	</cffunction>


<!---^^CUSTOMEND^^--->
</cfcomponent>	





