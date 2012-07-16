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
<cfcomponent displayname="UserBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="UserID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="SiteID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Screenname" type="string" default="" maxlength="50" />
	<cfproperty name="AvatarID" type="uuid" default="" maxlength="35" />
	<cfproperty name="AvatarFileType" type="string" default="" maxlength="5" />
	<cfproperty name="RedoAvatar" type="boolean" default="0" required="true" />
	<cfproperty name="ThreadCounter" type="numeric" default="0" required="true" />
	<cfproperty name="LastPostID" type="uuid" default="" maxlength="35" />
	<cfproperty name="LastThreadID" type="uuid" default="" maxlength="35" />
	<cfproperty name="AdminMessage" type="string" default="" />
	<cfproperty name="IsConfirmed" type="boolean" default="0" required="true" />
	<cfproperty name="IsPrivate" type="boolean" default="1" required="true" />
	<cfproperty name="IsPostBlocked" type="boolean" default="0" required="true" />
	<cfproperty name="IsBlocked" type="boolean" default="0" required="true" />
	<cfproperty name="DoShowOnline" type="boolean" default="1" required="true" />
	<cfproperty name="DoReplyNotifications" type="boolean" default="1" required="true" />
	<cfproperty name="PostCounter" type="numeric" default="0" required="true" />
	<cfproperty name="CustomValues" type="string" default="" />
	<cfproperty name="DateLastAction" type="date" default="" />
	<cfproperty name="DateLastLogin" type="date" default="" />
	<cfproperty name="DateIsNewFrom" type="date" default="" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="externalUserBean" type="any" default="" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="UserBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="UserID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="SiteID" type="string" required="false" default="" />
		<cfargument name="Screenname" type="string" required="false" default="" />
		<cfargument name="AvatarID" type="string" required="false" default="" />
		<cfargument name="AvatarFileType" type="string" required="false" default="" />
		<cfargument name="RedoAvatar" type="boolean" required="false" default="0" />
		<cfargument name="ThreadCounter" type="numeric" required="false" default="0" />
		<cfargument name="LastPostID" type="string" required="false" default="" />
		<cfargument name="LastThreadID" type="string" required="false" default="" />
		<cfargument name="AdminMessage" type="string" required="false" default="" />
		<cfargument name="IsConfirmed" type="boolean" required="false" default="0" />
		<cfargument name="IsPrivate" type="boolean" required="false" default="1" />
		<cfargument name="IsPostBlocked" type="boolean" required="false" default="0" />
		<cfargument name="IsBlocked" type="boolean" required="false" default="0" />
		<cfargument name="DoShowOnline" type="boolean" required="false" default="1" />
		<cfargument name="DoReplyNotifications" type="boolean" required="false" default="1" />
		<cfargument name="PostCounter" type="numeric" required="false" default="0" />
		<cfargument name="CustomValues" type="string" required="false" default="" />
		<cfargument name="DateLastAction" type="string" required="false" default="" />
		<cfargument name="DateLastLogin" type="string" required="false" default="" />
		<cfargument name="DateIsNewFrom" type="string" required="false" default="" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="externalUserBean" type="any" required="false" default="" />
		<cfargument name="avatar" type="any" required="false" default="" />
		<cfargument name="post" type="any" required="false" default="" />
		<cfargument name="thread" type="any" required="false" default="" />

		<!---^^SETTERS-START^^--->
		<cfset setUserID( arguments.UserID ) />
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setScreenname( arguments.Screenname ) />
		<cfset setAvatarID( arguments.AvatarID ) />
		<cfset setAvatarFileType( arguments.AvatarFileType ) />
		<cfset setRedoAvatar( arguments.RedoAvatar ) />
		<cfset setThreadCounter( arguments.ThreadCounter ) />
		<cfset setLastPostID( arguments.LastPostID ) />
		<cfset setLastThreadID( arguments.LastThreadID ) />
		<cfset setAdminMessage( arguments.AdminMessage ) />
		<cfset setIsConfirmed( arguments.IsConfirmed ) />
		<cfset setIsPrivate( arguments.IsPrivate ) />
		<cfset setIsPostBlocked( arguments.IsPostBlocked ) />
		<cfset setIsBlocked( arguments.IsBlocked ) />
		<cfset setDoShowOnline( arguments.DoShowOnline ) />
		<cfset setDoReplyNotifications( arguments.DoReplyNotifications ) />
		<cfset setPostCounter( arguments.PostCounter ) />
		<cfset setCustomValues( arguments.CustomValues ) />
		<cfset setDateLastAction( arguments.DateLastAction ) />
		<cfset setDateLastLogin( arguments.DateLastLogin ) />
		<cfset setDateIsNewFrom( arguments.DateIsNewFrom ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setexternalUserBean(arguments.externalUserBean)>
		<cfset setAvatar(arguments.avatar)>
		<cfset setPost(arguments.post)>
		<cfset setThread(arguments.thread)>
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="UserBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setUserID" access="public" returntype="void" output="false">
		<cfargument name="UserID" type="uuid" required="true" />
		<cfset variables.instance['userid'] = arguments.UserID />
	</cffunction>
	<cffunction name="getUserID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.UserID />
	</cffunction>
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	
	<cffunction name="setScreenname" access="public" returntype="void" output="false">
		<cfargument name="Screenname" type="string" required="true" />
		<cfset variables.instance['screenname'] = arguments.Screenname />
	</cffunction>
	<cffunction name="getScreenname" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Screenname />
	</cffunction>
	
	<cffunction name="setAvatarID" access="public" returntype="void" output="false">
		<cfargument name="AvatarID" type="string" required="true" />
		<cfset variables.instance['avatarid'] = arguments.AvatarID />
	</cffunction>
	<cffunction name="getAvatarID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AvatarID />
	</cffunction>
	
	<cffunction name="setAvatarFileType" access="public" returntype="void" output="false">
		<cfargument name="AvatarFileType" type="string" required="true" />
		<cfset variables.instance['avatarfiletype'] = arguments.AvatarFileType />
	</cffunction>
	<cffunction name="getAvatarFileType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AvatarFileType />
	</cffunction>
	
	<cffunction name="setRedoAvatar" access="public" returntype="void" output="false">
		<cfargument name="RedoAvatar" type="boolean" required="true" />
		<cfset variables.instance['redoavatar'] = arguments.RedoAvatar />
	</cffunction>
	<cffunction name="getRedoAvatar" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.RedoAvatar />
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
	
	<cffunction name="setLastThreadID" access="public" returntype="void" output="false">
		<cfargument name="LastThreadID" type="string" required="true" />
		<cfset variables.instance['lastthreadid'] = arguments.LastThreadID />
	</cffunction>
	<cffunction name="getLastThreadID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.LastThreadID />
	</cffunction>
	
	<cffunction name="setAdminMessage" access="public" returntype="void" output="false">
		<cfargument name="AdminMessage" type="string" required="true" />
		<cfset variables.instance['adminmessage'] = arguments.AdminMessage />
	</cffunction>
	<cffunction name="getAdminMessage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AdminMessage />
	</cffunction>
	
	<cffunction name="setIsConfirmed" access="public" returntype="void" output="false">
		<cfargument name="IsConfirmed" type="boolean" required="true" />
		<cfset variables.instance['isconfirmed'] = arguments.IsConfirmed />
	</cffunction>
	<cffunction name="getIsConfirmed" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsConfirmed />
	</cffunction>
	
	<cffunction name="setIsPrivate" access="public" returntype="void" output="false">
		<cfargument name="IsPrivate" type="boolean" required="true" />
		<cfset variables.instance['isprivate'] = arguments.IsPrivate />
	</cffunction>
	<cffunction name="getIsPrivate" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsPrivate />
	</cffunction>
	
	<cffunction name="setIsPostBlocked" access="public" returntype="void" output="false">
		<cfargument name="IsPostBlocked" type="boolean" required="true" />
		<cfset variables.instance['ispostblocked'] = arguments.IsPostBlocked />
	</cffunction>
	<cffunction name="getIsPostBlocked" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsPostBlocked />
	</cffunction>
	
	<cffunction name="setIsBlocked" access="public" returntype="void" output="false">
		<cfargument name="IsBlocked" type="boolean" required="true" />
		<cfset variables.instance['isblocked'] = arguments.IsBlocked />
	</cffunction>
	<cffunction name="getIsBlocked" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsBlocked />
	</cffunction>
	
	<cffunction name="setDoShowOnline" access="public" returntype="void" output="false">
		<cfargument name="DoShowOnline" type="boolean" required="true" />
		<cfset variables.instance['doshowonline'] = arguments.DoShowOnline />
	</cffunction>
	<cffunction name="getDoShowOnline" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoShowOnline />
	</cffunction>
	
	<cffunction name="setDoReplyNotifications" access="public" returntype="void" output="false">
		<cfargument name="DoReplyNotifications" type="boolean" required="true" />
		<cfset variables.instance['doreplynotifications'] = arguments.DoReplyNotifications />
	</cffunction>
	<cffunction name="getDoReplyNotifications" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoReplyNotifications />
	</cffunction>
	
	<cffunction name="setPostCounter" access="public" returntype="void" output="false">
		<cfargument name="PostCounter" type="numeric" required="true" />
		<cfset variables.instance['postcounter'] = arguments.PostCounter />
	</cffunction>
	<cffunction name="getPostCounter" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PostCounter />
	</cffunction>
	
	<cffunction name="setCustomValues" access="public" returntype="void" output="false">
		<cfargument name="CustomValues" type="string" required="true" />
		<cfset variables.instance['customvalues'] = arguments.CustomValues />
	</cffunction>
	<cffunction name="getCustomValues" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CustomValues />
	</cffunction>
	
	<cffunction name="setDateLastAction" access="public" returntype="void" output="false">
		<cfargument name="DateLastAction" type="string" required="true" />
		<cfset variables.instance['datelastaction'] = arguments.DateLastAction />
	</cffunction>
	<cffunction name="getDateLastAction" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastAction />
	</cffunction>
	
	<cffunction name="setDateLastLogin" access="public" returntype="void" output="false">
		<cfargument name="DateLastLogin" type="string" required="true" />
		<cfset variables.instance['datelastlogin'] = arguments.DateLastLogin />
	</cffunction>
	<cffunction name="getDateLastLogin" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateLastLogin />
	</cffunction>
	
	<cffunction name="setDateIsNewFrom" access="public" returntype="void" output="false">
		<cfargument name="DateIsNewFrom" type="string" required="true" />
		<cfset variables.instance['dateisnewfrom'] = arguments.DateIsNewFrom />
	</cffunction>
	<cffunction name="getDateIsNewFrom" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateIsNewFrom />
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
	<!---^^ACCESSORS-END^^--->

	<!--- Services --->
	<cffunction name="save" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		
		<cfif getBeanExists()>
			<cfset getUserService().updateUser( this ) />
		<cfelse>
			<cfset getUserService().saveUser( this ) />
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
		<cfset sArgs['UserID'] = getUserID() /> 
		

		<cfset getUserService().deleteUser( argumentCollection=sArgs  ) />
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

	<cffunction name="setUserService" access="public" returntype="void" output="false">
		<cfargument name="UserService" type="any" required="yes"/>
		<cfset variables.UserService = arguments.UserService />
	</cffunction>
	<cffunction name="getUserService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.UserService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"UserService")>
	</cffunction>

	<cffunction name="getKey" access="public" returntype="string" output="false" >
		<cfreturn "MeldForumsUser">
	</cffunction>

	<cffunction name="getID" access="public" returntype="uuid" output="false" >
		<cfreturn getUserID()>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	<cffunction name="setExternalUserBean" access="public" returntype="void" output="false">
		<cfargument name="ExternalUserBean" type="any" required="true" />
		<cfset variables.instance.ExternalUserBean = arguments.ExternalUserBean />
	</cffunction>
	<cffunction name="getExternalUserBean" access="public" returntype="any" output="false">
		<cfif StructKeyExists(variables.instance,"ExternalUserBean") and not isSimpleValue(variables.instance.ExternalUserBean)>
			<cfreturn variables.instance.ExternalUserBean />
		<cfelse>
			<cfset getUserService().getExternalUserBean( this ) />
		</cfif>

		<cfreturn variables.instance.ExternalUserBean />
	</cffunction>

	<cffunction name="setAvatar" access="public" returntype="void" output="false">
		<cfargument name="Avatar" type="any" required="true" />
		<cfset variables.instance.Avatar = arguments.Avatar />
	</cffunction>
	<cffunction name="getAvatar" access="public" returntype="any" output="false">
		<cfreturn variables.instance.Avatar />
	</cffunction>

	<cffunction name="setPost" access="public" returntype="void" output="false">
		<cfargument name="Post" type="any" required="true" />
		<cfset variables.instance.Post = arguments.Post />
	</cffunction>
	<cffunction name="getPost" access="public" returntype="any" output="false">
		<cfif StructKeyExists(variables.instance,"Post") and not isSimpleValue(variables.instance.Post)>
			<cfreturn variables.instance.Post />
		<cfelseif len( getLastPostID() )>
			<cfset getUserService().getLastPost( this ) />
		</cfif>

		<cfreturn variables.instance.Post />
	</cffunction>

	<cffunction name="setThread" access="public" returntype="void" output="false">
		<cfargument name="Thread" type="any" required="true" />
		<cfset variables.instance.Thread = arguments.Thread />
	</cffunction>
	<cffunction name="getThread" access="public" returntype="any" output="false">
		<cfif StructKeyExists(variables.instance,"Thread") and not isSimpleValue(variables.instance.Thread)>
			<cfreturn variables.instance.Thread />
		<cfelseif len( getLastThreadID() )>
			<cfset getUserService().getLastThread( this ) />
		</cfif>

		<cfreturn variables.instance.Thread />
	</cffunction>

	<cffunction name="getUserName" access="public" returntype="any" output="false">
		<cfreturn getscreenname() />
	</cffunction>

	<cffunction name="IsCreated" access="public" returntype="boolean" output="false">
		<cfreturn isDate(getDateCreate()) />
	</cffunction>

<!---^^CUSTOMEND^^--->
</cfcomponent>	






