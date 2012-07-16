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
<cfcomponent displayname="ForumBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="ForumID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ConferenceID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ConfigurationID" type="uuid" default="" maxlength="35" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="Name" type="string" default="" required="true" maxlength="150" />
	<cfproperty name="Title" type="string" default="" required="true" maxlength="150" />
	<cfproperty name="Description" type="string" default="" />
	<cfproperty name="FriendlyName" type="string" default="" maxlength="200" />
	<cfproperty name="IsActive" type="boolean" default="1" required="true" />
	<cfproperty name="AdminID" type="uuid" default="" maxlength="35" />
	<cfproperty name="OrderNo" type="numeric" default="1000" required="true" />
	<cfproperty name="ThreadCounter" type="numeric" default="0" required="true" />
	<cfproperty name="LastPostID" type="uuid" default="" maxlength="35" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="Idx" type="numeric" default="0" required="true" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="ParentConfigurationID" type="string" default="" />
	<cfproperty name="PostCount" type="numeric" default="0" />
	<cfproperty name="DateLastThread" type="date" default="" />
	<cfproperty name="viewCount" type="numeric" default="0" />
	<cfproperty name="Announcements" type="array" default="" />
	<cfproperty name="Threads" type="array" default="" />
	<cfproperty name="LastPost" type="any" default="" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="ForumBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ForumID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="ConferenceID" type="string" required="false" default="" />
		<cfargument name="ConfigurationID" type="string" required="false" default="" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Title" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="FriendlyName" type="string" required="false" default="" />
		<cfargument name="IsActive" type="boolean" required="false" default="1" />
		<cfargument name="AdminID" type="string" required="false" default="" />
		<cfargument name="OrderNo" type="numeric" required="false" default="1000" />
		<cfargument name="ThreadCounter" type="numeric" required="false" default="0" />
		<cfargument name="LastPostID" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="Idx" type="numeric" required="false" default="0" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="ParentConfigurationID" type="string" required="false" default="" />
		<cfargument name="PostCount" type="string" required="false" default="0" />
		<cfargument name="DateLastThread" type="string" required="false" default="" />
		<cfargument name="ViewCount" type="string" required="false" default="0" />
		<cfargument name="announcements" type="array" required="false" default="#arrayNew(1)#" />
		<cfargument name="threads" type="array" required="false" default="#arrayNew(1)#" />
		<cfargument name="lastPost" type="any" required="false" default="" />

		<!---^^SETTERS-START^^--->
		<cfset setForumID( arguments.ForumID ) />
		<cfset setConferenceID( arguments.ConferenceID ) />
		<cfset setConfigurationID( arguments.ConfigurationID ) />
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setName( arguments.Name ) />
		<cfset setTitle( arguments.Title ) />
		<cfset setDescription( arguments.Description ) />
		<cfset setFriendlyName( arguments.FriendlyName ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setAdminID( arguments.AdminID ) />
		<cfset setOrderNo( arguments.OrderNo ) />
		<cfset setThreadCounter( arguments.ThreadCounter ) />
		<cfset setLastPostID( arguments.LastPostID ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setIdx( arguments.Idx ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setParentConfigurationID(arguments.ParentConfigurationID) />
		<cfset setPostCount(arguments.postCount) />
		<cfset setDateLastThread(arguments.dateLastThread) />
		<cfset setViewCount(arguments.viewCount) />
		<cfset setAnnouncements(arguments.announcements) />
		<cfset setThreads(arguments.Threads) />
		<cfset setLastPost(arguments.lastPost) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="ForumBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setForumID" access="public" returntype="void" output="false">
		<cfargument name="ForumID" type="uuid" required="true" />
		<cfset variables.instance['forumid'] = arguments.ForumID />
	</cffunction>
	<cffunction name="getForumID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.ForumID />
	</cffunction>
	
	<cffunction name="setConferenceID" access="public" returntype="void" output="false">
		<cfargument name="ConferenceID" type="string" required="true" />
		<cfset variables.instance['conferenceid'] = arguments.ConferenceID />
	</cffunction>
	<cffunction name="getConferenceID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ConferenceID />
	</cffunction>
	
	<cffunction name="setConfigurationID" access="public" returntype="void" output="false">
		<cfargument name="ConfigurationID" type="string" required="true" />
		<cfset variables.instance['configurationid'] = arguments.ConfigurationID />
	</cffunction>
	<cffunction name="getConfigurationID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ConfigurationID />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
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
	
	<cffunction name="setFriendlyName" access="public" returntype="void" output="false">
		<cfargument name="FriendlyName" type="string" required="true" />
		<cfset variables.instance['friendlyname'] = arguments.FriendlyName />
	</cffunction>
	<cffunction name="getFriendlyName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.FriendlyName />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setAdminID" access="public" returntype="void" output="false">
		<cfargument name="AdminID" type="string" required="true" />
		<cfset variables.instance['adminid'] = arguments.AdminID />
	</cffunction>
	<cffunction name="getAdminID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AdminID />
	</cffunction>
	
	<cffunction name="setOrderNo" access="public" returntype="void" output="false">
		<cfargument name="OrderNo" type="numeric" required="true" />
		<cfset variables.instance['orderno'] = arguments.OrderNo />
	</cffunction>
	<cffunction name="getOrderNo" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.OrderNo />
	</cffunction>
	
	<cffunction name="setThreadCounter" access="public" returntype="void" output="false">
		<cfargument name="ThreadCounter" type="numeric" required="true" />
		<cfset variables.instance['threadcounter'] = arguments.ThreadCounter />
	</cffunction>
	<cffunction name="getThreadCounter" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ThreadCounter />
	</cffunction>
	
	<cffunction name="setLastPostID" access="public" returntype="void" output="false">
		<cfargument name="LastPostID" type="string" required="true" />
		<cfset variables.instance['lastpostid'] = arguments.LastPostID />
	</cffunction>
	<cffunction name="getLastPostID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.LastPostID />
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
			<cfset getForumService().updateForum( this ) />
		<cfelse>
			<cfset getForumService().saveForum( this ) />
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
		<cfset sArgs['ForumID'] = getForumID() /> 
		

		<cfset getForumService().deleteForum( argumentCollection=sArgs  ) />
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

	<cffunction name="setForumService" access="public" returntype="void" output="false">
		<cfargument name="ForumService" type="any" required="yes"/>
		<cfset variables.ForumService = arguments.ForumService />
	</cffunction>
	<cffunction name="getForumService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.ForumService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"ForumService")>
	</cffunction>

	<cffunction name="getKey" access="public" returntype="string" output="false" >
		<cfreturn "MeldForumsForum">
	</cffunction>

	<cffunction name="getID" access="public" returntype="uuid" output="false" >
		<cfreturn getForumID()>
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
		<cfelseif len( getParentConfigurationID() )>
			<cfreturn getParentConfigurationID()>
		<cfelse>
			<cfreturn "00000000-0000-0000-0000000000000001">
		</cfif>
	</cffunction>

	<cffunction name="setPostCount" access="public" returntype="void" output="false">
		<cfargument name="PostCount" type="string" required="true" />
		<cfset variables.instance['postcount'] = arguments.PostCount />
	</cffunction>
	<cffunction name="getPostCount" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PostCount />
	</cffunction>

	<cffunction name="setDateLastThread" access="public" returntype="void" output="false">
		<cfargument name="DateLastThread" type="string" required="true" />
		<cfset variables.instance['datelastthread'] = arguments.DateLastThread />
	</cffunction>
	<cffunction name="getDateLastThread" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastThread />
	</cffunction>

	<cffunction name="setviewCount" access="public" returntype="void" output="false">
		<cfargument name="viewCount" type="string" required="true" />
		<cfset variables.instance['viewcount'] = arguments.viewCount />
	</cffunction>
	<cffunction name="getviewCount" access="public" returntype="string" output="false">
		<cfreturn variables.instance.viewCount />
	</cffunction>

	<cffunction name="setAnnouncements" access="public" returntype="void" output="false">
		<cfargument name="Announcements" type="array" required="true" />
		<cfset variables.instance['announcements'] = arguments.Announcements />
	</cffunction>
	<cffunction name="getAnnouncements" access="public" returntype="array" output="false">
		<cfreturn variables.instance.Announcements />
	</cffunction>

	<cffunction name="setThreads" access="public" returntype="void" output="false">
		<cfargument name="Threads" type="array" required="true" />
		<cfset variables.instance['threads'] = arguments.Threads />
	</cffunction>
	<cffunction name="getThreads" access="public" returntype="array" output="false">
		<cfreturn variables.instance.Threads />
	</cffunction>

	<cffunction name="setLastPost" access="public" returntype="void" output="false">
		<cfargument name="LastPost" type="any" required="true" />
		<cfset variables.instance['lastpost'] = arguments.LastPost />
	</cffunction>
	<cffunction name="getLastPost" access="public" returntype="any" output="false">
		<cfreturn variables.instance.LastPost />
	</cffunction>
<!---^^CUSTOMEND^^--->
</cfcomponent>	




