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
<cfcomponent displayname="SubscribeBean" output="false" extends="MeldForums.com.meldsolutions.core.MeldBean">
<!---^^GENERATEDSTART^^--->
	<!---^^PROPERTIES-START^^--->
	<cfproperty name="SubscribeID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="ConferenceID" type="uuid" default="" maxlength="35" />
	<cfproperty name="ForumID" type="uuid" default="" maxlength="35" />
	<cfproperty name="ThreadID" type="uuid" default="" maxlength="35" />
	<cfproperty name="UserID" type="uuid" default="" required="true" maxlength="35" />
	<cfproperty name="DateCreate" type="date" default="" required="true" />
	<cfproperty name="DateLastUpdate" type="date" default="" required="true" />
	<cfproperty name="IsEmail" type="boolean" default="0" required="true" />
	<!---^^PROPERTIES-END^^--->

	<cfset variables.instance = StructNew() />

	<!--- INIT --->
	<cffunction name="init" access="public" returntype="SubscribeBean" output="false">
		<!---^^ATTRIBUTES-START^^--->
		<cfargument name="SubscribeID" type="uuid" required="false" default="#CreateUUID()#" />
		<cfargument name="ConferenceID" type="string" required="false" default="" />
		<cfargument name="ForumID" type="string" required="false" default="" />
		<cfargument name="ThreadID" type="string" required="false" default="" />
		<cfargument name="UserID" type="string" required="false" default="" />
		<cfargument name="DateCreate" type="string" required="false" default="" />
		<cfargument name="DateLastUpdate" type="string" required="false" default="" />
		<cfargument name="IsEmail" type="boolean" required="false" default="0" />
		<!---^^ATTRIBUTES-END^^--->
		<cfargument name="BeanExists" type="boolean" required="false" default="false" />

		<!---^^SETTERS-START^^--->
		<cfset setSubscribeID( arguments.SubscribeID ) />
		<cfset setConferenceID( arguments.ConferenceID ) />
		<cfset setForumID( arguments.ForumID ) />
		<cfset setThreadID( arguments.ThreadID ) />
		<cfset setUserID( arguments.UserID ) />
		<cfset setDateCreate( arguments.DateCreate ) />
		<cfset setDateLastUpdate( arguments.DateLastUpdate ) />
		<cfset setIsEmail( arguments.IsEmail ) />
		<!---^^SETTERS-END^^--->
		<cfset setBeanExists( arguments.BeanExists ) />
		
		<cfreturn this />
	</cffunction>

	<cffunction name="setMemento" access="public" returntype="SubscribeBean" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<!---^^ACCESSORS-START^^--->
	<cffunction name="setSubscribeID" access="public" returntype="void" output="false">
		<cfargument name="SubscribeID" type="uuid" required="true" />
		<cfset variables.instance['subscribeid'] = arguments.SubscribeID />
	</cffunction>
	<cffunction name="getSubscribeID" access="public" returntype="uuid" output="false">
		<cfreturn variables.instance.SubscribeID />
	</cffunction>
	
	<cffunction name="setConferenceID" access="public" returntype="void" output="false">
		<cfargument name="ConferenceID" type="string" required="true" />
		<cfset variables.instance['conferenceid'] = arguments.ConferenceID />
	</cffunction>
	<cffunction name="getConferenceID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ConferenceID />
	</cffunction>
	
	<cffunction name="setForumID" access="public" returntype="void" output="false">
		<cfargument name="ForumID" type="string" required="true" />
		<cfset variables.instance['forumid'] = arguments.ForumID />
	</cffunction>
	<cffunction name="getForumID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ForumID />
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
	
	<cffunction name="setIsEmail" access="public" returntype="void" output="false">
		<cfargument name="IsEmail" type="boolean" required="true" />
		<cfset variables.instance['isemail'] = arguments.IsEmail />
	</cffunction>
	<cffunction name="getIsEmail" access="public" returntype="boolean" output="false">
		<cfreturn variables.instance.IsEmail />
	</cffunction>
	<!---^^ACCESSORS-END^^--->

	<!--- Services --->
	<cffunction name="save" access="public" output="true" return="boolean">
		<cfif not getServiceExists()>
			<cfreturn false />
		</cfif>
		
		<cfif getBeanExists()>
			<cfset getSubscribeService().updateSubscribe( this ) />
		<cfelse>
			<cfset getSubscribeService().saveSubscribe( this ) />
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
		<cfset sArgs['SubscribeID'] = getSubscribeID() /> 
		

		<cfset getSubscribeService().deleteSubscribe( argumentCollection=sArgs  ) />
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

	<cffunction name="setSubscribeService" access="public" returntype="void" output="false">
		<cfargument name="SubscribeService" type="any" required="yes"/>
		<cfset variables.SubscribeService = arguments.SubscribeService />
	</cffunction>
	<cffunction name="getSubscribeService" access="public" returntype="any" output="false" >
		<cfif getServiceExists()>
			<cfreturn variables.SubscribeService />
		</cfif>
	</cffunction>
	<cffunction name="getServiceExists" access="public" returntype="boolean" output="false" >
		<cfreturn StructKeyExists(variables,"SubscribeService")>
	</cffunction>

<!---^^GENERATEDEND^^--->
<!---^^CUSTOMSTART^^--->
<!---^^CUSTOMEND^^--->
</cfcomponent>	



