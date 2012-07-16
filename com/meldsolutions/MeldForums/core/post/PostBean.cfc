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
<cfcomponent displayname="PostBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="PostID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ThreadID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="UserID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="AdminID" type="uuid" default="" maxlength="35" />
	<cfproperty name="Message" type="string" default="" required="true" />
	<cfproperty name="IsActive" type="boolean" default="0" required="true" />
	<cfproperty name="IsDisabled" type="boolean" default="0" required="true" />
	<cfproperty name="IsApproved" type="boolean" default="1" required="true" />
	<cfproperty name="IsUserDisabled" type="boolean" default="0" required="true" />
	<cfproperty name="IsModerated" type="boolean" default="0" required="true" />
	<cfproperty name="DateModerated" type="date" default="" />
	<cfproperty name="DoBlockAttachment" type="boolean" default="0" required="true" />
	<cfproperty name="AttachmentID" type="uuid" default="" maxlength="35" />
	<cfproperty name="PostPosition" type="numeric" default="0" required="true" />
	<cfproperty name="RemoteID" type="string" default="" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="Idx" type="numeric" default="0" required="true" />
	<cfproperty name="ParentID" type="uuid" default="" maxlength="35" />
	<!---^^PROPERTIES-END^^--->
	<cfproperty name="siteID" type="string" default="" required="true" />
	<cfproperty name="Title" type="string" default="" required="true" />
	<cfproperty name="Attachment" type="any" default="" />
	<cfproperty name="ThreadIdx" type="numeric" default="" required="true" />
	<cfproperty name="ThreadFriendlyName" type="string" default="" required="true" />

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="PostBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="PostID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="ThreadID" type="string" required="false" default="" />
		<cfargument name="UserID" type="string" required="false" default="" />
		<cfargument name="AdminID" type="string" required="false" default="" />
		<cfargument name="Message" type="string" required="false" default="" />
		<cfargument name="IsActive" type="boolean" required="false" default="0" />
		<cfargument name="IsDisabled" type="boolean" required="false" default="0" />
		<cfargument name="IsApproved" type="boolean" required="false" default="1" />
		<cfargument name="IsUserDisabled" type="boolean" required="false" default="0" />
		<cfargument name="IsModerated" type="boolean" required="false" default="0" />
		<cfargument name="DateModerated" type="string" required="false" default="" />
		<cfargument name="DoBlockAttachment" type="boolean" required="false" default="0" />
		<cfargument name="AttachmentID" type="string" required="false" default="" />
		<cfargument name="PostPosition" type="numeric" required="false" default="0" />
		<cfargument name="RemoteID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="Idx" type="numeric" required="false" default="0" />
		<cfargument name="ParentID" type="string" required="false" default="" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="siteID" type="string" required="false" default="" />
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />
		<cfargument name="Title" type="string" required="false" default="" />
		<cfargument name="Attachment" type="any" required="false" default=""/>
		<cfargument name="ThreadIdx" type="numeric" required="false" default="0" />
		<cfargument name="ThreadFriendlyName" type="string" required="false" default="" />

		<!---^^SETTERS-START^^--->
		<cfset setPostID( arguments.PostID ) />
		<cfset setThreadID( arguments.ThreadID ) />
		<cfset setUserID( arguments.UserID ) />
		<cfset setAdminID( arguments.AdminID ) />
		<cfset setMessage( arguments.Message ) />
		<cfset setIsActive( arguments.IsActive ) />
		<cfset setIsDisabled( arguments.IsDisabled ) />
		<cfset setIsApproved( arguments.IsApproved ) />
		<cfset setIsUserDisabled( arguments.IsUserDisabled ) />
		<cfset setIsModerated( arguments.IsModerated ) />
		<cfset setDateModerated( arguments.DateModerated ) />
		<cfset setDoBlockAttachment( arguments.DoBlockAttachment ) />
		<cfset setAttachmentID( arguments.AttachmentID ) />
		<cfset setPostPosition( arguments.PostPosition ) />
		<cfset setRemoteID( arguments.RemoteID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setIdx( arguments.Idx ) />
		<cfset setParentID( arguments.ParentID ) />
		<!---^^SETTERS-END^^--->
		<cfset setSiteID( arguments.SiteID ) />
		<cfset setBeanExists( arguments.BeanExists ) />
		<cfset setTitle( arguments.Title ) />
		<cfset setAttachment(arguments.attachment) />
		<cfset setThreadIdx( arguments.ThreadIdx ) />
		<cfset setThreadFriendlyName( arguments.ThreadFriendlyName ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="PostBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setPostID" access="public" returntype="void" output="false">
		<cfargument name="PostID" type="uuid" required="true" />
		<cfset variables.instance['postid'] = arguments.PostID />
	</cffunction>
	<cffunction name="getPostID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.PostID />
	</cffunction>
	
	<cffunction name="setThreadID" access="public" returntype="void" output="false">
		<cfargument name="ThreadID" type="string" required="true" />
		<cfset variables.instance['threadid'] = arguments.ThreadID />
	</cffunction>
	<cffunction name="getThreadID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ThreadID />
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
	
	<cffunction name="setMessage" access="public" returntype="void" output="false">
		<cfargument name="Message" type="string" required="true" />
		<cfset variables.instance['message'] = arguments.Message />
	</cffunction>
	<cffunction name="getMessage" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Message />
	</cffunction>
	
	<cffunction name="setIsActive" access="public" returntype="void" output="false">
		<cfargument name="IsActive" type="boolean" required="true" />
		<cfset variables.instance['isactive'] = arguments.IsActive />
	</cffunction>
	<cffunction name="getIsActive" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsActive />
	</cffunction>
	
	<cffunction name="setIsDisabled" access="public" returntype="void" output="false">
		<cfargument name="IsDisabled" type="boolean" required="true" />
		<cfset variables.instance['isdisabled'] = arguments.IsDisabled />
	</cffunction>
	<cffunction name="getIsDisabled" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsDisabled />
	</cffunction>
	
	<cffunction name="setIsApproved" access="public" returntype="void" output="false">
		<cfargument name="IsApproved" type="boolean" required="true" />
		<cfset variables.instance['isapproved'] = arguments.IsApproved />
	</cffunction>
	<cffunction name="getIsApproved" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsApproved />
	</cffunction>
	
	<cffunction name="setIsUserDisabled" access="public" returntype="void" output="false">
		<cfargument name="IsUserDisabled" type="boolean" required="true" />
		<cfset variables.instance['isuserdisabled'] = arguments.IsUserDisabled />
	</cffunction>
	<cffunction name="getIsUserDisabled" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsUserDisabled />
	</cffunction>
	
	<cffunction name="setIsModerated" access="public" returntype="void" output="false">
		<cfargument name="IsModerated" type="boolean" required="true" />
		<cfset variables.instance['ismoderated'] = arguments.IsModerated />
	</cffunction>
	<cffunction name="getIsModerated" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsModerated />
	</cffunction>
	
	<cffunction name="setDateModerated" access="public" returntype="void" output="false">
		<cfargument name="DateModerated" type="string" required="true" />
		<cfset variables.instance['datemoderated'] = arguments.DateModerated />
	</cffunction>
	<cffunction name="getDateModerated" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DateModerated />
	</cffunction>
	
	<cffunction name="setDoBlockAttachment" access="public" returntype="void" output="false">
		<cfargument name="DoBlockAttachment" type="boolean" required="true" />
		<cfset variables.instance['doblockattachment'] = arguments.DoBlockAttachment />
	</cffunction>
	<cffunction name="getDoBlockAttachment" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.DoBlockAttachment />
	</cffunction>
	
	<cffunction name="setAttachmentID" access="public" returntype="void" output="false">
		<cfargument name="AttachmentID" type="string" required="true" />
		<cfset variables.instance['attachmentid'] = arguments.AttachmentID />
	</cffunction>
	<cffunction name="getAttachmentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AttachmentID />
	</cffunction>
	
	<cffunction name="setPostPosition" access="public" returntype="void" output="false">
		<cfargument name="PostPosition" type="numeric" required="true" />
		<cfset variables.instance['postposition'] = arguments.PostPosition />
	</cffunction>
	<cffunction name="getPostPosition" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.PostPosition />
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
	
	<cffunction name="setParentID" access="public" returntype="void" output="false">
		<cfargument name="ParentID" type="string" required="true" />
		<cfset variables.instance['parentid'] = arguments.ParentID />
	</cffunction>
	<cffunction name="getParentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ParentID />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- Services --->
	<cffunction name="save" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		
		<cfif getBeanExists()>
			<cfset getPostService().updatePost( this ) />
		<cfelse>
			<cfset getPostService().savePost( this ) />
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
		<cfset sArgs['PostID'] = getPostID() /> 
		
		<cfset getPostService().deletePost( argumentCollection=sArgs  ) />
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

	<cffunction name="setPostService" access="public" returntype="void" output="false">
		<cfargument name="PostService" type="any" required="yes"/>
		<cfset variables.PostService = arguments.PostService />
	</cffunction>
	<cffunction name="getPostService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.PostService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"PostService")>
	</cffunction>

	<cffunction name="getKey" access="public" returntype="string" output="false" >
		<cfreturn "MeldForumsPost">
	</cffunction>

	<cffunction name="getID" access="public" returntype="uuid" output="false" >
		<cfreturn getPostID()>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
	
	<cffunction name="setSiteID" access="public" returntype="void" output="false">
		<cfargument name="SiteID" type="string" required="true" />
		<cfset variables.instance['siteid'] = arguments.SiteID />
	</cffunction>
	<cffunction name="getSiteID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SiteID />
	</cffunction>
	
	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="Title" type="string" required="true" />
		<cfset variables.instance['title'] = arguments.Title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Title />
	</cffunction>

	<cffunction name="setAttachment" access="public" returntype="void" output="false">
		<cfargument name="Attachment" type="any" required="true" />
		<cfset variables.instance['attachment'] = arguments.Attachment />
	</cffunction>
	<cffunction name="getAttachment" access="public" returntype="any" output="false">
		<cfreturn variables.instance.Attachment />
	</cffunction>

	<cffunction name="setThreadIdx" access="public" returntype="void" output="false">
		<cfargument name="ThreadIdx" type="numeric" required="true" />
		<cfset variables.instance['ThreadIdx'] = arguments.ThreadIdx />
	</cffunction>
	<cffunction name="getThreadIdx" access="public" returntype="numeric" output="false">
		<cfreturn variables.instance.ThreadIdx />
	</cffunction>

	<cffunction name="setThreadFriendlyName" access="public" returntype="void" output="false">
		<cfargument name="ThreadFriendlyName" type="string" required="true" />
		<cfset variables.instance['ThreadFriendlyName'] = arguments.ThreadFriendlyName />
	</cffunction>
	<cffunction name="getThreadFriendlyName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ThreadFriendlyName />
	</cffunction>
<!---^^CUSTOMEND^^--->
</cfcomponent>	





