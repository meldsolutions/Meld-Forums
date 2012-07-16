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
<cfcomponent displayname="ThreadBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="ThreadID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ForumID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="TypeID" type="numeric" default="0" required="true" />
	<cfproperty name="SiteID" type="string" default="" required="true" maxlength="25" />
	<cfproperty name="IsActive" type="boolean" default="0" required="true" />
	<cfproperty name="IsClosed" type="boolean" default="0" required="true" />
	<cfproperty name="IsDisabled" type="boolean" default="0" required="true" />
	<cfproperty name="IsUserDisabled" type="boolean" default="0" required="true" />
	<cfproperty name="IsDraft" type="boolean" default="0" required="true" />
	<cfproperty name="UserID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="AdminID" type="uuid" default="" maxlength="35" />
	<cfproperty name="AdminMessage" type="string" default="" />
	<cfproperty name="Title" type="string" default="" required="true" maxlength="150" />
	<cfproperty name="FriendlyName" type="string" default="" maxlength="200" />
	<cfproperty name="OrderNo" type="numeric" default="0" required="true" />
	<cfproperty name="PostCounter" type="numeric" default="0" required="true" />
	<cfproperty name="LastPostID" type="uuid" default="" maxlength="35" />
	<cfproperty name="DateLastPost" type="date" default="" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="Idx" type="numeric" default="0" required="true" />
	<cfproperty name="IsAnnouncement" type="boolean" default="0" required="true" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="LastPost" type="any" default="" />
	<cfproperty name="Posts" type="any" default="" />
	<cfproperty name="Message" type="string" default="" />
	<cfproperty name="ViewCounter" type="numeric" default="" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="ThreadBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="ThreadID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="ForumID" type="string" required="false" default="" />
		<cfargument name="TypeID" type="numeric" required="false" default="0" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="IsActive" type="boolean" required="false" default="0" />
		<cfargument name="IsClosed" type="boolean" required="false" default="0" />
		<cfargument name="IsDisabled" type="boolean" required="false" default="0" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" default="0" />
		<cfargument name="IsDraft" type="boolean" required="false" default="0" />
		<cfargument name="UserID" type="string" required="false" default="" />
		<cfargument name="AdminID" type="string" required="false" default="" />
		<cfargument name="AdminMessage" type="string" required="false" default="" />
		<cfargument name="Title" type="string" required="false" default="" />
		<cfargument name="FriendlyName" type="string" required="false" default="" />
		<cfargument name="OrderNo" type="numeric" required="false" default="0" />
		<cfargument name="PostCounter" type="numeric" required="false" default="0" />
		<cfargument name="LastPostID" type="string" required="false" default="" />
		<cfargument name="DateLastPost" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="Idx" type="numeric" required="false" default="0" />
		<cfargument name="IsAnnouncement" type="boolean" required="false" default="0" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="lastPost" type="any" required="false" default="" />
		<cfargument name="posts" type="any" required="false" default="#ArrayNew(1)#" />
		<cfargument name="Message" type="string" required="false" default="" />
		<cfargument name="ViewCounter" type="string" required="false" default="" />

		<!---^^SETTERS-START^^--->
		<cfset setThreadID( arguments.ThreadID ) />
		<cfset setForumID( arguments.ForumID ) />
		<cfset setTypeID( arguments.TypeID ) />
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setIsClosed( arguments.IsClosed ) />
		<cfset setIsDisabled( arguments.IsDisabled ) />
		<cfset setIsUserDisabled( arguments.IsUserDisabled ) />
		<cfset setIsDraft( arguments.IsDraft ) />
		<cfset setUserID( arguments.UserID ) />
		<cfset setAdminID( arguments.AdminID ) />
		<cfset setAdminMessage( arguments.AdminMessage ) />
		<cfset setTitle( arguments.Title ) />
		<cfset setFriendlyName( arguments.FriendlyName ) />
		<cfset setOrderNo( arguments.OrderNo ) />
		<cfset setPostCounter( arguments.PostCounter ) />
		<cfset setLastPostID( arguments.LastPostID ) />
		<cfset setDateLastPost( arguments.DateLastPost ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setIdx( arguments.Idx ) />
		<cfset setIsAnnouncement( arguments.IsAnnouncement ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setLastPost(arguments.lastPost) />
		<cfset setPosts(arguments.Posts) />
		<cfset setMessage(arguments.Message) />
		<cfset setViewCounter(arguments.ViewCounter) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="ThreadBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setThreadID" access="public" returntype="void" output="false">
		<cfargument name="ThreadID" type="uuid" required="true" />
		<cfset variables.instance['threadid'] = arguments.ThreadID />
	</cffunction>
	<cffunction name="getThreadID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.ThreadID />
	</cffunction>
	
	<cffunction name="setForumID" access="public" returntype="void" output="false">
		<cfargument name="ForumID" type="string" required="true" />
		<cfset variables.instance['forumid'] = arguments.ForumID />
	</cffunction>
	<cffunction name="getForumID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ForumID />
	</cffunction>
	
	<cffunction name="setTypeID" access="public" returntype="void" output="false">
		<cfargument name="TypeID" type="numeric" required="true" />
		<cfset variables.instance['typeid'] = arguments.TypeID />
	</cffunction>
	<cffunction name="getTypeID" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.TypeID />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setIsClosed" access="public" returntype="void" output="false">
		<cfargument name="IsClosed" type="boolean" required="true" />
		<cfset variables.instance['isclosed'] = arguments.IsClosed />
	</cffunction>
	<cffunction name="getIsClosed" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsClosed />
	</cffunction>
	
	<cffunction name="setIsDisabled" access="public" returntype="void" output="false">
		<cfargument name="IsDisabled" type="boolean" required="true" />
		<cfset variables.instance['isdisabled'] = arguments.IsDisabled />
	</cffunction>
	<cffunction name="getIsDisabled" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsDisabled />
	</cffunction>
	
	<cffunction name="setIsUserDisabled" access="public" returntype="void" output="false">
		<cfargument name="IsUserDisabled" type="boolean" required="true" />
		<cfset variables.instance['isuserdisabled'] = arguments.IsUserDisabled />
	</cffunction>
	<cffunction name="getIsUserDisabled" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsUserDisabled />
	</cffunction>
	
	<cffunction name="setIsDraft" access="public" returntype="void" output="false">
		<cfargument name="IsDraft" type="boolean" required="true" />
		<cfset variables.instance['isdraft'] = arguments.IsDraft />
	</cffunction>
	<cffunction name="getIsDraft" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsDraft />
	</cffunction>
	
	<cffunction name="setUserID" access="public" returntype="void" output="false">
		<cfargument name="UserID" type="string" required="true" />
		<cfset variables.instance['userid'] = arguments.UserID />
	</cffunction>
	<cffunction name="getUserID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UserID />
	</cffunction>
	
	<cffunction name="setAdminID" access="public" returntype="void" output="false">
		<cfargument name="AdminID" type="string" required="true" />
		<cfset variables.instance['adminid'] = arguments.AdminID />
	</cffunction>
	<cffunction name="getAdminID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AdminID />
	</cffunction>
	
	<cffunction name="setAdminMessage" access="public" returntype="void" output="false">
		<cfargument name="AdminMessage" type="string" required="true" />
		<cfset variables.instance['adminmessage'] = arguments.AdminMessage />
	</cffunction>
	<cffunction name="getAdminMessage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AdminMessage />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="Title" type="string" required="true" />
		<cfset variables.instance['title'] = arguments.Title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Title />
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
	
	<cffunction name="setPostCounter" access="public" returntype="void" output="false">
		<cfargument name="PostCounter" type="numeric" required="true" />
		<cfset variables.instance['postcounter'] = arguments.PostCounter />
	</cffunction>
	<cffunction name="getPostCounter" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PostCounter />
	</cffunction>
	
	<cffunction name="setLastPostID" access="public" returntype="void" output="false">
		<cfargument name="LastPostID" type="string" required="true" />
		<cfset variables.instance['lastpostid'] = arguments.LastPostID />
	</cffunction>
	<cffunction name="getLastPostID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.LastPostID />
	</cffunction>
	
	<cffunction name="setDateLastPost" access="public" returntype="void" output="false">
		<cfargument name="DateLastPost" type="string" required="true" />
		<cfset variables.instance['datelastpost'] = arguments.DateLastPost />
	</cffunction>
	<cffunction name="getDateLastPost" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastPost />
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
	
	<cffunction name="setIsAnnouncement" access="public" returntype="void" output="false">
		<cfargument name="IsAnnouncement" type="boolean" required="true" />
		<cfset variables.instance['isannouncement'] = arguments.IsAnnouncement />
	</cffunction>
	<cffunction name="getIsAnnouncement" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsAnnouncement />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- Services --->
	<cffunction name="save" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		
		<cfif getBeanExists()>
			<cfset getThreadService.update( this ) />
		<cfelse>
			<cfset getThreadService.save( this ) />
		</cfif>

		<cfreturn true>
	</cffunction>

	<cffunction name="update" access="public" output="true" return="boolean">
		<cfreturn save()>
	</cffunction>

	<cffunction name="delete" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>

		<cfset getThreadService.delete( this ) />
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

	<cffunction name="setThreadService" access="public" returntype="void" output="false">
		<cfargument name="ThreadService" type="any" required="yes"/>
		<cfset variables.ThreadService = arguments.ThreadService />
	</cffunction>
	<cffunction name="getThreadService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.ThreadService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"ThreadService")>
	</cffunction>

	<cffunction name="getKey" access="public" returntype="string" output="false" >
		<cfreturn "MeldForumsThread">
	</cffunction>

	<cffunction name="getID" access="public" returntype="uuid" output="false" >
		<cfreturn getThreadID()>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="setLastPost" access="public" returntype="void" output="false">
		<cfargument name="LastPost" type="any" required="true" />
		<cfset variables.instance['lastpost'] = arguments.LastPost />
	</cffunction>
	<cffunction name="getLastPost" access="public" returntype="any" output="false">
		<cfreturn variables.instance.LastPost />
	</cffunction>

	<cffunction name="setPosts" access="public" returntype="void" output="false">
		<cfargument name="Post" type="any" required="true" />
		<cfset variables.instance['posts'] = arguments.Post />
	</cffunction>
	<cffunction name="getPosts" access="public" returntype="any" output="false">
		<cfreturn variables.instance.Posts />
	</cffunction>

	<cffunction name="setMessage" access="public" returntype="void" output="false">
		<cfargument name="Message" type="string" required="true" />
		<cfset variables.instance['message'] = arguments.message />
	</cffunction>
	<cffunction name="getMessage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Message />
	</cffunction>

	<cffunction name="setViewCounter" access="public" returntype="void" output="false">
		<cfargument name="ViewCounter" type="string" required="true" />
		<cfset variables.instance['viewcounter'] = arguments.ViewCounter />
	</cffunction>
	<cffunction name="getViewCounter" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ViewCounter />
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>	













